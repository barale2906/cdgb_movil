import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/device_name.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/push/devices_repository.dart';
import 'package:sga_bojanini/core/push/push_gateway.dart';

/// Vincula el teléfono con el usuario de la sesión para recibir sus avisos.
///
/// Las llamadas son "silenciosas": el push es un complemento y nunca debe
/// impedir iniciar ni cerrar sesión. En teléfonos compartidos el servidor
/// reasigna el token al nuevo usuario al registrarlo.
class DeviceRegistrar {
  const DeviceRegistrar({
    required PushGateway gateway,
    required DevicesRepository repository,
    required String deviceName,
  }) : _gateway = gateway,
       _repository = repository,
       _deviceName = deviceName;

  final PushGateway _gateway;
  final DevicesRepository _repository;
  final String _deviceName;

  /// Registra el token actual (pide el permiso si hace falta).
  Future<void> registerQuietly() async {
    final token = await _token(requestPermission: true);
    if (token == null) return;
    await _swallow(
      () => _repository.register(
        token: token,
        platform: _platform,
        deviceName: _deviceName,
      ),
    );
  }

  /// Registra un token renovado por el servicio de push.
  Future<void> registerToken(String token) => _swallow(
    () => _repository.register(
      token: token,
      platform: _platform,
      deviceName: _deviceName,
    ),
  );

  /// Desvincula el token del usuario de [authToken] antes de cerrar su
  /// sesión; sin esto el siguiente en el teléfono seguiría recibiendo sus
  /// avisos hasta registrarse.
  Future<void> unregisterQuietly({required String authToken}) async {
    final token = await _token(requestPermission: false);
    if (token == null) return;
    await _swallow(
      () => _repository.unregister(token, authToken: authToken),
    );
  }

  Future<String?> _token({required bool requestPermission}) async {
    try {
      if (!await _gateway.initialize()) return null;
      if (requestPermission && !await _gateway.requestPermission()) {
        return null;
      }
      return await _gateway.token();
    } on Object {
      return null;
    }
  }

  Future<void> _swallow(Future<void> Function() action) async {
    try {
      await action();
    } on ApiException {
      // Sin red o el servidor aún no tiene la ruta: se reintenta en el
      // siguiente inicio de sesión.
    }
  }

  static String get _platform =>
      defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
}

final deviceRegistrarProvider = Provider<DeviceRegistrar>(
  (ref) => DeviceRegistrar(
    gateway: ref.watch(pushGatewayProvider),
    repository: ref.watch(devicesRepositoryProvider),
    deviceName: ref.watch(deviceNameProvider),
  ),
);
