import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/test_container.dart';

void main() {
  testWidgets('en dev el login dice a qué servidor se conectará', (
    tester,
  ) async {
    await AppHarness().pump(tester);
    expect(find.text('Servidor: Local USB'), findsOneWidget);
  });

  test('presets inválidos fallan al arrancar con un mensaje claro', () {
    expect(
      () => AppEnvironment.fromValues(
        env: 'dev',
        apiBaseUrl: 'http://localhost:8000/api/v1',
        serverPresets: 'SinUrl',
      ),
      throwsA(isA<AppEnvironmentException>()),
    );
    expect(
      () => AppEnvironment.fromValues(
        env: 'dev',
        apiBaseUrl: 'http://localhost:8000/api/v1',
        serverPresets: 'Mal|no-es-url',
      ),
      throwsA(isA<AppEnvironmentException>()),
    );
  });

  test('prod ignora presets y conserva el certificado anclado', () {
    final env = AppEnvironment.fromValues(
      env: 'prod',
      apiBaseUrl: 'https://sga.ad.bojaniniexperts.co/api/v1',
      serverPresets: 'Local|http://localhost:8000/api/v1',
      tlsPinnedCert: 'assets/certs/sga_clinica.pem',
    );
    expect(env.serverPresets, isEmpty);
    expect(env.tlsPinnedCert, 'assets/certs/sga_clinica.pem');
  });

  test('parsePresets: varias entradas, espacios y barra final', () {
    final presets = AppEnvironment.parsePresets(
      ' A | http://h1:8000/api/v1/ ; B|https://h2/api/v1 ;',
    );
    expect(presets.map((p) => p.label), ['A', 'B']);
    expect(presets.first.url.toString(), 'http://h1:8000/api/v1');
    expect(AppEnvironment.parsePresets(''), isEmpty);
    expect(AppEnvironment.parsePresets(null), isEmpty);
  });

  test('el nombre del servidor cae en el host si no hay preset', () {
    final env = AppEnvironment.fromValues(
      env: 'dev',
      apiBaseUrl: 'http://192.168.2.19:8000/api/v1',
      serverPresets: 'Local|http://localhost:8000/api/v1',
    );
    expect(env.serverName, '192.168.2.19:8000');
    expect(testEnvironment.serverName, 'Local USB');
  });
}
