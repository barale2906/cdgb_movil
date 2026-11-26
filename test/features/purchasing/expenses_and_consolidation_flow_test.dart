import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _view = ['ordenes_compra.ver', 'ordenes_gasto.ver', 'almacenes.ver'];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}));

  Future<void> openPurchasing(
    WidgetTester tester, {
    List<String> permissions = _view,
    String tab = 'Compras',
    void Function()? before,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    // El servidor falso entrega primero lo registrado antes: lo propio de
    // cada prueba va por delante de las lecturas habituales.
    before?.call();
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
    if (tab != 'Compras') {
      await tester.tap(find.widgetWithText(Tab, tab));
      await AppHarness.settle(tester);
    }
  }

  Future<void> openExpense(
    WidgetTester tester, {
    List<String> permissions = _view,
  }) async {
    await openPurchasing(tester, permissions: permissions, tab: 'Gastos');
    await tester.tap(find.text('OG-2026-0031'));
    await AppHarness.settle(tester);
  }

  group('órdenes de gasto', () {
    testWidgets('lista con estado de la orden y estado de pago', (
      tester,
    ) async {
      await openPurchasing(tester, tab: 'Gastos');

      expect(find.text('OG-2026-0031'), findsOneWidget);
      expect(find.text('RECIBIDA'), findsWidgets);
      expect(find.text('PAGO PARCIAL'), findsWidgets);
      expect(find.text('SIN PAGAR'), findsWidgets);
      expect(find.text(r'$800.000'), findsOneWidget);
    });

    testWidgets('el filtro de pago pide ese estado al servidor', (
      tester,
    ) async {
      await openPurchasing(tester, tab: 'Gastos');
      await tester.tap(find.widgetWithText(ChoiceChip, 'Sin pagar'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/expense-orders')
            .any((call) => call.queryParameters['payment_status'] == 'unpaid'),
        isTrue,
      );
    });

    testWidgets('detalle: pagado, saldo y pagos registrados', (tester) async {
      await openExpense(tester);

      expect(find.text('Mantenimiento de autoclave'), findsOneWidget);
      expect(find.text('Saldo pendiente'), findsOneWidget);
      expect(find.text(r'$500.000'), findsOneWidget, reason: 'saldo');
      expect(find.textContaining('Transferencia'), findsOneWidget);
      expect(find.textContaining('TRF-001'), findsOneWidget);
    });

    testWidgets('sin permiso de pagos no hay botón ni borrado', (tester) async {
      await openExpense(tester);

      expect(find.text('Registrar pago'), findsNothing);
      expect(find.byTooltip('Eliminar pago'), findsNothing);
    });

    testWidgets('registra un pago y no admite más que el saldo', (
      tester,
    ) async {
      await openExpense(tester, permissions: [..._view, 'ordenes_gasto.pagos']);
      harness.adapter.on(
        'POST',
        '/expense-orders/31/payments',
        status: 201,
        body: fixture('purchasing/expense_order_response.json'),
      );

      await tester.tap(find.text('Registrar pago').first);
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Valor'),
        '600000',
      );
      await tester.tap(find.text('Guardar'));
      await AppHarness.settle(tester);
      expect(
        find.text('El valor no puede superar el saldo pendiente.'),
        findsOneWidget,
      );
      expect(
        harness.adapter.callsTo('POST', '/expense-orders/31/payments'),
        isEmpty,
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Valor'),
        '200000',
      );
      await tester.tap(find.text('Guardar'));
      await AppHarness.settle(tester);

      final data =
          harness.adapter
                  .callsTo('POST', '/expense-orders/31/payments')
                  .single
                  .data
              as Map<String, dynamic>;
      expect(data['amount'], 200000);
      expect(data['payment_method'], 'transfer');
      expect(find.text('Pago registrado.'), findsOneWidget);
    });

    testWidgets('elimina un pago tras confirmar', (tester) async {
      await openExpense(tester, permissions: [..._view, 'ordenes_gasto.pagos']);
      harness.adapter.on(
        'DELETE',
        '/expense-orders/31/payments/51',
        body: envelope(null),
      );

      await tester.tap(find.byTooltip('Eliminar pago'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Eliminar pago').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('DELETE', '/expense-orders/31/payments/51'),
        hasLength(1),
      );
      expect(find.text('Pago eliminado.'), findsOneWidget);
    });

    testWidgets('registra la factura con número y fecha', (tester) async {
      await openExpense(
        tester,
        permissions: [..._view, 'ordenes_gasto.factura'],
      );
      harness.adapter.on(
        'POST',
        '/expense-orders/31/invoice',
        body: fixture('purchasing/expense_order_response.json'),
      );

      await tester.tap(find.text('Registrar factura').first);
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Número de factura'),
        'FV-9',
      );
      await tester.tap(find.widgetWithText(InputDecorator, 'Fecha de factura'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('ACEPTAR'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Guardar'));
      await AppHarness.settle(tester);

      final data =
          harness.adapter
                  .callsTo('POST', '/expense-orders/31/invoice')
                  .single
                  .data
              as Map<String, dynamic>;
      expect(data['invoice_number'], 'FV-9');
      expect(find.text('Factura registrada.'), findsOneWidget);
    });

    testWidgets('enviar a contabilidad exige factura y correos válidos', (
      tester,
    ) async {
      await openPurchasing(
        tester,
        permissions: [..._view, 'ordenes_gasto.factura'],
        tab: 'Gastos',
        before: () => harness.adapter
          ..on(
            'GET',
            '/expense-orders/32',
            body: envelope(
              (fixture('purchasing/expense_orders_response.json')['data']
                      as List)
                  .last,
            ),
          )
          ..on(
            'POST',
            '/expense-orders/32/send-accounting',
            body: fixture('purchasing/expense_order_response.json'),
          ),
      );
      await tester.tap(find.text('OG-2026-0032'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Enviar a contabilidad').first);
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Correos (separados por coma)'),
        'no-es-correo',
      );
      await tester.tap(find.text('Enviar por correo'));
      await AppHarness.settle(tester);
      expect(
        find.text('Ingrese correos válidos separados por comas.'),
        findsOneWidget,
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Correos (separados por coma)'),
        'conta@clinica.test, otro@clinica.test',
      );
      await tester.tap(find.text('Enviar por correo'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/expense-orders/32/send-accounting'),
        hasLength(1),
      );
      expect(find.text('Orden enviada a contabilidad.'), findsOneWidget);
    });

    testWidgets('sin factura registrada no se ofrece enviar a contabilidad', (
      tester,
    ) async {
      await openExpense(
        tester,
        permissions: [..._view, 'ordenes_gasto.factura'],
      );
      expect(find.text('Enviar a contabilidad'), findsNothing);
    });

    testWidgets('recibe un gasto con cantidades decimales', (tester) async {
      final order =
          (fixture('purchasing/expense_orders_response.json')['data'] as List)
                  .first
              as Map<String, dynamic>;
      final item = ((order['items'] as List).single as Map<String, dynamic>)
        ..['quantity_received'] = '0.500';
      order
        ..['status'] = 'partially_received'
        ..['items'] = [item];
      await openPurchasing(
        tester,
        permissions: [..._view, 'ordenes_gasto.recibir'],
        tab: 'Gastos',
        before: () => harness.adapter
          ..on('GET', '/expense-orders/31', body: envelope(order))
          ..on(
            'POST',
            '/expense-orders/31/receive',
            body: fixture('purchasing/expense_order_response.json'),
          ),
      );
      await tester.tap(find.text('OG-2026-0031'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Recibir mercancía'));
      await AppHarness.settle(tester);

      expect(find.text('Pendiente por recibir: 1,5'), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Cantidad recibida'),
        '1,5',
      );
      await tester.tap(find.text('Confirmar recepción'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('POST', '/expense-orders/31/receive')
            .single
            .data,
        {
          'items': [
            {'item_id': 301, 'quantity_received': 1.5},
          ],
        },
      );
    });
  });

  group('sugerencias', () {
    testWidgets('lista con existencias, proveedor y cantidad sugerida', (
      tester,
    ) async {
      await openPurchasing(tester, tab: 'Sugerencias');

      expect(find.text('Gasa estéril'), findsOneWidget);
      expect(
        find.text('Existencias: 12 · Punto de reorden: 50'),
        findsOneWidget,
      );
      expect(
        find.text('Proveedor sugerido: Droguería Proveedor S.A.S.'),
        findsOneWidget,
      );
      expect(find.text('Cantidad sugerida: 80'), findsOneWidget);
      expect(find.text('Jeringa 5 ml'), findsOneWidget);
    });

    testWidgets('sin sugerencias: mensaje', (tester) async {
      await openPurchasing(
        tester,
        tab: 'Sugerencias',
        before: () => harness.adapter.on(
          'GET',
          '/purchase-orders/suggestions',
          body: envelope(<dynamic>[]),
        ),
      );
      expect(
        find.text('Ningún producto está por debajo de su punto de reorden.'),
        findsOneWidget,
      );
    });

    testWidgets('error del servidor: muestra reintento', (tester) async {
      await openPurchasing(
        tester,
        tab: 'Sugerencias',
        before: () => harness.adapter.on(
          'GET',
          '/purchase-orders/suggestions',
          status: 500,
          body: errorBody('Error interno'),
        ),
      );
      expect(find.text('Reintentar'), findsOneWidget);
    });
  });

  group('consolidación', () {
    const consolidate = [..._view, 'ordenes_compra.consolidar'];

    testWidgets('lista las órdenes consolidadas con su periodo', (
      tester,
    ) async {
      await openPurchasing(tester, tab: 'Consolidadas');

      expect(find.text('CONS-2026-0005'), findsOneWidget);
      expect(find.textContaining('01/11/2026 – 24/11/2026'), findsOneWidget);
      expect(
        find.text('Consolidar órdenes'),
        findsNothing,
        reason: 'sin permiso',
      );
    });

    testWidgets('detalle con líneas, totales y órdenes de origen', (
      tester,
    ) async {
      await openPurchasing(tester, tab: 'Consolidadas');
      harness.adapter.on(
        'GET',
        '/consolidated-orders/5',
        body: fixture('purchasing/consolidated_order_response.json'),
      );
      await tester.tap(find.text('CONS-2026-0005'));
      await AppHarness.settle(tester);

      expect(find.text('Gasa estéril'), findsOneWidget);
      expect(find.text('OC-2026-0021'), findsOneWidget);
      expect(find.text('OC-2026-0022'), findsOneWidget);
      expect(find.text(r'$1.690.000'), findsWidgets);
    });

    testWidgets('elige proveedor y órdenes, ve la vista previa y consolida', (
      tester,
    ) async {
      await openPurchasing(
        tester,
        permissions: consolidate,
        tab: 'Consolidadas',
      );
      harness.adapter
        ..on(
          'GET',
          '/purchase-orders/consolidable-suppliers',
          body: fixture('purchasing/consolidable_suppliers_response.json'),
        )
        ..on(
          'GET',
          '/purchase-orders/consolidable',
          body: fixture('purchasing/consolidable_response.json'),
        )
        ..on(
          'POST',
          '/purchase-orders/consolidation-preview',
          body: fixture('purchasing/consolidation_preview_response.json'),
        )
        ..on(
          'POST',
          '/consolidated-orders',
          status: 201,
          body: fixture('purchasing/consolidated_order_response.json'),
        );

      await tester.tap(find.text('Consolidar órdenes'));
      await AppHarness.settle(tester);
      final preview = find.widgetWithText(FilledButton, 'Ver vista previa');
      expect(
        tester.widget<FilledButton>(preview).onPressed,
        isNull,
        reason: 'sin órdenes elegidas',
      );

      await tester.tap(
        find.byWidgetPredicate(
          (w) =>
              w is DropdownButtonFormField &&
              w.decoration.labelText == 'Proveedor',
        ),
      );
      await AppHarness.settle(tester, frames: 4);
      await tester.tap(find.text('Droguería Proveedor S.A.S.').last);
      await AppHarness.settle(tester);
      await tester.tap(find.text('OC-2026-0021'));
      await tester.tap(find.text('OC-2026-0022'));
      await tester.pump();
      await tester.tap(find.text('Ver vista previa'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('POST', '/purchase-orders/consolidation-preview')
            .single
            .data,
        {
          'purchase_order_ids': [21, 22],
        },
      );
      expect(find.text(r'$1.690.000'), findsWidgets);

      await tester.tap(find.widgetWithText(FilledButton, 'Consolidar órdenes'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Consolidar órdenes').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/consolidated-orders'),
        hasLength(1),
      );
      expect(find.text('Orden consolidada creada.'), findsOneWidget);
    });
  });
}
