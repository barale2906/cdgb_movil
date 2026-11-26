import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/files/file_picker_gateway.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_document.dart';
import 'package:sga_bojanini/features/assets/data/documents_repository.dart';

final FutureProviderFamily<List<AssetDocument>, int> assetDocumentsProvider =
    FutureProvider.autoDispose.family<List<AssetDocument>, int>(
      (ref, assetId) => ref.watch(documentsRepositoryProvider).list(assetId),
    );

/// Subir, descargar y eliminar documentos. Escrituras: botón bloqueado en
/// vuelo y nunca se reintentan; tras un timeout se consulta la lista antes de
/// repetir.
class DocumentActions extends SubmissionNotifier {
  DocumentsRepository get _repository => ref.read(documentsRepositoryProvider);

  Future<bool> upload(
    int assetId, {
    required PickedFile file,
    required String documentType,
    required String title,
    String? issuedAt,
    String? expiresAt,
  }) async {
    final saved = await runValue(
      () => _repository.upload(
        assetId,
        file: file,
        documentType: documentType,
        title: title,
        issuedAt: issuedAt,
        expiresAt: expiresAt,
      ),
    );
    _refresh(assetId);
    return saved != null;
  }

  Future<bool> delete(int assetId, int documentId) async {
    final done = await run(() => _repository.delete(documentId));
    _refresh(assetId);
    return done;
  }

  void _refresh(int assetId) {
    if (!ref.mounted) return;
    ref
      ..invalidate(assetDocumentsProvider(assetId))
      ..invalidate(assetDetailProvider(assetId));
  }
}

final NotifierProvider<DocumentActions, SubmissionState>
documentActionsProvider =
    NotifierProvider.autoDispose<DocumentActions, SubmissionState>(
      DocumentActions.new,
    );
