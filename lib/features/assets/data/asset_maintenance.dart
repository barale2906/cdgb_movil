import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';
import 'package:sga_bojanini/features/assets/data/asset_transfer.dart';

part 'asset_maintenance.freezed.dart';
part 'asset_maintenance.g.dart';

/// Estado de un mantenimiento: `scheduled → in_progress → completed`.
enum MaintenanceStatus {
  scheduled('scheduled'),
  inProgress('in_progress'),
  completed('completed'),
  cancelled('cancelled'),
  unknown('unknown')
  ;

  const MaintenanceStatus(this.value);

  final String value;

  static MaintenanceStatus parse(Object? raw) => values.firstWhere(
    (status) => status.value == raw,
    orElse: () => unknown,
  );
}

class MaintenanceStatusConverter
    implements JsonConverter<MaintenanceStatus, Object?> {
  const MaintenanceStatusConverter();

  @override
  MaintenanceStatus fromJson(Object? json) => MaintenanceStatus.parse(json);

  @override
  Object toJson(MaintenanceStatus object) => object.value;
}

enum MaintenanceType {
  preventive('preventive'),
  calibration('calibration'),
  metrologicalVerification('metrological_verification'),
  inspection('inspection'),
  corrective('corrective'),
  unknown('unknown')
  ;

  const MaintenanceType(this.value);

  final String value;

  static MaintenanceType parse(Object? raw) => values.firstWhere(
    (type) => type.value == raw,
    orElse: () => unknown,
  );
}

/// Resultado de la ejecución: define el estado final del activo.
enum MaintenanceResult {
  operational('operational'),
  operationalWithRestrictions('operational_with_restrictions'),
  outOfService('out_of_service'),
  unknown('unknown')
  ;

  const MaintenanceResult(this.value);

  final String value;

  static MaintenanceResult parse(Object? raw) => values.firstWhere(
    (result) => result.value == raw,
    orElse: () => unknown,
  );
}

@freezed
abstract class MaintenanceAsset with _$MaintenanceAsset {
  const factory MaintenanceAsset({
    required int id,
    String? code,
    String? name,
    String? location,
  }) = _MaintenanceAsset;

  factory MaintenanceAsset.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceAssetFromJson(json);
}

@freezed
abstract class ReplacedPart with _$ReplacedPart {
  const factory ReplacedPart({
    required String name,
    @DoubleConverter() double? quantity,
    @DoubleConverter() double? cost,
  }) = _ReplacedPart;

  factory ReplacedPart.fromJson(Map<String, dynamic> json) =>
      _$ReplacedPartFromJson(json);
}

/// Mantenimiento de un activo (`AssetMaintenanceResource`).
@freezed
abstract class AssetMaintenance with _$AssetMaintenance {
  const factory AssetMaintenance({
    required int id,
    MaintenanceAsset? asset,
    int? planId,
    String? maintenanceType,
    @MaintenanceStatusConverter()
    @Default(MaintenanceStatus.unknown)
    MaintenanceStatus status,
    @Default(false) bool isOverdue,
    String? scheduledDate,
    String? startedAt,
    String? performedAt,
    String? performedByType,
    NamedRef? technician,
    NamedRef? supplier,
    String? externalTechnicianName,
    String? reportedFailure,
    String? activitiesPerformed,
    String? findings,
    String? recommendations,
    @Default([]) List<ReplacedPart> partsReplaced,
    @DoubleConverter() double? cost,
    String? result,
    String? cancelReason,
    @Default(0) int documentsCount,
    @Default([]) List<TransferSignature> signatures,
    String? createdAt,
  }) = _AssetMaintenance;

  const AssetMaintenance._();

  factory AssetMaintenance.fromJson(Map<String, dynamic> json) =>
      _$AssetMaintenanceFromJson(json);

  MaintenanceType get type => MaintenanceType.parse(maintenanceType);

  MaintenanceResult get resultType => MaintenanceResult.parse(result);

  bool get canStart => status == MaintenanceStatus.scheduled;

  bool get canComplete => status == MaintenanceStatus.inProgress;

  bool get canCancel =>
      status == MaintenanceStatus.scheduled ||
      status == MaintenanceStatus.inProgress;
}
