import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Estado de facturación de un registro: `null` pendiente, `billed`,
/// `cancelled` (`docs/app-movil/16-flujos.md` §5).
class BillingChip extends StatelessWidget {
  const BillingChip({required this.status, super.key});

  final String? status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (status) {
      'billed' => StatusChip(
        label: l10n.billingBilled,
        kind: StatusKind.success,
        icon: Icons.check_circle_outline,
      ),
      'cancelled' => StatusChip(
        label: l10n.billingCancelled,
        kind: StatusKind.error,
        icon: Icons.block,
      ),
      _ => StatusChip(
        label: l10n.billingPending,
        kind: StatusKind.warning,
        icon: Icons.schedule,
      ),
    };
  }
}
