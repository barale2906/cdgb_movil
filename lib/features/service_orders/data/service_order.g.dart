// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceOrder _$ServiceOrderFromJson(Map<String, dynamic> json) =>
    _ServiceOrder(
      orderNumber: json['order_number'] as String,
      patientExternalId: json['patient_external_id'] as String,
      patientDocument: json['patient_document'] as String,
      patientFirstName: json['patient_first_name'] as String,
      patientLastName: json['patient_last_name'] as String,
      orderStatus: json['order_status'] == null
          ? ServiceOrderStatus.unknown
          : const ServiceOrderStatusConverter().fromJson(json['order_status']),
      serviceDate: json['service_date'] as String?,
      billingStatus: json['billing_status'] as String?,
      totalAmount: const DoubleConverter().fromJson(json['total_amount']),
      totalDiscount: const DoubleConverter().fromJson(json['total_discount']),
      netTotal: const DoubleConverter().fromJson(json['net_total']),
      procedures:
          (json['procedures'] as List<dynamic>?)
              ?.map((e) => ProcedureRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ServiceOrderToJson(_ServiceOrder instance) =>
    <String, dynamic>{
      'order_number': instance.orderNumber,
      'patient_external_id': instance.patientExternalId,
      'patient_document': instance.patientDocument,
      'patient_first_name': instance.patientFirstName,
      'patient_last_name': instance.patientLastName,
      'order_status': const ServiceOrderStatusConverter().toJson(
        instance.orderStatus,
      ),
      'service_date': instance.serviceDate,
      'billing_status': instance.billingStatus,
      'total_amount': const DoubleConverter().toJson(instance.totalAmount),
      'total_discount': const DoubleConverter().toJson(instance.totalDiscount),
      'net_total': const DoubleConverter().toJson(instance.netTotal),
      'procedures': instance.procedures.map((e) => e.toJson()).toList(),
    };

_DiscountOrder _$DiscountOrderFromJson(Map<String, dynamic> json) =>
    _DiscountOrder(
      orderNumber: json['order_number'] as String,
      patientDocument: json['patient_document'] as String,
      patientFirstName: json['patient_first_name'] as String,
      patientLastName: json['patient_last_name'] as String,
      serviceDate: json['service_date'] as String?,
      records:
          (json['records'] as List<dynamic>?)
              ?.map((e) => ProcedureRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DiscountOrderToJson(_DiscountOrder instance) =>
    <String, dynamic>{
      'order_number': instance.orderNumber,
      'patient_document': instance.patientDocument,
      'patient_first_name': instance.patientFirstName,
      'patient_last_name': instance.patientLastName,
      'service_date': instance.serviceDate,
      'records': instance.records.map((e) => e.toJson()).toList(),
    };
