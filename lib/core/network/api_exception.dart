/// Errores tipados de la API (CLAUDE.md §5). Los repositorios los lanzan;
/// la UI decide qué mostrar según el tipo.
sealed class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  /// Mensaje del servidor (en español) o vacío si no hubo respuesta.
  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// 401: token ausente, inválido o revocado; en login, credenciales erróneas.
final class UnauthenticatedException extends ApiException {
  const UnauthenticatedException(super.message) : super(statusCode: 401);
}

/// 403: sin permiso, sin acceso al almacén o cuenta desactivada.
final class ForbiddenException extends ApiException {
  const ForbiddenException(super.message, {this.accountDisabled = false})
    : super(statusCode: 403);

  /// La cuenta fue desactivada: se debe cerrar la sesión.
  final bool accountDisabled;
}

final class NotFoundException extends ApiException {
  const NotFoundException(super.message) : super(statusCode: 404);
}

/// 409: regla de negocio violada; [message] es apto para mostrar.
final class BusinessRuleException extends ApiException {
  const BusinessRuleException(super.message, {this.errorCode})
    : super(statusCode: 409);

  /// Código estable del backend, p. ej. `EXPIRED_STOCK`.
  final String? errorCode;
}

/// 422: validación fallida. Las claves de [errors] vienen tal cual del
/// servidor (p. ej. `items.0.quantity_base`).
final class ValidationException extends ApiException {
  const ValidationException(super.message, {this.errors = const {}})
    : super(statusCode: 422);

  final Map<String, List<String>> errors;

  /// Primer mensaje del campo [field], si existe.
  String? firstErrorFor(String field) {
    final messages = errors[field];
    return messages == null || messages.isEmpty ? null : messages.first;
  }
}

/// 429: demasiadas peticiones (p. ej. PIN de firma bloqueado).
final class RateLimitedException extends ApiException {
  const RateLimitedException(super.message) : super(statusCode: 429);
}

/// 410: el recurso existió y ya no está (p. ej. reporte expirado).
final class GoneException extends ApiException {
  const GoneException(super.message) : super(statusCode: 410);
}

/// 5xx o respuesta con formato inesperado.
final class ServerException extends ApiException {
  const ServerException(super.message, {super.statusCode});
}

enum NetworkFailureKind { timeout, noConnection }

/// Sin red, timeout o servidor inalcanzable (en prod: revisar la VPN).
final class NetworkException extends ApiException {
  const NetworkException(this.kind) : super('');

  final NetworkFailureKind kind;
}
