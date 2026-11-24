import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _readPermissions = [
  'stock.ver',
  'almacenes.ver',
  'lotes.ver',
  'generic-products.ver',
];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}));

  Future<void> openInventory(
    WidgetTester tester, {
    List<String> permissions = _readPermissions,
    bool withWarehouse = true,
  }) async {
    if (!withWarehouse) harness = AppHarness();
    harness
      ..stubSignedInUser(
        permissions: permissions,
        menu: 'auth/menu_inventory_response.json',
      )
      ..stubInventoryReads()
      ..storeSession();
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Inventario'),
      ),
    );
    await AppHarness.settle(tester);
  }

  testWidgets('sin almacén activo pide elegirlo', (tester) async {
    await openInventory(tester, withWarehouse: false);
    expect(find.textContaining('Seleccione un almacén activo'), findsOneWidget);
    expect(harness.adapter.callsTo('GET', '/stock'), isEmpty);
  });

  group('existencias', () {
    testWidgets('lista las existencias del almacén activo', (tester) async {
      await openInventory(tester);

      expect(find.text('Gasa estéril 10x10'), findsOneWidget);
      expect(find.text('Disponible: 120'), findsOneWidget);
      expect(find.textContaining('Total: 120 · Reservado: 0'), findsOneWidget);
      expect(
        harness.adapter
            .callsTo('GET', '/stock')
            .first
            .queryParameters['warehouse_id'],
        1,
      );
    });

    testWidgets('"Bajo mínimo" consulta /stock/low', (tester) async {
      await openInventory(tester);

      await tester.tap(find.text('Bajo mínimo'));
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('GET', '/stock/low'), hasLength(1));
      expect(find.text('Gasa estéril 10x10'), findsOneWidget);
    });

    testWidgets('lista vacía: mensaje', (tester) async {
      harness.adapter.on('GET', '/stock', body: pagedBody([]));
      await openInventory(tester);
      expect(
        find.text('No hay existencias registradas en este almacén.'),
        findsOneWidget,
      );
    });

    testWidgets('falla la red: reintentar vuelve a pedir', (tester) async {
      harness.adapter
        ..onSocketFailure('GET', '/stock')
        ..on('GET', '/stock', body: fixture('inventory/stock_response.json'));
      await openInventory(tester);

      expect(find.text('Reintentar'), findsOneWidget);
      await tester.tap(find.text('Reintentar'));
      await AppHarness.settle(tester);

      expect(find.text('Gasa estéril 10x10'), findsOneWidget);
    });
  });

  group('lotes', () {
    Future<void> goToBatches(WidgetTester tester) async {
      await tester.tap(find.text('Lotes'));
      await AppHarness.settle(tester);
    }

    testWidgets('lista lotes con estado y cantidad por almacén', (
      tester,
    ) async {
      await openInventory(tester);
      await goToBatches(tester);

      expect(find.text('Lote L-2026-01'), findsOneWidget);
      expect(find.text('VENCE EN 11 DÍAS'), findsOneWidget);
      expect(find.text('VENCIDO'), findsOneWidget);
      expect(
        harness.adapter
            .callsTo('GET', '/batches')
            .first
            .queryParameters['warehouse_id'],
        1,
      );
    });

    testWidgets('filtros Por vencer y Vencidos usan sus endpoints', (
      tester,
    ) async {
      await openInventory(tester);
      await goToBatches(tester);

      await tester.tap(find.text('Por vencer'));
      await AppHarness.settle(tester);
      expect(harness.adapter.callsTo('GET', '/batches/expiring'), hasLength(1));

      await tester.tap(find.text('Vencidos'));
      await AppHarness.settle(tester);
      expect(harness.adapter.callsTo('GET', '/batches/expired'), hasLength(1));
    });

    testWidgets('el detalle muestra ubicaciones con saldo', (tester) async {
      await openInventory(tester);
      await goToBatches(tester);

      await tester.tap(find.text('Lote L-2026-01'));
      await AppHarness.settle(tester);

      expect(find.text('Estante A1'), findsOneWidget);
      expect(
        find.textContaining('Bodega Central · Zona fría · A1'),
        findsOneWidget,
      );
      expect(find.text('05/12/2026'), findsOneWidget);
    });

    testWidgets('sin lotes.ver no aparece la pestaña', (tester) async {
      await openInventory(tester, permissions: ['stock.ver', 'almacenes.ver']);
      expect(find.text('Lotes'), findsNothing);
    });
  });

  group('comprobantes e historial', () {
    testWidgets('lista comprobantes y abre el detalle', (tester) async {
      await openInventory(tester);

      await tester.tap(find.text('Comprobantes'));
      await AppHarness.settle(tester);
      expect(find.text('SAL-2026-000123'), findsOneWidget);
      expect(find.text('PENDIENTE DE FIRMA'), findsOneWidget);

      await tester.tap(find.text('SAL-2026-000123'));
      await AppHarness.settle(tester);
      expect(find.text('Urgencias'), findsOneWidget);
      expect(find.text('Reposición de piso'), findsWidgets);
      expect(find.text('Gasa estéril 10x10'), findsOneWidget);
    });

    testWidgets('el filtro Pendientes envía pending_signature', (tester) async {
      await openInventory(tester);
      await tester.tap(find.text('Comprobantes'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Pendientes'));
      await AppHarness.settle(tester);

      final statuses = harness.adapter
          .callsTo('GET', '/movement-documents')
          .map((r) => r.queryParameters['status'])
          .toList();
      expect(statuses, contains('pending_signature'));
    });

    testWidgets('historial muestra tipo, lote y cantidad', (tester) async {
      await openInventory(tester);
      await tester.tap(find.text('Historial'));
      await AppHarness.settle(tester);

      expect(find.text('Salida'), findsOneWidget);
      expect(find.text('Lote L-2026-01'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });
  });

  group('escáner', () {
    const scanPermissions = [..._readPermissions, 'generic-products.barcode'];

    testWidgets('sin generic-products.barcode no hay botón de escanear', (
      tester,
    ) async {
      await openInventory(tester);
      expect(find.byTooltip('Escanear código'), findsNothing);
    });

    testWidgets('un código válido abre el producto', (tester) async {
      harness.adapter
        ..on(
          'GET',
          '/generic-products/barcode/100005',
          body: envelope({
            'id': 5,
            'name': 'Gasa estéril 10x10',
            'barcode': '100005',
          }),
        )
        ..on(
          'GET',
          '/generic-products/5',
          body: fixture('catalog/product_detail_response.json'),
        );
      await openInventory(tester, permissions: scanPermissions);

      await tester.tap(find.byTooltip('Escanear código'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Simular lectura'));
      await AppHarness.settle(tester);

      expect(
        find.text('Curación'),
        findsOneWidget,
        reason: 'detalle del producto',
      );
    });

    testWidgets('un código desconocido avisa y se queda en inventario', (
      tester,
    ) async {
      harness.scanCode = '999999';
      harness.adapter.on(
        'GET',
        '/generic-products/barcode/999999',
        status: 404,
        body: errorBody('Producto no encontrado'),
      );
      await openInventory(tester, permissions: scanPermissions);

      await tester.tap(find.byTooltip('Escanear código'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Simular lectura'));
      await AppHarness.settle(tester);

      expect(
        find.text('No se encontró un producto con el código 999999.'),
        findsOneWidget,
      );
      expect(find.text('Existencias'), findsOneWidget);
    });
  });

  group('acciones según permisos', () {
    testWidgets('sin movimientos.* no hay botón de nuevo movimiento', (
      tester,
    ) async {
      await openInventory(tester);
      expect(find.text('Nuevo movimiento'), findsNothing);
    });

    testWidgets('con un permiso de movimiento aparece y ofrece solo ese tipo', (
      tester,
    ) async {
      await openInventory(
        tester,
        permissions: [..._readPermissions, 'movimientos.entrada'],
      );

      await tester.tap(find.text('Nuevo movimiento'));
      await AppHarness.settle(tester);

      expect(find.text('Entrada'), findsOneWidget);
      expect(find.text('Salida'), findsNothing);
      expect(find.text('Traslado'), findsNothing);
    });

    testWidgets('la ruta de un tipo sin permiso redirige a Inicio', (
      tester,
    ) async {
      await openInventory(tester);
      final context = tester.element(find.byType(Scaffold).first);

      GoRouter.of(context).go('/inventory/new/exit');
      await AppHarness.settle(tester);

      expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
    });
  });
}
