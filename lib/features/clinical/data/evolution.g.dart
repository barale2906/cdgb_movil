// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evolution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Evolution _$EvolutionFromJson(Map<String, dynamic> json) => _Evolution(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String,
  patientProcedureRecordId: (json['patient_procedure_record_id'] as num?)
      ?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  userName: json['user_name'] as String?,
  recordedAt: json['recorded_at'] as String?,
);

Map<String, dynamic> _$EvolutionToJson(_Evolution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'patient_procedure_record_id': instance.patientProcedureRecordId,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'recorded_at': instance.recordedAt,
    };

_ProcedureMedication _$ProcedureMedicationFromJson(Map<String, dynamic> json) =>
    _ProcedureMedication(
      productName: json['product_name'] as String,
      lotNumber: json['lot_number'] as String?,
      expirationDate: json['expiration_date'] as String?,
      quantity: const DoubleConverter().fromJson(json['quantity']),
    );

Map<String, dynamic> _$ProcedureMedicationToJson(
  _ProcedureMedication instance,
) => <String, dynamic>{
  'product_name': instance.productName,
  'lot_number': instance.lotNumber,
  'expiration_date': instance.expirationDate,
  'quantity': const DoubleConverter().toJson(instance.quantity),
};
