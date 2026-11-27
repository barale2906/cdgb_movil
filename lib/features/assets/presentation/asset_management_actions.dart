import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Acciones de escritura de la ficha: editar datos y hoja de vida técnica,
/// programar mantenimientos y eliminar un activo registrado por error. Cada
/// una exige su propio permiso.
class AssetManagementActions extends ConsumerWidget {
  const AssetManagementActions({required this.asset, super.key});

  final Asset asset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final permissions = ref.watch(permissionServiceProvider);
    final busy = ref.watch(assetFormControllerProvider).isSubmitting;
    final canEdit = permissions.can('activos.editar') && !asset.isRetired;
    final canSchedule =
        permissions.can('activos_mantenimientos.programar') &&
        asset.requiresMaintenance &&
        !asset.isRetired;
    final canDelete = permissions.can('activos.eliminar');

    Widget action(
      String label,
      IconData icon,
      VoidCallback? onPressed, {
      BojaniButtonKind kind = BojaniButtonKind.secondary,
    }) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: BojaniButton(
        label: label,
        icon: icon,
        kind: kind,
        onPressed: busy ? null : onPressed,
      ),
    );

    return Column(
      children: [
        if (canEdit)
          action(
            l10n.assetEditAction,
            Icons.edit_outlined,
            () => unawaited(context.push('/assets/${asset.id}/edit')),
          ),
        if (canEdit && asset.supportsTechnicalProfile)
          action(
            l10n.techProfileEdit,
            Icons.fact_check_outlined,
            () => unawaited(
              context.push('/assets/${asset.id}/technical-profile'),
            ),
          ),
        if (canSchedule)
          action(
            l10n.maintenanceScheduleAction,
            Icons.event_available_outlined,
            () =>
                unawaited(context.push('/assets/${asset.id}/maintenance/new')),
          ),
        if (canDelete)
          action(
            l10n.assetDelete,
            Icons.delete_outline,
            () => unawaited(_delete(context, ref)),
            kind: BojaniButtonKind.tertiary,
          ),
      ],
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.assetDelete,
      message: l10n.assetDeleteBody(asset.name),
      confirmLabel: l10n.assetDelete,
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await ref
        .read(assetFormControllerProvider.notifier)
        .delete(asset.id);
    if (!context.mounted) return;
    if (!done) {
      showWriteError(
        context,
        ref,
        error: ref.read(assetFormControllerProvider).error,
        timeoutWarning: l10n.assetDeleteTimeoutWarning,
      );
      return;
    }
    AppSnackbar.show(context, l10n.assetDeleted);
    context.pop();
  }
}
