import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/push/push_gateway.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fake_push_gateway.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  final t0 = DateTime(2026, 11, 25, 8);
  late FakeHttpAdapter adapter;
  late InMemoryTokenStore store;
  late FakePushGateway gateway;

  Future<ProviderContainer> build() async {
    final container = ProviderContainer(
      retry: noAutoRetry,
      overrides: [
        ...await baseOverrides(
          adapter: adapter,
          store: store,
          clock: TestClock(t0),
        ),
        pushGatewayProvider.overrideWithValue(gateway),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  Future<void> settle(ProviderContainer container) async {
    container.read(sessionControllerProvider);
    for (var i = 0; i < 50; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  List<String> calls() => [
    for (final request in adapter.requests) '${request.method} ${request.path}',
  ];

  void stubLogin() {
    final body = fixture('auth/login_response.json');
    (body['data'] as Map<String, dynamic>)['token'] = '1|token-nuevo';
    adapter
      ..on('POST', '/auth/login', body: body)
      ..on('POST', '/auth/devices', body: envelope(null))
      ..on('DELETE', '/auth/devices/fcm-token-1', body: envelope(null))
      ..on('POST', '/auth/logout', body: envelope(null));
  }

  setUp(() {
    adapter = FakeHttpAdapter();
    store = InMemoryTokenStore();
    gateway = FakePushGateway();
  });

  test('al iniciar sesión se registra el teléfono para sus avisos', () async {
    stubLogin();
    final container = await build();
    await settle(container);

    await container
        .read(sessionControllerProvider.notifier)
        .login(email: 'usuario.prueba@example.com', password: 'secreto123');
    await settle(container);

    expect(calls(), contains('POST /auth/devices'));
    final data =
        adapter.callsTo('POST', '/auth/devices').single.data
            as Map<String, dynamic>;
    expect(data['token'], 'fcm-token-1');
  });

  test('al restaurar una sesión válida también se registra', () async {
    store.session = StoredSession(
      token: 'abc',
      startedAt: t0.subtract(const Duration(hours: 1)),
      tokenIssuedAt: t0.subtract(const Duration(hours: 1)),
      lastActiveAt: t0.subtract(const Duration(minutes: 1)),
    );
    adapter
      ..on('GET', '/auth/me', body: fixture('auth/me_response.json'))
      ..on('POST', '/auth/devices', body: envelope(null));
    final container = await build();

    await settle(container);

    expect(adapter.callsTo('POST', '/auth/devices'), hasLength(1));
  });

  test('al cerrar sesión se da de baja el teléfono ANTES de revocar', () async {
    stubLogin();
    final container = await build();
    await settle(container);
    final session = container.read(sessionControllerProvider.notifier);
    await session.login(
      email: 'usuario.prueba@example.com',
      password: 'secreto123',
    );
    await settle(container);

    await session.logout();

    final order = calls();
    expect(
      order.indexOf('DELETE /auth/devices/fcm-token-1'),
      lessThan(order.indexOf('POST /auth/logout')),
      reason: 'con el token revocado el servidor ya no acepta la baja',
    );
    final delete = adapter.requests.firstWhere((r) => r.method == 'DELETE');
    expect(delete.headers['Authorization'], 'Bearer 1|token-nuevo');
    expect(
      container.read(sessionControllerProvider),
      isA<SessionUnauthenticated>(),
    );
  });

  test('si la baja del push falla, la sesión se cierra igual', () async {
    stubLogin();
    adapter.on(
      'DELETE',
      '/auth/devices/fcm-token-1',
      status: 500,
      body: errorBody('Falla'),
    );
    final container = await build();
    await settle(container);
    final session = container.read(sessionControllerProvider.notifier);
    await session.login(
      email: 'usuario.prueba@example.com',
      password: 'secreto123',
    );
    await settle(container);

    await session.logout();

    expect(calls(), contains('POST /auth/logout'));
    expect(store.session, isNull);
  });

  test('sin push disponible no se llama a /auth/devices', () async {
    stubLogin();
    gateway.available = false;
    final container = await build();
    await settle(container);
    final session = container.read(sessionControllerProvider.notifier);

    await session.login(
      email: 'usuario.prueba@example.com',
      password: 'secreto123',
    );
    await settle(container);
    await session.logout();

    expect(calls().where((c) => c.contains('/auth/devices')), isEmpty);
  });
}
