// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_center.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CostCenter _$CostCenterFromJson(Map<String, dynamic> json) => _CostCenter(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  code: json['code'] as String?,
  type: json['type'] as String?,
  typeLabel: json['type_label'] as String?,
  isExternal: json['is_external'] as bool? ?? false,
  description: json['description'] as String?,
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$CostCenterToJson(_CostCenter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'type': instance.type,
      'type_label': instance.typeLabel,
      'is_external': instance.isExternal,
      'description': instance.description,
      'is_active': instance.isActive,
    };
