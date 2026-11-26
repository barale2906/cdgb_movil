import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/monitoring/data/alert_rule_request.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_repository.dart';

/// Periodos de análisis de un sensor.
enum MonitoringPeriod {
  day(Duration(days: 1)),
  week(Duration(days: 7)),
  month(Duration(days: 30))
  ;

  const MonitoringPeriod(this.length);

  final Duration length;
}

/// Sensor + periodo (hora de Colombia, calculada con el reloj inyectado).
@immutable
class SensorRange {
  const SensorRange(this.sensorId, this.period);

  final int sensorId;
  final MonitoringPeriod period;

  @override
  bool operator ==(Object other) =>
      other is SensorRange &&
      other.sensorId == sensorId &&
      other.period == period;

  @override
  int get hashCode => Object.hash(sensorId, period);
}

final FutureProvider<List<Sensor>> sensorsProvider =
    FutureProvider.autoDispose<List<Sensor>>(
      (ref) => ref.watch(monitoringRepositoryProvider).sensors(),
    );

/// Un sensor: sale de la lista ya cargada o se pide si no está.
final FutureProviderFamily<Sensor, int> sensorProvider = FutureProvider
    .autoDispose
    .family<Sensor, int>((ref, id) async {
      final sensors = await ref.watch(sensorsProvider.future);
      for (final sensor in sensors) {
        if (sensor.id == id) return sensor;
      }
      return ref.watch(monitoringRepositoryProvider).sensor(id);
    });

final FutureProviderFamily<List<Reading>, SensorRange> readingsProvider =
    FutureProvider.autoDispose.family<List<Reading>, SensorRange>((ref, key) {
      final now = ColombiaTime.now(ref.watch(clockProvider));
      return ref
          .watch(monitoringRepositoryProvider)
          .readings(
            key.sensorId,
            from: now.subtract(key.period.length),
            to: now,
          );
    });

final FutureProviderFamily<TrendAnalysis, SensorRange> trendProvider =
    FutureProvider.autoDispose.family<TrendAnalysis, SensorRange>((ref, key) {
      final now = ColombiaTime.now(ref.watch(clockProvider));
      return ref
          .watch(monitoringRepositoryProvider)
          .trend(key.sensorId, from: now.subtract(key.period.length), to: now);
    });

final FutureProviderFamily<List<CalibrationCertificate>, int>
calibrationsProvider = FutureProvider.autoDispose
    .family<List<CalibrationCertificate>, int>(
      (ref, sensorId) =>
          ref.watch(monitoringRepositoryProvider).calibrations(sensorId),
    );

final FutureProviderFamily<List<AlertRule>, int> alertRulesProvider =
    FutureProvider.autoDispose.family<List<AlertRule>, int>(
      (ref, sensorId) =>
          ref.watch(monitoringRepositoryProvider).alertRules(sensorId),
    );

/// Crear, activar/desactivar y eliminar reglas de alerta. Son escrituras:
/// bloquean el botón en vuelo y nunca se reintentan solas; tras un timeout se
/// recarga la lista por si sí se aplicaron.
class AlertRuleActions extends SubmissionNotifier {
  Future<bool> create(int sensorId, AlertRuleRequest request) => _apply(
    sensorId,
    () => ref
        .read(monitoringRepositoryProvider)
        .createAlertRule(sensorId, request),
  );

  Future<bool> setActive(
    int sensorId,
    int ruleId, {
    required bool active,
  }) => _apply(
    sensorId,
    () => ref
        .read(monitoringRepositoryProvider)
        .setAlertRuleActive(ruleId, active: active),
  );

  Future<bool> delete(int sensorId, int ruleId) => _apply(
    sensorId,
    () => ref.read(monitoringRepositoryProvider).deleteAlertRule(ruleId),
  );

  Future<bool> _apply(int sensorId, Future<void> Function() action) async {
    final done = await run(action);
    final error = state.error;
    final timedOut =
        error is NetworkException && error.kind == NetworkFailureKind.timeout;
    if (done || timedOut) ref.invalidate(alertRulesProvider(sensorId));
    return done;
  }
}

final NotifierProvider<AlertRuleActions, SubmissionState>
alertRuleActionsProvider =
    NotifierProvider.autoDispose<AlertRuleActions, SubmissionState>(
      AlertRuleActions.new,
    );

/// Registra una lectura manual y refresca lo que depende de ella.
class RegisterReadingController extends SubmissionNotifier {
  Future<ReadingResult?> submit({
    required int sensorId,
    required double value,
    required DateTime recordedAt,
  }) async {
    final result = await runValue(
      () => ref
          .read(monitoringRepositoryProvider)
          .registerReading(sensorId, value: value, recordedAt: recordedAt),
    );
    if (result != null) {
      ref
        ..invalidate(sensorsProvider)
        ..invalidate(readingsProvider)
        ..invalidate(trendProvider);
    }
    return result;
  }
}

final NotifierProvider<RegisterReadingController, SubmissionState>
registerReadingControllerProvider =
    NotifierProvider.autoDispose<RegisterReadingController, SubmissionState>(
      RegisterReadingController.new,
    );
