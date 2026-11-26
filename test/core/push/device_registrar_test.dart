import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/auth_token_provider.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/push/device_registrar.dart';
import 'package:sga_bojanini/core/push/devices_repository.dart';
import 'package:sga_bojanini/core/push/push_gateway.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fake_push_gateway.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  late FakeHttpAdapter adapter;
  late FakePushGateway gateway;

  Future<ProviderContainer> build({PushGateway? override}) async {
    final container = ProviderContainer(
      retry: noAutoRetry,
      overrides: [
        ...await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 25, 8)),
        ),
        pushGatewayProvider.overrideWithValue(override ?? gateway),
      ],
    );
    addTearDown(container.dispose);
    container.read(authTokenProvider.notifier).replace('sesion-actual');
    return container;
  }

  setUp(() {
    adapter = FakeHttpAdapter();
    gateway = FakePushGateway();
  });

  group('DevicesRepository', () {
    test('registra token, plataforma y nombre del equipo', () async {
      adapter.on('POST', '/auth/devices', body: envelope(null));
      final container = await build();

      await container
          .read(devicesRepositoryProvider)
          .register(
            token: 'abc:123',
            platform: 'android',
            deviceName: 'SGA Android · a1b2c3',
          );

      expect(adapter.callsTo('POST', '/auth/devices').single.data, {
        'token': 'abc:123',
        'platform': 'android',
        'device_name': 'SGA Android · a1b2c3',
      });
    });

    test('la baja codifica el token y usa la sesión indicada', () async {
      adapter.on('DELETE', '/auth/devices/a%2Fb%3Ac', body: envelope(null));
      final container = await build();

      await container
          .read(devicesRepositoryProvider)
          .unregister('a/b:c', authToken: 'sesion-vieja');

      final call = adapter.requests.single;
      expect(call.method, 'DELETE');
      expect(call.headers['Authorization'], 'Bearer sesion-vieja');
    });
  });

  group('DeviceRegistrar', () {
    test('pide permiso, toma el token y lo registra', () async {
      adapter.on('POST', '/auth/devices', body: envelope(null));
      final container = await build();

      await container.read(deviceRegistrarProvider).registerQuietly();

      expect(gateway.permissionRequests, 1);
      final data =
          adapter.callsTo('POST', '/auth/devices').single.data
              as Map<String, dynamic>;
      expect(data['token'], 'fcm-token-1');
      expect(data['platform'], 'android');
      expect(data['device_name'], 'Equipo de pruebas');
    });

    test('sin permiso de notificaciones no registra nada', () async {
      gateway.permissionGranted = false;
      final container = await build();

      await container.read(deviceRegistrarProvider).registerQuietly();

      expect(adapter.requests, isEmpty);
    });

    test('push no disponible (sin Firebase): no hace nada', () async {
      final container = await build(override: const DisabledPushGateway());

      await container.read(deviceRegistrarProvider).registerQuietly();
      await container
          .read(deviceRegistrarProvider)
          .unregisterQuietly(authToken: 'x');

      expect(adapter.requests, isEmpty);
    });

    test(
      'sin token o con el servicio fallando: no rompe ni registra',
      () async {
        gateway.tokenValue = null;
        final container = await build();
        await container.read(deviceRegistrarProvider).registerQuietly();

        gateway
          ..tokenValue = 'x'
          ..throwOnToken = true;
        await container.read(deviceRegistrarProvider).registerQuietly();

        expect(adapter.requests, isEmpty);
      },
    );

    test('un error del servidor se traga: el push nunca bloquea', () async {
      adapter
        ..on('POST', '/auth/devices', status: 500, body: errorBody('Falla'))
        ..onError(
          'DELETE',
          '/auth/devices/fcm-token-1',
          DioExceptionType.connectionTimeout,
        );
      final container = await build();
      final registrar = container.read(deviceRegistrarProvider);

      await registrar.registerQuietly();
      await registrar.registerToken('otro');
      await registrar.unregisterQuietly(authToken: 'sesion-actual');

      expect(adapter.callsTo('POST', '/auth/devices'), hasLength(2));
    });

    test('la baja no vuelve a pedir el permiso', () async {
      adapter.on('DELETE', '/auth/devices/fcm-token-1', body: envelope(null));
      final container = await build();

      await container
          .read(deviceRegistrarProvider)
          .unregisterQuietly(authToken: 'sesion-actual');

      expect(gateway.permissionRequests, 0);
      expect(
        adapter.callsTo('DELETE', '/auth/devices/fcm-token-1'),
        hasLength(1),
      );
    });
  });
}
