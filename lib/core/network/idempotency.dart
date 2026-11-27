import 'dart:convert';
import 'dart:math';

import 'package:sga_bojanini/core/network/api_exception.dart';

/// Clave de idempotencia (`Idempotency-Key`) de las creaciones: con la misma
/// clave y el mismo cuerpo el servidor devuelve la respuesta original en vez
/// de crear el registro otra vez.
abstract final class IdempotencyKey {
  static const header = 'Idempotency-Key';

  static const _bytes = 16;

  /// 32 caracteres hexadecimales aleatorios (el servidor admite hasta 100).
  static String generate([Random? random]) {
    final source = random ?? Random.secure();
    return List.generate(
      _bytes,
      (_) => source.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  /// Cabeceras de la solicitud; vacías si no hay clave.
  static Map<String, String> headers(String? key) => {header: ?key};
}

/// Guarda la clave de un envío mientras siga siendo el mismo: un reintento
/// manual tras un tiempo de espera agotado reutiliza la clave (si el servidor
/// ya lo había guardado, devuelve esa respuesta). Si el contenido cambia, se
/// usa una clave nueva: el servidor rechaza la misma clave con otro cuerpo.
class IdempotencyKeyHolder {
  IdempotencyKeyHolder({String Function()? generator})
    : _generator = generator ?? IdempotencyKey.generate;

  final String Function() _generator;
  String? _key;
  String? _fingerprint;

  /// Clave para enviar [body]; la misma mientras el cuerpo no cambie.
  String keyFor(Object? body) {
    final fingerprint = jsonEncode(body);
    if (_key == null || _fingerprint != fingerprint) {
      _key = _generator();
      _fingerprint = fingerprint;
    }
    return _key!;
  }

  void release() {
    _key = null;
    _fingerprint = null;
  }

  /// Tras un envío: la clave se conserva solo si el servidor no respondió
  /// (tiempo de espera agotado), porque el registro pudo haberse creado.
  void settle({required bool succeeded, ApiException? error}) {
    final unconfirmed =
        error is NetworkException && error.kind == NetworkFailureKind.timeout;
    if (succeeded || (error != null && !unconfirmed)) release();
  }
}
