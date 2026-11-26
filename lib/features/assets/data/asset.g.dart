// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetCategory _$AssetCategoryFromJson(Map<String, dynamic> json) =>
    _AssetCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$AssetCategoryToJson(_AssetCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };

_AssetLocation _$AssetLocationFromJson(Map<String, dynamic> json) =>
    _AssetLocation(
      isOffPremises: json['is_off_premises'] as bool? ?? false,
      offPremisesLocation: json['off_premises_location'] as String?,
      placeId: (json['place_id'] as num?)?.toInt(),
      placeName: json['place_name'] as String?,
      siteId: (json['site_id'] as num?)?.toInt(),
      siteName: json['site_name'] as String?,
    );

Map<String, dynamic> _$AssetLocationToJson(_AssetLocation instance) =>
    <String, dynamic>{
      'is_off_premises': instance.isOffPremises,
      'off_premises_location': instance.offPremisesLocation,
      'place_id': instance.placeId,
      'place_name': instance.placeName,
      'site_id': instance.siteId,
      'site_name': instance.siteName,
    };

_NextMaintenance _$NextMaintenanceFromJson(Map<String, dynamic> json) =>
    _NextMaintenance(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String?,
      typeLabel: json['type_label'] as String?,
      status: json['status'] as String?,
      scheduledDate: json['scheduled_date'] as String?,
      isOverdue: json['is_overdue'] as bool? ?? false,
    );

Map<String, dynamic> _$NextMaintenanceToJson(_NextMaintenance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'type_label': instance.typeLabel,
      'status': instance.status,
      'scheduled_date': instance.scheduledDate,
      'is_overdue': instance.isOverdue,
    };

_PendingTransfer _$PendingTransferFromJson(Map<String, dynamic> json) =>
    _PendingTransfer(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String?,
      typeLabel: json['type_label'] as String?,
    );

Map<String, dynamic> _$PendingTransferToJson(_PendingTransfer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'type_label': instance.typeLabel,
    };

_AssetCounts _$AssetCountsFromJson(Map<String, dynamic> json) => _AssetCounts(
  comments: (json['comments'] as num?)?.toInt() ?? 0,
  documents: (json['documents'] as num?)?.toInt() ?? 0,
  maintenancePlans: (json['maintenance_plans'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AssetCountsToJson(_AssetCounts instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'documents': instance.documents,
      'maintenance_plans': instance.maintenancePlans,
    };

_Asset _$AssetFromJson(Map<String, dynamic> json) => _Asset(
  id: (json['id'] as num).toInt(),
  code: json['code'] as String,
  name: json['name'] as String,
  status: json['status'] == null
      ? AssetStatus.unknown
      : const AssetStatusConverter().fromJson(json['status']),
  assetType: json['asset_type'] == null
      ? AssetType.unknown
      : const AssetTypeConverter().fromJson(json['asset_type']),
  description: json['description'] as String?,
  category: json['category'] == null
      ? null
      : AssetCategory.fromJson(json['category'] as Map<String, dynamic>),
  requiresMaintenance: json['requires_maintenance'] as bool? ?? false,
  location: json['location'] == null
      ? const AssetLocation()
      : AssetLocation.fromJson(json['location'] as Map<String, dynamic>),
  responsible: json['responsible'] == null
      ? null
      : NamedRef.fromJson(json['responsible'] as Map<String, dynamic>),
  brand: json['brand'] as String?,
  model: json['model'] as String?,
  serial: json['serial'] as String?,
  acquisitionDate: json['acquisition_date'] as String?,
  acquisitionValue: const DoubleConverter().fromJson(json['acquisition_value']),
  supplier: json['supplier'] == null
      ? null
      : NamedRef.fromJson(json['supplier'] as Map<String, dynamic>),
  invoiceNumber: json['invoice_number'] as String?,
  warrantyUntil: json['warranty_until'] as String?,
  retiredAt: json['retired_at'] as String?,
  retirementReason: json['retirement_reason'] as String?,
  notes: json['notes'] as String?,
  nextMaintenance: json['next_maintenance'] == null
      ? null
      : NextMaintenance.fromJson(
          json['next_maintenance'] as Map<String, dynamic>,
        ),
  pendingTransfer: json['pending_transfer'] == null
      ? null
      : PendingTransfer.fromJson(
          json['pending_transfer'] as Map<String, dynamic>,
        ),
  technicalProfile:
      json['technical_profile'] as Map<String, dynamic>? ?? const {},
  counts: json['counts'] == null
      ? null
      : AssetCounts.fromJson(json['counts'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$AssetToJson(_Asset instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'status': const AssetStatusConverter().toJson(instance.status),
  'asset_type': const AssetTypeConverter().toJson(instance.assetType),
  'description': instance.description,
  'category': instance.category?.toJson(),
  'requires_maintenance': instance.requiresMaintenance,
  'location': instance.location.toJson(),
  'responsible': instance.responsible?.toJson(),
  'brand': instance.brand,
  'model': instance.model,
  'serial': instance.serial,
  'acquisition_date': instance.acquisitionDate,
  'acquisition_value': const DoubleConverter().toJson(
    instance.acquisitionValue,
  ),
  'supplier': instance.supplier?.toJson(),
  'invoice_number': instance.invoiceNumber,
  'warranty_until': instance.warrantyUntil,
  'retired_at': instance.retiredAt,
  'retirement_reason': instance.retirementReason,
  'notes': instance.notes,
  'next_maintenance': instance.nextMaintenance?.toJson(),
  'pending_transfer': instance.pendingTransfer?.toJson(),
  'technical_profile': instance.technicalProfile,
  'counts': instance.counts?.toJson(),
  'created_at': instance.createdAt,
};
