import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/config/package_info_provider.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/update/update_service.dart';
import 'package:url_launcher/url_launcher.dart';

/// Cada cuánto se vuelve a consultar `version.json`.
const updateCheckInterval = Duration(hours: 24);

/// Resultado de la verificación. Sin `UPDATE_URL` no hace ninguna petición.
/// Usa su propio cliente (sin token ni URL base: el archivo es estático).
final updateCheckProvider = FutureProvider<UpdateCheck>((ref) async {
  final url = ref.watch(appEnvironmentProvider).updateUrl;
  if (url == null) return UpdateCheck.none;

  final timer = Timer(updateCheckInterval, ref.invalidateSelf);
  ref.onDispose(timer.cancel);

  final packageInfo = await ref.watch(packageInfoProvider.future);
  final dio = Dio(
    BaseOptions(
      connectTimeout: NetworkConfig.connectTimeout,
      receiveTimeout: NetworkConfig.receiveTimeout,
    ),
  );
  final adapter = ref.watch(httpClientAdapterProvider);
  if (adapter != null) dio.httpClientAdapter = adapter;

  return UpdateService(
    dio: dio,
    currentBuild: int.tryParse(packageInfo.buildNumber) ?? 0,
  ).check(url);
});

/// El usuario descartó el aviso de versión nueva en esta ejecución.
class UpdateDismissedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void dismiss() => state = true;
}

final updateDismissedProvider = NotifierProvider<UpdateDismissedNotifier, bool>(
  UpdateDismissedNotifier.new,
);

/// Abre la descarga del APK en el navegador (sin permiso de instalación).
typedef UrlOpener = Future<bool> Function(Uri url);

final urlOpenerProvider = Provider<UrlOpener>(
  (ref) =>
      (url) => launchUrl(url, mode: LaunchMode.externalApplication),
);
