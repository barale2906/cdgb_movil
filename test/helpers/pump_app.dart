import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_theme.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Configuración de pruebas: destino dev contra backend local.
final testEnvironment = AppEnvironment.fromValues(
  env: 'dev',
  apiBaseUrl: 'http://localhost:8000/api/v1',
);

extension PumpApp on WidgetTester {
  /// Monta [widget] con tema, localización y providers de la app.
  Future<void> pumpApp(
    Widget widget, {
    AppEnvironment? environment,
  }) {
    return pumpWidget(
      ProviderScope(
        overrides: [
          appEnvironmentProvider.overrideWithValue(
            environment ?? testEnvironment,
          ),
        ],
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
