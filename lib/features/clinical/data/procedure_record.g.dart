// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProcedureRecord _$ProcedureRecordFromJson(Map<String, dynamic> json) =>
    _ProcedureRecord(
      id: (json['id'] as num).toInt(),
      patientExternalId: json['patient_external_id'] as String,
      patientDocument: json['patient_document'] as String,
      patientFirstName: json['patient_first_name'] as String,
      patientLastName: json['patient_last_name'] as String,
      medicalServiceId: (json['medical_service_id'] as num?)?.toInt(),
      medicalServiceName: json['medical_service_name'] as String?,
      quantity: const DoubleConverter().fromJson(json['quantity']),
      unitPrice: const DoubleConverter().fromJson(json['unit_price']),
      total: const DoubleConverter().fromJson(json['total']),
      discountAmount: const DoubleConverter().fromJson(json['discount_amount']),
      netTotal: const DoubleConverter().fromJson(json['net_total']),
      discountStatus: json['discount_status'] as String?,
      orderNumber: json['order_number'] as String?,
      billingStatus: json['billing_status'] as String?,
      serviceDate: json['service_date'] as String?,
      seller: json['seller'] as String?,
      referrer: json['referrer'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$ProcedureRecordToJson(
  _ProcedureRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_external_id': instance.patientExternalId,
  'patient_document': instance.patientDocument,
  'patient_first_name': instance.patientFirstName,
  'patient_last_name': instance.patientLastName,
  'medical_service_id': instance.medicalServiceId,
  'medical_service_name': instance.medicalServiceName,
  'quantity': const DoubleConverter().toJson(instance.quantity),
  'unit_price': const DoubleConverter().toJson(instance.unitPrice),
  'total': const DoubleConverter().toJson(instance.total),
  'discount_amount': const DoubleConverter().toJson(instance.discountAmount),
  'net_total': const DoubleConverter().toJson(instance.netTotal),
  'discount_status': instance.discountStatus,
  'order_number': instance.orderNumber,
  'billing_status': instance.billingStatus,
  'service_date': instance.serviceDate,
  'seller': instance.seller,
  'referrer': instance.referrer,
  'is_active': instance.isActive,
};

_HistoryRecord _$HistoryRecordFromJson(Map<String, dynamic> json) =>
    _HistoryRecord(
      id: (json['id'] as num).toInt(),
      serviceDate: json['service_date'] as String?,
      serviceName: json['service_name'] as String?,
      procedureCode: json['procedure_code'] as String?,
      procedureName: json['procedure_name'] as String?,
      quantity: const DoubleConverter().fromJson(json['quantity']),
      unitPrice: const DoubleConverter().fromJson(json['unit_price']),
      total: const DoubleConverter().fromJson(json['total']),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$HistoryRecordToJson(_HistoryRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_date': instance.serviceDate,
      'service_name': instance.serviceName,
      'procedure_code': instance.procedureCode,
      'procedure_name': instance.procedureName,
      'quantity': const DoubleConverter().toJson(instance.quantity),
      'unit_price': const DoubleConverter().toJson(instance.unitPrice),
      'total': const DoubleConverter().toJson(instance.total),
      'is_active': instance.isActive,
    };

_HistorySummary _$HistorySummaryFromJson(Map<String, dynamic> json) =>
    _HistorySummary(
      totalRecords: (json['total_records'] as num?)?.toInt() ?? 0,
      totalAmount: const DoubleConverter().fromJson(json['total_amount']),
      firstServiceDate: json['first_service_date'] as String?,
      lastServiceDate: json['last_service_date'] as String?,
    );

Map<String, dynamic> _$HistorySummaryToJson(_HistorySummary instance) =>
    <String, dynamic>{
      'total_records': instance.totalRecords,
      'total_amount': const DoubleConverter().toJson(instance.totalAmount),
      'first_service_date': instance.firstServiceDate,
      'last_service_date': instance.lastServiceDate,
    };

_PatientHistory _$PatientHistoryFromJson(Map<String, dynamic> json) =>
    _PatientHistory(
      patientExternalId: json['patient_external_id'] as String,
      patientDocument: json['patient_document'] as String,
      patientFirstName: json['patient_first_name'] as String,
      patientLastName: json['patient_last_name'] as String,
      summary: HistorySummary.fromJson(json['summary'] as Map<String, dynamic>),
      records:
          (json['records'] as List<dynamic>?)
              ?.map((e) => HistoryRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PatientHistoryToJson(_PatientHistory instance) =>
    <String, dynamic>{
      'patient_external_id': instance.patientExternalId,
      'patient_document': instance.patientDocument,
      'patient_first_name': instance.patientFirstName,
      'patient_last_name': instance.patientLastName,
      'summary': instance.summary.toJson(),
      'records': instance.records.map((e) => e.toJson()).toList(),
    };
