import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _view = ['ordenes_compra.ver', 'almacenes.ver', 'stock.ver'];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}));

  Future<void> openPurchasing(
    WidgetTester tester, {
    List<String> permissions = _view,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: permissions)
      ..stubPurchasingReads()
      ..storeSession();
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Compras'),
      ),
    );
    await AppHarness.settle(tester);
  }

  Future<void> pickOption(
    WidgetTester tester,
    String label,
    String option,
  ) async {
    await tester.tap(
      find.byWidgetPredicate(
        (w) => w is DropdownButtonFormField && w.decoration.labelText == label,
      ),
    );
    await AppHarness.settle(tester, frames: 4);
    await tester.tap(find.text(option).last);
    await AppHarness.settle(tester, frames: 4);
  }

  Future<void> openFirstOrder(WidgetTester tester) async {
    await tester.tap(find.text('OC-2026-0011'));
    await AppHarness.settle(tester);
  }

  group('órdenes de compra', () {
    testWidgets('lista las órdenes con proveedor, total y estado', (
      tester,
    ) async {
      await openPurchasing(tester);

      expect(find.text('OC-2026-0011'), findsOneWidget);
      expect(find.text('POR APROBAR'), findsWidgets);
      expect(find.text(r'$1.190.000'), findsOneWidget);
      expect(find.text('OC-2026-0012'), findsOneWidget);
      expect(find.text('ENVIADA'), findsWidgets);
    });

    testWidgets('el filtro por estado pide solo ese estado al servidor', (
      tester,
    ) async {
      await openPurchasing(tester);
      await tester.tap(find.widgetWithText(ChoiceChip, 'Enviada'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/purchase-orders')
            .any((call) => call.queryParameters['status'] == 'sent'),
        isTrue,
      );
    });

    testWidgets('sin gastos permitidos solo hay pestañas de compra', (
      tester,
    ) async {
      await openPurchasing(tester);
      expect(find.text('Gastos'), findsNothing);
      expect(find.text('Sugerencias'), findsOneWidget);
    });

    testWidgets('detalle: productos, impuestos y totales', (tester) async {
      await openPurchasing(tester);
      await openFirstOrder(tester);

      expect(find.text('Droguería Proveedor S.A.S.'), findsWidgets);
      expect(find.text('Gasa estéril'), findsOneWidget);
      expect(find.textContaining('Caja x 10'), findsOneWidget);
      expect(find.text(r'$1.000.000'), findsOneWidget, reason: 'subtotal');
      expect(find.text(r'$190.000'), findsOneWidget, reason: 'impuestos');
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
    });

    testWidgets('sin permiso de aprobar no hay botones de flujo', (
      tester,
    ) async {
      await openPurchasing(tester);
      await openFirstOrder(tester);

      expect(find.text('Aprobar'), findsNothing);
      expect(find.text('Rechazar'), findsNothing);
      expect(find.text('Cancelar orden'), findsNothing);
    });

    testWidgets('aprobar con comentarios y refrescar la orden', (tester) async {
      await openPurchasing(
        tester,
        permissions: [..._view, 'ordenes_compra.aprobar'],
      );
      harness.adapter.on(
        'POST',
        '/purchase-orders/11/approve',
        body: fixture('purchasing/purchase_order_response.json'),
      );
      await openFirstOrder(tester);

      await tester.tap(find.text('Aprobar'));
      await AppHarness.settle(tester);
      await tester.enterText(find.byType(TextField).last, 'Autorizado');
      await tester.tap(find.text('Aprobar').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('POST', '/purchase-orders/11/approve')
            .single
            .data,
        {'comments': 'Autorizado'},
      );
      expect(find.text('Orden aprobada.'), findsOneWidget);
    });

    testWidgets('rechazar pide confirmación con botón destructivo', (
      tester,
    ) async {
      await openPurchasing(
        tester,
        permissions: [..._view, 'ordenes_compra.aprobar'],
      );
      harness.adapter.on(
        'POST',
        '/purchase-orders/11/reject',
        body: fixture('purchasing/purchase_order_response.json'),
      );
      await openFirstOrder(tester);

      await tester.tap(find.text('Rechazar'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Rechazar').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/purchase-orders/11/reject'),
        hasLength(1),
      );
      expect(find.text('Orden rechazada.'), findsOneWidget);
    });

    testWidgets('409 del servidor: se muestra su mensaje y no se repite', (
      tester,
    ) async {
      await openPurchasing(
        tester,
        permissions: [..._view, 'ordenes_compra.aprobar'],
      );
      harness.adapter.on(
        'POST',
        '/purchase-orders/11/approve',
        status: 409,
        body: errorBody('La orden ya fue procesada por otro usuario.'),
      );
      await openFirstOrder(tester);
      await tester.tap(find.text('Aprobar'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Aprobar').last);
      await AppHarness.settle(tester);

      expect(
        find.text('La orden ya fue procesada por otro usuario.'),
        findsOneWidget,
      );
      expect(
        harness.adapter.callsTo('POST', '/purchase-orders/11/approve'),
        hasLength(1),
      );
    });

    testWidgets(
      'timeout al aprobar: avisa, vuelve a consultar y no reintenta',
      (
        tester,
      ) async {
        await openPurchasing(
          tester,
          permissions: [..._view, 'ordenes_compra.aprobar'],
        );
        harness.adapter.onError(
          'POST',
          '/purchase-orders/11/approve',
          DioExceptionType.receiveTimeout,
        );
        await openFirstOrder(tester);
        await tester.tap(find.text('Aprobar'));
        await AppHarness.settle(tester);
        await tester.tap(find.text('Aprobar').last);
        await AppHarness.settle(tester);

        expect(
          find.textContaining('Antes de repetirlo, actualice la orden'),
          findsOneWidget,
        );
        expect(
          harness.adapter.callsTo('POST', '/purchase-orders/11/approve'),
          hasLength(1),
        );
        expect(
          harness.adapter.callsTo('GET', '/purchase-orders/11').length,
          greaterThan(1),
          reason: 'consulta el estado real tras el timeout',
        );
      },
    );

    testWidgets('cancelar una orden pide confirmación', (tester) async {
      await openPurchasing(
        tester,
        permissions: [..._view, 'ordenes_compra.crear'],
      );
      harness.adapter.on(
        'POST',
        '/purchase-orders/11/cancel',
        body: fixture('purchasing/purchase_order_response.json'),
      );
      await openFirstOrder(tester);

      await tester.tap(find.text('Cancelar orden'));
      await AppHarness.settle(tester);
      expect(find.textContaining('no se podrá reactivar'), findsOneWidget);
      await tester.tap(find.text('Cancelar orden').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/purchase-orders/11/cancel'),
        hasLength(1),
      );
      expect(find.text('Orden cancelada.'), findsOneWidget);
    });
  });

  group('recepción', () {
    const receive = [..._view, 'ordenes_compra.recibir'];

    Future<void> openReceive(WidgetTester tester) async {
      await openPurchasing(tester, permissions: receive);
      await tester.tap(find.text('OC-2026-0012'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Recibir mercancía'));
      await AppHarness.settle(tester);
    }

    testWidgets('muestra lo pendiente y exige lote, vencimiento y ubicación', (
      tester,
    ) async {
      await openReceive(tester);
      expect(find.text('Pendiente por recibir: 15'), findsOneWidget);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Cantidad recibida'),
        '5',
      );
      await tester.pump();
      await tester.tap(find.text('Confirmar recepción'));
      await AppHarness.settle(tester);

      expect(find.text('Este campo es obligatorio.'), findsWidgets);
      expect(
        harness.adapter.callsTo('POST', '/purchase-orders/12/receive'),
        isEmpty,
      );
    });

    testWidgets('no permite recibir más de lo pendiente', (tester) async {
      await openReceive(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Cantidad recibida'),
        '16',
      );
      await tester.pump();
      await tester.tap(find.text('Confirmar recepción'));
      await AppHarness.settle(tester);

      expect(
        find.text('No puede recibir más de lo que está pendiente.'),
        findsOneWidget,
      );
    });

    testWidgets('sin cantidades avisa que falta al menos una', (tester) async {
      await openReceive(tester);
      await tester.tap(find.text('Confirmar recepción'));
      await AppHarness.settle(tester);

      expect(
        find.text('Escriba la cantidad recibida de al menos un producto.'),
        findsOneWidget,
      );
    });

    testWidgets('registra la recepción con lote, vencimiento y ubicación', (
      tester,
    ) async {
      await openReceive(tester);
      harness.adapter.on(
        'POST',
        '/purchase-orders/12/receive',
        body: fixture('purchasing/purchase_order_response.json'),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Cantidad recibida'),
        '10',
      );
      await tester.pump();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Número de lote'),
        'L-77',
      );
      await tester.tap(
        find.widgetWithText(InputDecorator, 'Fecha de vencimiento'),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('ACEPTAR'));
      await AppHarness.settle(tester);
      await pickOption(tester, 'Ubicación', 'Zona fría · Estante A1');
      await tester.tap(find.text('Confirmar recepción'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter
                  .callsTo('POST', '/purchase-orders/12/receive')
                  .single
                  .data
              as Map<String, dynamic>;
      final line = (body['items'] as List).single as Map<String, dynamic>;
      expect(line['item_id'], 102);
      expect(line['quantity_received'], 10);
      expect(line['lot_number'], 'L-77');
      expect(line['location_id'], isA<int>());
      expect(line['expiration_date'], matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));
      expect(find.text('Recepción registrada.'), findsOneWidget);
    });
  });
}
