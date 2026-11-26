// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitoring_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SensorZone _$SensorZoneFromJson(Map<String, dynamic> json) => _SensorZone(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  code: json['code'] as String?,
  tempMin: const DoubleConverter().fromJson(json['temp_min']),
  tempMax: const DoubleConverter().fromJson(json['temp_max']),
  humidityMin: const DoubleConverter().fromJson(json['humidity_min']),
  humidityMax: const DoubleConverter().fromJson(json['humidity_max']),
  warehouseName: json['warehouse_name'] as String?,
);

Map<String, dynamic> _$SensorZoneToJson(_SensorZone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'temp_min': const DoubleConverter().toJson(instance.tempMin),
      'temp_max': const DoubleConverter().toJson(instance.tempMax),
      'humidity_min': const DoubleConverter().toJson(instance.humidityMin),
      'humidity_max': const DoubleConverter().toJson(instance.humidityMax),
      'warehouse_name': instance.warehouseName,
    };

_SensorCalibration _$SensorCalibrationFromJson(Map<String, dynamic> json) =>
    _SensorCalibration(
      status: json['status'] as String? ?? 'missing',
      statusLabel: json['status_label'] as String?,
      expiresAt: json['expires_at'] as String?,
      daysLeft: (json['days_left'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SensorCalibrationToJson(_SensorCalibration instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_label': instance.statusLabel,
      'expires_at': instance.expiresAt,
      'days_left': instance.daysLeft,
    };

_LastReading _$LastReadingFromJson(Map<String, dynamic> json) => _LastReading(
  value: const DoubleConverter().fromJson(json['value']),
  recordedAt: json['recorded_at'] as String?,
  readingSource: json['reading_source'] as String?,
  userName: json['user_name'] as String?,
);

Map<String, dynamic> _$LastReadingToJson(_LastReading instance) =>
    <String, dynamic>{
      'value': const DoubleConverter().toJson(instance.value),
      'recorded_at': instance.recordedAt,
      'reading_source': instance.readingSource,
      'user_name': instance.userName,
    };

_Sensor _$SensorFromJson(Map<String, dynamic> json) => _Sensor(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  type: json['type'] == null
      ? SensorType.unknown
      : const SensorTypeConverter().fromJson(json['type']),
  unit: json['unit'] as String? ?? '',
  code: json['code'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  zone: json['zone'] == null
      ? null
      : SensorZone.fromJson(json['zone'] as Map<String, dynamic>),
  calibration: json['calibration'] == null
      ? null
      : SensorCalibration.fromJson(json['calibration'] as Map<String, dynamic>),
  lastReading: json['last_reading'] == null
      ? null
      : LastReading.fromJson(json['last_reading'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SensorToJson(_Sensor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': const SensorTypeConverter().toJson(instance.type),
  'unit': instance.unit,
  'code': instance.code,
  'is_active': instance.isActive,
  'zone': instance.zone?.toJson(),
  'calibration': instance.calibration?.toJson(),
  'last_reading': instance.lastReading?.toJson(),
};

_Reading _$ReadingFromJson(Map<String, dynamic> json) => _Reading(
  id: (json['id'] as num).toInt(),
  value: const DoubleConverter().fromJson(json['value']),
  readingSource: json['reading_source'] as String?,
  recordedAt: json['recorded_at'] as String?,
);

Map<String, dynamic> _$ReadingToJson(_Reading instance) => <String, dynamic>{
  'id': instance.id,
  'value': const DoubleConverter().toJson(instance.value),
  'reading_source': instance.readingSource,
  'recorded_at': instance.recordedAt,
};

_ConsecutiveRule _$ConsecutiveRuleFromJson(Map<String, dynamic> json) =>
    _ConsecutiveRule(
      hasTrend: json['has_trend'] as bool? ?? false,
      direction: json['direction'] as String?,
      longestStreak: (json['longest_streak'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ConsecutiveRuleToJson(_ConsecutiveRule instance) =>
    <String, dynamic>{
      'has_trend': instance.hasTrend,
      'direction': instance.direction,
      'longest_streak': instance.longestStreak,
    };

_LinearRegression _$LinearRegressionFromJson(Map<String, dynamic> json) =>
    _LinearRegression(
      hasTrend: json['has_trend'] as bool? ?? false,
      direction: json['direction'] as String?,
      interpretation: json['interpretation'] as String?,
    );

Map<String, dynamic> _$LinearRegressionToJson(_LinearRegression instance) =>
    <String, dynamic>{
      'has_trend': instance.hasTrend,
      'direction': instance.direction,
      'interpretation': instance.interpretation,
    };

_TrendAnalysis _$TrendAnalysisFromJson(Map<String, dynamic> json) =>
    _TrendAnalysis(
      totalReadings: (json['total_readings'] as num?)?.toInt() ?? 0,
      overallTrend: json['overall_trend'] as bool? ?? false,
      overallDirection: json['overall_direction'] as String?,
      confidence: json['confidence'] as String? ?? 'none',
      consecutiveRule: json['consecutive_rule'] == null
          ? null
          : ConsecutiveRule.fromJson(
              json['consecutive_rule'] as Map<String, dynamic>,
            ),
      linearRegression: json['linear_regression'] == null
          ? null
          : LinearRegression.fromJson(
              json['linear_regression'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TrendAnalysisToJson(_TrendAnalysis instance) =>
    <String, dynamic>{
      'total_readings': instance.totalReadings,
      'overall_trend': instance.overallTrend,
      'overall_direction': instance.overallDirection,
      'confidence': instance.confidence,
      'consecutive_rule': instance.consecutiveRule?.toJson(),
      'linear_regression': instance.linearRegression?.toJson(),
    };

_CalibrationCertificate _$CalibrationCertificateFromJson(
  Map<String, dynamic> json,
) => _CalibrationCertificate(
  id: (json['id'] as num).toInt(),
  certificateNumber: json['certificate_number'] as String?,
  laboratory: json['laboratory'] as String?,
  calibratedAt: json['calibrated_at'] as String?,
  expiresAt: json['expires_at'] as String?,
  daysLeft: (json['days_left'] as num?)?.toInt(),
  isCurrent: json['is_current'] as bool? ?? false,
  status: json['status'] as String? ?? '',
  statusLabel: json['status_label'] as String?,
  originalName: json['original_name'] as String?,
);

Map<String, dynamic> _$CalibrationCertificateToJson(
  _CalibrationCertificate instance,
) => <String, dynamic>{
  'id': instance.id,
  'certificate_number': instance.certificateNumber,
  'laboratory': instance.laboratory,
  'calibrated_at': instance.calibratedAt,
  'expires_at': instance.expiresAt,
  'days_left': instance.daysLeft,
  'is_current': instance.isCurrent,
  'status': instance.status,
  'status_label': instance.statusLabel,
  'original_name': instance.originalName,
};

_AlertRule _$AlertRuleFromJson(Map<String, dynamic> json) => _AlertRule(
  id: (json['id'] as num).toInt(),
  conditionType: json['condition_type'] as String? ?? '',
  threshold: const DoubleConverter().fromJson(json['threshold']),
  consecutiveReadings: (json['consecutive_readings'] as num?)?.toInt(),
  isActive: json['is_active'] as bool? ?? true,
  notificationChannels:
      (json['notification_channels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$AlertRuleToJson(_AlertRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'condition_type': instance.conditionType,
      'threshold': const DoubleConverter().toJson(instance.threshold),
      'consecutive_readings': instance.consecutiveReadings,
      'is_active': instance.isActive,
      'notification_channels': instance.notificationChannels,
    };
