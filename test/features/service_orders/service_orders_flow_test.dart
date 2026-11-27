import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _menu = 'auth/menu_service_orders_response.json';
const _number = 'OS-20261124-000001';
const _view = ['ordenes_servicio.ver'];
const _creator = [
  'ordenes_servicio.ver',
  'ordenes_servicio.crear',
  'servicios_medicos.ver',
];
const List<String> _canceller = [..._creator, 'ordenes_servicio.editar'];
const _approver = ['ordenes_servicio.ver', 'ordenes_servicio.aprobar'];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Map<String, dynamic> body(String name) => fixture('service_orders/$name');

  Future<void> openOrders(
    WidgetTester tester, {
    List<String> permissions = _view,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: permissions, menu: _menu)
      ..storeSession();
    harness.adapter
      ..on(
        'GET',
        '/service-orders/discounts',
        body: body('discounts_response.json'),
      )
      ..on(
        'GET',
        '/medsys/patients',
        body: fixture('clinical/patients_response.json'),
      )
      ..on(
        'GET',
        '/medical-services/search',
        body: fixture('clinical/procedures_response.json'),
      );
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Órdenes de servicio').last);
    await AppHarness.settle(tester);
  }

  Future<void> openDetail(
    WidgetTester tester, {
    required List<String> permissions,
    String order = 'order_pending_response.json',
  }) async {
    harness.adapter.on('GET', '/service-orders/$_number', body: body(order));
    await openOrders(tester, permissions: permissions);
    await tester.enterText(find.byType(TextField).first, _number.toLowerCase());
    await tester.tap(find.text('Buscar orden'));
    await AppHarness.settle(tester);
  }

  group('sección', () {
    testWidgets('solo con ver: búsqueda por número y sin pestañas ni crear', (
      tester,
    ) async {
      await openOrders(tester);

      expect(find.text('Número de orden'), findsOneWidget);
      expect(find.text('Descuentos'), findsNothing);
      expect(find.text('Nueva orden'), findsNothing);
    });

    testWidgets('buscar abre la orden con el número en mayúsculas', (
      tester,
    ) async {
      await openDetail(tester, permissions: _view);

      expect(
        harness.adapter.callsTo('GET', '/service-orders/$_number'),
        hasLength(1),
      );
      expect(find.text('Curaciones simples'), findsOneWidget);
    });

    testWidgets('la búsqueda vacía pide el número', (tester) async {
      await openOrders(tester);
      await tester.tap(find.text('Buscar orden'));
      await AppHarness.settle(tester);

      expect(find.text('Este campo es obligatorio.'), findsOneWidget);
    });

    testWidgets('con crear y ver servicios aparece nueva orden', (
      tester,
    ) async {
      await openOrders(tester, permissions: _creator);
      expect(find.text('Nueva orden'), findsOneWidget);
    });

    testWidgets('sin ver servicios médicos no hay nueva orden', (tester) async {
      await openOrders(
        tester,
        permissions: ['ordenes_servicio.ver', 'ordenes_servicio.crear'],
      );
      expect(find.text('Nueva orden'), findsNothing);
    });

    testWidgets('quien aprueba ve los descuentos pendientes', (tester) async {
      harness.adapter.on(
        'GET',
        '/service-orders/$_number',
        body: body('order_pending_response.json'),
      );
      await openOrders(tester, permissions: _approver);

      await tester.tap(find.text('Descuentos'));
      await AppHarness.settle(tester);

      expect(find.text(_number), findsOneWidget);
      expect(find.text('Ana María Pérez Gómez'), findsOneWidget);
      expect(find.text(r'Descuento: $15.000'), findsOneWidget);

      await tester.tap(find.text(_number));
      await AppHarness.settle(tester);
      expect(find.text('Aprobar descuento'), findsWidgets);
    });

    testWidgets('sin descuentos pendientes: mensaje', (tester) async {
      harness.adapter.on(
        'GET',
        '/service-orders/discounts',
        body: envelope(<dynamic>[]),
      );
      await openOrders(tester, permissions: _approver);

      await tester.tap(find.text('Descuentos'));
      await AppHarness.settle(tester);

      expect(
        find.text('No hay descuentos pendientes de aprobación.'),
        findsOneWidget,
      );
    });
  });

  group('detalle y acciones', () {
    testWidgets('muestra estado, procedimientos y totales', (tester) async {
      await openDetail(tester, permissions: _view);

      expect(find.text('DESCUENTO POR APROBAR'), findsOneWidget);
      expect(find.text('SIN FACTURAR'), findsOneWidget);
      expect(find.text('Consulta dermatología'), findsOneWidget);
      expect(find.text(r'$250.000'), findsOneWidget);
      expect(find.text(r'$235.000'), findsWidgets);
      expect(find.text('Aprobar descuento'), findsNothing);
      expect(find.text('Marcar como facturada'), findsNothing);
      expect(find.text('Anular orden'), findsNothing);
    });

    testWidgets('aprobar el descuento pide confirmar y recarga la orden', (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        '/service-orders/$_number/approve',
        body: body('order_approved_response.json'),
      );
      await openDetail(tester, permissions: _approver);
      harness.adapter.on(
        'GET',
        '/service-orders/$_number',
        body: body('order_approved_response.json'),
      );

      await tester.tap(find.text('Aprobar descuento'));
      await AppHarness.settle(tester);
      expect(
        find.text('Se aprobará el descuento de \$15.000 de la orden $_number.'),
        findsOneWidget,
      );
      await tester.tap(
        find.text('Aprobar descuento').last,
      );
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/service-orders/$_number/approve'),
        hasLength(1),
      );
      expect(find.text('Descuento aprobado.'), findsOneWidget);
      expect(find.text('APROBADA'), findsOneWidget);
    });

    testWidgets('con descuento pendiente no se factura', (tester) async {
      await openDetail(tester, permissions: _creator);

      expect(
        find.text('Apruebe el descuento antes de facturar.'),
        findsOneWidget,
      );
      expect(find.text('Marcar como facturada'), findsNothing);
    });

    testWidgets('facturar pide confirmar y envía la acción', (tester) async {
      harness.adapter.on(
        'POST',
        '/service-orders/$_number/bill',
        body: body('order_billed_response.json'),
      );
      await openDetail(
        tester,
        permissions: _creator,
        order: 'order_approved_response.json',
      );
      harness.adapter.on(
        'GET',
        '/service-orders/$_number',
        body: body('order_billed_response.json'),
      );

      await tester.tap(find.text('Marcar como facturada'));
      await AppHarness.settle(tester);
      await tester.tap(
        find.text('Marcar como facturada').last,
      );
      await AppHarness.settle(tester);

      expect(find.text('Orden facturada.'), findsOneWidget);
      expect(find.text('FACTURADO'), findsOneWidget);
      expect(find.text('Marcar como facturada'), findsNothing);
    });

    testWidgets('anular advierte que los insumos vuelven al inventario', (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        '/service-orders/$_number/cancel',
        body: body('order_cancelled_response.json'),
      );
      await openDetail(
        tester,
        permissions: _canceller,
        order: 'order_approved_response.json',
      );
      harness.adapter.on(
        'GET',
        '/service-orders/$_number',
        body: body('order_cancelled_response.json'),
      );

      await tester.tap(find.text('Anular orden'));
      await AppHarness.settle(tester);
      expect(find.textContaining('volverán al inventario'), findsOneWidget);
      await tester.tap(find.text('Anular orden').last);
      await AppHarness.settle(tester);

      expect(find.text('Orden anulada.'), findsOneWidget);
      expect(find.text('ANULADO'), findsOneWidget);
      expect(find.text('Anular orden'), findsNothing);
    });

    testWidgets('cancelar el diálogo no envía nada', (tester) async {
      await openDetail(
        tester,
        permissions: _canceller,
        order: 'order_approved_response.json',
      );

      await tester.tap(find.text('Anular orden'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Cancelar'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/service-orders/$_number/cancel'),
        isEmpty,
      );
    });

    testWidgets('sin el permiso de editar no aparece anular', (tester) async {
      await openDetail(
        tester,
        permissions: _creator,
        order: 'order_approved_response.json',
      );

      expect(find.text('Marcar como facturada'), findsOneWidget);
      expect(find.text('Anular orden'), findsNothing);
    });

    testWidgets('una orden facturada ya no se puede anular', (tester) async {
      await openDetail(
        tester,
        permissions: _canceller,
        order: 'order_billed_response.json',
      );

      expect(find.text('FACTURADO'), findsOneWidget);
      expect(find.text('Anular orden'), findsNothing);
    });

    testWidgets('un 409 del servidor se muestra tal cual', (tester) async {
      harness.adapter.on(
        'POST',
        '/service-orders/$_number/bill',
        status: 409,
        body: errorBody(
          "La orden $_number ya se encuentra en estado 'billed'.",
        ),
      );
      await openDetail(
        tester,
        permissions: _creator,
        order: 'order_approved_response.json',
      );

      await tester.tap(find.text('Marcar como facturada'));
      await AppHarness.settle(tester);
      await tester.tap(
        find.text('Marcar como facturada').last,
      );
      await AppHarness.settle(tester);

      expect(find.textContaining('ya se encuentra en estado'), findsOneWidget);
    });

    testWidgets('sin respuesta al facturar: avisa y no reintenta', (
      tester,
    ) async {
      harness.adapter.onError(
        'POST',
        '/service-orders/$_number/bill',
        DioExceptionType.receiveTimeout,
      );
      await openDetail(
        tester,
        permissions: _creator,
        order: 'order_approved_response.json',
      );

      await tester.tap(find.text('Marcar como facturada'));
      await AppHarness.settle(tester);
      await tester.tap(
        find.text('Marcar como facturada').last,
      );
      await AppHarness.settle(tester);

      expect(
        find.textContaining('Revise el estado de la orden'),
        findsOneWidget,
      );
      expect(
        harness.adapter.callsTo('POST', '/service-orders/$_number/bill'),
        hasLength(1),
      );
    });

    testWidgets('una orden inexistente muestra el error con reintento', (
      tester,
    ) async {
      harness.adapter.on(
        'GET',
        '/service-orders/$_number',
        status: 404,
        body: errorBody('Orden $_number no encontrada.'),
      );
      await openOrders(tester);
      await tester.enterText(find.byType(TextField).first, _number);
      await tester.tap(find.text('Buscar orden'));
      await AppHarness.settle(tester);

      expect(find.textContaining('no encontrada'), findsOneWidget);
      expect(find.text('Reintentar'), findsOneWidget);
    });
  });
}
