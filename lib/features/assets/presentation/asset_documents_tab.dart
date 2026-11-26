import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/files/file_picker_gateway.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/file_sharer.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/application/documents_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_document.dart';
import 'package:sga_bojanini/features/assets/data/documents_repository.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Documentos del activo: ver/compartir, agregar (cámara, galería o archivo)
/// y eliminar según permisos.
class AssetDocumentsTab extends ConsumerWidget {
  const AssetDocumentsTab({required this.assetId, super.key});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final documents = ref.watch(assetDocumentsProvider(assetId));
    final canUpload = ref
        .watch(permissionServiceProvider)
        .can('activos_documentos.cargar');
    return Column(
      children: [
        Expanded(
          child: documents.when(
            loading: () => const SkeletonList(),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () => ref.invalidate(assetDocumentsProvider(assetId)),
            ),
            data: (items) => RefreshIndicator(
              onRefresh: () =>
                  ref.refresh(assetDocumentsProvider(assetId).future),
              child: items.isEmpty
                  ? ListView(
                      children: [
                        EmptyState(
                          icon: Icons.folder_open_outlined,
                          message: l10n.assetDocumentsEmpty,
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: items.length,
                      itemBuilder: (_, index) => _DocumentTile(
                        assetId: assetId,
                        document: items[index],
                      ),
                    ),
            ),
          ),
        ),
        if (canUpload)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.assetDocumentAdd,
              icon: Icons.add,
              onPressed: () => unawaited(_chooseSource(context, ref)),
            ),
          ),
      ],
    );
  }

  Future<void> _chooseSource(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final picker = ref.read(filePickerProvider);
    final choice = await showModalBottomSheet<Future<PickedFile?> Function()>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.assetDocumentTakePhoto),
              onTap: () => Navigator.of(context).pop(picker.takePhoto),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.assetDocumentGallery),
              onTap: () => Navigator.of(context).pop(picker.pickPhoto),
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: Text(l10n.assetDocumentFile),
              onTap: () => Navigator.of(context).pop(picker.pickDocument),
            ),
          ],
        ),
      ),
    );
    if (choice == null || !context.mounted) return;
    final file = await choice();
    if (file == null || !context.mounted) return;
    if (file.bytes.length > maxDocumentBytes) {
      AppSnackbar.show(
        context,
        l10n.assetDocumentTooLarge,
        kind: AppSnackbarKind.warning,
      );
      return;
    }
    await context.push('/assets/$assetId/documents/new', extra: file);
  }
}

class _DocumentTile extends ConsumerWidget {
  const _DocumentTile({required this.assetId, required this.document});

  final int assetId;
  final AssetDocument document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canDelete = ref
        .watch(permissionServiceProvider)
        .can('activos_documentos.eliminar');
    // Mantiene vivo el controlador mientras dura la eliminación.
    ref.watch(documentActionsProvider);
    final expired = document.isExpiredAt(ref.read(clockProvider)());
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        leading: Icon(
          document.isImage
              ? Icons.image_outlined
              : Icons.picture_as_pdf_outlined,
        ),
        title: Text(document.title ?? document.originalName ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              [
                document.documentTypeLabel,
                if (document.size != null) _size(document.size!),
              ].nonNulls.join(' · '),
            ),
            if (document.expiresAt != null)
              Text(
                l10n.assetDocumentExpires(AppFormat.date(document.expiresAt!)),
              ),
            if (expired) ...[
              const SizedBox(height: AppSpacing.xs),
              StatusChip(
                label: l10n.assetDocumentExpired,
                kind: StatusKind.error,
                icon: Icons.event_busy,
              ),
            ],
          ],
        ),
        trailing: canDelete
            ? IconButton(
                tooltip: l10n.assetDocumentDelete,
                icon: const Icon(Icons.delete_outline),
                onPressed: () => unawaited(_delete(context, ref)),
              )
            : null,
        onTap: () => unawaited(_share(context, ref)),
      ),
    );
  }

  static String _size(int bytes) => bytes >= 1024 * 1024
      ? '${AppFormat.decimal(bytes / (1024 * 1024), maxDecimals: 1)} MB'
      : '${AppFormat.decimal(bytes / 1024, maxDecimals: 0)} KB';

  Future<void> _share(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    try {
      final bytes = await ref
          .read(documentsRepositoryProvider)
          .download(document.id);
      await ref.read(fileSharerProvider)(
        bytes,
        document.originalName ?? 'documento-${document.id}',
      );
    } on ApiException catch (error) {
      if (!context.mounted) return;
      _error(
        context,
        ApiErrorMessage.of(
          l10n,
          error,
          isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
        ),
      );
    } on Object {
      if (context.mounted) _error(context, l10n.errorGeneric);
    }
  }

  void _error(BuildContext context, String message) => AppSnackbar.show(
    context,
    message,
    kind: AppSnackbarKind.error,
    closeLabel: AppLocalizations.of(context).actionClose,
  );

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.assetDocumentDelete,
      message: l10n.assetDocumentDeleteBody,
      confirmLabel: l10n.assetDocumentDelete,
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await ref
        .read(documentActionsProvider.notifier)
        .delete(assetId, document.id);
    if (!context.mounted) return;
    if (done) {
      AppSnackbar.show(context, l10n.assetDocumentDeleted);
      return;
    }
    AppSnackbar.show(
      context,
      ApiErrorMessage.ofWrite(
        l10n,
        ref.read(documentActionsProvider).error,
        isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
        timeoutWarning: l10n.assetDocumentTimeoutWarning,
      ),
      kind: AppSnackbarKind.error,
      closeLabel: l10n.actionClose,
    );
  }
}
