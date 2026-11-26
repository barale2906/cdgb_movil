import 'package:flutter/foundation.dart';

/// Condiciones de una regla de alerta que acepta el servidor.
enum AlertCondition {
  above('above'),
  below('below'),
  outOfRange('out_of_range'),
  trendUp('trend_up'),
  trendDown('trend_down')
  ;

  const AlertCondition(this.value);

  final String value;

  /// Las que comparan contra un valor necesitan umbral.
  bool get needsThreshold =>
      this == AlertCondition.above || this == AlertCondition.below;
}

/// Canales de aviso de una regla.
enum AlertChannel {
  internal('internal'),
  email('email'),
  push('push')
  ;

  const AlertChannel(this.value);

  final String value;
}

/// Cuerpo de `POST /sensors/{id}/alert-rules`.
@immutable
class AlertRuleRequest {
  const AlertRuleRequest({
    required this.condition,
    required this.consecutiveReadings,
    required this.channels,
    this.threshold,
  });

  final AlertCondition condition;
  final double? threshold;
  final int consecutiveReadings;
  final Set<AlertChannel> channels;

  Map<String, Object> toJson() => {
    'condition_type': condition.value,
    if (condition.needsThreshold && threshold != null) 'threshold': threshold!,
    'consecutive_readings': consecutiveReadings,
    'notification_channels': [for (final c in channels) c.value],
  };
}
