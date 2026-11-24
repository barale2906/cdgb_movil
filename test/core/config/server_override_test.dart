import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/server_override.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppEnvironment _env(String env, String url) =>
    AppEnvironment.fromValues(env: env, apiBaseUrl: url);

void main() {
  late ServerOverride override;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    override = ServerOverride(await SharedPreferences.getInstance());
  });

  test('sin servidor guardado no cambia el destino', () {
    final base = _env('dev', 'http://localhost:8000/api/v1');
    expect(override.apply(base).apiBaseUrl, base.apiBaseUrl);
  });

  test('en dev aplica el servidor guardado y conserva el resto', () async {
    await override.save(Uri.parse('http://192.168.1.10:8000/api/v1/'));
    final applied = override.apply(_env('dev', 'http://localhost:8000/api/v1'));

    expect(applied.apiBaseUrl.toString(), 'http://192.168.1.10:8000/api/v1');
    expect(applied.sessionMaxHours, 12);
    expect(applied.isDev, isTrue);
  });

  test('en prod se ignora siempre', () async {
    await override.save(Uri.parse('http://evil.example.com/api/v1'));
    final prod = _env('prod', 'https://api.example.com/api/v1');
    expect(override.apply(prod).apiBaseUrl, prod.apiBaseUrl);
  });

  test('clear vuelve al servidor del archivo de destino', () async {
    await override.save(Uri.parse('http://192.168.1.10:8000/api/v1'));
    await override.clear();
    expect(override.current, isNull);
  });

  test('un valor guardado inválido se ignora', () async {
    SharedPreferences.setMockInitialValues({
      'server_override_url': 'no es url',
    });
    final broken = ServerOverride(await SharedPreferences.getInstance());
    final base = _env('dev', 'http://localhost:8000/api/v1');
    expect(broken.apply(base).apiBaseUrl, base.apiBaseUrl);
  });

  group('AppEnvironment.tryParseBaseUrl', () {
    test('acepta http(s) con host y rechaza el resto', () {
      expect(
        AppEnvironment.tryParseBaseUrl('http://10.0.2.2:8000/api/v1'),
        isNotNull,
      );
      expect(AppEnvironment.tryParseBaseUrl(' https://a.co/api '), isNotNull);
      expect(AppEnvironment.tryParseBaseUrl('ftp://a.co'), isNull);
      expect(AppEnvironment.tryParseBaseUrl('a.co/api'), isNull);
      expect(AppEnvironment.tryParseBaseUrl(''), isNull);
    });
  });
}
