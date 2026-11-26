import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

class AssetStatusConverter implements JsonConverter<AssetStatus, Object?> {
  const AssetStatusConverter();

  @override
  AssetStatus fromJson(Object? json) => AssetStatus.parse(json);

  @override
  Object toJson(AssetStatus object) => object.value;
}

class AssetTypeConverter implements JsonConverter<AssetType, Object?> {
  const AssetTypeConverter();

  @override
  AssetType fromJson(Object? json) => AssetType.parse(json);

  @override
  Object toJson(AssetType object) => object.value;
}

@freezed
abstract class AssetCategory with _$AssetCategory {
  const factory AssetCategory({
    required int id,
    required String name,
    String? code,
  }) = _AssetCategory;

  factory AssetCategory.fromJson(Map<String, dynamic> json) =>
      _$AssetCategoryFromJson(json);
}

/// Dónde está el activo: un lugar de una sede o fuera de las instalaciones.
@freezed
abstract class AssetLocation with _$AssetLocation {
  const factory AssetLocation({
    @Default(false) bool isOffPremises,
    String? offPremisesLocation,
    int? placeId,
    String? placeName,
    int? siteId,
    String? siteName,
  }) = _AssetLocation;

  factory AssetLocation.fromJson(Map<String, dynamic> json) =>
      _$AssetLocationFromJson(json);
}

@freezed
abstract class NextMaintenance with _$NextMaintenance {
  const factory NextMaintenance({
    required int id,
    String? type,
    String? typeLabel,
    String? status,
    String? scheduledDate,
    @Default(false) bool isOverdue,
  }) = _NextMaintenance;

  factory NextMaintenance.fromJson(Map<String, dynamic> json) =>
      _$NextMaintenanceFromJson(json);
}

@freezed
abstract class PendingTransfer with _$PendingTransfer {
  const factory PendingTransfer({
    required int id,
    String? type,
    String? typeLabel,
  }) = _PendingTransfer;

  factory PendingTransfer.fromJson(Map<String, dynamic> json) =>
      _$PendingTransferFromJson(json);
}

@freezed
abstract class AssetCounts with _$AssetCounts {
  const factory AssetCounts({
    @Default(0) int comments,
    @Default(0) int documents,
    @Default(0) int maintenancePlans,
  }) = _AssetCounts;

  factory AssetCounts.fromJson(Map<String, dynamic> json) =>
      _$AssetCountsFromJson(json);
}

/// Activo fijo (`AssetResource`).
@freezed
abstract class Asset with _$Asset {
  const factory Asset({
    required int id,
    required String code,
    required String name,
    @AssetStatusConverter() @Default(AssetStatus.unknown) AssetStatus status,
    @AssetTypeConverter() @Default(AssetType.unknown) AssetType assetType,
    String? description,
    AssetCategory? category,
    @Default(false) bool requiresMaintenance,
    @Default(AssetLocation()) AssetLocation location,
    NamedRef? responsible,
    String? brand,
    String? model,
    String? serial,
    String? acquisitionDate,
    @DoubleConverter() double? acquisitionValue,
    NamedRef? supplier,
    String? invoiceNumber,
    String? warrantyUntil,
    String? retiredAt,
    String? retirementReason,
    String? notes,
    NextMaintenance? nextMaintenance,
    PendingTransfer? pendingTransfer,
    @Default({}) Map<String, dynamic> technicalProfile,
    AssetCounts? counts,
    String? createdAt,
  }) = _Asset;

  const Asset._();

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  /// Un activo fuera de las instalaciones solo admite devolución o baja.
  bool get isOffPremises => location.isOffPremises;

  bool get isRetired => status == AssetStatus.retired;

  /// Descripción corta del lugar: "Sede · Lugar" o la ubicación externa.
  String? get locationLabel {
    if (location.isOffPremises) return location.offPremisesLocation;
    final parts = [
      location.siteName,
      location.placeName,
    ].whereType<String>().where((part) => part.isNotEmpty);
    return parts.isEmpty ? null : parts.join(' · ');
  }
}
