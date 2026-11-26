import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/data/asset_transfer.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

String transferStatusLabel(AppLocalizations l10n, TransferStatus status) =>
    switch (status) {
      TransferStatus.pendingSignature => l10n.transferStatusPending,
      TransferStatus.confirmed => l10n.transferStatusConfirmed,
      TransferStatus.cancelled => l10n.transferStatusCancelled,
      TransferStatus.unknown => l10n.statusUnknown,
    };

StatusKind transferStatusKind(TransferStatus status) => switch (status) {
  TransferStatus.confirmed => StatusKind.success,
  TransferStatus.pendingSignature => StatusKind.warning,
  TransferStatus.cancelled => StatusKind.error,
  TransferStatus.unknown => StatusKind.special,
};

IconData transferStatusIcon(TransferStatus status) => switch (status) {
  TransferStatus.confirmed => Icons.check_circle_outline,
  TransferStatus.pendingSignature => Icons.draw_outlined,
  TransferStatus.cancelled => Icons.block,
  TransferStatus.unknown => Icons.help_outline,
};

String transferTypeLabel(AppLocalizations l10n, TransferType type) =>
    switch (type) {
      TransferType.relocation => l10n.transferTypeRelocation,
      TransferType.externalRepair => l10n.transferTypeExternalRepair,
      TransferType.loan => l10n.transferTypeLoan,
      TransferType.returnToSite => l10n.transferTypeReturn,
      TransferType.retirement => l10n.transferTypeRetirement,
    };

/// Tipo del traslado; los tipos que la app no solicita (p. ej. entre sedes)
/// se muestran con el texto del servidor.
String transferTypeText(AppLocalizations l10n, AssetTransfer transfer) {
  for (final type in TransferType.values) {
    if (type.value == transfer.type) return transferTypeLabel(l10n, type);
  }
  return transfer.typeLabel ?? transfer.type ?? l10n.statusUnknown;
}

class TransferStatusChip extends StatelessWidget {
  const TransferStatusChip({required this.status, super.key});

  final TransferStatus status;

  @override
  Widget build(BuildContext context) => StatusChip(
    label: transferStatusLabel(AppLocalizations.of(context), status),
    kind: transferStatusKind(status),
    icon: transferStatusIcon(status),
  );
}
