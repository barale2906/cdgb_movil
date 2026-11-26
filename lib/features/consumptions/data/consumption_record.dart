import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'consumption_record.freezed.dart';
part 'consumption_record.g.dart';

/// Estado de la sincronización de un consumo con la historia clínica.
enum SyncStatus {
  pending('pending'),
  synced('synced'),
  failed('failed'),
  unknown('')
  ;

  const SyncStatus(this.value);

  final String value;

  static SyncStatus parse(Object? value) => SyncStatus.values.firstWhere(
    (status) => status.value == value,
    orElse: () => SyncStatus.unknown,
  );
}

/// Un estado nuevo del backend no debe romper la lista.
class SyncStatusConverter implements JsonConverter<SyncStatus, Object?> {
  const SyncStatusConverter();

  @override
  SyncStatus fromJson(Object? json) => SyncStatus.parse(json);

  @override
  Object toJson(SyncStatus object) => object.value;
}

/// Consumo de un insumo en un procedimiento (`ConsumptionRecordResource`).
@freezed
abstract class ConsumptionRecord with _$ConsumptionRecord {
  const factory ConsumptionRecord({
    required int id,
    String? appointmentId,
    String? patientIdentifier,
    String? serviceType,
    String? productName,
    String? productCode,
    String? lotNumber,
    @DoubleConverter() double? quantity,
    String? consumedAt,
    @SyncStatusConverter() @Default(SyncStatus.unknown) SyncStatus syncStatus,
    String? syncedToHcAt,
  }) = _ConsumptionRecord;

  const ConsumptionRecord._();

  factory ConsumptionRecord.fromJson(Map<String, dynamic> json) =>
      _$ConsumptionRecordFromJson(json);

  /// Solo un consumo fallido se puede reenviar a la historia clínica.
  bool get canRetrySync => syncStatus == SyncStatus.failed;
}

/// Proyección de consumo de un servicio según citas futuras de MedSys y el
/// promedio histórico.
@freezed
abstract class ServiceProjection with _$ServiceProjection {
  const factory ServiceProjection({
    required String serviceName,
    @Default(0) int futureAppointments,
    @DoubleConverter() double? avgUnitsPerAppointment,
    @Default(0) int projectedUnits,
  }) = _ServiceProjection;

  factory ServiceProjection.fromJson(Map<String, dynamic> json) =>
      _$ServiceProjectionFromJson(json);
}
