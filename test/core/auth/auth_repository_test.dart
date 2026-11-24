import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/auth_repository.dart';
import 'package:sga_bojanini/core/auth/auth_token_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  late FakeHttpAdapter adapter;
  late ProviderContainer container;
  late AuthRepository repository;

  setUp(() async {
    adapter = FakeHttpAdapter();
    container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: InMemoryTokenStore(),
        clock: TestClock(DateTime(2026, 11, 24, 8)),
      ),
    );
    addTearDown(container.dispose);
    // Evita que el controlador de sesión intente restaurar durante la prueba.
    repository = container.read(authRepositoryProvider);
  });

  group('login', () {
    test('envía credenciales y device_name sin Authorization', () async {
      adapter.on(
        'POST',
        '/auth/login',
        body: fixture('auth/login_response.json'),
      );
      container.read(authTokenProvider.notifier).replace('token-previo');

      final result = await repository.login(
        email: 'usuario.prueba@example.com',
        password: 'secreto123',
        deviceName: 'Equipo de pruebas',
      );

      final request = adapter.requests.single;
      expect(request.data, {
        'email': 'usuario.prueba@example.com',
        'password': 'secreto123',
        'device_name': 'Equipo de pruebas',
      });
      expect(request.headers.containsKey('Authorization'), isFalse);
      expect(request.headers['Accept'], 'application/json');
      expect(result.token, '1|token-de-prueba');
      expect(result.user.id, 42);
    });

    test(
      '401 de credenciales no cierra la sesión y llega al llamador',
      () async {
        adapter.on(
          'POST',
          '/auth/login',
          status: 401,
          body: errorBody('Credenciales inválidas.'),
        );
        await expectLater(
          repository.login(email: 'a@b.co', password: 'x', deviceName: 'd'),
          throwsA(
            isA<UnauthenticatedException>().having(
              (e) => e.message,
              'message',
              'Credenciales inválidas.',
            ),
          ),
        );
      },
    );

    test('409 cuenta desactivada', () async {
      adapter.on(
        'POST',
        '/auth/login',
        status: 409,
        body: errorBody(
          'Tu cuenta está desactivada. Contacta al administrador.',
        ),
      );
      await expectLater(
        repository.login(email: 'a@b.co', password: 'x', deviceName: 'd'),
        throwsA(isA<BusinessRuleException>()),
      );
    });
  });

  group('peticiones autenticadas', () {
    setUp(() => container.read(authTokenProvider.notifier).replace('abc'));

    test('me agrega el Bearer del token en memoria', () async {
      adapter.on('GET', '/auth/me', body: fixture('auth/me_response.json'));
      final user = await repository.me();
      expect(adapter.requests.single.headers['Authorization'], 'Bearer abc');
      expect(user.warehouses, hasLength(1));
    });

    test('menu devuelve el árbol', () async {
      adapter.on('GET', '/auth/menu', body: fixture('auth/menu_response.json'));
      final menu = await repository.menu();
      expect(menu.map((m) => m.key), [
        'dashboard',
        'inventory-management',
        'purchasing',
      ]);
    });

    test('refresh devuelve el token nuevo', () async {
      adapter.on('POST', '/auth/refresh', body: envelope({'token': '2|nuevo'}));
      expect(await repository.refresh(), '2|nuevo');
    });

    test('logout puede revocar un token explícito', () async {
      adapter.on('POST', '/auth/logout', body: envelope(null));
      await repository.logout(token: 'otro');
      expect(adapter.requests.single.headers['Authorization'], 'Bearer otro');
    });

    test('changePassword envía la confirmación', () async {
      adapter.on('PUT', '/auth/password', body: envelope(null));
      await repository.changePassword(
        currentPassword: 'vieja123',
        newPassword: 'nueva1234',
      );
      expect(adapter.requests.single.data, {
        'current_password': 'vieja123',
        'new_password': 'nueva1234',
        'new_password_confirmation': 'nueva1234',
      });
    });

    test('changePassword propaga 422 con errores por campo', () async {
      adapter.on(
        'PUT',
        '/auth/password',
        status: 422,
        body: errorBody(
          'Inválido',
          extra: {
            'errors': {
              'current_password': ['La contraseña actual no es correcta.'],
            },
          },
        ),
      );
      await expectLater(
        repository.changePassword(
          currentPassword: 'x',
          newPassword: 'nueva1234',
        ),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.firstErrorFor('current_password'),
            'campo',
            'La contraseña actual no es correcta.',
          ),
        ),
      );
    });

    test('sin red: NetworkException', () async {
      adapter.onSocketFailure('GET', '/auth/me');
      await expectLater(repository.me(), throwsA(isA<NetworkException>()));
    });

    test('timeout: NetworkException de tipo timeout', () async {
      adapter.onError('GET', '/auth/me', DioExceptionType.receiveTimeout);
      await expectLater(
        repository.me(),
        throwsA(
          isA<NetworkException>().having(
            (e) => e.kind,
            'kind',
            NetworkFailureKind.timeout,
          ),
        ),
      );
    });
  });
}
