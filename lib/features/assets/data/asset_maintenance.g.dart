// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_maintenance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaintenanceAsset _$MaintenanceAssetFromJson(Map<String, dynamic> json) =>
    _MaintenanceAsset(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$MaintenanceAssetToJson(_MaintenanceAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'location': instance.location,
    };

_ReplacedPart _$ReplacedPartFromJson(Map<String, dynamic> json) =>
    _ReplacedPart(
      name: json['name'] as String,
      quantity: const DoubleConverter().fromJson(json['quantity']),
      cost: const DoubleConverter().fromJson(json['cost']),
    );

Map<String, dynamic> _$ReplacedPartToJson(_ReplacedPart instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': const DoubleConverter().toJson(instance.quantity),
      'cost': const DoubleConverter().toJson(instance.cost),
    };

_AssetMaintenance _$AssetMaintenanceFromJson(Map<String, dynamic> json) =>
    _AssetMaintenance(
      id: (json['id'] as num).toInt(),
      asset: json['asset'] == null
          ? null
          : MaintenanceAsset.fromJson(json['asset'] as Map<String, dynamic>),
      planId: (json['plan_id'] as num?)?.toInt(),
      maintenanceType: json['maintenance_type'] as String?,
      status: json['status'] == null
          ? MaintenanceStatus.unknown
          : const MaintenanceStatusConverter().fromJson(json['status']),
      isOverdue: json['is_overdue'] as bool? ?? false,
      scheduledDate: json['scheduled_date'] as String?,
      startedAt: json['started_at'] as String?,
      performedAt: json['performed_at'] as String?,
      performedByType: json['performed_by_type'] as String?,
      technician: json['technician'] == null
          ? null
          : NamedRef.fromJson(json['technician'] as Map<String, dynamic>),
      supplier: json['supplier'] == null
          ? null
          : NamedRef.fromJson(json['supplier'] as Map<String, dynamic>),
      externalTechnicianName: json['external_technician_name'] as String?,
      reportedFailure: json['reported_failure'] as String?,
      activitiesPerformed: json['activities_performed'] as String?,
      findings: json['findings'] as String?,
      recommendations: json['recommendations'] as String?,
      partsReplaced:
          (json['parts_replaced'] as List<dynamic>?)
              ?.map((e) => ReplacedPart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      cost: const DoubleConverter().fromJson(json['cost']),
      result: json['result'] as String?,
      cancelReason: json['cancel_reason'] as String?,
      documentsCount: (json['documents_count'] as num?)?.toInt() ?? 0,
      signatures:
          (json['signatures'] as List<dynamic>?)
              ?.map(
                (e) => TransferSignature.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AssetMaintenanceToJson(_AssetMaintenance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'asset': instance.asset?.toJson(),
      'plan_id': instance.planId,
      'maintenance_type': instance.maintenanceType,
      'status': const MaintenanceStatusConverter().toJson(instance.status),
      'is_overdue': instance.isOverdue,
      'scheduled_date': instance.scheduledDate,
      'started_at': instance.startedAt,
      'performed_at': instance.performedAt,
      'performed_by_type': instance.performedByType,
      'technician': instance.technician?.toJson(),
      'supplier': instance.supplier?.toJson(),
      'external_technician_name': instance.externalTechnicianName,
      'reported_failure': instance.reportedFailure,
      'activities_performed': instance.activitiesPerformed,
      'findings': instance.findings,
      'recommendations': instance.recommendations,
      'parts_replaced': instance.partsReplaced.map((e) => e.toJson()).toList(),
      'cost': const DoubleConverter().toJson(instance.cost),
      'result': instance.result,
      'cancel_reason': instance.cancelReason,
      'documents_count': instance.documentsCount,
      'signatures': instance.signatures.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt,
    };

_MaintenancePlan _$MaintenancePlanFromJson(Map<String, dynamic> json) =>
    _MaintenancePlan(
      id: (json['id'] as num).toInt(),
      maintenanceType: json['maintenance_type'] as String?,
      frequencyValue: (json['frequency_value'] as num?)?.toInt(),
      frequencyUnit: json['frequency_unit'] as String?,
      startDate: json['start_date'] as String?,
      performedByType: json['performed_by_type'] as String?,
      technician: json['technician'] == null
          ? null
          : NamedRef.fromJson(json['technician'] as Map<String, dynamic>),
      supplier: json['supplier'] == null
          ? null
          : NamedRef.fromJson(json['supplier'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      nextDate: json['next_date'] as String?,
    );

Map<String, dynamic> _$MaintenancePlanToJson(_MaintenancePlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'maintenance_type': instance.maintenanceType,
      'frequency_value': instance.frequencyValue,
      'frequency_unit': instance.frequencyUnit,
      'start_date': instance.startDate,
      'performed_by_type': instance.performedByType,
      'technician': instance.technician?.toJson(),
      'supplier': instance.supplier?.toJson(),
      'notes': instance.notes,
      'is_active': instance.isActive,
      'next_date': instance.nextDate,
    };
