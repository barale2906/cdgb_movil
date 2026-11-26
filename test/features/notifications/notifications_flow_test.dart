import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _permissions = ['notificaciones.ver', 'stock.ver', 'almacenes.ver'];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}));

  Future<void> open(
    WidgetTester tester, {
    List<String> permissions = _permissions,
    int unread = 3,
  }) async {
    harness
      ..stubSignedInUser(
        permissions: permissions,
        menu: 'auth/menu_inventory_response.json',
      )
      ..stubInventoryReads()
      ..stubDashboard(unread: unread)
      ..storeSession();
    harness.adapter.on(
      'GET',
      '/notifications',
      body: fixture('notifications/list_response.json'),
    );
    await harness.pump(tester);
  }

  Future<void> openCenter(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Abrir notificaciones'));
    await AppHarness.settle(tester);
  }

  testWidgets('la campana muestra el contador de sin leer', (tester) async {
    await open(tester);

    expect(find.text('3'), findsOneWidget);
    expect(find.bySemanticsLabel('3 notificaciones sin leer'), findsOneWidget);
  });

  testWidgets(
    'sin notificaciones.ver no hay campana ni se consulta el contador',
    (tester) async {
      await open(tester, permissions: ['stock.ver']);

      expect(find.byTooltip('Abrir notificaciones'), findsNothing);
      expect(
        harness.adapter.callsTo('GET', '/notifications/unread-count'),
        isEmpty,
      );
    },
  );

  testWidgets('el contador se actualiza solo cada 60 s', (tester) async {
    await open(tester, unread: 1);
    expect(find.text('1'), findsOneWidget);
    harness.adapter.on(
      'GET',
      '/notifications/unread-count',
      body: envelope({'count': 5}),
    );

    await tester.pump(const Duration(seconds: 61));
    await AppHarness.settle(tester, frames: 3);

    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('un fallo del sondeo conserva el último valor', (tester) async {
    await open(tester, unread: 4);
    harness.adapter.onSocketFailure('GET', '/notifications/unread-count');

    await tester.pump(const Duration(seconds: 61));
    await AppHarness.settle(tester, frames: 3);

    expect(find.text('4'), findsOneWidget);
  });

  testWidgets('el centro lista las notificaciones con severidad y estado', (
    tester,
  ) async {
    await open(tester);
    await openCenter(tester);

    expect(find.text('Stock bajo'), findsOneWidget);
    expect(find.text('CRÍTICA'), findsOneWidget);
    expect(find.text('ADVERTENCIA'), findsOneWidget);
    expect(find.text('SIN LEER'), findsNWidgets(3));
    expect(
      find.text('Aviso general'),
      findsOneWidget,
      reason: 'tipo y severidad desconocidos',
    );
  });

  testWidgets('abrir una notificación la marca leída y lleva a su módulo', (
    tester,
  ) async {
    await open(tester);
    harness.adapter.on(
      'PUT',
      '/notifications/a1b2-uuid-1/read',
      body: envelope(null),
    );
    await openCenter(tester);

    await tester.tap(find.text('Stock bajo'));
    await AppHarness.settle(tester);

    expect(
      harness.adapter.callsTo('PUT', '/notifications/a1b2-uuid-1/read'),
      hasLength(1),
    );
    expect(
      find.text('Existencias'),
      findsOneWidget,
      reason: 'abrió Inventario',
    );
  });

  testWidgets('una notificación sin destino se marca leída y se queda', (
    tester,
  ) async {
    await open(tester);
    harness.adapter.on(
      'PUT',
      '/notifications/a1b2-uuid-4/read',
      body: envelope(null),
    );
    await openCenter(tester);

    await tester.tap(find.text('Aviso general'));
    await AppHarness.settle(tester);

    expect(
      harness.adapter.callsTo('PUT', '/notifications/a1b2-uuid-4/read'),
      hasLength(1),
    );
    expect(find.text('Notificaciones'), findsWidgets);
  });

  testWidgets('"Marcar todas como leídas" avisa y deja el contador en cero', (
    tester,
  ) async {
    await open(tester);
    harness.adapter.on('POST', '/notifications/read-all', body: envelope(null));
    await openCenter(tester);

    await tester.tap(find.text('Marcar todas como leídas'));
    await AppHarness.settle(tester);

    expect(
      find.text('Todas las notificaciones quedaron leídas.'),
      findsOneWidget,
    );
    expect(find.text('Marcar todas como leídas'), findsNothing);
  });

  testWidgets('el filtro "Sin leer" pide unread_only', (tester) async {
    await open(tester);
    await openCenter(tester);

    await tester.tap(find.text('Sin leer').first);
    await AppHarness.settle(tester);

    final filters = harness.adapter
        .callsTo('GET', '/notifications')
        .map((r) => r.queryParameters['unread_only'])
        .toList();
    expect(filters, contains(true));
  });

  testWidgets('lista vacía: mensaje', (tester) async {
    await open(tester);
    harness.adapter.on('GET', '/notifications', body: pagedBody([]));
    // La primera consulta usó la lista completa; con el filtro llega vacía.
    await openCenter(tester);
    harness.adapter.on('GET', '/notifications', body: pagedBody([]));
    await tester.tap(find.text('Sin leer').first);
    await AppHarness.settle(tester);

    expect(find.text('No tiene notificaciones sin leer.'), findsOneWidget);
  });
}
