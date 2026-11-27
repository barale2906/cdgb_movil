import 'package:flutter/foundation.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';

/// Válido si no hay IVA o está entre 0 y 100.
bool isValidTaxRate(double? rate) => rate == null || (rate >= 0 && rate <= 100);

/// Fecha `AAAA-MM-DD` del servidor a `DateTime` (sin hora), o `null`.
DateTime? parseDraftDate(String? value) {
  final parsed = DateTime.tryParse(value ?? '');
  return parsed == null
      ? null
      : DateTime(parsed.year, parsed.month, parsed.day);
}

/// Resultado de enviar un borrador: nada, guardado (con su id) o error.
@immutable
class DraftSubmission {
  const DraftSubmission({
    this.isSubmitting = false,
    this.error,
    this.savedId,
  });

  final bool isSubmitting;
  final ApiException? error;

  /// Id de la orden guardada: ya no se vuelve a enviar.
  final int? savedId;

  /// El envío anterior no tuvo respuesta: el borrador pudo haberse guardado.
  bool get isUnconfirmed =>
      error is NetworkException &&
      (error! as NetworkException).kind == NetworkFailureKind.timeout;
}
