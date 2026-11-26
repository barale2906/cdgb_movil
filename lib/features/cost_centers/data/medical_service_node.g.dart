// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_service_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MedicalServiceNode _$MedicalServiceNodeFromJson(Map<String, dynamic> json) =>
    _MedicalServiceNode(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      children:
          (json['children'] as List<dynamic>?)
              ?.map(
                (e) => MedicalServiceNode.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MedicalServiceNodeToJson(_MedicalServiceNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'type': instance.type,
      'description': instance.description,
      'is_active': instance.isActive,
      'children': instance.children.map((e) => e.toJson()).toList(),
    };

_ProcedurePrice _$ProcedurePriceFromJson(Map<String, dynamic> json) =>
    _ProcedurePrice(
      id: (json['id'] as num).toInt(),
      unitPrice: const DoubleConverter().fromJson(json['unit_price']),
      effectiveFrom: json['effective_from'] as String?,
      effectiveTo: json['effective_to'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      isCurrentlyValid: json['is_currently_valid'] as bool? ?? false,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ProcedurePriceToJson(_ProcedurePrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit_price': const DoubleConverter().toJson(instance.unitPrice),
      'effective_from': instance.effectiveFrom,
      'effective_to': instance.effectiveTo,
      'is_active': instance.isActive,
      'is_currently_valid': instance.isCurrentlyValid,
      'notes': instance.notes,
    };
