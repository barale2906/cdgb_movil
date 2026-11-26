import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';

part 'asset_transfer.freezed.dart';
part 'asset_transfer.g.dart';

/// Estado de un traslado: el activo cambia solo al confirmarse.
enum TransferStatus {
  pendingSignature('pending_signature'),
  confirmed('confirmed'),
  cancelled('cancelled'),
  unknown('unknown')
  ;

  const TransferStatus(this.value);

  final String value;

  static TransferStatus parse(Object? raw) => values.firstWhere(
    (status) => status.value == raw,
    orElse: () => unknown,
  );
}

class TransferStatusConverter
    implements JsonConverter<TransferStatus, Object?> {
  const TransferStatusConverter();

  @override
  TransferStatus fromJson(Object? json) => TransferStatus.parse(json);

  @override
  Object toJson(TransferStatus object) => object.value;
}

/// Tipos de traslado que la app puede solicitar (`type`).
enum TransferType {
  relocation('relocation'),
  externalRepair('external_repair'),
  loan('loan'),
  returnToSite('return'),
  retirement('retirement')
  ;

  const TransferType(this.value);

  final String value;

  /// Un activo fuera de las instalaciones solo admite devolución o baja.
  static List<TransferType> allowedFor({required bool isOffPremises}) =>
      isOffPremises
      ? const [returnToSite, retirement]
      : const [relocation, externalRepair, loan, retirement];
}

@freezed
abstract class TransferAssetRef with _$TransferAssetRef {
  const factory TransferAssetRef({
    required int id,
    String? code,
    String? name,
  }) = _TransferAssetRef;

  factory TransferAssetRef.fromJson(Map<String, dynamic> json) =>
      _$TransferAssetRefFromJson(json);
}

@freezed
abstract class TransferSignature with _$TransferSignature {
  const factory TransferSignature({
    required String role,
    String? method,
    String? signerName,
    String? signerDocument,
    String? signedAt,
  }) = _TransferSignature;

  factory TransferSignature.fromJson(Map<String, dynamic> json) =>
      _$TransferSignatureFromJson(json);
}

/// Traslado de un activo (`AssetTransferResource`).
@freezed
abstract class AssetTransfer with _$AssetTransfer {
  const factory AssetTransfer({
    required int id,
    String? type,
    String? typeLabel,
    @TransferStatusConverter()
    @Default(TransferStatus.unknown)
    TransferStatus status,
    @Default(false) bool requiresSignature,
    TransferAssetRef? asset,
    String? from,
    String? to,
    String? externalDestination,
    NamedRef? supplier,
    NamedRef? fromResponsible,
    NamedRef? toResponsible,
    String? expectedReturnDate,
    String? resultingStatus,
    String? reason,
    NamedRef? requestedBy,
    String? confirmedAt,
    String? cancelReason,
    @Default([]) List<TransferSignature> signatures,
    String? createdAt,
  }) = _AssetTransfer;

  const AssetTransfer._();

  factory AssetTransfer.fromJson(Map<String, dynamic> json) =>
      _$AssetTransferFromJson(json);

  bool get isPending => status == TransferStatus.pendingSignature;
}
