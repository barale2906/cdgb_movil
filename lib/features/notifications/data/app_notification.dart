import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

enum NotificationSeverity { critical, warning, info, success }

class NotificationSeverityConverter
    implements JsonConverter<NotificationSeverity, Object?> {
  const NotificationSeverityConverter();

  @override
  NotificationSeverity fromJson(Object? json) => switch (json) {
    'critical' || 'error' => NotificationSeverity.critical,
    'warning' => NotificationSeverity.warning,
    'success' => NotificationSeverity.success,
    _ => NotificationSeverity.info,
  };

  @override
  Object toJson(NotificationSeverity object) => object.name;
}

/// Notificación interna del usuario (`GET /notifications`). Su id es un UUID.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    @Default('') String type,
    @Default('') String title,
    @Default('') String message,
    @NotificationSeverityConverter()
    @Default(NotificationSeverity.info)
    NotificationSeverity severity,
    String? readAt,
    String? createdAt,
    @Default({}) Map<String, dynamic> data,
  }) = _AppNotification;

  const AppNotification._();

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);

  bool get isRead => readAt != null;
}
