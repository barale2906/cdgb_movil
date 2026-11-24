import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';

/// Configuración del destino actual. Se sobrescribe en `main.dart` con
/// `AppEnvironment.fromDartDefines()` y en pruebas con valores fijos.
final appEnvironmentProvider = Provider<AppEnvironment>(
  (ref) => throw UnimplementedError(
    'appEnvironmentProvider debe sobrescribirse en ProviderScope.',
  ),
);
