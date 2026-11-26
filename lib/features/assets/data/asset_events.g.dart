// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetComment _$AssetCommentFromJson(Map<String, dynamic> json) =>
    _AssetComment(
      id: (json['id'] as num).toInt(),
      comment: json['comment'] as String,
      user: json['user'] == null
          ? null
          : NamedRef.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AssetCommentToJson(_AssetComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'user': instance.user?.toJson(),
      'created_at': instance.createdAt,
    };

_AssetMovement _$AssetMovementFromJson(Map<String, dynamic> json) =>
    _AssetMovement(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String?,
      typeLabel: json['type_label'] as String?,
      fromStatus: json['from_status'] as String?,
      toStatus: json['to_status'] as String?,
      description: json['description'] as String?,
      transferId: (json['transfer_id'] as num?)?.toInt(),
      maintenanceId: (json['maintenance_id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : NamedRef.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AssetMovementToJson(_AssetMovement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'type_label': instance.typeLabel,
      'from_status': instance.fromStatus,
      'to_status': instance.toStatus,
      'description': instance.description,
      'transfer_id': instance.transferId,
      'maintenance_id': instance.maintenanceId,
      'user': instance.user?.toJson(),
      'created_at': instance.createdAt,
    };

_LocationRecord _$LocationRecordFromJson(Map<String, dynamic> json) =>
    _LocationRecord(
      id: (json['id'] as num).toInt(),
      location: json['location'] as String?,
      isOffPremises: json['is_off_premises'] as bool? ?? false,
      isCurrent: json['is_current'] as bool? ?? false,
      fromDate: json['from_date'] as String?,
      toDate: json['to_date'] as String?,
      transferLabel: json['transfer_label'] as String?,
      assignedBy: json['assigned_by'] == null
          ? null
          : NamedRef.fromJson(json['assigned_by'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationRecordToJson(_LocationRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'is_off_premises': instance.isOffPremises,
      'is_current': instance.isCurrent,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'transfer_label': instance.transferLabel,
      'assigned_by': instance.assignedBy?.toJson(),
    };
