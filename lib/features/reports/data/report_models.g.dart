// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportExport _$ReportExportFromJson(Map<String, dynamic> json) =>
    _ReportExport(
      id: const IdAsStringConverter().fromJson(json['id']),
      type: json['type'] as String? ?? '',
      format: json['format'] as String? ?? '',
      status: json['status'] == null
          ? ExportStatus.unknown
          : const ExportStatusConverter().fromJson(json['status']),
      isReady: json['is_ready'] as bool? ?? false,
      isExpired: json['is_expired'] as bool? ?? false,
      fileSize: (json['file_size'] as num?)?.toInt(),
      errorMessage: json['error_message'] as String?,
      expiresAt: json['expires_at'] as String?,
      createdAt: json['created_at'] as String?,
      completedAt: json['completed_at'] as String?,
    );

Map<String, dynamic> _$ReportExportToJson(_ReportExport instance) =>
    <String, dynamic>{
      'id': const IdAsStringConverter().toJson(instance.id),
      'type': instance.type,
      'format': instance.format,
      'status': const ExportStatusConverter().toJson(instance.status),
      'is_ready': instance.isReady,
      'is_expired': instance.isExpired,
      'file_size': instance.fileSize,
      'error_message': instance.errorMessage,
      'expires_at': instance.expiresAt,
      'created_at': instance.createdAt,
      'completed_at': instance.completedAt,
    };
