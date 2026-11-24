import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sga_bojanini/app.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Falla al arrancar si el destino (env/*.json) es inválido: nunca se
  // ejecuta contra un servidor desconocido.
  final environment = AppEnvironment.fromDartDefines();
  await initializeDateFormatting('es_CO');

  runApp(
    ProviderScope(
      overrides: [appEnvironmentProvider.overrideWithValue(environment)],
      child: const SgaApp(),
    ),
  );
}
