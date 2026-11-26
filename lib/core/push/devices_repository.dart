import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';

/// Dispositivos del usuario para push (`POST/DELETE /auth/devices`).
class DevicesRepository {
  const DevicesRepository(this._dio);

  final Dio _dio;

  Future<void> register({
    required String token,
    required String platform,
    required String deviceName,
  }) => apiCall(
    () => _dio.post<dynamic>(
      '/auth/devices',
      data: {'token': token, 'platform': platform, 'device_name': deviceName},
    ),
  );

  /// Desvincula [token]. Con [authToken] actúa en nombre de esa sesión (el
  /// cierre de sesión la revoca justo después).
  Future<void> unregister(String token, {String? authToken}) => apiCall(
    () => _dio.delete<dynamic>(
      '/auth/devices/${Uri.encodeComponent(token)}',
      options: authToken == null
          ? null
          : Options(headers: {'Authorization': 'Bearer $authToken'}),
    ),
  );
}

final devicesRepositoryProvider = Provider<DevicesRepository>(
  (ref) => DevicesRepository(ref.watch(dioProvider)),
);
