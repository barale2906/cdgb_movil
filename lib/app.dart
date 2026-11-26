import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/app_router.dart';
import 'package:sga_bojanini/core/auth/inactivity_guard.dart';
import 'package:sga_bojanini/core/theme/app_theme.dart';
import 'package:sga_bojanini/core/update/update_widgets.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';
import 'package:sga_bojanini/push_navigation.dart';

/// Raíz de la aplicación: tema, localización, rutas y bloqueo por
/// inactividad.
class SgaApp extends ConsumerWidget {
  const SgaApp({super.key});

  static const locale = Locale('es', 'CO');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(pushNavigationProvider);
    return MaterialApp.router(
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
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) => UpdateGate(
        child: InactivityGuard(child: child ?? const SizedBox.shrink()),
      ),
    );
  }
}
