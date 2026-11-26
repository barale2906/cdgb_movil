import 'package:flutter/foundation.dart';

/// Persona que firma (externa al sistema): nombre, documento y firma PNG.
@immutable
class ExternalSigner {
  const ExternalSigner({
    required this.name,
    required this.document,
    required this.signature,
  });

  final String name;
  final String document;

  /// Data URL `data:image/png;base64,...`.
  final String signature;

  Map<String, dynamic> toJson() => {
    'name': name,
    'document': document,
    'signature': signature,
  };
}

/// Quién recibe: un usuario del sistema con su PIN de 3 dígitos, o un
/// externo con firma en pantalla.
@immutable
sealed class Receiver {
  const Receiver();

  Map<String, dynamic> toJson();
}

class PinReceiver extends Receiver {
  const PinReceiver(this.pin);

  final String pin;

  @override
  Map<String, dynamic> toJson() => {'pin': pin};
}

class ExternalReceiver extends Receiver {
  const ExternalReceiver(this.signer);

  final ExternalSigner signer;

  @override
  Map<String, dynamic> toJson() => signer.toJson();
}

/// Confirmación con firmas (comprobantes de inventario y traslados de
/// activos comparten el formato): si [deliveredBy] es null se usa la firma
/// registrada de quien tiene la sesión.
@immutable
class ConfirmRequest {
  const ConfirmRequest({required this.receivedBy, this.deliveredBy});

  final Receiver receivedBy;
  final ExternalSigner? deliveredBy;

  Map<String, dynamic> toJson() => {
    if (deliveredBy != null) 'delivered_by': deliveredBy!.toJson(),
    'received_by': receivedBy.toJson(),
  };
}
