// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movement_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentSignature _$DocumentSignatureFromJson(Map<String, dynamic> json) =>
    _DocumentSignature(
      role: json['role'] as String,
      method: json['method'] as String?,
      signerName: json['signer_name'] as String?,
      signerDocument: json['signer_document'] as String?,
      signedAt: json['signed_at'] as String?,
    );

Map<String, dynamic> _$DocumentSignatureToJson(_DocumentSignature instance) =>
    <String, dynamic>{
      'role': instance.role,
      'method': instance.method,
      'signer_name': instance.signerName,
      'signer_document': instance.signerDocument,
      'signed_at': instance.signedAt,
    };

_MovementLine _$MovementLineFromJson(Map<String, dynamic> json) =>
    _MovementLine(
      id: (json['id'] as num).toInt(),
      movementType: json['movement_type'] as String,
      quantity: const DoubleConverter().fromJson(json['quantity']),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      productVariantId: (json['product_variant_id'] as num?)?.toInt(),
      batchId: (json['batch_id'] as num?)?.toInt(),
      locationFromId: (json['location_from_id'] as num?)?.toInt(),
      locationToId: (json['location_to_id'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      notes: json['notes'] as String?,
      movementDate: json['movement_date'] as String?,
      status: json['status'] as String?,
      productName: json['product_name'] as String?,
      variantLabBrand: json['variant_lab_brand'] as String?,
      batchLotNumber: json['batch_lot_number'] as String?,
      batchExpirationDate: json['batch_expiration_date'] as String?,
      userName: json['user_name'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$MovementLineToJson(_MovementLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movement_type': instance.movementType,
      'quantity': const DoubleConverter().toJson(instance.quantity),
      'warehouse_id': instance.warehouseId,
      'product_variant_id': instance.productVariantId,
      'batch_id': instance.batchId,
      'location_from_id': instance.locationFromId,
      'location_to_id': instance.locationToId,
      'reason': instance.reason,
      'notes': instance.notes,
      'movement_date': instance.movementDate,
      'status': instance.status,
      'product_name': instance.productName,
      'variant_lab_brand': instance.variantLabBrand,
      'batch_lot_number': instance.batchLotNumber,
      'batch_expiration_date': instance.batchExpirationDate,
      'user_name': instance.userName,
      'created_at': instance.createdAt,
    };

_CostCenterRef _$CostCenterRefFromJson(Map<String, dynamic> json) =>
    _CostCenterRef(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
      type: json['type'] as String?,
      isExternal: json['is_external'] as bool? ?? false,
    );

Map<String, dynamic> _$CostCenterRefToJson(_CostCenterRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'type': instance.type,
      'is_external': instance.isExternal,
    };

_MovementDocument _$MovementDocumentFromJson(Map<String, dynamic> json) =>
    _MovementDocument(
      id: (json['id'] as num).toInt(),
      documentNumber: json['document_number'] as String,
      documentType: json['document_type'] as String,
      status: json['status'] == null
          ? DocumentStatus.unknown
          : const DocumentStatusConverter().fromJson(json['status']),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      warehouseToId: (json['warehouse_to_id'] as num?)?.toInt(),
      warehouseName: json['warehouse_name'] as String?,
      warehouseToName: json['warehouse_to_name'] as String?,
      patientDocument: json['patient_document'] as String?,
      invoiceNumber: json['invoice_number'] as String?,
      reason: json['reason'] as String?,
      movementDate: json['movement_date'] as String?,
      userName: json['user_name'] as String?,
      createdAt: json['created_at'] as String?,
      costCenter: json['cost_center'] == null
          ? null
          : CostCenterRef.fromJson(json['cost_center'] as Map<String, dynamic>),
      signatures:
          (json['signatures'] as List<dynamic>?)
              ?.map(
                (e) => DocumentSignature.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      movements:
          (json['movements'] as List<dynamic>?)
              ?.map((e) => MovementLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MovementDocumentToJson(_MovementDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'document_number': instance.documentNumber,
      'document_type': instance.documentType,
      'status': const DocumentStatusConverter().toJson(instance.status),
      'warehouse_id': instance.warehouseId,
      'warehouse_to_id': instance.warehouseToId,
      'warehouse_name': instance.warehouseName,
      'warehouse_to_name': instance.warehouseToName,
      'patient_document': instance.patientDocument,
      'invoice_number': instance.invoiceNumber,
      'reason': instance.reason,
      'movement_date': instance.movementDate,
      'user_name': instance.userName,
      'created_at': instance.createdAt,
      'cost_center': instance.costCenter?.toJson(),
      'signatures': instance.signatures.map((e) => e.toJson()).toList(),
      'movements': instance.movements.map((e) => e.toJson()).toList(),
    };
