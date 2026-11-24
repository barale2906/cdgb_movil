import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Servidor alternativo elegido en "Acerca de" (solo flavor dev), para
/// probar contra otro backend sin recompilar. Producción lo ignora.
class ServerOverride {
  const ServerOverride(this._prefs);

  static const _key = 'server_override_url';

  final SharedPreferences _prefs;

  String? get current => _prefs.getString(_key);

  Future<void> save(Uri url) => _prefs.setString(_key, url.toString());

  Future<void> clear() => _prefs.remove(_key);

  /// Aplica el servidor guardado si el ambiente lo permite y es válido.
  AppEnvironment apply(AppEnvironment base) {
    final saved = current;
    final uri = saved == null ? null : AppEnvironment.tryParseBaseUrl(saved);
    return base.isDev && uri != null ? base.withApiBaseUrl(uri) : base;
  }
}
