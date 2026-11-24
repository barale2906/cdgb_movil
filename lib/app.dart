import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sga_bojanini/core/theme/app_theme.dart';
import 'package:sga_bojanini/features/about/presentation/about_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Raíz de la aplicación. En la fase 1 `home` se reemplaza por go_router.
class SgaApp extends StatelessWidget {
  const SgaApp({super.key});

  static const locale = Locale('es', 'CO');

  @override
  Widget build(BuildContext context) => MaterialApp(
    onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    locale: locale,
    supportedLocales: const [locale, Locale('es')],
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: const AboutPage(),
  );
}
