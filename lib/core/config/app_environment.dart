import 'package:flutter/foundation.dart';

/// Ambiente de ejecución. El servidor concreto lo define el archivo de
/// destino `env/<destino>.json` (ver docs/plan/02-arquitectura.md §8).
enum AppEnv {
  dev,
  prod
  ;

  static AppEnv parse(String value) => AppEnv.values.firstWhere(
    (env) => env.name == value,
    orElse: () => throw AppEnvironmentException(
      'ENV inválido: "$value". Valores permitidos: dev, prod.',
    ),
  );
}

/// Error de configuración: la app no debe arrancar con un destino inválido.
class AppEnvironmentException implements Exception {
  const AppEnvironmentException(this.message);

  final String message;

  @override
  String toString() => 'AppEnvironmentException: $message';
}

/// Configuración inmutable leída de `--dart-define-from-file=env/<destino>.json`.
@immutable
class AppEnvironment {
  const AppEnvironment({
    required this.env,
    required this.apiBaseUrl,
    required this.updateUrl,
    required this.inactivityLockMinutes,
    required this.sessionMaxHours,
    required this.httpLogs,
  });

  /// Construye y valida la configuración a partir de valores crudos.
  factory AppEnvironment.fromValues({
    required String env,
    required String apiBaseUrl,
    String? updateUrl,
    String? inactivityLockMinutes,
    String? sessionMaxHours,
    String? httpLogs,
  }) {
    final parsedEnv = AppEnv.parse(env.trim());
    final baseUri = Uri.tryParse(apiBaseUrl.trim());
    if (apiBaseUrl.trim().isEmpty || baseUri == null || !baseUri.hasAuthority) {
      throw AppEnvironmentException(
        'API_BASE_URL inválida: "$apiBaseUrl". '
        '¿Se ejecutó con --dart-define-from-file=env/<destino>.json?',
      );
    }
    if (parsedEnv == AppEnv.prod && baseUri.scheme != 'https') {
      throw const AppEnvironmentException(
        'En prod API_BASE_URL debe usar HTTPS.',
      );
    }
    final trimmedUpdateUrl = (updateUrl ?? '').trim();
    final updateUri = trimmedUpdateUrl.isEmpty
        ? null
        : Uri.tryParse(trimmedUpdateUrl);
    if (trimmedUpdateUrl.isNotEmpty &&
        (updateUri == null || !updateUri.hasAuthority)) {
      throw AppEnvironmentException('UPDATE_URL inválida: "$updateUrl".');
    }

    return AppEnvironment(
      env: parsedEnv,
      apiBaseUrl: _withoutTrailingSlash(baseUri),
      updateUrl: updateUri,
      inactivityLockMinutes: _positiveInt(
        'INACTIVITY_LOCK_MINUTES',
        inactivityLockMinutes,
        fallback: defaultInactivityLockMinutes,
      ),
      sessionMaxHours: _positiveInt(
        'SESSION_MAX_HOURS',
        sessionMaxHours,
        fallback: defaultSessionMaxHours,
      ),
      httpLogs: parsedEnv == AppEnv.dev && (httpLogs ?? '').trim() == 'true',
    );
  }

  /// Lee los valores inyectados en compilación. Una clave ausente llega
  /// vacía y toma el valor por defecto de [AppEnvironment.fromValues].
  factory AppEnvironment.fromDartDefines() => AppEnvironment.fromValues(
    env: const String.fromEnvironment('ENV'),
    apiBaseUrl: const String.fromEnvironment('API_BASE_URL'),
    updateUrl: const String.fromEnvironment('UPDATE_URL'),
    inactivityLockMinutes: const String.fromEnvironment(
      'INACTIVITY_LOCK_MINUTES',
    ),
    sessionMaxHours: const String.fromEnvironment('SESSION_MAX_HOURS'),
    httpLogs: const String.fromEnvironment('HTTP_LOGS'),
  );

  static const defaultInactivityLockMinutes = 15;
  static const defaultSessionMaxHours = 12;

  final AppEnv env;

  /// URL base de la API, sin barra final (p. ej. `https://host/api/v1`).
  final Uri apiBaseUrl;

  /// URL de `version.json`; `null` = actualizaciones desactivadas.
  final Uri? updateUrl;

  final int inactivityLockMinutes;
  final int sessionMaxHours;

  /// Logs de red; siempre `false` fuera de dev.
  final bool httpLogs;

  bool get isDev => env == AppEnv.dev;

  static Uri _withoutTrailingSlash(Uri uri) {
    final path = uri.path.endsWith('/')
        ? uri.path.substring(0, uri.path.length - 1)
        : uri.path;
    return uri.replace(path: path);
  }

  static int _positiveInt(
    String key,
    String? raw, {
    required int fallback,
  }) {
    final text = (raw ?? '').trim();
    if (text.isEmpty) return fallback;
    final value = int.tryParse(text);
    if (value == null || value <= 0) {
      throw AppEnvironmentException(
        '$key debe ser un entero positivo: "$raw".',
      );
    }
    return value;
  }
}
