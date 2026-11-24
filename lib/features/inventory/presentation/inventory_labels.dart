import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Nombre visible de un `movement_type` / `document_type`.
String movementTypeLabel(AppLocalizations l10n, String type) => switch (type) {
  'entry' => l10n.movementEntry,
  'exit' => l10n.movementExit,
  'transfer' => l10n.movementTransfer,
  'adjustment' => l10n.movementAdjustment,
  'return' => l10n.movementReturn,
  'expiration_write_off' => l10n.movementWriteOff,
  'loss' => l10n.movementLoss,
  _ => type,
};

class DocumentStatusChip extends StatelessWidget {
  const DocumentStatusChip({required this.status, super.key});

  final DocumentStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (status) {
      DocumentStatus.pendingSignature => StatusChip(
        label: l10n.documentStatusPending,
        kind: StatusKind.warning,
        icon: Icons.edit_note,
      ),
      DocumentStatus.confirmed => StatusChip(
        label: l10n.documentStatusConfirmed,
        kind: StatusKind.success,
        icon: Icons.check_circle_outline,
      ),
      DocumentStatus.unknown => const SizedBox.shrink(),
    };
  }
}

/// Días para vencer a partir del cual se avisa (lotes "por vencer").
const batchExpiringSoonDays = 30;

class BatchStatusChip extends StatelessWidget {
  const BatchStatusChip({required this.batch, super.key});

  final Batch batch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final days = batch.daysUntilExpiry;
    if (batch.isExpired) {
      return StatusChip(
        label: l10n.batchStatusExpired,
        kind: StatusKind.error,
        icon: Icons.error_outline,
      );
    }
    if (batch.status == BatchStatus.depleted) {
      return StatusChip(label: l10n.batchStatusDepleted, kind: StatusKind.info);
    }
    if (days != null && days <= batchExpiringSoonDays) {
      return StatusChip(
        label: l10n.batchExpiresInDays(days),
        kind: StatusKind.warning,
        icon: Icons.schedule,
      );
    }
    return StatusChip(label: l10n.batchStatusActive, kind: StatusKind.success);
  }
}
