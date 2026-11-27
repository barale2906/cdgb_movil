import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/clinical/procedure_record.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/clinical/application/record_actions.dart';
import 'package:sga_bojanini/features/clinical/presentation/clinical_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Eliminar el registro (irreversible), con confirmación. Solo con
/// `registros_procedimientos.eliminar`; si pertenece a una orden, el aviso lo
/// dice.
class DeleteRecordButton extends ConsumerWidget {
  const DeleteRecordButton({required this.record, super.key});

  final ProcedureRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowed = ref.watch(
      permissionServiceProvider.select(
        (p) => p.can('registros_procedimientos.eliminar'),
      ),
    );
    if (!allowed) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final busy = ref.watch(recordActionsProvider).isSubmitting;
    return BojaniButton(
      label: l10n.clinicalRecordDelete,
      icon: Icons.delete_outline,
      kind: BojaniButtonKind.destructive,
      isLoading: busy,
      onPressed: () => unawaited(_delete(context, ref)),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final order = record.orderNumber;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.clinicalRecordDelete,
      message: [
        l10n.clinicalRecordDeleteConfirm(
          record.title(l10n),
          record.patientName,
        ),
        if (order != null) l10n.clinicalRecordDeleteOrder(order),
      ].join(' '),
      confirmLabel: l10n.clinicalRecordDelete,
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await ref
        .read(recordActionsProvider.notifier)
        .delete(record.id);
    if (!context.mounted) return;
    if (done) {
      AppSnackbar.show(context, l10n.clinicalRecordDeleted);
      context.pop();
      return;
    }
    showWriteError(
      context,
      ref,
      error: ref.read(recordActionsProvider).error,
      timeoutWarning: l10n.clinicalRecordDeleteTimeout,
    );
  }
}
