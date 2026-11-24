import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'movement_document.freezed.dart';
part 'movement_document.g.dart';

enum DocumentStatus {
  @JsonValue('pending_signature')
  pendingSignature,
  confirmed,
  unknown,
}

class DocumentStatusConverter
    implements JsonConverter<DocumentStatus, Object?> {
  const DocumentStatusConverter();

  @override
  DocumentStatus fromJson(Object? json) => switch (json) {
    'pending_signature' => DocumentStatus.pendingSignature,
    'confirmed' => DocumentStatus.confirmed,
    _ => DocumentStatus.unknown,
  };

  @override
  Object toJson(DocumentStatus object) => switch (object) {
    DocumentStatus.pendingSignature => 'pending_signature',
    DocumentStatus.confirmed => 'confirmed',
    DocumentStatus.unknown => 'unknown',
  };
}

@freezed
abstract class DocumentSignature with _$DocumentSignature {
  const factory DocumentSignature({
    required String role,
    String? method,
    String? signerName,
    String? signerDocument,
    String? signedAt,
  }) = _DocumentSignature;

  factory DocumentSignature.fromJson(Map<String, dynamic> json) =>
      _$DocumentSignatureFromJson(json);
}

/// Línea de un comprobante, o movimiento suelto (ajuste, devolución, baja).
@freezed
abstract class MovementLine with _$MovementLine {
  const factory MovementLine({
    required int id,
    required String movementType,
    @DoubleConverter() double? quantity,
    int? warehouseId,
    int? productVariantId,
    int? batchId,
    int? locationFromId,
    int? locationToId,
    String? reason,
    String? notes,
    String? movementDate,
    String? status,
    String? productName,
    String? variantLabBrand,
    String? batchLotNumber,
    String? batchExpirationDate,
    String? userName,
    String? createdAt,
  }) = _MovementLine;

  factory MovementLine.fromJson(Map<String, dynamic> json) =>
      _$MovementLineFromJson(json);
}

@freezed
abstract class CostCenterRef with _$CostCenterRef {
  const factory CostCenterRef({
    required int id,
    required String name,
    String? code,
    String? type,
    @Default(false) bool isExternal,
  }) = _CostCenterRef;

  factory CostCenterRef.fromJson(Map<String, dynamic> json) =>
      _$CostCenterRefFromJson(json);
}

/// Comprobante (`MovementDocumentResource`). El stock cambia solo al
/// confirmarlo; entradas y salidas a paciente nacen confirmadas.
@freezed
abstract class MovementDocument with _$MovementDocument {
  const factory MovementDocument({
    required int id,
    required String documentNumber,
    required String documentType,
    @DocumentStatusConverter()
    @Default(DocumentStatus.unknown)
    DocumentStatus status,
    int? warehouseId,
    int? warehouseToId,
    String? warehouseName,
    String? warehouseToName,
    String? patientDocument,
    String? invoiceNumber,
    String? reason,
    String? movementDate,
    String? userName,
    String? createdAt,
    CostCenterRef? costCenter,
    @Default([]) List<DocumentSignature> signatures,
    @Default([]) List<MovementLine> movements,
  }) = _MovementDocument;

  const MovementDocument._();

  factory MovementDocument.fromJson(Map<String, dynamic> json) =>
      _$MovementDocumentFromJson(json);

  bool get isPending => status == DocumentStatus.pendingSignature;
  bool get isConfirmed => status == DocumentStatus.confirmed;
}
