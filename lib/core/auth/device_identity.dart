import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

/// Nombre estable del equipo: sistema + identificador de instalación.
/// (El modelo del teléfono requeriría `device_info_plus`, pendiente de
/// aprobación; ver resumen de la fase 1.)
abstract final class DeviceIdentity {
  static const _installIdKey = 'install_id';
  static const _idLength = 6;
  static const _alphabet = 'abcdefghjkmnpqrstuvwxyz23456789';

  static String deviceName(SharedPreferences prefs, {Random? random}) {
    final id =
        prefs.getString(_installIdKey) ?? _createInstallId(prefs, random);
    return 'SGA ${_platformLabel()} · $id';
  }

  static String _createInstallId(SharedPreferences prefs, Random? random) {
    final rng = random ?? Random.secure();
    final id = String.fromCharCodes(
      List.generate(
        _idLength,
        (_) => _alphabet.codeUnitAt(rng.nextInt(_alphabet.length)),
      ),
    );
    unawaited(prefs.setString(_installIdKey, id));
    return id;
  }

  static String _platformLabel() =>
      Platform.isAndroid ? 'Android' : Platform.operatingSystem;
}
