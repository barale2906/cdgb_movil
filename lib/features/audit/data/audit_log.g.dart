// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditLog _$AuditLogFromJson(Map<String, dynamic> json) => _AuditLog(
  id: (json['id'] as num).toInt(),
  action: json['action'] as String,
  userId: (json['user_id'] as num?)?.toInt(),
  userName: json['user_name'] as String?,
  auditableType: json['auditable_type'] as String?,
  auditableId: _idToString(json['auditable_id']),
  oldValues: _valuesOrNull(json['old_values']),
  newValues: _valuesOrNull(json['new_values']),
  ipAddress: json['ip_address'] as String?,
  userAgent: json['user_agent'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$AuditLogToJson(_AuditLog instance) => <String, dynamic>{
  'id': instance.id,
  'action': instance.action,
  'user_id': instance.userId,
  'user_name': instance.userName,
  'auditable_type': instance.auditableType,
  'auditable_id': instance.auditableId,
  'old_values': instance.oldValues,
  'new_values': instance.newValues,
  'ip_address': instance.ipAddress,
  'user_agent': instance.userAgent,
  'created_at': instance.createdAt,
};
