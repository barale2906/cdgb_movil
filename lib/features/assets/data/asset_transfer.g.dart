// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransferAssetRef _$TransferAssetRefFromJson(Map<String, dynamic> json) =>
    _TransferAssetRef(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TransferAssetRefToJson(_TransferAssetRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

_TransferSignature _$TransferSignatureFromJson(Map<String, dynamic> json) =>
    _TransferSignature(
      role: json['role'] as String,
      method: json['method'] as String?,
      signerName: json['signer_name'] as String?,
      signerDocument: json['signer_document'] as String?,
      signedAt: json['signed_at'] as String?,
    );

Map<String, dynamic> _$TransferSignatureToJson(_TransferSignature instance) =>
    <String, dynamic>{
      'role': instance.role,
      'method': instance.method,
      'signer_name': instance.signerName,
      'signer_document': instance.signerDocument,
      'signed_at': instance.signedAt,
    };

_AssetTransfer _$AssetTransferFromJson(Map<String, dynamic> json) =>
    _AssetTransfer(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String?,
      typeLabel: json['type_label'] as String?,
      status: json['status'] == null
          ? TransferStatus.unknown
          : const TransferStatusConverter().fromJson(json['status']),
      requiresSignature: json['requires_signature'] as bool? ?? false,
      asset: json['asset'] == null
          ? null
          : TransferAssetRef.fromJson(json['asset'] as Map<String, dynamic>),
      from: json['from'] as String?,
      to: json['to'] as String?,
      externalDestination: json['external_destination'] as String?,
      supplier: json['supplier'] == null
          ? null
          : NamedRef.fromJson(json['supplier'] as Map<String, dynamic>),
      fromResponsible: json['from_responsible'] == null
          ? null
          : NamedRef.fromJson(json['from_responsible'] as Map<String, dynamic>),
      toResponsible: json['to_responsible'] == null
          ? null
          : NamedRef.fromJson(json['to_responsible'] as Map<String, dynamic>),
      expectedReturnDate: json['expected_return_date'] as String?,
      resultingStatus: json['resulting_status'] as String?,
      reason: json['reason'] as String?,
      requestedBy: json['requested_by'] == null
          ? null
          : NamedRef.fromJson(json['requested_by'] as Map<String, dynamic>),
      confirmedAt: json['confirmed_at'] as String?,
      cancelReason: json['cancel_reason'] as String?,
      signatures:
          (json['signatures'] as List<dynamic>?)
              ?.map(
                (e) => TransferSignature.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AssetTransferToJson(_AssetTransfer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'type_label': instance.typeLabel,
      'status': const TransferStatusConverter().toJson(instance.status),
      'requires_signature': instance.requiresSignature,
      'asset': instance.asset?.toJson(),
      'from': instance.from,
      'to': instance.to,
      'external_destination': instance.externalDestination,
      'supplier': instance.supplier?.toJson(),
      'from_responsible': instance.fromResponsible?.toJson(),
      'to_responsible': instance.toResponsible?.toJson(),
      'expected_return_date': instance.expectedReturnDate,
      'resulting_status': instance.resultingStatus,
      'reason': instance.reason,
      'requested_by': instance.requestedBy?.toJson(),
      'confirmed_at': instance.confirmedAt,
      'cancel_reason': instance.cancelReason,
      'signatures': instance.signatures.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt,
    };
