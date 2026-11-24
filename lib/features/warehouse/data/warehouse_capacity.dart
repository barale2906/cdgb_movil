import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_capacity.freezed.dart';
part 'warehouse_capacity.g.dart';

/// Uso de volumen (`capacity_volume`). Sin `max` no hay porcentaje.
@freezed
abstract class VolumeUsage with _$VolumeUsage {
  const factory VolumeUsage({
    double? maxCm3,
    @Default(0) double usedCm3,
    double? availableCm3,
    double? usagePct,
  }) = _VolumeUsage;

  factory VolumeUsage.fromJson(Map<String, dynamic> json) =>
      _$VolumeUsageFromJson(json);
}

/// Uso de peso (`capacity_weight`).
@freezed
abstract class WeightUsage with _$WeightUsage {
  const factory WeightUsage({
    double? maxKg,
    @Default(0) double usedKg,
    double? availableKg,
    double? usagePct,
  }) = _WeightUsage;

  factory WeightUsage.fromJson(Map<String, dynamic> json) =>
      _$WeightUsageFromJson(json);
}

@freezed
abstract class LocationCapacity with _$LocationCapacity {
  const factory LocationCapacity({
    required int id,
    required String name,
    required VolumeUsage capacityVolume,
    required WeightUsage capacityWeight,
    String? code,
  }) = _LocationCapacity;

  factory LocationCapacity.fromJson(Map<String, dynamic> json) =>
      _$LocationCapacityFromJson(json);
}

@freezed
abstract class ZoneCapacity with _$ZoneCapacity {
  const factory ZoneCapacity({
    required int id,
    required String name,
    required VolumeUsage capacityVolume,
    required WeightUsage capacityWeight,
    String? code,
    @Default([]) List<LocationCapacity> locations,
  }) = _ZoneCapacity;

  factory ZoneCapacity.fromJson(Map<String, dynamic> json) =>
      _$ZoneCapacityFromJson(json);
}

/// `GET /warehouses/{id}/capacity`: el árbol completo en una sola llamada.
@freezed
abstract class WarehouseCapacity with _$WarehouseCapacity {
  const factory WarehouseCapacity({
    required int id,
    required String name,
    required VolumeUsage capacityVolume,
    required WeightUsage capacityWeight,
    String? code,
    @Default([]) List<ZoneCapacity> zones,
  }) = _WarehouseCapacity;

  factory WarehouseCapacity.fromJson(Map<String, dynamic> json) =>
      _$WarehouseCapacityFromJson(json);
}
