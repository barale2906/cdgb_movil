import 'package:dio/dio.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';

/// Traduce errores de Dio a [ApiException] (tabla de `docs/plan/02` §3).
abstract final class ApiErrorMapper {
  static const _accountDisabledMarker = 'desactivada';

  static ApiException fromDio(DioException error) {
    final inner = error.error;
    if (inner is ApiException) return inner;

    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout => const NetworkException(
        NetworkFailureKind.timeout,
      ),
      DioExceptionType.badResponse => _fromResponse(error.response),
      DioExceptionType.badCertificate => const ServerException(
        'Certificado del servidor no válido.',
      ),
      DioExceptionType.cancel ||
      DioExceptionType.connectionError ||
      DioExceptionType.unknown => const NetworkException(
        NetworkFailureKind.noConnection,
      ),
    };
  }

  static ApiException _fromResponse(Response<dynamic>? response) {
    final status = response?.statusCode ?? 0;
    final body = response?.data;
    final json = body is Json ? body : const <String, dynamic>{};
    final message = json['message'] as String? ?? '';

    return switch (status) {
      401 => UnauthenticatedException(message),
      403 => ForbiddenException(
        message,
        accountDisabled: message.toLowerCase().contains(_accountDisabledMarker),
      ),
      404 => NotFoundException(message),
      409 => BusinessRuleException(
        message,
        errorCode: json['error_code'] as String?,
      ),
      422 => ValidationException(message, errors: _parseErrors(json['errors'])),
      429 => RateLimitedException(message),
      _ => ServerException(message, statusCode: status),
    };
  }

  static Map<String, List<String>> _parseErrors(Object? raw) {
    if (raw is! Map<String, dynamic>) return const {};
    return {
      for (final entry in raw.entries)
        entry.key: [
          if (entry.value is List<dynamic>)
            for (final message in entry.value as List<dynamic>)
              message.toString()
          else
            entry.value.toString(),
        ],
    };
  }
}

/// Ejecuta [request] y relanza los fallos de red como [ApiException].
/// Cada repositorio llama a la API a través de esta función.
Future<T> apiCall<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (error) {
    throw ApiErrorMapper.fromDio(error);
  }
}
