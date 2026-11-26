import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/consumptions/data/consumption_record.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Estado de la sincronización con la historia clínica (nunca solo color).
class SyncChip extends StatelessWidget {
  const SyncChip({required this.status, super.key});

  final SyncStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (status) {
      SyncStatus.pending => StatusChip(
        label: l10n.syncPending,
        kind: StatusKind.warning,
        icon: Icons.schedule,
      ),
      SyncStatus.synced => StatusChip(
        label: l10n.syncSynced,
        kind: StatusKind.success,
        icon: Icons.check_circle_outline,
      ),
      SyncStatus.failed => StatusChip(
        label: l10n.syncFailed,
        kind: StatusKind.error,
        icon: Icons.error_outline,
      ),
      SyncStatus.unknown => const SizedBox.shrink(),
    };
  }
}

/// Nombre del insumo; el backend puede no enviarlo.
String consumptionTitle(ConsumptionRecord record, AppLocalizations l10n) =>
    record.productName ?? l10n.consumptionProductUnknown;
