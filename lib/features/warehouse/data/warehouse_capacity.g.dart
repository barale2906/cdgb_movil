// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_capacity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VolumeUsage _$VolumeUsageFromJson(Map<String, dynamic> json) => _VolumeUsage(
  maxCm3: (json['max_cm3'] as num?)?.toDouble(),
  usedCm3: (json['used_cm3'] as num?)?.toDouble() ?? 0,
  availableCm3: (json['available_cm3'] as num?)?.toDouble(),
  usagePct: (json['usage_pct'] as num?)?.toDouble(),
);

Map<String, dynamic> _$VolumeUsageToJson(_VolumeUsage instance) =>
    <String, dynamic>{
      'max_cm3': instance.maxCm3,
      'used_cm3': instance.usedCm3,
      'available_cm3': instance.availableCm3,
      'usage_pct': instance.usagePct,
    };

_WeightUsage _$WeightUsageFromJson(Map<String, dynamic> json) => _WeightUsage(
  maxKg: (json['max_kg'] as num?)?.toDouble(),
  usedKg: (json['used_kg'] as num?)?.toDouble() ?? 0,
  availableKg: (json['available_kg'] as num?)?.toDouble(),
  usagePct: (json['usage_pct'] as num?)?.toDouble(),
);

Map<String, dynamic> _$WeightUsageToJson(_WeightUsage instance) =>
    <String, dynamic>{
      'max_kg': instance.maxKg,
      'used_kg': instance.usedKg,
      'available_kg': instance.availableKg,
      'usage_pct': instance.usagePct,
    };

_LocationCapacity _$LocationCapacityFromJson(Map<String, dynamic> json) =>
    _LocationCapacity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      capacityVolume: VolumeUsage.fromJson(
        json['capacity_volume'] as Map<String, dynamic>,
      ),
      capacityWeight: WeightUsage.fromJson(
        json['capacity_weight'] as Map<String, dynamic>,
      ),
      code: json['code'] as String?,
    );

Map<String, dynamic> _$LocationCapacityToJson(_LocationCapacity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capacity_volume': instance.capacityVolume.toJson(),
      'capacity_weight': instance.capacityWeight.toJson(),
      'code': instance.code,
    };

_ZoneCapacity _$ZoneCapacityFromJson(Map<String, dynamic> json) =>
    _ZoneCapacity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      capacityVolume: VolumeUsage.fromJson(
        json['capacity_volume'] as Map<String, dynamic>,
      ),
      capacityWeight: WeightUsage.fromJson(
        json['capacity_weight'] as Map<String, dynamic>,
      ),
      code: json['code'] as String?,
      locations:
          (json['locations'] as List<dynamic>?)
              ?.map((e) => LocationCapacity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ZoneCapacityToJson(_ZoneCapacity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capacity_volume': instance.capacityVolume.toJson(),
      'capacity_weight': instance.capacityWeight.toJson(),
      'code': instance.code,
      'locations': instance.locations.map((e) => e.toJson()).toList(),
    };

_WarehouseCapacity _$WarehouseCapacityFromJson(Map<String, dynamic> json) =>
    _WarehouseCapacity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      capacityVolume: VolumeUsage.fromJson(
        json['capacity_volume'] as Map<String, dynamic>,
      ),
      capacityWeight: WeightUsage.fromJson(
        json['capacity_weight'] as Map<String, dynamic>,
      ),
      code: json['code'] as String?,
      zones:
          (json['zones'] as List<dynamic>?)
              ?.map((e) => ZoneCapacity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WarehouseCapacityToJson(_WarehouseCapacity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capacity_volume': instance.capacityVolume.toJson(),
      'capacity_weight': instance.capacityWeight.toJson(),
      'code': instance.code,
      'zones': instance.zones.map((e) => e.toJson()).toList(),
    };
