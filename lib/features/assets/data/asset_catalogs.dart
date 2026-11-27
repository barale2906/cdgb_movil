import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';

part 'asset_catalogs.freezed.dart';
part 'asset_catalogs.g.dart';

@freezed
abstract class AssetSite with _$AssetSite {
  const factory AssetSite({
    required int id,
    required String name,
    @Default([]) List<AssetPlace> places,
  }) = _AssetSite;

  factory AssetSite.fromJson(Map<String, dynamic> json) =>
      _$AssetSiteFromJson(json);
}

@freezed
abstract class AssetPlace with _$AssetPlace {
  const factory AssetPlace({required int id, required String name}) =
      _AssetPlace;

  factory AssetPlace.fromJson(Map<String, dynamic> json) =>
      _$AssetPlaceFromJson(json);
}

/// Opción de catálogo del servidor (`{value, label}`).
@freezed
abstract class CatalogOption with _$CatalogOption {
  const factory CatalogOption({
    required String value,
    required String label,
    @Default(false) bool requiresSignature,
  }) = _CatalogOption;

  factory CatalogOption.fromJson(Map<String, dynamic> json) =>
      _$CatalogOptionFromJson(json);
}

/// `GET /assets/filters`: catálogos para filtros y formularios.
@freezed
abstract class AssetFilters with _$AssetFilters {
  const factory AssetFilters({
    @Default([]) List<AssetCategory> categories,
    @Default([]) List<AssetSite> sites,
    @Default([]) List<NamedRef> users,
    @Default([]) List<NamedRef> suppliers,
    @Default([]) List<CatalogOption> transferTypes,
    @Default([]) List<CatalogOption> maintenanceResults,
    @Default([]) List<CatalogOption> documentTypes,
    @Default([]) List<CatalogOption> settableStatuses,
  }) = _AssetFilters;

  factory AssetFilters.fromJson(Map<String, dynamic> json) =>
      _$AssetFiltersFromJson(json);
}

@freezed
abstract class MaintenanceCounts with _$MaintenanceCounts {
  const factory MaintenanceCounts({
    @Default(0) int overdue,
    @Default(0) int upcoming,
    @Default(0) int inProgress,
  }) = _MaintenanceCounts;

  factory MaintenanceCounts.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceCountsFromJson(json);
}

/// `GET /assets/statistics`.
@freezed
abstract class AssetStatistics with _$AssetStatistics {
  const factory AssetStatistics({
    @Default(0) int total,
    @Default({}) Map<String, int> byStatus,
    @Default(0) int offPremises,
    @DoubleConverter() double? totalValue,
    @Default(0) int pendingTransfers,
    @Default(MaintenanceCounts()) MaintenanceCounts maintenance,
  }) = _AssetStatistics;

  factory AssetStatistics.fromJson(Map<String, dynamic> json) =>
      _$AssetStatisticsFromJson(json);
}
