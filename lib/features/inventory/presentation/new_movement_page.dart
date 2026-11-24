import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/features/inventory/application/movement_permissions.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Elige el tipo de movimiento a registrar (solo los que el usuario puede).
class NewMovementPage extends ConsumerWidget {
  const NewMovementPage({super.key});

  static const path = '/inventory/new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final permissions = ref.watch(permissionServiceProvider);
    final kinds = MovementKind.values.where(
      (k) => permissions.can(k.permission),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.newMovementTitle)),
      body: SafeArea(
        child: kinds.isEmpty
            ? EmptyState(
                icon: Icons.lock_outline,
                message: l10n.newMovementNone,
              )
            : ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  Text(
                    l10n.newMovementChoose,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final kind in kinds)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Card(
                        child: ListTile(
                          minTileHeight: AppSizes.minTouchTarget,
                          leading: Icon(kind.icon),
                          title: Text(_title(l10n, kind)),
                          subtitle: Text(_hint(l10n, kind)),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push(kind.path),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  static String _title(AppLocalizations l10n, MovementKind kind) =>
      switch (kind) {
        MovementKind.entry => l10n.movementEntry,
        MovementKind.exit => l10n.movementExit,
        MovementKind.transfer => l10n.movementTransfer,
        MovementKind.adjustment => l10n.movementAdjustment,
        MovementKind.returnStock => l10n.movementReturn,
        MovementKind.writeOff => l10n.movementWriteOff,
        MovementKind.loss => l10n.movementLoss,
      };

  static String _hint(AppLocalizations l10n, MovementKind kind) =>
      switch (kind) {
        MovementKind.entry => l10n.movementEntryHint,
        MovementKind.exit => l10n.movementExitHint,
        MovementKind.transfer => l10n.movementTransferHint,
        MovementKind.adjustment => l10n.movementAdjustmentHint,
        MovementKind.returnStock => l10n.movementReturnHint,
        MovementKind.writeOff => l10n.movementWriteOffHint,
        MovementKind.loss => l10n.movementLossHint,
      };
}
