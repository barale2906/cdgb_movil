import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/auth_token_provider.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  final t0 = DateTime(2026, 11, 24, 8);
  late FakeHttpAdapter adapter;
  late InMemoryTokenStore store;
  late TestClock clock;

  Future<ProviderContainer> build() async {
    final container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: store,
        clock: clock,
      ),
    );
    addTearDown(container.dispose);
    return container;
  }

  /// Espera a que el controlador salga de `restoring`.
  Future<SessionState> settle(ProviderContainer container) async {
    container.read(sessionControllerProvider);
    for (var i = 0; i < 50; i++) {
      if (container.read(sessionControllerProvider) is! SessionRestoring) break;
      await Future<void>.delayed(Duration.zero);
    }
    return container.read(sessionControllerProvider);
  }

  void stubLogin({String token = '1|token-de-prueba'}) {
    final body = fixture('auth/login_response.json');
    (body['data'] as Map<String, dynamic>)['token'] = token;
    adapter.on('POST', '/auth/login', body: body);
  }

  setUp(() {
    adapter = FakeHttpAdapter();
    store = InMemoryTokenStore();
    clock = TestClock(t0);
  });

  group('restore', () {
    test('sin token guardado: sin sesión', () async {
      final container = await build();
      expect(await settle(container), isA<SessionUnauthenticated>());
    });

    test(
      'token válido: autenticado y desbloqueado si la actividad es reciente',
      () async {
        store.session = StoredSession(
          token: 'abc',
          startedAt: t0.subtract(const Duration(hours: 1)),
          tokenIssuedAt: t0.subtract(const Duration(hours: 1)),
          lastActiveAt: t0.subtract(const Duration(minutes: 2)),
        );
        adapter.on('GET', '/auth/me', body: fixture('auth/me_response.json'));
        final container = await build();

        final state = await settle(container);

        expect(state, isA<SessionAuthenticated>());
        expect((state as SessionAuthenticated).locked, isFalse);
        expect(container.read(authTokenProvider), 'abc');
      },
    );

    test('tras más del tiempo de inactividad arranca bloqueado', () async {
      store.session = StoredSession(
        token: 'abc',
        startedAt: t0.subtract(const Duration(hours: 1)),
        tokenIssuedAt: t0.subtract(const Duration(hours: 1)),
        lastActiveAt: t0.subtract(const Duration(minutes: 20)),
      );
      adapter.on('GET', '/auth/me', body: fixture('auth/me_response.json'));
      final state = await settle(await build());
      expect((state as SessionAuthenticated).locked, isTrue);
    });

    test(
      'sin marca de actividad arranca bloqueado (seguro por defecto)',
      () async {
        store.session = StoredSession(
          token: 'abc',
          startedAt: t0,
          tokenIssuedAt: t0,
        );
        adapter.on('GET', '/auth/me', body: fixture('auth/me_response.json'));
        final state = await settle(await build());
        expect((state as SessionAuthenticated).locked, isTrue);
      },
    );

    test('turno vencido: revoca el token, limpia y avisa el motivo', () async {
      store.session = StoredSession(
        token: 'abc',
        startedAt: t0.subtract(const Duration(hours: 13)),
        tokenIssuedAt: t0.subtract(const Duration(hours: 13)),
        lastActiveAt: t0,
      );
      adapter.on('POST', '/auth/logout', body: envelope(null));
      final container = await build();

      final state = await settle(container);

      expect(
        state,
        const SessionState.unauthenticated(reason: SessionEndReason.shiftEnded),
      );
      expect(store.session, isNull);
      expect(adapter.callsTo('POST', '/auth/logout'), hasLength(1));
    });

    test('401 al verificar: limpia el token', () async {
      store.session = StoredSession(
        token: 'abc',
        startedAt: t0,
        tokenIssuedAt: t0,
      );
      adapter.on(
        'GET',
        '/auth/me',
        status: 401,
        body: errorBody('No autenticado.'),
      );
      final container = await build();

      final state = await settle(container);

      expect(state, isA<SessionUnauthenticated>());
      expect(store.session, isNull);
      expect(container.read(authTokenProvider), isNull);
    });

    test(
      'sin red al verificar: conserva el token y permite reintentar',
      () async {
        store.session = StoredSession(
          token: 'abc',
          startedAt: t0,
          tokenIssuedAt: t0,
        );
        adapter
          ..onSocketFailure('GET', '/auth/me')
          ..on('GET', '/auth/me', body: fixture('auth/me_response.json'));
        final container = await build();

        expect(await settle(container), isA<SessionRestoreFailed>());
        expect(store.session, isNotNull);

        await container.read(sessionControllerProvider.notifier).restore();
        expect(
          container.read(sessionControllerProvider),
          isA<SessionAuthenticated>(),
        );
      },
    );

    test('renueva el token si tiene más de 24 h', () async {
      store.session = StoredSession(
        token: 'viejo',
        startedAt: t0.subtract(const Duration(hours: 2)),
        tokenIssuedAt: t0.subtract(const Duration(hours: 30)),
        lastActiveAt: t0,
      );
      adapter
        ..on('GET', '/auth/me', body: fixture('auth/me_response.json'))
        ..on('POST', '/auth/refresh', body: envelope({'token': 'nuevo'}));
      final container = await build();

      await settle(container);
      for (var i = 0; i < 50; i++) {
        if (container.read(authTokenProvider) == 'nuevo') break;
        await Future<void>.delayed(Duration.zero);
      }

      expect(container.read(authTokenProvider), 'nuevo');
      expect(store.session!.token, 'nuevo');
      expect(store.session!.tokenIssuedAt, t0);
      expect(store.session!.startedAt, t0.subtract(const Duration(hours: 2)));
    });

    test('no renueva un token reciente', () async {
      store.session = StoredSession(
        token: 'abc',
        startedAt: t0,
        tokenIssuedAt: t0.subtract(const Duration(hours: 2)),
        lastActiveAt: t0,
      );
      adapter.on('GET', '/auth/me', body: fixture('auth/me_response.json'));
      await settle(await build());
      expect(adapter.callsTo('POST', '/auth/refresh'), isEmpty);
    });
  });

  group('login / logout', () {
    test('login guarda la sesión y deja al usuario autenticado', () async {
      stubLogin();
      final container = await build();
      await settle(container);

      await container
          .read(sessionControllerProvider.notifier)
          .login(email: 'usuario.prueba@example.com', password: 'secreto123');

      final state =
          container.read(sessionControllerProvider) as SessionAuthenticated;
      expect(state.user.email, 'usuario.prueba@example.com');
      expect(state.locked, isFalse);
      expect(state.startedAt, t0);
      expect(store.session!.token, '1|token-de-prueba');
      expect(container.read(authTokenProvider), '1|token-de-prueba');
    });

    test(
      'login fallido deja la sesión como estaba y lanza la excepción',
      () async {
        adapter.on(
          'POST',
          '/auth/login',
          status: 401,
          body: errorBody('Credenciales inválidas.'),
        );
        final container = await build();
        await settle(container);

        await expectLater(
          container
              .read(sessionControllerProvider.notifier)
              .login(email: 'a@b.co', password: 'x'),
          throwsA(isA<UnauthenticatedException>()),
        );
        expect(
          container.read(sessionControllerProvider),
          isA<SessionUnauthenticated>(),
        );
        expect(store.session, isNull);
      },
    );

    test('logout revoca en el servidor, borra el token y la sesión', () async {
      stubLogin();
      adapter.on('POST', '/auth/logout', body: envelope(null));
      final container = await build();
      await settle(container);
      final notifier = container.read(sessionControllerProvider.notifier);
      await notifier.login(email: 'a@b.co', password: 'x');

      await notifier.logout();

      expect(
        container.read(sessionControllerProvider),
        const SessionState.unauthenticated(),
      );
      expect(store.session, isNull);
      expect(container.read(authTokenProvider), isNull);
      expect(
        adapter.callsTo('POST', '/auth/logout').single.headers['Authorization'],
        'Bearer 1|token-de-prueba',
      );
    });

    test('logout limpia localmente aunque el servidor no responda', () async {
      stubLogin();
      adapter.onSocketFailure('POST', '/auth/logout');
      final container = await build();
      await settle(container);
      final notifier = container.read(sessionControllerProvider.notifier);
      await notifier.login(email: 'a@b.co', password: 'x');

      await notifier.logout();

      expect(
        container.read(sessionControllerProvider),
        isA<SessionUnauthenticated>(),
      );
      expect(store.session, isNull);
    });

    test(
      'un 401 en cualquier petición cierra la sesión como "expirada"',
      () async {
        stubLogin();
        adapter.on(
          'GET',
          '/auth/menu',
          status: 401,
          body: errorBody('No autenticado.'),
        );
        final container = await build();
        await settle(container);
        await container
            .read(sessionControllerProvider.notifier)
            .login(email: 'a@b.co', password: 'x');

        await expectLater(
          container.read(dioProvider).get<dynamic>('/auth/menu'),
          throwsA(anything),
        );
        await Future<void>.delayed(Duration.zero);

        expect(
          container.read(sessionControllerProvider),
          const SessionState.unauthenticated(reason: SessionEndReason.expired),
        );
        expect(store.session, isNull);
      },
    );

    test('403 de cuenta desactivada cierra la sesión con ese motivo', () async {
      stubLogin();
      adapter.on(
        'GET',
        '/auth/menu',
        status: 403,
        body: errorBody(
          'Tu cuenta ha sido desactivada. Contacta al administrador.',
        ),
      );
      final container = await build();
      await settle(container);
      await container
          .read(sessionControllerProvider.notifier)
          .login(email: 'a@b.co', password: 'x');

      await expectLater(
        container.read(dioProvider).get<dynamic>('/auth/menu'),
        throwsA(anything),
      );
      await Future<void>.delayed(Duration.zero);

      expect(
        container.read(sessionControllerProvider),
        const SessionState.unauthenticated(
          reason: SessionEndReason.accountDisabled,
        ),
      );
    });
  });

  group('bloqueo', () {
    Future<(ProviderContainer, SessionController)> authenticated() async {
      stubLogin();
      final container = await build();
      await settle(container);
      final notifier = container.read(sessionControllerProvider.notifier);
      await notifier.login(
        email: 'usuario.prueba@example.com',
        password: 'secreto123',
      );
      return (container, notifier);
    }

    test('lock marca la sesión como bloqueada', () async {
      final (container, notifier) = await authenticated();
      notifier.lock();
      expect(
        (container.read(sessionControllerProvider) as SessionAuthenticated)
            .locked,
        isTrue,
      );
    });

    test(
      'unlock: nuevo login, revoca el token anterior y conserva el turno',
      () async {
        final (container, notifier) = await authenticated();
        notifier.lock();
        clock.advance(const Duration(hours: 3));
        stubLogin(token: '2|token-nuevo');
        adapter.on('POST', '/auth/logout', body: envelope(null));

        await notifier.unlock('secreto123');

        final state =
            container.read(sessionControllerProvider) as SessionAuthenticated;
        expect(state.locked, isFalse);
        expect(
          state.startedAt,
          t0,
          reason: 'el turno no se reinicia al desbloquear',
        );
        expect(container.read(authTokenProvider), '2|token-nuevo');
        expect(store.session!.token, '2|token-nuevo');
        expect(
          adapter
              .callsTo('POST', '/auth/logout')
              .single
              .headers['Authorization'],
          'Bearer 1|token-de-prueba',
        );
      },
    );

    test(
      'unlock con contraseña incorrecta sigue bloqueado y no toca el token',
      () async {
        final (container, notifier) = await authenticated();
        notifier.lock();
        adapter.on(
          'POST',
          '/auth/login',
          status: 401,
          body: errorBody('Credenciales inválidas.'),
        );

        await expectLater(
          notifier.unlock('mala'),
          throwsA(isA<UnauthenticatedException>()),
        );

        expect(
          (container.read(sessionControllerProvider) as SessionAuthenticated)
              .locked,
          isTrue,
        );
        expect(container.read(authTokenProvider), '1|token-de-prueba');
      },
    );
  });

  group('permisos', () {
    test('un 403 por permiso refresca los permisos con GET /auth/me', () async {
      stubLogin();
      adapter
        ..on(
          'GET',
          '/warehouses',
          status: 403,
          body: errorBody("No tienes el permiso 'almacenes.ver'."),
        )
        ..on('GET', '/auth/me', body: fixture('auth/me_response.json'));
      final container = await build();
      await settle(container);
      final notifier = container.read(sessionControllerProvider.notifier);
      await notifier.login(email: 'a@b.co', password: 'x');

      await expectLater(
        container.read(dioProvider).get<dynamic>('/warehouses'),
        throwsA(anything),
      );
      for (var i = 0; i < 50; i++) {
        final state =
            container.read(sessionControllerProvider) as SessionAuthenticated;
        if (state.user.permissions.contains('generic-products.ver')) break;
        await Future<void>.delayed(Duration.zero);
      }

      final state =
          container.read(sessionControllerProvider) as SessionAuthenticated;
      expect(state.user.permissions, contains('generic-products.ver'));
      expect(
        state,
        isA<SessionAuthenticated>(),
        reason: 'la sesión sigue activa',
      );
    });

    test('un 403 en /auth/me no entra en bucle', () async {
      stubLogin();
      adapter
        ..on('GET', '/warehouses', status: 403, body: errorBody('Sin permiso.'))
        ..on('GET', '/auth/me', status: 403, body: errorBody('Sin permiso.'));
      final container = await build();
      await settle(container);
      await container
          .read(sessionControllerProvider.notifier)
          .login(email: 'a@b.co', password: 'x');

      await expectLater(
        container.read(dioProvider).get<dynamic>('/warehouses'),
        throwsA(anything),
      );
      await Future<void>.delayed(const Duration(milliseconds: 20));

      expect(adapter.callsTo('GET', '/auth/me'), hasLength(1));
    });
  });

  group('turno', () {
    test(
      'enforceShiftLimit cierra la sesión pasadas las horas máximas',
      () async {
        stubLogin();
        adapter.on('POST', '/auth/logout', body: envelope(null));
        final container = await build();
        await settle(container);
        final notifier = container.read(sessionControllerProvider.notifier);
        await notifier.login(email: 'a@b.co', password: 'x');

        clock.advance(const Duration(hours: 11, minutes: 59));
        await notifier.enforceShiftLimit();
        expect(
          container.read(sessionControllerProvider),
          isA<SessionAuthenticated>(),
        );

        clock.advance(const Duration(minutes: 2));
        await notifier.enforceShiftLimit();
        expect(
          container.read(sessionControllerProvider),
          const SessionState.unauthenticated(
            reason: SessionEndReason.shiftEnded,
          ),
        );
      },
    );

    test(
      'recordBackground guarda la hora para decidir el bloqueo al reabrir',
      () async {
        stubLogin();
        final container = await build();
        await settle(container);
        final notifier = container.read(sessionControllerProvider.notifier);
        await notifier.login(email: 'a@b.co', password: 'x');

        clock.advance(const Duration(minutes: 5));
        await notifier.recordBackground();

        expect(store.session!.lastActiveAt, t0.add(const Duration(minutes: 5)));
      },
    );
  });
}
