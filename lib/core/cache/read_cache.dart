import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Copia local de las listas de referencia (almacenes, productos,
/// proveedores, centros de costo, servicios) para consultarlas sin conexión.
/// Solo lectura: las escrituras siempre son en línea (plan 02 §6).
///
/// Se borra entera al terminar la sesión: en un teléfono compartido no debe
/// quedar nada del usuario anterior.
class ReadCache {
  const ReadCache(this._prefs);

  static const _prefix = 'read_cache.';

  final SharedPreferences _prefs;

  Future<void> write(String key, List<Json> items) =>
      _prefs.setString('$_prefix$key', jsonEncode(items));

  /// La copia guardada, o `null` si no hay o está dañada.
  List<Json>? read(String key) {
    final text = _prefs.getString('$_prefix$key');
    if (text == null) return null;
    try {
      final decoded = jsonDecode(text);
      if (decoded is! List<dynamic>) return null;
      return [for (final item in decoded) item as Json];
    } on Object {
      return null;
    }
  }

  Future<void> clear() async {
    for (final key in _prefs.getKeys().where((k) => k.startsWith(_prefix))) {
      await _prefs.remove(key);
    }
  }
}

final readCacheProvider = Provider<ReadCache>(
  (ref) => ReadCache(ref.watch(sharedPreferencesProvider)),
);

/// Lee una lista de referencia: la pide al servidor y guarda la copia; si no
/// hay red (sin conexión o tiempo agotado) usa la última copia. Cualquier otro
/// error (permiso, servidor) se propaga: no se esconde detrás de datos viejos.
Future<List<T>> cachedList<T>({
  required ReadCache cache,
  required String key,
  required Future<List<Json>> Function() fetch,
  required T Function(Json) parse,
}) async {
  try {
    final raw = await fetch();
    await cache.write(key, raw);
    return [for (final item in raw) parse(item)];
  } on NetworkException {
    final saved = cache.read(key);
    if (saved == null) rethrow;
    return [for (final item in saved) parse(item)];
  }
}
