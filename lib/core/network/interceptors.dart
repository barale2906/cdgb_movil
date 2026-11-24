import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';

/// Clave de `RequestOptions.extra` para peticiones públicas (login): no
/// llevan token y un 401 no cierra la sesión.
const skipAuthExtra = 'skipAuth';

/// Agrega `Authorization: Bearer` desde el token en memoria.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._readToken);

  final String? Function() _readToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isPublic = options.extra[skipAuthExtra] == true;
    final hasExplicitToken = options.headers.containsKey('Authorization');
    final token = _readToken();
    if (!isPublic && !hasExplicitToken && token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

/// Convierte cada fallo en [ApiException] y avisa cuando la sesión ya no es
/// válida (401 fuera del login, o cuenta desactivada).
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({required this.onSessionInvalid, this.onForbidden});

  final void Function(ApiException error) onSessionInvalid;

  /// 403 por permiso: los permisos pudieron cambiar; conviene refrescarlos.
  final void Function()? onForbidden;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final mapped = ApiErrorMapper.fromDio(err);
    final isPublic = err.requestOptions.extra[skipAuthExtra] == true;
    final invalidatesSession =
        (mapped is UnauthenticatedException && !isPublic) ||
        (mapped is ForbiddenException && mapped.accountDisabled);
    if (invalidatesSession) {
      onSessionInvalid(mapped);
    } else if (mapped is ForbiddenException && !isPublic) {
      onForbidden?.call();
    }

    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: mapped,
      ),
    );
  }
}

/// Bitácora de red solo en dev: método, ruta y estado. Nunca cabeceras,
/// cuerpos ni parámetros (podrían contener contraseñas, tokens o datos
/// de pacientes).
class SafeLogInterceptor extends Interceptor {
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _log(response.requestOptions, response.statusCode);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log(err.requestOptions, err.response?.statusCode);
    handler.next(err);
  }

  void _log(RequestOptions options, int? status) {
    developer.log(
      '${options.method} ${options.uri.path} → ${status ?? 'sin respuesta'}',
      name: 'http',
    );
  }
}
