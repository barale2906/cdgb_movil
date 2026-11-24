import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sga_bojanini/core/auth/device_name.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/config/package_info_provider.dart';
import 'package:sga_bojanini/core/connectivity/connectivity_provider.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/theme/app_theme.dart';
import 'package:sga_bojanini/core/utils/preferences.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_connectivity.dart';
import 'test_container.dart';

/// Overrides que toda pantalla necesita en pruebas de widget: sin plugins
/// nativos ni red real.
Future<List<Override>> widgetTestOverrides({
  AppEnvironment? environment,
  FakeConnectivitySource? connectivity,
  String buildNumber = '1',
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return [
    appEnvironmentProvider.overrideWithValue(environment ?? testEnvironment),
    sharedPreferencesProvider.overrideWithValue(prefs),
    deviceNameProvider.overrideWithValue('Equipo de pruebas'),
    connectivitySourceProvider.overrideWithValue(
      connectivity ?? FakeConnectivitySource(),
    ),
    packageInfoProvider.overrideWith(
      (ref) => PackageInfo(
        appName: 'SGA Bojanini',
        packageName: 'co.bojanini.sga.dev',
        version: '0.1.0',
        buildNumber: buildNumber,
      ),
    ),
  ];
}

extension PumpApp on WidgetTester {
  /// Monta [widget] con tema, localización y providers de la app.
  Future<void> pumpApp(
    Widget widget, {
    AppEnvironment? environment,
    List<Override> overrides = const [],
    String buildNumber = '1',
  }) async {
    final base = await widgetTestOverrides(
      environment: environment,
      buildNumber: buildNumber,
    );
    await pumpWidget(
      ProviderScope(
        retry: noAutoRetry,
        overrides: [...base, ...overrides],
        child: MaterialApp(
          theme: AppTheme.light(),
          locale: const Locale('es'),
          supportedLocales: const [Locale('es')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: widget,
        ),
      ),
    );
  }
}
