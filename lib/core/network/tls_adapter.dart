import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Certificado (PEM) del servidor, cargado al arrancar desde el asset
/// indicado en `TLS_PINNED_CERT`; `null` si el destino no lo usa.
final pinnedCertificateProvider = Provider<Uint8List?>((ref) => null);

/// Adaptador HTTP que confía en el certificado propio del servidor.
///
/// El servidor de la clínica usa un certificado autofirmado que Android no
/// reconoce. Con [strict] (producción) se confía **solo** en ese
/// certificado: cualquier otro servidor HTTPS se rechaza. En dev se suma a
/// los certificados del sistema.
HttpClientAdapter? pinnedAdapter(
  Uint8List? certificate, {
  required bool strict,
}) {
  if (certificate == null) return null;
  return IOHttpClientAdapter(
    createHttpClient: () {
      final context = SecurityContext(withTrustedRoots: !strict)
        ..setTrustedCertificatesBytes(certificate);
      return HttpClient(context: context);
    },
  );
}
