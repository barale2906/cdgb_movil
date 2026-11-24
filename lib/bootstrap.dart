import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart'
    show LicenseEntryWithLineBreaks, LicenseRegistry;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:intl/date_symbol_data_local.dart';
import 'package:sga_bojanini/app.dart';
import 'package:sga_bojanini/core/auth/device_identity.dart';
import 'package:sga_bojanini/core/auth/device_name.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/config/app_restart.dart';
import 'package:sga_bojanini/core/config/server_override.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/network/tls_adapter.dart';
import 'package:sga_bojanini/core/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Datos que se leen una vez al arrancar (y al reiniciar la app).
@immutable
class AppBootstrap {
  const AppBootstrap({
    required this.environment,
    required this.preferences,
    required this.deviceName,
    this.pinnedCertificate,
  });

  final AppEnvironment environment;
  final SharedPreferences preferences;
  final String deviceName;

  /// Certificado del servidor (PEM) si el destino lo pide.
  final Uint8List? pinnedCertificate;

  /// Falla al arrancar si el destino (env/*.json) es inválido: nunca se
  /// ejecuta contra un servidor desconocido.
  static Future<AppBootstrap> load() async {
    final base = AppEnvironment.fromDartDefines();
    _registerFontLicense();
    final preferences = await SharedPreferences.getInstance();
    await initializeDateFormatting('es_CO');
    return AppBootstrap(
      environment: ServerOverride(preferences).apply(base),
      preferences: preferences,
      deviceName: DeviceIdentity.deviceName(preferences),
      pinnedCertificate: await _loadCertificate(base.tlsPinnedCert),
    );
  }

  /// Falla al arrancar si el asset declarado no existe: mejor un error
  /// claro que una app que no conecta.
  static Future<Uint8List?> _loadCertificate(String? asset) async {
    if (asset == null) return null;
    try {
      return (await rootBundle.load(asset)).buffer.asUint8List();
    } on Object {
      throw AppEnvironmentException(
        'TLS_PINNED_CERT apunta a un asset que no existe: "$asset".',
      );
    }
  }

  static bool _fontLicenseRegistered = false;

  /// Incluye la licencia OFL de Montserrat en la pantalla de licencias.
  static void _registerFontLicense() {
    if (_fontLicenseRegistered) return;
    _fontLicenseRegistered = true;
    LicenseRegistry.addLicense(() async* {
      final text = await rootBundle.loadString(
        'assets/fonts/montserrat/OFL.txt',
      );
      yield LicenseEntryWithLineBreaks(['Montserrat'], text);
    });
  }

  List<Override> get overrides => [
    appEnvironmentProvider.overrideWithValue(environment),
    sharedPreferencesProvider.overrideWithValue(preferences),
    deviceNameProvider.overrideWithValue(deviceName),
    pinnedCertificateProvider.overrideWithValue(pinnedCertificate),
  ];
}

/// Monta la app y permite reiniciarla (nuevo `ProviderScope`) para aplicar
/// un cambio de servidor sin cerrar el proceso.
class RestartableApp extends StatefulWidget {
  const RestartableApp({required this.initial, super.key});

  final AppBootstrap initial;

  @override
  State<RestartableApp> createState() => _RestartableAppState();
}

class _RestartableAppState extends State<RestartableApp> {
  late AppBootstrap _bootstrap = widget.initial;
  Key _scopeKey = UniqueKey();

  Future<void> _restart() async {
    final next = await AppBootstrap.load();
    if (!mounted) return;
    setState(() {
      _bootstrap = next;
      _scopeKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) => AppRestart(
    restart: _restart,
    child: ProviderScope(
      key: _scopeKey,
      retry: noAutoRetry,
      overrides: _bootstrap.overrides,
      child: const SgaApp(),
    ),
  );
}
