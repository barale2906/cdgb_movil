import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

String sensorTypeLabel(AppLocalizations l10n, SensorType type) =>
    switch (type) {
      SensorType.temperature => l10n.sensorTypeTemperature,
      SensorType.humidity => l10n.sensorTypeHumidity,
      SensorType.unknown => '',
    };

IconData sensorTypeIcon(SensorType type) => switch (type) {
  SensorType.temperature => Icons.thermostat,
  SensorType.humidity => Icons.water_drop_outlined,
  SensorType.unknown => Icons.sensors,
};

/// Chip del estado de calibración (`valid`, `expiring`, `expired`, `missing`).
class CalibrationChip extends StatelessWidget {
  const CalibrationChip({required this.status, super.key, this.daysLeft});

  final String status;
  final int? daysLeft;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (status) {
      'valid' => StatusChip(
        label: l10n.calibrationValid,
        kind: StatusKind.success,
        icon: Icons.verified_outlined,
      ),
      'expiring' => StatusChip(
        label: daysLeft == null
            ? l10n.calibrationExpiring
            : l10n.calibrationDaysLeft(daysLeft!),
        kind: StatusKind.warning,
        icon: Icons.schedule,
      ),
      'expired' => StatusChip(
        label: l10n.calibrationExpired,
        kind: StatusKind.error,
        icon: Icons.error_outline,
      ),
      _ => StatusChip(label: l10n.calibrationMissing, kind: StatusKind.info),
    };
  }
}

/// Chip "En rango" / "Fuera de rango" de un valor frente a los límites.
class RangeChip extends StatelessWidget {
  const RangeChip({required this.outOfRange, super.key});

  final bool outOfRange;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return outOfRange
        ? StatusChip(
            label: l10n.sensorOutOfRange,
            kind: StatusKind.error,
            icon: Icons.warning_amber_outlined,
          )
        : StatusChip(
            label: l10n.sensorInRange,
            kind: StatusKind.success,
            icon: Icons.check_circle_outline,
          );
  }
}
