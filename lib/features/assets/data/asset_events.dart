import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';

part 'asset_events.freezed.dart';
part 'asset_events.g.dart';

@freezed
abstract class AssetComment with _$AssetComment {
  const factory AssetComment({
    required int id,
    required String comment,
    NamedRef? user,
    String? createdAt,
  }) = _AssetComment;

  factory AssetComment.fromJson(Map<String, dynamic> json) =>
      _$AssetCommentFromJson(json);
}

/// Evento de la bitácora del activo (cambios de estado, traslados, etc.).
@freezed
abstract class AssetMovement with _$AssetMovement {
  const factory AssetMovement({
    required int id,
    String? type,
    String? typeLabel,
    String? fromStatus,
    String? toStatus,
    String? description,
    int? transferId,
    int? maintenanceId,
    NamedRef? user,
    String? createdAt,
  }) = _AssetMovement;

  factory AssetMovement.fromJson(Map<String, dynamic> json) =>
      _$AssetMovementFromJson(json);
}

@freezed
abstract class LocationRecord with _$LocationRecord {
  const factory LocationRecord({
    required int id,
    String? location,
    @Default(false) bool isOffPremises,
    @Default(false) bool isCurrent,
    String? fromDate,
    String? toDate,
    String? transferLabel,
    NamedRef? assignedBy,
  }) = _LocationRecord;

  factory LocationRecord.fromJson(Map<String, dynamic> json) =>
      _$LocationRecordFromJson(json);
}
