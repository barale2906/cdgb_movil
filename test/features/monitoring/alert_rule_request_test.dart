import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/features/monitoring/data/alert_rule_request.dart';

void main() {
  test('por encima de un valor envía el umbral', () {
    const request = AlertRuleRequest(
      condition: AlertCondition.above,
      threshold: 8,
      consecutiveReadings: 3,
      channels: {AlertChannel.internal, AlertChannel.push},
    );
    expect(request.toJson(), {
      'condition_type': 'above',
      'threshold': 8.0,
      'consecutive_readings': 3,
      'notification_channels': ['internal', 'push'],
    });
  });

  test('una tendencia o fuera de rango no envía umbral aunque se pase', () {
    for (final condition in [
      AlertCondition.trendUp,
      AlertCondition.trendDown,
      AlertCondition.outOfRange,
    ]) {
      final json = AlertRuleRequest(
        condition: condition,
        threshold: 5,
        consecutiveReadings: 1,
        channels: const {AlertChannel.email},
      ).toJson();
      expect(json.containsKey('threshold'), isFalse, reason: condition.name);
    }
  });

  test('solo por encima y por debajo necesitan umbral', () {
    expect(
      AlertCondition.values.where((c) => c.needsThreshold),
      [AlertCondition.above, AlertCondition.below],
    );
  });
}
