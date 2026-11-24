// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'SGA Bojanini';

  @override
  String get brandSubtitle => 'SISTEMA DE GESTIÓN DE ALMACÉN';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutEnvironment => 'Ambiente';

  @override
  String get aboutServer => 'Servidor';

  @override
  String get aboutUpdates => 'Actualizaciones';

  @override
  String get aboutUpdatesDisabled => 'Desactivadas (ruta del APK pendiente)';

  @override
  String aboutSessionPolicy(int minutes, int hours) {
    return 'Bloqueo por inactividad: $minutes min · Cierre de sesión: $hours h';
  }

  @override
  String get envDev => 'Desarrollo';

  @override
  String get envProd => 'Producción';

  @override
  String get setupInProgress =>
      'Fase 0: proyecto configurado. Los módulos se habilitan en las siguientes fases.';
}
