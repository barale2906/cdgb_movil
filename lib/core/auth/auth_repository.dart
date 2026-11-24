import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/auth_user.dart';
import 'package:sga_bojanini/core/auth/menu_item.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/network/interceptors.dart';

class LoginResult {
  const LoginResult({required this.token, required this.user});

  final String token;
  final AuthUser user;
}

/// Endpoints de sesión: `docs/app-movil/02-auth.md` del backend.
class AuthRepository {
  const AuthRepository(this._dio);

  final Dio _dio;

  Future<LoginResult> login({
    required String email,
    required String password,
    required String deviceName,
  }) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/auth/login',
      data: {'email': email, 'password': password, 'device_name': deviceName},
      options: Options(extra: {skipAuthExtra: true}),
    );
    final data = ApiResponse.object(response);
    return LoginResult(
      token: data['token'] as String,
      user: AuthUser.fromJson(data['user'] as Json),
    );
  });

  /// Cierra la sesión del [token] indicado, o la del token actual si es null.
  Future<void> logout({String? token}) => apiCall(
    () => _dio.post<dynamic>(
      '/auth/logout',
      options: token == null
          ? null
          : Options(headers: {'Authorization': 'Bearer $token'}),
    ),
  );

  Future<AuthUser> me() => apiCall(() async {
    final response = await _dio.get<dynamic>('/auth/me');
    return AuthUser.fromJson(ApiResponse.object(response));
  });

  Future<List<MenuItem>> menu() => apiCall(() async {
    final response = await _dio.get<dynamic>('/auth/menu');
    return ApiResponse.list(response, MenuItem.fromJson);
  });

  /// Devuelve el token nuevo; el anterior vive solo 120 s.
  Future<String> refresh() => apiCall(() async {
    final response = await _dio.post<dynamic>('/auth/refresh');
    return ApiResponse.object(response)['token'] as String;
  });

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => apiCall(
    () => _dio.put<dynamic>(
      '/auth/password',
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPassword,
      },
    ),
  );
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(dioProvider)),
);
