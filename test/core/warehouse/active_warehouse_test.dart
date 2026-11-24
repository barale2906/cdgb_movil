import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';
import 'package:sga_bojanini/core/utils/preferences.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  final t0 = DateTime(2026, 11, 24, 8);
  late FakeHttpAdapter adapter;
  late ProviderContainer container;

  Future<void> signIn({
    List<Map<String, dynamic>>? warehouses,
    List<String>? permissions,
  }) async {
    adapter = FakeHttpAdapter();
    final me = fixture('auth/me_response.json');
    if (permissions != null) {
      (me['data'] as Map<String, dynamic>)['permissions'] = permissions;
    }
    adapter
      ..on('GET', '/auth/me', body: me)
      ..on(
        'GET',
        '/warehouses',
        body: warehouses == null
            ? fixture('auth/warehouses_response.json')
            : envelope(warehouses),
      );
    final store = InMemoryTokenStore(
      StoredSession(
        token: 'abc',
        startedAt: t0,
        tokenIssuedAt: t0,
        lastActiveAt: t0,
      ),
    );
    container = ProviderContainer(
      overrides: await baseOverrides(
        adapter: adapter,
        store: store,
        clock: TestClock(t0),
      ),
    );
    addTearDown(container.dispose);
    container.read(sessionControllerProvider);
    for (var i = 0; i < 50; i++) {
      if (container.read(sessionControllerProvider) is SessionAuthenticated) {
        break;
      }
      await Future<void>.delayed(Duration.zero);
    }
    await container.read(warehousesProvider.future);
  }

  test('con varios almacenes no hay activo hasta elegir', () async {
    await signIn();
    expect(container.read(warehousesProvider).value, hasLength(2));
    expect(container.read(activeWarehouseProvider), isNull);
  });

  test('elegir uno lo activa y lo persiste', () async {
    await signIn();

    await container.read(activeWarehouseIdProvider.notifier).select(2);

    expect(container.read(activeWarehouseProvider)?.name, 'Farmacia');
    expect(
      container.read(sharedPreferencesProvider).getInt('active_warehouse_id'),
      2,
    );
  });

  test('con un solo almacén asignado se usa ese', () async {
    await signIn(
      warehouses: [
        {'id': 7, 'name': 'Única', 'code': 'U'},
      ],
    );
    expect(container.read(activeWarehouseProvider)?.id, 7);
  });

  test('un almacén guardado que ya no está asignado se ignora', () async {
    await signIn();
    await container.read(activeWarehouseIdProvider.notifier).select(99);
    expect(container.read(activeWarehouseProvider), isNull);
  });

  test('sin almacenes.ver no se piden almacenes', () async {
    await signIn(permissions: ['stock.ver']);
    expect(container.read(warehousesProvider).value, isEmpty);
    expect(adapter.callsTo('GET', '/warehouses'), isEmpty);
  });

  test('al terminar la sesión se borra el almacén elegido', () async {
    await signIn();
    await container.read(activeWarehouseIdProvider.notifier).select(2);
    adapter.on('POST', '/auth/logout', body: envelope(null));

    await container.read(sessionControllerProvider.notifier).logout();
    await Future<void>.delayed(Duration.zero);

    expect(container.read(activeWarehouseIdProvider), isNull);
    expect(
      container.read(sharedPreferencesProvider).getInt('active_warehouse_id'),
      isNull,
    );
  });
}
