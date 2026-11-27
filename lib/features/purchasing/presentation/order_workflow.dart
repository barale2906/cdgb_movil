import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/text_prompt_dialog.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/purchasing/application/order_actions.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Muestra el resultado de una acción: confirmación o el error del servidor
/// (un timeout pide revisar la orden antes de repetir, no hay idempotencia).
/// Con [message] se muestra solo ese aviso (validación previa al envío).
void showOrderResult(
  BuildContext context,
  WidgetRef ref, {
  required bool done,
  required String successMessage,
  required ApiException? error,
  String? message,
}) {
  if (!context.mounted) return;
  final l10n = AppLocalizations.of(context);
  if (message != null) {
    AppSnackbar.show(
      context,
      message,
      kind: AppSnackbarKind.warning,
      closeLabel: l10n.actionClose,
    );
    return;
  }
  if (done) {
    AppSnackbar.show(context, successMessage);
    return;
  }
  showWriteError(
    context,
    ref,
    error: error,
    timeoutWarning: l10n.orderTimeoutWarning,
  );
}

/// Pide comentarios opcionales (aprobar / rechazar). `null` = canceló.
Future<String?> askComments(
  BuildContext context, {
  required String title,
  required String confirmLabel,
  bool destructive = false,
}) => promptText(
  context,
  title: title,
  confirmLabel: confirmLabel,
  fieldLabel: AppLocalizations.of(context).fieldCommentsOptional,
  destructive: destructive,
);

/// Botones del flujo de una orden según su estado y los permisos del
/// usuario. [permissionPrefix] es `ordenes_compra` o `ordenes_gasto`: ambos
/// comparten los sufijos `crear`, `aprobar`, `enviar` y `recibir`.
///
/// Una sola acción principal por pantalla (guía de diseño): la que toca el
/// siguiente paso del flujo; el resto son secundarias.
class OrderWorkflowButtons extends ConsumerWidget {
  const OrderWorkflowButtons({
    required this.orderId,
    required this.status,
    required this.permissionPrefix,
    required this.actions,
    required this.onReceive,
    required this.onEdit,
    super.key,
  });

  final int orderId;
  final OrderStatus status;
  final String permissionPrefix;
  final NotifierProvider<OrderActions, SubmissionState> actions;

  /// Abre la pantalla de recepción de la orden.
  final VoidCallback onReceive;

  /// Abre el formulario del borrador para modificarlo.
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final permissions = ref.watch(permissionServiceProvider);
    bool can(String action) => permissions.can('$permissionPrefix.$action');
    final busy = ref.watch(actions).isSubmitting;

    Future<void> run(
      Future<bool> Function(OrderActions notifier) call,
      String successMessage,
    ) async {
      final done = await call(ref.read(actions.notifier));
      if (!context.mounted) return;
      showOrderResult(
        context,
        ref,
        done: done,
        successMessage: successMessage,
        error: ref.read(actions).error,
      );
    }

    Future<void> approveOrReject({required bool approve}) async {
      final comments = await askComments(
        context,
        title: approve ? l10n.orderApproveTitle : l10n.orderRejectTitle,
        confirmLabel: approve ? l10n.orderApprove : l10n.orderReject,
        destructive: !approve,
      );
      if (comments == null || !context.mounted) return;
      await run(
        (n) => approve
            ? n.approve(orderId, comments: comments)
            : n.reject(orderId, comments: comments),
        approve ? l10n.orderApproved : l10n.orderRejected,
      );
    }

    Future<void> cancel() async {
      final confirmed = await ConfirmDialog.show(
        context,
        title: l10n.orderCancelTitle,
        message: l10n.orderCancelBody,
        confirmLabel: l10n.orderCancel,
        destructive: true,
      );
      if (!confirmed || !context.mounted) return;
      await run((n) => n.cancel(orderId), l10n.orderCancelled);
    }

    Future<void> deleteDraft() async {
      final confirmed = await ConfirmDialog.show(
        context,
        title: l10n.orderDraftDelete,
        message: l10n.orderDraftDeleteBody,
        confirmLabel: l10n.orderDraftDelete,
        destructive: true,
      );
      if (!confirmed || !context.mounted) return;
      final done = await ref.read(actions.notifier).delete(orderId);
      if (!context.mounted) return;
      showOrderResult(
        context,
        ref,
        done: done,
        successMessage: l10n.orderDraftDeleted,
        error: ref.read(actions).error,
      );
      if (done && context.mounted) context.pop();
    }

    final buttons = <Widget>[
      if (status == OrderStatus.draft && can('crear'))
        BojaniButton(
          label: l10n.orderSubmit,
          icon: Icons.outbox_outlined,
          isLoading: busy,
          onPressed: () =>
              unawaited(run((n) => n.submit(orderId), l10n.orderSubmitted)),
        ),
      if (status == OrderStatus.draft && can('crear')) ...[
        BojaniButton(
          label: l10n.orderDraftEdit,
          icon: Icons.edit_outlined,
          kind: BojaniButtonKind.secondary,
          onPressed: busy ? null : onEdit,
        ),
        BojaniButton(
          label: l10n.orderDraftDelete,
          icon: Icons.delete_outline,
          kind: BojaniButtonKind.destructive,
          onPressed: busy ? null : () => unawaited(deleteDraft()),
        ),
      ],
      if (status == OrderStatus.pendingApproval && can('aprobar')) ...[
        BojaniButton(
          label: l10n.orderApprove,
          icon: Icons.check,
          isLoading: busy,
          onPressed: () => unawaited(approveOrReject(approve: true)),
        ),
        BojaniButton(
          label: l10n.orderReject,
          icon: Icons.close,
          kind: BojaniButtonKind.secondary,
          onPressed: busy
              ? null
              : () => unawaited(approveOrReject(approve: false)),
        ),
      ],
      if (status == OrderStatus.approved && can('enviar'))
        BojaniButton(
          label: l10n.orderSend,
          icon: Icons.send_outlined,
          isLoading: busy,
          onPressed: () =>
              unawaited(run((n) => n.send(orderId), l10n.orderSentMessage)),
        ),
      if (status.canReceive && can('recibir'))
        BojaniButton(
          label: l10n.orderReceive,
          icon: Icons.move_to_inbox_outlined,
          onPressed: busy ? null : onReceive,
        ),
      if (status.canCancel && can('crear'))
        BojaniButton(
          label: l10n.orderCancel,
          icon: Icons.delete_outline,
          kind: BojaniButtonKind.tertiary,
          onPressed: busy ? null : () => unawaited(cancel()),
        ),
    ];
    if (buttons.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (final button in buttons) ...[
          button,
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}
