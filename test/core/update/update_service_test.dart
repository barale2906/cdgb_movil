import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/update/update_providers.dart';
import 'package:sga_bojanini/core/update/update_service.dart';
import 'package:sga_bojanini/core/update/update_widgets.dart';
import 'package:sga_bojanini/core/update/version_info.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';

final Uri _updateUrl = Uri.parse('https://files.example.com/version.json');

UpdateService _service(FakeHttpAdapter adapter, int build) => UpdateService(
  dio: Dio()..httpClientAdapter = adapter,
  currentBuild: build,
);

/// Deja terminar las lecturas asíncronas y desmonta el árbol (cancela el
/// temporizador de la verificación periódica).
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
}

void main() {
  group('UpdateService', () {
    test('sin UPDATE_URL no hace ninguna petición', () async {
      final adapter = FakeHttpAdapter();
      final result = await _service(adapter, 1).check(null);
      expect(result.status, UpdateStatus.upToDate);
      expect(adapter.requests, isEmpty);
    });

    test('build por debajo del mínimo → obligatoria', () async {
      final adapter = FakeHttpAdapter()
        ..on('GET', _updateUrl.toString(), body: fixture('version.json'));
      final result = await _service(adapter, 9).check(_updateUrl);
      expect(result.status, UpdateStatus.required);
      expect(result.info?.latest, '1.2.0');
    });

    test('build entre el mínimo y el último → disponible', () async {
      final adapter = FakeHttpAdapter()
        ..on('GET', _updateUrl.toString(), body: fixture('version.json'));
      expect(
        (await _service(adapter, 10).check(_updateUrl)).status,
        UpdateStatus.available,
      );
      expect(
        (await _service(adapter, 11).check(_updateUrl)).status,
        UpdateStatus.available,
      );
    });

    test('build igual o mayor al último → al día', () async {
      final adapter = FakeHttpAdapter()
        ..on('GET', _updateUrl.toString(), body: fixture('version.json'));
      expect(
        (await _service(adapter, 12).check(_updateUrl)).status,
        UpdateStatus.upToDate,
      );
      expect(
        (await _service(adapter, 99).check(_updateUrl)).status,
        UpdateStatus.upToDate,
      );
    });

    test('un fallo de red o un JSON inválido nunca bloquean', () async {
      final failing = FakeHttpAdapter()
        ..onSocketFailure('GET', _updateUrl.toString());
      expect(
        (await _service(failing, 1).check(_updateUrl)).status,
        UpdateStatus.upToDate,
      );

      final invalid = FakeHttpAdapter()
        ..on('GET', _updateUrl.toString(), body: {'latest': 5});
      expect(
        (await _service(invalid, 1).check(_updateUrl)).status,
        UpdateStatus.upToDate,
      );

      final notJson = FakeHttpAdapter()
        ..on('GET', _updateUrl.toString(), body: ['x']);
      expect(
        (await _service(notJson, 1).check(_updateUrl)).status,
        UpdateStatus.upToDate,
      );
    });
  });

  test('VersionInfo parsea el contrato de version.json', () {
    final info = VersionInfo.fromJson(fixture('version.json'));
    expect(info.build, 12);
    expect(info.minBuild, 10);
    expect(info.url, endsWith('.apk'));
  });

  group('UpdateGate / banner', () {
    final environment = AppEnvironment.fromValues(
      env: 'prod',
      apiBaseUrl: 'https://api.example.com/api/v1',
      updateUrl: _updateUrl.toString(),
    );

    List<Override> overrides(FakeHttpAdapter adapter) => [
      httpClientAdapterProvider.overrideWithValue(adapter),
    ];

    testWidgets('versión obsoleta: pantalla bloqueante con descarga', (
      tester,
    ) async {
      final adapter = FakeHttpAdapter()
        ..on('GET', _updateUrl.toString(), body: fixture('version.json'));
      final opened = <Uri>[];
      await tester.pumpApp(
        const UpdateGate(child: Text('App')),
        environment: environment,
        buildNumber: '5',
        overrides: [
          ...overrides(adapter),
          urlOpenerProvider.overrideWithValue((url) async {
            opened.add(url);
            return true;
          }),
        ],
      );
      await _settle(tester);

      expect(find.text('App'), findsNothing);
      expect(find.text('Actualice la aplicación'), findsOneWidget);

      await tester.tap(find.text('Descargar'));
      expect(opened.single.toString(), endsWith('sga-bojanini-1.2.0.apk'));
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('versión al día: deja pasar la app', (tester) async {
      final adapter = FakeHttpAdapter()
        ..on('GET', _updateUrl.toString(), body: fixture('version.json'));
      await tester.pumpApp(
        const UpdateGate(child: Text('App')),
        environment: environment,
        overrides: overrides(adapter),
        buildNumber: '12',
      );
      await _settle(tester);

      expect(find.text('App'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('versión nueva: aviso de descarga', (tester) async {
      final adapter = FakeHttpAdapter()
        ..on('GET', _updateUrl.toString(), body: fixture('version.json'));
      await tester.pumpApp(
        const Scaffold(body: UpdateAvailableBanner()),
        environment: environment,
        overrides: overrides(adapter),
        buildNumber: '11',
      );
      await _settle(tester);

      expect(find.textContaining('versión 1.2.0'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('sin UPDATE_URL no aparece nada', (tester) async {
      await tester.pumpApp(const Scaffold(body: UpdateAvailableBanner()));
      await _settle(tester);
      expect(find.byType(AlertBanner), findsNothing);
    });
  });
}
