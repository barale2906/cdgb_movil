import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';

void main() {
  group('AppEnvironment.fromValues', () {
    test('construye un destino dev válido con valores por defecto', () {
      final env = AppEnvironment.fromValues(
        env: 'dev',
        apiBaseUrl: 'http://10.0.2.2:8000/api/v1',
      );

      expect(env.env, AppEnv.dev);
      expect(env.isDev, isTrue);
      expect(env.apiBaseUrl.toString(), 'http://10.0.2.2:8000/api/v1');
      expect(env.updateUrl, isNull);
      expect(env.inactivityLockMinutes, 15);
      expect(env.sessionMaxHours, 12);
      expect(env.httpLogs, isFalse);
    });

    test('quita la barra final de la URL base', () {
      final env = AppEnvironment.fromValues(
        env: 'dev',
        apiBaseUrl: 'http://localhost:8000/api/v1/',
      );

      expect(env.apiBaseUrl.toString(), 'http://localhost:8000/api/v1');
    });

    test('acepta prod con HTTPS y URL de actualización', () {
      final env = AppEnvironment.fromValues(
        env: 'prod',
        apiBaseUrl: 'https://api.example.com/api/v1',
        updateUrl: 'https://files.example.com/app/version.json',
      );

      expect(env.env, AppEnv.prod);
      expect(env.isDev, isFalse);
      expect(
        env.updateUrl.toString(),
        'https://files.example.com/app/version.json',
      );
    });

    test('rechaza HTTP en prod', () {
      expect(
        () => AppEnvironment.fromValues(
          env: 'prod',
          apiBaseUrl: 'http://api.example.com/api/v1',
        ),
        throwsA(isA<AppEnvironmentException>()),
      );
    });

    test('nunca activa logs de red en prod', () {
      final env = AppEnvironment.fromValues(
        env: 'prod',
        apiBaseUrl: 'https://api.example.com/api/v1',
        httpLogs: 'true',
      );

      expect(env.httpLogs, isFalse);
    });

    test('activa logs de red en dev solo si HTTP_LOGS es true', () {
      final env = AppEnvironment.fromValues(
        env: 'dev',
        apiBaseUrl: 'http://localhost:8000/api/v1',
        httpLogs: 'true',
      );

      expect(env.httpLogs, isTrue);
    });

    test('rechaza URL base vacía (se ejecutó sin env/*.json)', () {
      expect(
        () => AppEnvironment.fromValues(env: 'dev', apiBaseUrl: ''),
        throwsA(
          isA<AppEnvironmentException>().having(
            (e) => e.message,
            'message',
            contains('dart-define-from-file'),
          ),
        ),
      );
    });

    test('rechaza URL base sin host', () {
      expect(
        () => AppEnvironment.fromValues(env: 'dev', apiBaseUrl: 'api/v1'),
        throwsA(isA<AppEnvironmentException>()),
      );
    });

    test('rechaza ENV desconocido', () {
      expect(
        () => AppEnvironment.fromValues(
          env: 'stg',
          apiBaseUrl: 'https://api.example.com/api/v1',
        ),
        throwsA(isA<AppEnvironmentException>()),
      );
    });

    test('rechaza UPDATE_URL inválida', () {
      expect(
        () => AppEnvironment.fromValues(
          env: 'dev',
          apiBaseUrl: 'http://localhost:8000/api/v1',
          updateUrl: 'version.json',
        ),
        throwsA(isA<AppEnvironmentException>()),
      );
    });

    test('una clave de tiempo vacía toma el valor por defecto', () {
      final env = AppEnvironment.fromValues(
        env: 'dev',
        apiBaseUrl: 'http://localhost:8000/api/v1',
        inactivityLockMinutes: ' ',
        sessionMaxHours: '',
      );

      expect(
        env.inactivityLockMinutes,
        AppEnvironment.defaultInactivityLockMinutes,
      );
      expect(env.sessionMaxHours, AppEnvironment.defaultSessionMaxHours);
    });

    for (final invalid in ['0', '-5', 'abc']) {
      test('rechaza tiempos de sesión no positivos: "$invalid"', () {
        expect(
          () => AppEnvironment.fromValues(
            env: 'dev',
            apiBaseUrl: 'http://localhost:8000/api/v1',
            inactivityLockMinutes: invalid,
          ),
          throwsA(isA<AppEnvironmentException>()),
        );
        expect(
          () => AppEnvironment.fromValues(
            env: 'dev',
            apiBaseUrl: 'http://localhost:8000/api/v1',
            sessionMaxHours: invalid,
          ),
          throwsA(isA<AppEnvironmentException>()),
        );
      });
    }
  });
}
