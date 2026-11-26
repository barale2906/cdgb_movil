// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConsumptionRecord _$ConsumptionRecordFromJson(Map<String, dynamic> json) =>
    _ConsumptionRecord(
      id: (json['id'] as num).toInt(),
      appointmentId: json['appointment_id'] as String?,
      patientIdentifier: json['patient_identifier'] as String?,
      serviceType: json['service_type'] as String?,
      productName: json['product_name'] as String?,
      productCode: json['product_code'] as String?,
      lotNumber: json['lot_number'] as String?,
      quantity: const DoubleConverter().fromJson(json['quantity']),
      consumedAt: json['consumed_at'] as String?,
      syncStatus: json['sync_status'] == null
          ? SyncStatus.unknown
          : const SyncStatusConverter().fromJson(json['sync_status']),
      syncedToHcAt: json['synced_to_hc_at'] as String?,
    );

Map<String, dynamic> _$ConsumptionRecordToJson(_ConsumptionRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_id': instance.appointmentId,
      'patient_identifier': instance.patientIdentifier,
      'service_type': instance.serviceType,
      'product_name': instance.productName,
      'product_code': instance.productCode,
      'lot_number': instance.lotNumber,
      'quantity': const DoubleConverter().toJson(instance.quantity),
      'consumed_at': instance.consumedAt,
      'sync_status': const SyncStatusConverter().toJson(instance.syncStatus),
      'synced_to_hc_at': instance.syncedToHcAt,
    };

_ServiceProjection _$ServiceProjectionFromJson(Map<String, dynamic> json) =>
    _ServiceProjection(
      serviceName: json['service_name'] as String,
      futureAppointments: (json['future_appointments'] as num?)?.toInt() ?? 0,
      avgUnitsPerAppointment: const DoubleConverter().fromJson(
        json['avg_units_per_appointment'],
      ),
      projectedUnits: (json['projected_units'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ServiceProjectionToJson(_ServiceProjection instance) =>
    <String, dynamic>{
      'service_name': instance.serviceName,
      'future_appointments': instance.futureAppointments,
      'avg_units_per_appointment': const DoubleConverter().toJson(
        instance.avgUnitsPerAppointment,
      ),
      'projected_units': instance.projectedUnits,
    };
