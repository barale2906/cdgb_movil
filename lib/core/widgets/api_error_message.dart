import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Texto para el usuario a partir de un [ApiException]: qué pasó y cómo
/// seguir, sin códigos técnicos.
abstract final class ApiErrorMessage {
  static String of(
    AppLocalizations l10n,
    ApiException? error, {
    required bool isProd,
  }) {
    return switch (error) {
      null => l10n.errorGeneric,
      NetworkException(:final kind) => _network(l10n, kind, isProd: isProd),
      // El servidor ya redacta en español estos mensajes.
      BusinessRuleException(:final message) ||
      ForbiddenException(:final message) ||
      NotFoundException(:final message) ||
      ValidationException(:final message) when message.isNotEmpty => message,
      UnauthenticatedException() => l10n.errorUnauthenticated,
      ForbiddenException() => l10n.errorForbidden,
      NotFoundException() => l10n.errorNotFound,
      RateLimitedException() => l10n.errorRateLimited,
      ServerException() => l10n.errorServer,
      BusinessRuleException() || ValidationException() => l10n.errorGeneric,
    };
  }

  /// Mensaje en formularios de acceso: el 401 es "credenciales inválidas"
  /// (no "sesión terminada") y el 409 informa cuenta desactivada.
  static String loginMessage(
    AppLocalizations l10n,
    ApiException error, {
    required bool isProd,
  }) {
    final isCredentialsError =
        error is UnauthenticatedException && error.message.isNotEmpty;
    return isCredentialsError ? error.message : of(l10n, error, isProd: isProd);
  }

  static String _network(
    AppLocalizations l10n,
    NetworkFailureKind kind, {
    required bool isProd,
  }) {
    if (kind == NetworkFailureKind.timeout) return l10n.errorTimeout;
    // En producción se llega por VPN: es lo primero que hay que revisar.
    return isProd ? l10n.errorNetworkProd : l10n.errorNetwork;
  }
}
