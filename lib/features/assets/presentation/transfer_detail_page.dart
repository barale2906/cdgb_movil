import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/text_prompt_dialog.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/assets/application/transfers_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_transfer.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Traslado: datos, firmas y acciones (confirmar con firmas, cancelar, acta).
class TransferDetailPage extends ConsumerWidget {
  const TransferDetailPage({required this.transferId, super.key});

  final int transferId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final transfer = ref.watch(transferDetailProvider(transferId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.transferDetailTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: transfer.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(transferDetailProvider(transferId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () => ref.refresh(
                    transferDetailProvider(transferId).future,
                  ),
                  child: _Content(transfer: data),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.transfer});

  final AssetTransfer transfer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final canConfirm = ref
        .watch(permissionServiceProvider)
        .can('activos_traslados.confirmar');
    final busy = ref.watch(transferActionsProvider).isSubmitting;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                transferTypeText(l10n, transfer),
                style: textTheme.titleMedium,
              ),
            ),
            TransferStatusChip(status: transfer.status),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (transfer.asset != null)
          Card(
            child: ListTile(
              title: Text(transfer.asset!.name ?? l10n.notAvailable),
              subtitle: Text(transfer.asset!.code ?? ''),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/assets/${transfer.asset!.id}'),
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        InfoRow(label: l10n.transferFrom, value: transfer.from),
        InfoRow(label: l10n.transferTo, value: transfer.to),
        InfoRow(
          label: l10n.transferExternalDestination,
          value: transfer.externalDestination,
        ),
        InfoRow(label: l10n.assetSupplier, value: transfer.supplier?.name),
        InfoRow(
          label: l10n.transferFromResponsible,
          value: transfer.fromResponsible?.name,
        ),
        InfoRow(
          label: l10n.transferToResponsible,
          value: transfer.toResponsible?.name,
        ),
        InfoRow(
          label: l10n.transferExpectedReturn,
          value: transfer.expectedReturnDate == null
              ? null
              : AppFormat.date(transfer.expectedReturnDate!),
        ),
        InfoRow(label: l10n.transferReason, value: transfer.reason),
        InfoRow(
          label: l10n.transferRequestedBy,
          value: transfer.requestedBy?.name,
        ),
        InfoRow(
          label: l10n.orderCreatedAt,
          value: transfer.createdAt == null
              ? null
              : AppFormat.dateTime(transfer.createdAt),
        ),
        InfoRow(
          label: l10n.transferConfirmedAt,
          value: transfer.confirmedAt == null
              ? null
              : AppFormat.dateTime(transfer.confirmedAt),
        ),
        InfoRow(label: l10n.transferCancelReason, value: transfer.cancelReason),
        if (transfer.signatures.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.documentSignatures, style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final signature in transfer.signatures)
            Card(
              child: ListTile(
                title: Text(
                  '${_roleLabel(l10n, signature.role)}: '
                  '${signature.signerName ?? l10n.notAvailable}',
                ),
                subtitle: Text(
                  [
                    if (signature.signerDocument != null)
                      signature.signerDocument!,
                    if (signature.signedAt != null)
                      AppFormat.dateTime(signature.signedAt),
                  ].join(' · '),
                ),
              ),
            ),
        ],
        const SizedBox(height: AppSpacing.lg),
        if (transfer.isPending && canConfirm) ...[
          BojaniButton(
            label: l10n.confirmAction,
            icon: Icons.draw_outlined,
            onPressed: busy
                ? null
                : () =>
                      context.push('/assets/transfers/${transfer.id}/confirm'),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        BojaniButton(
          label: l10n.transferAct,
          icon: Icons.picture_as_pdf_outlined,
          kind: BojaniButtonKind.secondary,
          onPressed: () => context.push('/assets/transfers/${transfer.id}/act'),
        ),
        if (transfer.isPending && canConfirm) ...[
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.transferCancel,
            icon: Icons.delete_outline,
            kind: BojaniButtonKind.tertiary,
            isLoading: busy,
            onPressed: () => unawaited(_cancel(context, ref)),
          ),
        ],
      ],
    );
  }

  static String _roleLabel(AppLocalizations l10n, String role) =>
      role == 'delivered_by' ? l10n.signatureDelivered : l10n.signatureReceived;

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final reason = await promptText(
      context,
      title: l10n.transferCancelTitle,
      confirmLabel: l10n.transferCancel,
      fieldLabel: l10n.transferCancelReason,
      destructive: true,
      required: true,
    );
    if (reason == null || !context.mounted) return;
    final done = await ref
        .read(transferActionsProvider.notifier)
        .cancel(transfer.id, reason);
    if (!context.mounted) return;
    if (done) {
      AppSnackbar.show(context, l10n.transferCancelled);
      return;
    }
    showWriteError(
      context,
      ref,
      error: ref.read(transferActionsProvider).error,
      timeoutWarning: l10n.transferTimeoutWarning,
    );
  }
}
