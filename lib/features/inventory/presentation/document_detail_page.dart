import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/inventory/application/document_actions.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/presentation/email_dialog.dart';
import 'package:sga_bojanini/features/inventory/presentation/history_tab.dart';
import 'package:sga_bojanini/features/inventory/presentation/inventory_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Comprobante: datos, líneas, firmas y acciones (confirmar, cancelar,
/// PDF, correo). El stock cambia solo al confirmar.
class DocumentDetailPage extends ConsumerWidget {
  const DocumentDetailPage({required this.documentId, super.key});

  final int documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final document = ref.watch(documentDetailProvider(documentId));
    return Scaffold(
      appBar: AppBar(
        title: Text(document.value?.documentNumber ?? l10n.documentDetailTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: document.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(documentDetailProvider(documentId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(documentDetailProvider(documentId).future),
                  child: _Content(document: data),
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
  const _Content({required this.document});

  final MovementDocument document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final permissions = ref.watch(permissionServiceProvider);
    // Mantiene vivo el controlador de cancelación mientras dure la petición.
    ref.watch(cancelDocumentControllerProvider);
    final date = document.movementDate ?? document.createdAt;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                movementTypeLabel(l10n, document.documentType),
                style: textTheme.titleMedium,
              ),
            ),
            DocumentStatusChip(status: document.status),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        InfoRow(label: l10n.documentWarehouse, value: document.warehouseName),
        InfoRow(
          label: l10n.documentDestination,
          value: document.warehouseToName,
        ),
        InfoRow(
          label: l10n.documentCostCenter,
          value: document.costCenter?.name,
        ),
        InfoRow(
          label: l10n.documentDate,
          value: date == null ? null : AppFormat.date(date),
        ),
        InfoRow(label: l10n.documentCreatedBy, value: document.userName),
        InfoRow(label: l10n.documentReason, value: document.reason),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.documentLines, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        for (final line in document.movements)
          Card(child: MovementLineTile(line: line, card: false)),
        if (document.signatures.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(l10n.documentSignatures, style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final signature in document.signatures)
            _SignatureTile(documentId: document.id, signature: signature),
        ],
        const SizedBox(height: AppSpacing.lg),
        if (document.isPending && permissions.can('movimientos.confirmar')) ...[
          BojaniButton(
            label: l10n.confirmAction,
            icon: Icons.draw_outlined,
            onPressed: () =>
                context.push('/inventory/documents/${document.id}/confirm'),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        BojaniButton(
          label: l10n.pdfView,
          icon: Icons.picture_as_pdf_outlined,
          kind: document.isPending && permissions.can('movimientos.confirmar')
              ? BojaniButtonKind.secondary
              : BojaniButtonKind.primary,
          onPressed: () =>
              context.push('/inventory/documents/${document.id}/pdf'),
        ),
        if (permissions.can('movimientos.enviar_correo')) ...[
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.sendEmailAction,
            icon: Icons.mail_outline,
            kind: BojaniButtonKind.secondary,
            onPressed: () => unawaited(showEmailDialog(context, document.id)),
          ),
        ],
        if (document.isPending && permissions.can('movimientos.cancelar')) ...[
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.cancelPendingAction,
            icon: Icons.delete_outline,
            kind: BojaniButtonKind.tertiary,
            onPressed: () => unawaited(_cancel(context, ref)),
          ),
        ],
      ],
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.cancelPendingTitle,
      message: l10n.cancelPendingBody,
      confirmLabel: l10n.cancelPendingAction,
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await ref
        .read(cancelDocumentControllerProvider.notifier)
        .cancel(document.id);
    if (!context.mounted) return;
    if (done) {
      AppSnackbar.show(context, l10n.cancelledMessage);
      context.pop();
      return;
    }
    final error = ref.read(cancelDocumentControllerProvider).error;
    AppSnackbar.show(
      context,
      (error?.message ?? '').isEmpty ? l10n.errorGeneric : error!.message,
      kind: AppSnackbarKind.error,
      closeLabel: l10n.actionClose,
    );
  }
}

class _SignatureTile extends ConsumerWidget {
  const _SignatureTile({required this.documentId, required this.signature});

  final int documentId;
  final DocumentSignature signature;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final role = signature.role == 'delivered_by'
        ? l10n.signatureDelivered
        : l10n.signatureReceived;
    return Card(
      child: ListTile(
        title: Text('$role: ${signature.signerName ?? l10n.notAvailable}'),
        subtitle: signature.signerDocument == null
            ? null
            : Text(signature.signerDocument!),
        trailing: TextButton(
          onPressed: () => unawaited(_view(context, ref)),
          child: Text(l10n.viewSignature),
        ),
      ),
    );
  }

  Future<void> _view(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final image = await ref.read(
      signatureImageProvider((
        documentId: documentId,
        role: signature.role,
      )).future,
    );
    if (!context.mounted || image == null) return;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: Image.memory(
          base64Decode(image.split(',').last),
          semanticLabel: l10n.viewSignature,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.actionClose),
          ),
        ],
      ),
    );
  }
}
