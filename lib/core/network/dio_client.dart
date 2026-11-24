import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/auth_token_provider.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/interceptors.dart';
import 'package:sga_bojanini/core/network/tls_adapter.dart';

abstract final class NetworkConfig {
  static const connectTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 30);
}

/// Crea el [Dio] único de la app. Separado del provider para poder probarlo.
Dio createDio({
  required AppEnvironment environment,
  required String? Function() readToken,
  required void Function(ApiException error) onSessionInvalid,
  void Function()? onForbidden,
  HttpClientAdapter? adapter,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: environment.apiBaseUrl.toString(),
      connectTimeout: NetworkConfig.connectTimeout,
      receiveTimeout: NetworkConfig.receiveTimeout,
      headers: {Headers.acceptHeader: Headers.jsonContentType},
    ),
  );
  if (adapter != null) dio.httpClientAdapter = adapter;
  dio.interceptors.addAll([
    AuthInterceptor(readToken),
    ErrorInterceptor(
      onSessionInvalid: onSessionInvalid,
      onForbidden: onForbidden,
    ),
    if (environment.httpLogs) SafeLogInterceptor(),
  ]);
  return dio;
}

/// Adaptador HTTP; `null` usa el de producción. Las pruebas lo reemplazan
/// por un servidor falso (sin red real).
final httpClientAdapterProvider = Provider<HttpClientAdapter?>((ref) => null);

/// Adaptador efectivo: el de pruebas, o el del certificado anclado, o el
/// de producción por defecto (`null`).
final httpAdapterProvider = Provider<HttpClientAdapter?>((ref) {
  final environment = ref.watch(appEnvironmentProvider);
  return ref.watch(httpClientAdapterProvider) ??
      pinnedAdapter(
        ref.watch(pinnedCertificateProvider),
        strict: !environment.isDev,
      );
});

final dioProvider = Provider<Dio>((ref) {
  return createDio(
    environment: ref.watch(appEnvironmentProvider),
    adapter: ref.watch(httpAdapterProvider),
    readToken: () => ref.read(authTokenProvider),
    onSessionInvalid: (error) => unawaited(
      ref.read(sessionControllerProvider.notifier).handleInvalidSession(error),
    ),
    onForbidden: () =>
        unawaited(ref.read(sessionControllerProvider.notifier).reloadUser()),
  );
});
