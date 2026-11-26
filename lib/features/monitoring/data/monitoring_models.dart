import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'monitoring_models.freezed.dart';
part 'monitoring_models.g.dart';

enum SensorType { temperature, humidity, unknown }

class SensorTypeConverter implements JsonConverter<SensorType, Object?> {
  const SensorTypeConverter();

  @override
  SensorType fromJson(Object? json) => SensorType.values.firstWhere(
    (type) => type.name == json,
    orElse: () => SensorType.unknown,
  );

  @override
  Object toJson(SensorType object) => object.name;
}

@freezed
abstract class SensorZone with _$SensorZone {
  const factory SensorZone({
    required int id,
    String? name,
    String? code,
    @DoubleConverter() double? tempMin,
    @DoubleConverter() double? tempMax,
    @DoubleConverter() double? humidityMin,
    @DoubleConverter() double? humidityMax,
    String? warehouseName,
  }) = _SensorZone;

  factory SensorZone.fromJson(Map<String, dynamic> json) =>
      _$SensorZoneFromJson(json);
}

@freezed
abstract class SensorCalibration with _$SensorCalibration {
  const factory SensorCalibration({
    @Default('missing') String status,
    String? statusLabel,
    String? expiresAt,
    int? daysLeft,
  }) = _SensorCalibration;

  factory SensorCalibration.fromJson(Map<String, dynamic> json) =>
      _$SensorCalibrationFromJson(json);
}

@freezed
abstract class LastReading with _$LastReading {
  const factory LastReading({
    @DoubleConverter() double? value,
    String? recordedAt,
    String? readingSource,
    String? userName,
  }) = _LastReading;

  factory LastReading.fromJson(Map<String, dynamic> json) =>
      _$LastReadingFromJson(json);
}

/// Sensor con su resumen (zona, calibración y última lectura).
@freezed
abstract class Sensor with _$Sensor {
  const factory Sensor({
    required int id,
    required String name,
    @SensorTypeConverter() @Default(SensorType.unknown) SensorType type,
    @Default('') String unit,
    String? code,
    @Default(true) bool isActive,
    SensorZone? zone,
    SensorCalibration? calibration,
    LastReading? lastReading,
  }) = _Sensor;

  const Sensor._();

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  /// Límite inferior permitido según el tipo de sensor y su zona.
  double? get allowedMin => switch (type) {
    SensorType.temperature => zone?.tempMin,
    SensorType.humidity => zone?.humidityMin,
    SensorType.unknown => null,
  };

  double? get allowedMax => switch (type) {
    SensorType.temperature => zone?.tempMax,
    SensorType.humidity => zone?.humidityMax,
    SensorType.unknown => null,
  };

  bool get hasLimits => allowedMin != null && allowedMax != null;

  bool isOutOfRange(double value) =>
      (allowedMin != null && value < allowedMin!) ||
      (allowedMax != null && value > allowedMax!);
}

@freezed
abstract class Reading with _$Reading {
  const factory Reading({
    required int id,
    @DoubleConverter() double? value,
    String? readingSource,
    String? recordedAt,
  }) = _Reading;

  factory Reading.fromJson(Map<String, dynamic> json) =>
      _$ReadingFromJson(json);
}

@freezed
abstract class ConsecutiveRule with _$ConsecutiveRule {
  const factory ConsecutiveRule({
    @Default(false) bool hasTrend,
    String? direction,
    @Default(0) int longestStreak,
  }) = _ConsecutiveRule;

  factory ConsecutiveRule.fromJson(Map<String, dynamic> json) =>
      _$ConsecutiveRuleFromJson(json);
}

@freezed
abstract class LinearRegression with _$LinearRegression {
  const factory LinearRegression({
    @Default(false) bool hasTrend,
    String? direction,
    String? interpretation,
  }) = _LinearRegression;

  factory LinearRegression.fromJson(Map<String, dynamic> json) =>
      _$LinearRegressionFromJson(json);
}

/// Análisis de tendencia (`GET /sensors/{id}/trend`).
@freezed
abstract class TrendAnalysis with _$TrendAnalysis {
  const factory TrendAnalysis({
    @Default(0) int totalReadings,
    @Default(false) bool overallTrend,
    String? overallDirection,
    @Default('none') String confidence,
    ConsecutiveRule? consecutiveRule,
    LinearRegression? linearRegression,
  }) = _TrendAnalysis;

  factory TrendAnalysis.fromJson(Map<String, dynamic> json) =>
      _$TrendAnalysisFromJson(json);
}

@freezed
abstract class CalibrationCertificate with _$CalibrationCertificate {
  const factory CalibrationCertificate({
    required int id,
    String? certificateNumber,
    String? laboratory,
    String? calibratedAt,
    String? expiresAt,
    int? daysLeft,
    @Default(false) bool isCurrent,
    @Default('') String status,
    String? statusLabel,
    String? originalName,
  }) = _CalibrationCertificate;

  factory CalibrationCertificate.fromJson(Map<String, dynamic> json) =>
      _$CalibrationCertificateFromJson(json);
}

@freezed
abstract class AlertRule with _$AlertRule {
  const factory AlertRule({
    required int id,
    @Default('') String conditionType,
    @DoubleConverter() double? threshold,
    int? consecutiveReadings,
    @Default(true) bool isActive,
    @Default([]) List<String> notificationChannels,
  }) = _AlertRule;

  factory AlertRule.fromJson(Map<String, dynamic> json) =>
      _$AlertRuleFromJson(json);
}
