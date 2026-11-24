// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MySignature _$MySignatureFromJson(Map<String, dynamic> json) => _MySignature(
  signerName: json['signer_name'] as String,
  documentType: json['document_type'] as String,
  documentNumber: json['document_number'] as String,
  documentTypeLabel: json['document_type_label'] as String?,
  signatureData: json['signature_data'] as String?,
  hasPin: json['has_pin'] as bool? ?? false,
  pinGeneratedAt: json['pin_generated_at'] as String?,
  registeredAt: json['registered_at'] as String?,
);

Map<String, dynamic> _$MySignatureToJson(_MySignature instance) =>
    <String, dynamic>{
      'signer_name': instance.signerName,
      'document_type': instance.documentType,
      'document_number': instance.documentNumber,
      'document_type_label': instance.documentTypeLabel,
      'signature_data': instance.signatureData,
      'has_pin': instance.hasPin,
      'pin_generated_at': instance.pinGeneratedAt,
      'registered_at': instance.registeredAt,
    };
