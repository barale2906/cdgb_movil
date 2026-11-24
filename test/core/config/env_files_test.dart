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

  AppEnvironment load(File file) {
    final values = (jsonDecode(file.readAsStringSync()) as Map)
        .cast<String, String>();
    return AppEnvironment.fromValues(
      env: values['ENV']!,
      apiBaseUrl: values['API_BASE_URL']!,
      updateUrl: values['UPDATE_URL'] ?? '',
      inactivityLockMinutes: values['INACTIVITY_LOCK_MINUTES'] ?? '',
      sessionMaxHours: values['SESSION_MAX_HOURS'] ?? '',
      httpLogs: values['HTTP_LOGS'] ?? '',
      tlsPinnedCert: values['TLS_PINNED_CERT'] ?? '',
      serverPresets: values['SERVER_PRESETS'] ?? '',
    );
  }

  test('existen los destinos versionados', () {
    final names = envFiles.map((f) => f.uri.pathSegments.last).toSet();
    expect(
      names,
      containsAll(['local.json', 'usb.json', 'clinica.json', 'prod.json']),
    );
  });

  for (final file in envFiles) {
    test('${file.path} es un destino válido', () {
      final env = load(file);
      if (file.path.endsWith('prod.json')) {
        expect(env.env, AppEnv.prod);
        expect(env.apiBaseUrl.scheme, 'https');
      }
      final cert = env.tlsPinnedCert;
      if (cert != null) {
        expect(File(cert).existsSync(), isTrue, reason: 'asset $cert');
      }
    });
  }

  group('cambio de servidor', () {
    test('producción y clínica apuntan al mismo servidor real', () {
      final prod = load(File('env/prod.json'));
      final clinica = load(File('env/clinica.json'));
      expect(prod.apiBaseUrl, clinica.apiBaseUrl);
      expect(prod.apiBaseUrl.host, 'sga.ad.bojaniniexperts.co');
      expect(clinica.env, AppEnv.dev, reason: 'permite cambiar de servidor');
    });

    test('prod es fijo: sin presets y con el certificado anclado', () {
      final prod = load(File('env/prod.json'));
      expect(prod.serverPresets, isEmpty);
      expect(prod.tlsPinnedCert, isNotNull);
    });

    test('los destinos dev ofrecen producción, USB y emulador', () {
      for (final name in ['local', 'usb', 'clinica']) {
        final env = load(File('env/$name.json'));
        final urls = env.serverPresets.map((p) => p.url.toString()).toList();
        expect(
          urls,
          containsAll([
            'https://sga.ad.bojaniniexperts.co/api/v1',
            'http://localhost:8000/api/v1',
            'http://10.0.2.2:8000/api/v1',
          ]),
          reason: name,
        );
      }
    });

    test('el servidor activo se nombra por su preset', () {
      expect(load(File('env/usb.json')).serverName, startsWith('Local USB'));
      expect(
        load(File('env/clinica.json')).serverName,
        startsWith('Producción clínica'),
      );
    });

    test('el certificado versionado es un PEM de certificado', () {
      final pem = File('assets/certs/sga_clinica.pem').readAsStringSync();
      expect(pem, startsWith('-----BEGIN CERTIFICATE-----'));
      expect(pem.trim(), endsWith('-----END CERTIFICATE-----'));
      expect(pem, isNot(contains('PRIVATE KEY')));
    });
  });
}
