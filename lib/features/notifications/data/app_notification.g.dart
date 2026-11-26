// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      severity: json['severity'] == null
          ? NotificationSeverity.info
          : const NotificationSeverityConverter().fromJson(json['severity']),
      readAt: json['read_at'] as String?,
      createdAt: json['created_at'] as String?,
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$AppNotificationToJson(
  _AppNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'message': instance.message,
  'severity': const NotificationSeverityConverter().toJson(instance.severity),
  'read_at': instance.readAt,
  'created_at': instance.createdAt,
  'data': instance.data,
};
