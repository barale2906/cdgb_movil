import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/permission_gate.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Perfil del usuario: datos, roles, almacenes y acciones de sesión.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final textTheme = Theme.of(context).textTheme;
    if (user == null) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(user.name, style: textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(user.email, style: textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.profileRoles, style: textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final role in user.roles)
                  StatusChip(label: role.name, kind: StatusKind.info),
              ],
            ),
            const PermissionGate(
              permission: 'almacenes.ver',
              child: _AssignedWarehouses(),
            ),
            const SizedBox(height: AppSpacing.lg),
            BojaniButton(
              label: l10n.profileChangePassword,
              kind: BojaniButtonKind.secondary,
              icon: Icons.key_outlined,
              onPressed: () => context.push(Routes.changePassword),
            ),
            const SizedBox(height: AppSpacing.sm),
            BojaniButton(
              label: l10n.aboutTitle,
              kind: BojaniButtonKind.secondary,
              icon: Icons.info_outline,
              onPressed: () => context.push(Routes.about),
            ),
            const SizedBox(height: AppSpacing.lg),
            BojaniButton(
              label: l10n.switchUser,
              kind: BojaniButtonKind.secondary,
              icon: Icons.swap_horiz,
              onPressed: () => _endSession(
                context,
                ref,
                title: l10n.switchUserConfirmTitle,
                message: l10n.switchUserConfirmBody,
                confirmLabel: l10n.switchUser,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            BojaniButton(
              label: l10n.logout,
              kind: BojaniButtonKind.destructive,
              icon: Icons.logout,
              onPressed: () => _endSession(
                context,
                ref,
                title: l10n.logoutConfirmTitle,
                message: l10n.logoutConfirmBody,
                confirmLabel: l10n.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _endSession(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String message,
    required String confirmLabel,
  }) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      destructive: true,
    );
    if (confirmed) await ref.read(sessionControllerProvider.notifier).logout();
  }
}

class _AssignedWarehouses extends ConsumerWidget {
  const _AssignedWarehouses();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final warehouses = ref.watch(warehousesProvider).value ?? const [];
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.profileWarehouses, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        if (warehouses.isEmpty)
          Text(l10n.profileNoWarehouses, style: textTheme.bodyMedium)
        else
          for (final warehouse in warehouses)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(warehouse.name, style: textTheme.bodyMedium),
            ),
      ],
    );
  }
}
