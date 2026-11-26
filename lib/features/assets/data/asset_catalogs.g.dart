// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_catalogs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetSite _$AssetSiteFromJson(Map<String, dynamic> json) => _AssetSite(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  places:
      (json['places'] as List<dynamic>?)
          ?.map((e) => AssetPlace.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AssetSiteToJson(_AssetSite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'places': instance.places.map((e) => e.toJson()).toList(),
    };

_AssetPlace _$AssetPlaceFromJson(Map<String, dynamic> json) =>
    _AssetPlace(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$AssetPlaceToJson(_AssetPlace instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_CatalogOption _$CatalogOptionFromJson(Map<String, dynamic> json) =>
    _CatalogOption(
      value: json['value'] as String,
      label: json['label'] as String,
      requiresSignature: json['requires_signature'] as bool? ?? false,
    );

Map<String, dynamic> _$CatalogOptionToJson(_CatalogOption instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'requires_signature': instance.requiresSignature,
    };

_AssetFilters _$AssetFiltersFromJson(Map<String, dynamic> json) =>
    _AssetFilters(
      sites:
          (json['sites'] as List<dynamic>?)
              ?.map((e) => AssetSite.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      transferTypes:
          (json['transfer_types'] as List<dynamic>?)
              ?.map((e) => CatalogOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      maintenanceResults:
          (json['maintenance_results'] as List<dynamic>?)
              ?.map((e) => CatalogOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      documentTypes:
          (json['document_types'] as List<dynamic>?)
              ?.map((e) => CatalogOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      settableStatuses:
          (json['settable_statuses'] as List<dynamic>?)
              ?.map((e) => CatalogOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AssetFiltersToJson(_AssetFilters instance) =>
    <String, dynamic>{
      'sites': instance.sites.map((e) => e.toJson()).toList(),
      'transfer_types': instance.transferTypes.map((e) => e.toJson()).toList(),
      'maintenance_results': instance.maintenanceResults
          .map((e) => e.toJson())
          .toList(),
      'document_types': instance.documentTypes.map((e) => e.toJson()).toList(),
      'settable_statuses': instance.settableStatuses
          .map((e) => e.toJson())
          .toList(),
    };

_MaintenanceCounts _$MaintenanceCountsFromJson(Map<String, dynamic> json) =>
    _MaintenanceCounts(
      overdue: (json['overdue'] as num?)?.toInt() ?? 0,
      upcoming: (json['upcoming'] as num?)?.toInt() ?? 0,
      inProgress: (json['in_progress'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MaintenanceCountsToJson(_MaintenanceCounts instance) =>
    <String, dynamic>{
      'overdue': instance.overdue,
      'upcoming': instance.upcoming,
      'in_progress': instance.inProgress,
    };

_AssetStatistics _$AssetStatisticsFromJson(Map<String, dynamic> json) =>
    _AssetStatistics(
      total: (json['total'] as num?)?.toInt() ?? 0,
      byStatus:
          (json['by_status'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      offPremises: (json['off_premises'] as num?)?.toInt() ?? 0,
      totalValue: const DoubleConverter().fromJson(json['total_value']),
      pendingTransfers: (json['pending_transfers'] as num?)?.toInt() ?? 0,
      maintenance: json['maintenance'] == null
          ? const MaintenanceCounts()
          : MaintenanceCounts.fromJson(
              json['maintenance'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AssetStatisticsToJson(_AssetStatistics instance) =>
    <String, dynamic>{
      'total': instance.total,
      'by_status': instance.byStatus,
      'off_premises': instance.offPremises,
      'total_value': const DoubleConverter().toJson(instance.totalValue),
      'pending_transfers': instance.pendingTransfers,
      'maintenance': instance.maintenance.toJson(),
    };
