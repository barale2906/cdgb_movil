// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WarehouseSummary _$WarehouseSummaryFromJson(Map<String, dynamic> json) =>
    _WarehouseSummary(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$WarehouseSummaryToJson(_WarehouseSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'address': instance.address,
      'description': instance.description,
      'is_active': instance.isActive,
    };
