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

/// Servidor al que se puede cambiar en dev (etiqueta + URL base).
@immutable
class ServerPreset {
  const ServerPreset({required this.label, required this.url});

  final String label;
  final Uri url;

  @override
  bool operator ==(Object other) =>
      other is ServerPreset && other.label == label && other.url == url;

  @override
  int get hashCode => Object.hash(label, url);
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
    this.tlsPinnedCert,
    this.serverPresets = const [],
  });

  /// Construye y valida la configuración a partir de valores crudos.
  factory AppEnvironment.fromValues({
    required String env,
    required String apiBaseUrl,
    String? updateUrl,
    String? inactivityLockMinutes,
    String? sessionMaxHours,
    String? httpLogs,
    String? tlsPinnedCert,
    String? serverPresets,
  }) {
    final parsedEnv = AppEnv.parse(env.trim());
    final baseUri = tryParseBaseUrl(apiBaseUrl);
    if (baseUri == null) {
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
      tlsPinnedCert: (tlsPinnedCert ?? '').trim().isEmpty
          ? null
          : tlsPinnedCert!.trim(),
      // Solo dev puede cambiar de servidor; en prod la URL es fija.
      serverPresets: parsedEnv == AppEnv.dev
          ? parsePresets(serverPresets)
          : const [],
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
    tlsPinnedCert: const String.fromEnvironment('TLS_PINNED_CERT'),
    serverPresets: const String.fromEnvironment('SERVER_PRESETS'),
  );

  /// URL base válida (esquema http/https con host), o `null`.
  static Uri? tryParseBaseUrl(String raw) {
    final uri = Uri.tryParse(raw.trim());
    final validScheme = uri != null && {'http', 'https'}.contains(uri.scheme);
    return validScheme && uri.hasAuthority ? uri : null;
  }

  /// Lista `Etiqueta|URL;Etiqueta|URL` de servidores seleccionables.
  static List<ServerPreset> parsePresets(String? raw) {
    final text = (raw ?? '').trim();
    if (text.isEmpty) return const [];
    return [
      for (final entry in text.split(';').map((e) => e.trim()))
        if (entry.isNotEmpty) _parsePreset(entry),
    ];
  }

  static ServerPreset _parsePreset(String entry) {
    final parts = entry.split('|');
    final url = parts.length == 2 ? tryParseBaseUrl(parts[1]) : null;
    if (url == null || parts.first.trim().isEmpty) {
      throw AppEnvironmentException(
        'SERVER_PRESETS inválido: "$entry". '
        'Formato: Etiqueta|URL;Etiqueta|URL.',
      );
    }
    return ServerPreset(
      label: parts.first.trim(),
      url: _withoutTrailingSlash(url),
    );
  }

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

  /// Asset (PEM) con el certificado del servidor, para servidores con
  /// certificado propio (autofirmado). En prod es el **único** ancla de
  /// confianza; en dev se suma a los del sistema.
  final String? tlsPinnedCert;

  /// Servidores a los que se puede cambiar desde "Acerca de" (solo dev).
  final List<ServerPreset> serverPresets;

  bool get isDev => env == AppEnv.dev;

  /// Nombre para mostrar del servidor activo: la etiqueta del preset que
  /// coincide con la URL, o el host.
  String get serverName {
    for (final preset in serverPresets) {
      if (preset.url == apiBaseUrl) return preset.label;
    }
    return apiBaseUrl.authority;
  }

  /// Mismo destino apuntando a otro servidor (cambio de servidor en dev).
  AppEnvironment withApiBaseUrl(Uri baseUrl) => AppEnvironment(
    env: env,
    apiBaseUrl: _withoutTrailingSlash(baseUrl),
    updateUrl: updateUrl,
    inactivityLockMinutes: inactivityLockMinutes,
    sessionMaxHours: sessionMaxHours,
    httpLogs: httpLogs,
    tlsPinnedCert: tlsPinnedCert,
    serverPresets: serverPresets,
  );

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
