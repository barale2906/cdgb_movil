import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/monitoring/data/alert_rule_request.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';

/// Resultado de registrar una lectura: la lectura y cuántas alertas generó.
class ReadingResult {
  const ReadingResult({required this.reading, required this.alertCount});

  final Reading reading;
  final int alertCount;
}

/// Sensores, lecturas, calibraciones y reglas de alerta
/// (`docs/app-movil/07-monitoring.md` del backend).
class MonitoringRepository {
  const MonitoringRepository(this._dio);

  final Dio _dio;

  /// Sensores del usuario, con zona, calibración y última lectura.
  Future<List<Sensor>> sensors() => apiCall(() async {
    final response = await _dio.get<dynamic>('/sensors');
    return ApiResponse.list(response, Sensor.fromJson);
  });

  Future<Sensor> sensor(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/sensors/$id');
    return Sensor.fromJson(ApiResponse.object(response));
  });

  Future<List<Reading>> readings(
    int sensorId, {
    required DateTime from,
    required DateTime to,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/sensors/$sensorId/readings',
      queryParameters: _range(from, to),
    );
    return ApiResponse.list(response, Reading.fromJson);
  });

  Future<TrendAnalysis> trend(
    int sensorId, {
    required DateTime from,
    required DateTime to,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/sensors/$sensorId/trend',
      queryParameters: _range(from, to),
    );
    return TrendAnalysis.fromJson(ApiResponse.object(response));
  });

  /// Lectura manual (escritura: nunca se reintenta sola).
  Future<ReadingResult> registerReading(
    int sensorId, {
    required double value,
    required DateTime recordedAt,
  }) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/sensors/$sensorId/readings',
      data: {
        'value': value,
        'reading_source': 'manual',
        'recorded_at': ColombiaTime.format(recordedAt),
      },
    );
    final data = ApiResponse.object(response);
    final alerts = data['alerts'];
    return ReadingResult(
      reading: Reading.fromJson(data['reading'] as Json),
      alertCount: alerts is List<dynamic> ? alerts.length : 0,
    );
  });

  Future<List<CalibrationCertificate>> calibrations(int sensorId) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/sensors/$sensorId/calibrations',
        );
        return ApiResponse.list(response, CalibrationCertificate.fromJson);
      });

  /// Certificado (PDF o imagen) como bytes; el enlace directo daría 401.
  Future<Uint8List> downloadCalibration(int id) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/calibrations/$id/download',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? const []);
  });

  /// Excel con las lecturas del periodo y su resumen estadístico.
  Future<Uint8List> exportReadings(
    int sensorId, {
    required DateTime from,
    required DateTime to,
  }) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/sensors/$sensorId/readings/export',
      queryParameters: _range(from, to),
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? const []);
  });

  Future<List<AlertRule>> alertRules(int sensorId) => apiCall(() async {
    final response = await _dio.get<dynamic>('/sensors/$sensorId/alert-rules');
    return ApiResponse.list(response, AlertRule.fromJson);
  });

  /// Crea una regla (escritura: nunca se reintenta sola).
  Future<AlertRule> createAlertRule(int sensorId, AlertRuleRequest request) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/sensors/$sensorId/alert-rules',
          data: request.toJson(),
        );
        return AlertRule.fromJson(ApiResponse.object(response));
      });

  Future<AlertRule> setAlertRuleActive(int id, {required bool active}) =>
      apiCall(() async {
        final response = await _dio.put<dynamic>(
          '/alert-rules/$id',
          data: {'is_active': active},
        );
        return AlertRule.fromJson(ApiResponse.object(response));
      });

  Future<void> deleteAlertRule(int id) => apiCall(() async {
    final response = await _dio.delete<dynamic>('/alert-rules/$id');
    ApiResponse.message(response);
  });

  static Map<String, String> _range(DateTime from, DateTime to) => {
    'date_from': _date(from),
    'date_to': _date(to),
  };

  static String _date(DateTime value) => ColombiaTime.formatDate(value);
}

final monitoringRepositoryProvider = Provider<MonitoringRepository>(
  (ref) => MonitoringRepository(ref.watch(dioProvider)),
);
