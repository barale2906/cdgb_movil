import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/push/push_gateway.dart';
import 'package:sga_bojanini/features/notifications/application/notification_target.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fake_push_gateway.dart';
import '../../helpers/fixtures.dart';

const _permissions = [
  'ordenes_compra.ver',
  'stock.ver',
  'almacenes.ver',
  'notificaciones.ver',
  'tablero.ver',
];

void main() {
  late FakePushGateway push;
  late AppHarness harness;

  setUp(() {
    push = FakePushGateway();
    harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}, push: push);
  });

  Future<void> open(
    WidgetTester tester, {
    Duration activeAgo = const Duration(minutes: 1),
  }) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: _permissions)
      ..stubPurchasingReads()
      ..stubDashboard()
      ..storeSession(activeAgo: activeAgo);
    harness.adapter
      ..on('POST', '/auth/devices', body: envelope(null))
      ..on('GET', '/stock', body: fixture('inventory/stock_response.json'));
    await harness.pump(tester);
  }

  group('notificationTargetForType', () {
    test('lleva cada tipo a su sección', () {
      expect(
        notificationTargetForType('purchase_order_pending_approval'),
        '/purchasing',
      );
      expect(notificationTargetForType('stock_below_reorder'), '/inventory');
      expect(notificationTargetForType('report_ready'), '/reports/exports');
    });

    test('tipo desconocido o ausente: sin destino', () {
      expect(notificationTargetForType('algo_nuevo'), isNull);
      expect(notificationTargetForType(null), isNull);
    });
  });

  testWidgets('tocar un aviso con la app abierta lleva a su sección', (
    tester,
  ) async {
    await open(tester);

    push.emitOpened('purchase_order_pending_approval');
    await AppHarness.settle(tester);

    expect(find.text('OC-2026-0011'), findsOneWidget);
  });

  testWidgets('un aviso sin tipo conocido no cambia de pantalla', (
    tester,
  ) async {
    await open(tester);

    push.emitOpened('algo_nuevo');
    await AppHarness.settle(tester);

    expect(find.text('OC-2026-0011'), findsNothing);
  });

  testWidgets('la app abierta desde un aviso (cerrada) va a su destino', (
    tester,
  ) async {
    push.initial = const PushMessage(type: 'purchase_order_pending_approval');
    await open(tester);

    expect(find.text('OC-2026-0011'), findsOneWidget);
  });

  testWidgets('con la sesión bloqueada el destino espera al desbloqueo', (
    tester,
  ) async {
    await open(tester, activeAgo: const Duration(minutes: 30));
    expect(find.text('Sesión bloqueada'), findsOneWidget);

    push.emitOpened('purchase_order_pending_approval');
    await AppHarness.settle(tester);
    expect(find.text('OC-2026-0011'), findsNothing);

    final login = fixture('auth/login_response.json');
    ((login['data'] as Map<String, dynamic>)['user']
            as Map<String, dynamic>)['permissions'] =
        _permissions;
    harness.adapter
      ..on('POST', '/auth/login', body: login)
      ..on('POST', '/auth/logout', body: envelope(null));
    await tester.enterText(find.byType(TextFormField).first, 'secreto123');
    await tester.tap(find.text('Desbloquear'));
    await AppHarness.settle(tester);

    expect(find.text('OC-2026-0011'), findsOneWidget);
  });

  testWidgets('un aviso con la app abierta actualiza el contador', (
    tester,
  ) async {
    await open(tester);
    final before = harness.adapter
        .callsTo('GET', '/notifications/unread-count')
        .length;

    push.emitForeground('stock_below_reorder');
    await AppHarness.settle(tester);

    expect(
      harness.adapter.callsTo('GET', '/notifications/unread-count').length,
      greaterThan(before),
    );
  });

  testWidgets('un token renovado se registra con la sesión iniciada', (
    tester,
  ) async {
    await open(tester);
    final before = harness.adapter.callsTo('POST', '/auth/devices').length;

    push.emitRefresh('token-renovado');
    await AppHarness.settle(tester);

    final calls = harness.adapter.callsTo('POST', '/auth/devices').toList();
    expect(calls.length, before + 1);
    expect(
      (calls.last.data as Map<String, dynamic>)['token'],
      'token-renovado',
    );
  });
}
