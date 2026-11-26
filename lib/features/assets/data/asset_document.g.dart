// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetDocument _$AssetDocumentFromJson(Map<String, dynamic> json) =>
    _AssetDocument(
      id: (json['id'] as num).toInt(),
      documentType: json['document_type'] as String?,
      documentTypeLabel: json['document_type_label'] as String?,
      title: json['title'] as String?,
      originalName: json['original_name'] as String?,
      mimeType: json['mime_type'] as String?,
      size: (json['size'] as num?)?.toInt(),
      maintenanceId: (json['maintenance_id'] as num?)?.toInt(),
      issuedAt: json['issued_at'] as String?,
      expiresAt: json['expires_at'] as String?,
      uploadedBy: json['uploaded_by'] == null
          ? null
          : NamedRef.fromJson(json['uploaded_by'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AssetDocumentToJson(_AssetDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'document_type': instance.documentType,
      'document_type_label': instance.documentTypeLabel,
      'title': instance.title,
      'original_name': instance.originalName,
      'mime_type': instance.mimeType,
      'size': instance.size,
      'maintenance_id': instance.maintenanceId,
      'issued_at': instance.issuedAt,
      'expires_at': instance.expiresAt,
      'uploaded_by': instance.uploadedBy?.toJson(),
      'created_at': instance.createdAt,
    };
