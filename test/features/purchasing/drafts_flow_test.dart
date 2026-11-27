import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _purchaseView = ['ordenes_compra.ver', 'almacenes.ver', 'stock.ver'];
const List<String> _purchaseCreate = [
  ..._purchaseView,
  'ordenes_compra.crear',
  'proveedores.ver',
  'generic-products.ver',
];
const _expenseView = ['ordenes_gasto.ver', 'ordenes_compra.ver'];
const List<String> _expenseCreate = [
  ..._expenseView,
  'ordenes_gasto.crear',
  'proveedores.ver',
];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}));

  Future<void> openPurchasing(
    WidgetTester tester,
    List<String> permissions,
  ) async {
    tester.view
      ..physicalSize = const Size(800, 4000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: permissions)
      ..stubPurchasingReads()
      ..storeSession();
    harness.adapter
      ..on(
        'GET',
        '/suppliers',
        body: fixture('catalog/suppliers_list_response.json'),
      )
      ..on(
        'GET',
        '/generic-products',
        body: fixture('catalog/products_list_response.json'),
      )
      ..on(
        'GET',
        '/generic-products/5',
        body: fixture('catalog/product_detail_response.json'),
      )
      ..on(
        'GET',
        '/generic-products/5/presentations',
        body: fixture('inventory/presentations_response.json'),
      )
      ..on(
        'GET',
        '/cost-centers',
        body: fixture('cost_centers/cost_centers_response.json'),
      )
      ..on(
        'GET',
        '/purchase-orders/13',
        body: fixture('purchasing/purchase_order_draft_response.json'),
      )
      ..on(
        'GET',
        '/expense-orders/33',
        body: fixture('purchasing/expense_order_draft_response.json'),
      );
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

  Finder field(String label) => find.widgetWithText(TextFormField, label);

  group('compra', () {
    Future<void> fillPurchase(WidgetTester tester) async {
      await tester.tap(find.text('Nueva orden de compra'));
      await AppHarness.settle(tester);
      await pickOption(tester, 'Proveedor', 'Proveedor Uno S.A.S.');
      await tester.tap(find.text('Agregar producto'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Gasa estéril 10x10'));
      await AppHarness.settle(tester);
      await pickOption(tester, 'Presentación', 'Caja x 100');
      await tester.tap(find.text('Agregar producto').last);
      await AppHarness.settle(tester);
      await tester.enterText(field('Valor unitario'), '50000');
      await AppHarness.settle(tester);
    }

    testWidgets('sin permiso de crear no hay botón', (tester) async {
      await openPurchasing(tester, _purchaseView);
      expect(find.text('Nueva orden de compra'), findsNothing);
    });

    testWidgets('crea el borrador y abre su detalle', (tester) async {
      harness.adapter.on(
        'POST',
        '/purchase-orders',
        status: 201,
        body: fixture('purchasing/purchase_order_draft_response.json'),
      );
      await openPurchasing(tester, _purchaseCreate);
      await fillPurchase(tester);

      expect(find.text(r'Total estimado: $50.000'), findsOneWidget);
      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/purchase-orders').single.data,
        {
          'supplier_id': 1,
          'warehouse_id': 1,
          'items': [
            {
              'product_variant_id': 50,
              'product_presentation_id': 3,
              'quantity': 1,
              'unit_price': 50000.0,
            },
          ],
        },
      );
      expect(find.text('Borrador guardado.'), findsOneWidget);
      expect(find.text('OC-2026-0013'), findsWidgets);
    });

    testWidgets('faltan datos: pide completarlos y no envía', (tester) async {
      await openPurchasing(tester, _purchaseCreate);
      await tester.tap(find.text('Nueva orden de compra'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);

      expect(find.text('Elija el proveedor.'), findsOneWidget);
      expect(find.text('Agregue al menos una línea.'), findsOneWidget);
      expect(harness.adapter.callsTo('POST', '/purchase-orders'), isEmpty);
    });

    testWidgets('los proveedores solo de gasto no se ofrecen en compras', (
      tester,
    ) async {
      await openPurchasing(tester, _purchaseCreate);
      await tester.tap(find.text('Nueva orden de compra'));
      await AppHarness.settle(tester);

      await tester.tap(
        find.byWidgetPredicate(
          (w) =>
              w is DropdownButtonFormField &&
              w.decoration.labelText == 'Proveedor',
        ),
      );
      await AppHarness.settle(tester, frames: 4);

      expect(find.text('Proveedor Uno S.A.S.'), findsWidgets);
      expect(find.text('Servicios Dos'), findsNothing);
    });

    testWidgets('sin respuesta: avisa y bloquea el reenvío', (tester) async {
      harness.adapter.onError(
        'POST',
        '/purchase-orders',
        DioExceptionType.receiveTimeout,
      );
      await openPurchasing(tester, _purchaseCreate);
      await fillPurchase(tester);

      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);

      expect(
        find.textContaining('es posible que sí se haya guardado'),
        findsOneWidget,
      );
      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);
      expect(harness.adapter.callsTo('POST', '/purchase-orders'), hasLength(1));
    });

    testWidgets('un 422 del servidor se muestra y conserva lo escrito', (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        '/purchase-orders',
        status: 422,
        body: errorBody('El almacén no existe.'),
      );
      await openPurchasing(tester, _purchaseCreate);
      await fillPurchase(tester);

      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);

      expect(find.text('El almacén no existe.'), findsOneWidget);
      expect(find.text('Gasa estéril 10x10'), findsOneWidget);
    });

    group('un borrador existente', () {
      Future<void> openDraft(WidgetTester tester) async {
        harness.adapter.on(
          'GET',
          '/purchase-orders',
          body: pagedBody([
            fixture('purchasing/purchase_order_draft_response.json')['data'],
          ]),
        );
        await openPurchasing(tester, _purchaseCreate);
        await tester.tap(find.text('OC-2026-0013'));
        await AppHarness.settle(tester);
      }

      testWidgets('se edita con sus datos y se guarda con PUT', (tester) async {
        harness.adapter.on(
          'PUT',
          '/purchase-orders/13',
          body: fixture('purchasing/purchase_order_draft_response.json'),
        );
        await openDraft(tester);

        await tester.tap(find.text('Editar borrador'));
        await AppHarness.settle(tester);
        expect(find.text('Gasa estéril 10x10'), findsOneWidget);
        expect(find.text('MarcaX · Caja x 100'), findsOneWidget);
        await tester.enterText(field('Cantidad'), '12');
        await tester.tap(find.text('Guardar borrador'));
        await AppHarness.settle(tester);

        final data =
            harness.adapter.callsTo('PUT', '/purchase-orders/13').single.data
                as Map<String, dynamic>;
        expect(data['supplier_id'], 1);
        expect(data['expected_delivery_date'], '2026-12-05');
        expect(data['notes'], 'Pedido mensual');
        final item = (data['items'] as List).single as Map<String, dynamic>;
        expect(item['quantity'], 12);
        expect(item['tax_rate'], 19.0);
        expect(harness.adapter.callsTo('POST', '/purchase-orders'), isEmpty);
      });

      testWidgets('se elimina con confirmación', (tester) async {
        harness.adapter.on(
          'DELETE',
          '/purchase-orders/13',
          body: {'success': true, 'message': 'Orden eliminada'},
        );
        await openDraft(tester);

        await tester.tap(find.text('Eliminar borrador'));
        await AppHarness.settle(tester);
        expect(find.textContaining('no se puede deshacer'), findsOneWidget);
        await tester.tap(find.text('Eliminar borrador').last);
        await AppHarness.settle(tester);

        expect(
          harness.adapter.callsTo('DELETE', '/purchase-orders/13'),
          hasLength(1),
        );
        expect(find.text('Borrador eliminado.'), findsOneWidget);
      });

      testWidgets('cancelar la confirmación no elimina', (tester) async {
        await openDraft(tester);

        await tester.tap(find.text('Eliminar borrador'));
        await AppHarness.settle(tester);
        await tester.tap(find.text('Cancelar'));
        await AppHarness.settle(tester);

        expect(
          harness.adapter.callsTo('DELETE', '/purchase-orders/13'),
          isEmpty,
        );
      });

      testWidgets('sin permiso de crear no se edita ni se elimina', (
        tester,
      ) async {
        harness.adapter.on(
          'GET',
          '/purchase-orders',
          body: pagedBody([
            fixture('purchasing/purchase_order_draft_response.json')['data'],
          ]),
        );
        await openPurchasing(tester, _purchaseView);
        await tester.tap(find.text('OC-2026-0013'));
        await AppHarness.settle(tester);

        expect(find.text('Editar borrador'), findsNothing);
        expect(find.text('Eliminar borrador'), findsNothing);
      });
    });
  });

  group('gasto', () {
    Future<void> openExpenses(
      WidgetTester tester,
      List<String> permissions,
    ) async {
      await openPurchasing(tester, permissions);
      await tester.tap(find.text('Gastos'));
      await AppHarness.settle(tester);
    }

    testWidgets('sin permiso de crear no hay botón', (tester) async {
      await openExpenses(tester, _expenseView);
      expect(find.text('Nueva orden de gasto'), findsNothing);
    });

    testWidgets('crea el borrador solo con proveedores de gasto', (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        '/expense-orders',
        status: 201,
        body: fixture('purchasing/expense_order_draft_response.json'),
      );
      await openExpenses(tester, _expenseCreate);
      await tester.tap(find.text('Nueva orden de gasto'));
      await AppHarness.settle(tester);

      await tester.tap(
        find.byWidgetPredicate(
          (w) =>
              w is DropdownButtonFormField &&
              w.decoration.labelText == 'Proveedor',
        ),
      );
      await AppHarness.settle(tester, frames: 4);
      expect(find.text('Proveedor Uno S.A.S.'), findsNothing);
      await tester.tap(find.text('Servicios Dos').last);
      await AppHarness.settle(tester, frames: 4);

      await tester.enterText(field('Descripción'), 'Mantenimiento aire');
      await tester.enterText(field('Unidad'), 'servicio');
      await tester.enterText(field('Valor unitario'), '200000');
      await tester.enterText(field('IVA % (opcional)'), '19');
      await AppHarness.settle(tester);
      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('POST', '/expense-orders').single.data, {
        'supplier_id': 2,
        'items': [
          {
            'description': 'Mantenimiento aire',
            'unit': 'servicio',
            'quantity': 1.0,
            'unit_price': 200000.0,
            'tax_rate': 19.0,
          },
        ],
      });
      expect(find.text('Borrador guardado.'), findsOneWidget);
    });

    testWidgets('exige proveedor, descripción, unidad y valor', (tester) async {
      await openExpenses(tester, _expenseCreate);
      await tester.tap(find.text('Nueva orden de gasto'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);

      expect(find.text('Elija el proveedor.'), findsOneWidget);
      expect(find.text('Este campo es obligatorio.'), findsWidgets);
      expect(harness.adapter.callsTo('POST', '/expense-orders'), isEmpty);
    });

    testWidgets('el IVA fuera de 0 a 100 se rechaza', (tester) async {
      await openExpenses(tester, _expenseCreate);
      await tester.tap(find.text('Nueva orden de gasto'));
      await AppHarness.settle(tester);

      await tester.enterText(field('IVA % (opcional)'), '150');
      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);

      expect(find.text('Debe estar entre 0 y 100.'), findsOneWidget);
    });

    testWidgets('se pueden agregar y quitar conceptos', (tester) async {
      await openExpenses(tester, _expenseCreate);
      await tester.tap(find.text('Nueva orden de gasto'));
      await AppHarness.settle(tester);

      expect(find.text('Quitar'), findsNothing, reason: 'una sola línea');
      await tester.tap(find.text('Agregar concepto'));
      await AppHarness.settle(tester);
      expect(find.text('Quitar'), findsNWidgets(2));
      await tester.tap(find.text('Quitar').first);
      await AppHarness.settle(tester);
      expect(find.text('Quitar'), findsNothing);
    });

    testWidgets('se edita un borrador de gasto con sus datos', (tester) async {
      harness.adapter
        ..on(
          'GET',
          '/expense-orders',
          body: pagedBody([
            fixture('purchasing/expense_order_draft_response.json')['data'],
          ]),
        )
        ..on(
          'PUT',
          '/expense-orders/33',
          body: fixture('purchasing/expense_order_draft_response.json'),
        );
      await openExpenses(tester, _expenseCreate);
      await tester.tap(find.text('OG-2026-0033'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Editar borrador'));
      await AppHarness.settle(tester);
      expect(find.text('Mantenimiento aire'), findsOneWidget);
      await tester.enterText(field('Valor unitario'), '250000');
      await tester.tap(find.text('Guardar borrador'));
      await AppHarness.settle(tester);

      final data =
          harness.adapter.callsTo('PUT', '/expense-orders/33').single.data
              as Map<String, dynamic>;
      expect(data['supplier_id'], 2);
      expect(data['notes'], 'Mantenimiento');
      expect(
        ((data['items'] as List).single as Map<String, dynamic>)['unit_price'],
        250000.0,
      );
    });
  });
}
