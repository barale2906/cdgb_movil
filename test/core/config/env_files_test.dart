import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';

/// Garantiza que todos los archivos de destino versionados sean válidos.
void main() {
  final envFiles = Directory('env')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json') && !f.path.contains('example'))
      .toList();

  test('existen los destinos versionados', () {
    final names = envFiles.map((f) => f.uri.pathSegments.last).toSet();
    expect(names, containsAll(['local.json', 'usb.json', 'prod.json']));
  });

  for (final file in envFiles) {
    test('${file.path} es un destino válido', () {
      final values = (jsonDecode(file.readAsStringSync()) as Map)
          .cast<String, String>();

      final env = AppEnvironment.fromValues(
        env: values['ENV']!,
        apiBaseUrl: values['API_BASE_URL']!,
        updateUrl: values['UPDATE_URL'] ?? '',
        inactivityLockMinutes: values['INACTIVITY_LOCK_MINUTES'] ?? '',
        sessionMaxHours: values['SESSION_MAX_HOURS'] ?? '',
        httpLogs: values['HTTP_LOGS'] ?? '',
      );

      if (file.path.endsWith('prod.json')) {
        expect(env.env, AppEnv.prod);
        expect(env.apiBaseUrl.scheme, 'https');
      }
    });
  }
}
