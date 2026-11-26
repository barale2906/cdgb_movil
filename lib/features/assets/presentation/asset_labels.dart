import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

String assetStatusLabel(AppLocalizations l10n, AssetStatus status) =>
    switch (status) {
      AssetStatus.operational => l10n.assetStatusOperational,
      AssetStatus.maintenance => l10n.assetStatusMaintenance,
      AssetStatus.outOfService => l10n.assetStatusOutOfService,
      AssetStatus.available => l10n.assetStatusAvailable,
      AssetStatus.retired => l10n.assetStatusRetired,
      AssetStatus.unknown => l10n.statusUnknown,
    };

StatusKind assetStatusKind(AssetStatus status) => switch (status) {
  AssetStatus.operational => StatusKind.success,
  AssetStatus.maintenance => StatusKind.warning,
  AssetStatus.outOfService => StatusKind.error,
  AssetStatus.available => StatusKind.info,
  AssetStatus.retired || AssetStatus.unknown => StatusKind.special,
};

IconData assetStatusIcon(AssetStatus status) => switch (status) {
  AssetStatus.operational => Icons.check_circle_outline,
  AssetStatus.maintenance => Icons.build_outlined,
  AssetStatus.outOfService => Icons.block,
  AssetStatus.available => Icons.inventory_2_outlined,
  AssetStatus.retired || AssetStatus.unknown => Icons.archive_outlined,
};

String assetTypeLabel(AppLocalizations l10n, AssetType type) => switch (type) {
  AssetType.biomedical => l10n.assetTypeBiomedical,
  AssetType.computing => l10n.assetTypeComputing,
  AssetType.general => l10n.assetTypeGeneral,
  AssetType.unknown => l10n.statusUnknown,
};

class AssetStatusChip extends StatelessWidget {
  const AssetStatusChip({required this.status, super.key});

  final AssetStatus status;

  @override
  Widget build(BuildContext context) => StatusChip(
    label: assetStatusLabel(AppLocalizations.of(context), status),
    kind: assetStatusKind(status),
    icon: assetStatusIcon(status),
  );
}

/// Etiqueta de un campo del perfil técnico (`technical_profile`); `null` si
/// el campo no se muestra (listas y datos internos).
String? technicalFieldLabel(AppLocalizations l10n, String field) =>
    switch (field) {
      'manufacturer' => l10n.techManufacturer,
      'country_of_origin' => l10n.techCountry,
      'manufacture_year' => l10n.techYear,
      'useful_life_years' => l10n.techUsefulLife,
      'acquisition_mode' => l10n.techAcquisitionMode,
      'accessories' => l10n.techAccessories,
      'usage_recommendations' => l10n.techRecommendations,
      'invima_registry' => l10n.techInvima,
      'risk_class' => l10n.techRiskClass,
      'biomedical_class' => l10n.techBiomedicalClass,
      'power_source' => l10n.techPowerSource,
      'voltage' => l10n.techVoltage,
      'current' => l10n.techCurrent,
      'power' => l10n.techPower,
      'frequency' => l10n.techFrequency,
      'requires_calibration' => l10n.techRequiresCalibration,
      'operating_conditions' => l10n.techOperatingConditions,
      'processor' => l10n.techProcessor,
      'ram' => l10n.techRam,
      'storage' => l10n.techStorage,
      'operating_system' => l10n.techOperatingSystem,
      'ip_address' => l10n.techIp,
      'mac_address' => l10n.techMac,
      'hostname' => l10n.techHostname,
      _ => null,
    };
