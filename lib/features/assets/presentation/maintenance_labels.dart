import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

String maintenanceStatusLabel(
  AppLocalizations l10n,
  MaintenanceStatus status, {
  bool overdue = false,
}) {
  if (overdue) return l10n.maintenanceStatusOverdue;
  return switch (status) {
    MaintenanceStatus.scheduled => l10n.maintenanceStatusScheduled,
    MaintenanceStatus.inProgress => l10n.maintenanceStatusInProgress,
    MaintenanceStatus.completed => l10n.maintenanceStatusCompleted,
    MaintenanceStatus.cancelled => l10n.maintenanceStatusCancelled,
    MaintenanceStatus.unknown => l10n.statusUnknown,
  };
}

StatusKind maintenanceStatusKind(
  MaintenanceStatus status, {
  bool overdue = false,
}) {
  if (overdue) return StatusKind.error;
  return switch (status) {
    MaintenanceStatus.scheduled => StatusKind.info,
    MaintenanceStatus.inProgress => StatusKind.warning,
    MaintenanceStatus.completed => StatusKind.success,
    MaintenanceStatus.cancelled => StatusKind.error,
    MaintenanceStatus.unknown => StatusKind.special,
  };
}

IconData maintenanceStatusIcon(MaintenanceStatus status) => switch (status) {
  MaintenanceStatus.scheduled => Icons.event_outlined,
  MaintenanceStatus.inProgress => Icons.build_outlined,
  MaintenanceStatus.completed => Icons.check_circle_outline,
  MaintenanceStatus.cancelled => Icons.block,
  MaintenanceStatus.unknown => Icons.help_outline,
};

String maintenanceTypeLabel(AppLocalizations l10n, MaintenanceType type) =>
    switch (type) {
      MaintenanceType.preventive => l10n.maintenanceTypePreventive,
      MaintenanceType.calibration => l10n.maintenanceTypeCalibration,
      MaintenanceType.metrologicalVerification =>
        l10n.maintenanceTypeMetrological,
      MaintenanceType.inspection => l10n.maintenanceTypeInspection,
      MaintenanceType.corrective => l10n.maintenanceTypeCorrective,
      MaintenanceType.unknown => l10n.statusUnknown,
    };

String maintenanceResultLabel(
  AppLocalizations l10n,
  MaintenanceResult result,
) => switch (result) {
  MaintenanceResult.operational => l10n.maintenanceResultOperational,
  MaintenanceResult.operationalWithRestrictions =>
    l10n.maintenanceResultRestricted,
  MaintenanceResult.outOfService => l10n.maintenanceResultOutOfService,
  MaintenanceResult.unknown => l10n.statusUnknown,
};

class MaintenanceStatusChip extends StatelessWidget {
  const MaintenanceStatusChip({required this.maintenance, super.key});

  final AssetMaintenance maintenance;

  @override
  Widget build(BuildContext context) => StatusChip(
    label: maintenanceStatusLabel(
      AppLocalizations.of(context),
      maintenance.status,
      overdue: maintenance.isOverdue,
    ),
    kind: maintenanceStatusKind(
      maintenance.status,
      overdue: maintenance.isOverdue,
    ),
    icon: maintenanceStatusIcon(maintenance.status),
  );
}
