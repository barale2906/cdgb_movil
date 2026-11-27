import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show FutureProviderFamily, NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_draft.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/data/asset_events.dart';
import 'package:sga_bojanini/features/assets/data/assets_repository.dart';

class AssetListNotifier extends PagedNotifier<Asset> {
  AssetListNotifier(this.query);

  final AssetQuery query;

  @override
  Future<PagedList<Asset>> fetchPage(int page) =>
      ref.read(assetsRepositoryProvider).list(query, page: page);
}

final NotifierProviderFamily<AssetListNotifier, PagedState<Asset>, AssetQuery>
assetListProvider = NotifierProvider.autoDispose
    .family<AssetListNotifier, PagedState<Asset>, AssetQuery>(
      AssetListNotifier.new,
    );

final FutureProviderFamily<Asset, int> assetDetailProvider = FutureProvider
    .autoDispose
    .family<Asset, int>(
      (ref, id) => ref.watch(assetsRepositoryProvider).get(id),
    );

final FutureProvider<AssetFilters> assetFiltersProvider =
    FutureProvider.autoDispose<AssetFilters>(
      (ref) => ref.watch(assetsRepositoryProvider).filters(),
    );

final FutureProvider<AssetStatistics> assetStatisticsProvider =
    FutureProvider.autoDispose<AssetStatistics>(
      (ref) => ref.watch(assetsRepositoryProvider).statistics(),
    );

class AssetMovementsNotifier extends PagedNotifier<AssetMovement> {
  AssetMovementsNotifier(this.assetId);

  final int assetId;

  @override
  Future<PagedList<AssetMovement>> fetchPage(int page) =>
      ref.read(assetsRepositoryProvider).movements(assetId, page: page);
}

final NotifierProviderFamily<
  AssetMovementsNotifier,
  PagedState<AssetMovement>,
  int
>
assetMovementsProvider = NotifierProvider.autoDispose
    .family<AssetMovementsNotifier, PagedState<AssetMovement>, int>(
      AssetMovementsNotifier.new,
    );

final FutureProviderFamily<List<LocationRecord>, int> locationHistoryProvider =
    FutureProvider.autoDispose.family<List<LocationRecord>, int>(
      (ref, id) => ref.watch(assetsRepositoryProvider).locationHistory(id),
    );

final FutureProviderFamily<List<AssetComment>, int> assetCommentsProvider =
    FutureProvider.autoDispose.family<List<AssetComment>, int>(
      (ref, id) => ref.watch(assetsRepositoryProvider).comments(id),
    );

final FutureProviderFamily<Uint8List, int> lifeSheetProvider = FutureProvider
    .autoDispose
    .family<Uint8List, int>(
      (ref, id) => ref.watch(assetsRepositoryProvider).lifeSheet(id),
    );

/// Agrega un comentario y refresca el listado. Escritura: no se reintenta.
class AddCommentController extends SubmissionNotifier {
  Future<bool> add(int assetId, String comment) async {
    final saved = await runValue(
      () => ref.read(assetsRepositoryProvider).addComment(assetId, comment),
    );
    if (saved != null) {
      ref
        ..invalidate(assetCommentsProvider(assetId))
        ..invalidate(assetDetailProvider(assetId));
    }
    return saved != null;
  }
}

final NotifierProvider<AddCommentController, SubmissionState>
addCommentControllerProvider =
    NotifierProvider.autoDispose<AddCommentController, SubmissionState>(
      AddCommentController.new,
    );

/// Cambia el estado del activo y refresca lo que lo muestra. Escritura:
/// botón bloqueado en vuelo y sin reintentos; tras un timeout se consulta la
/// ficha antes de repetir.
class ChangeStatusController extends SubmissionNotifier {
  Future<bool> change(int assetId, AssetStatus status, {String? reason}) async {
    final asset = await runValue(
      () => ref
          .read(assetsRepositoryProvider)
          .changeStatus(assetId, status, reason: reason),
    );
    if (ref.mounted) {
      ref
        ..invalidate(assetDetailProvider(assetId))
        ..invalidate(assetListProvider)
        ..invalidate(assetStatisticsProvider)
        ..invalidate(assetMovementsProvider(assetId));
    }
    return asset != null;
  }
}

final NotifierProvider<ChangeStatusController, SubmissionState>
changeStatusControllerProvider =
    NotifierProvider.autoDispose<ChangeStatusController, SubmissionState>(
      ChangeStatusController.new,
    );

/// Crear, editar y eliminar un activo, y guardar su hoja de vida técnica.
/// Escrituras: botón bloqueado en vuelo y sin reintentos; tras un timeout se
/// consulta la lista antes de repetir (un reintento podría duplicar el
/// activo).
class AssetFormController extends SubmissionNotifier {
  AssetsRepository get _repository => ref.read(assetsRepositoryProvider);

  /// Devuelve el activo creado o `null` si falló.
  Future<Asset?> create(AssetDraft draft) async {
    final asset = await runValue(() => _repository.create(draft));
    if (asset != null) _refreshLists();
    return asset;
  }

  Future<bool> update(int id, AssetDraft draft) async {
    final asset = await runValue(() => _repository.update(id, draft));
    if (asset != null) _refresh(id);
    return asset != null;
  }

  Future<bool> delete(int id) async {
    final done = await run(() => _repository.delete(id));
    if (done) _refreshLists();
    return done;
  }

  Future<bool> saveTechnicalProfile(
    int id,
    Map<String, Object?> profile,
  ) async {
    final done = await run(
      () => _repository.updateTechnicalProfile(id, profile),
    );
    if (done) _refresh(id);
    return done;
  }

  void _refresh(int id) {
    if (!ref.mounted) return;
    ref
      ..invalidate(assetDetailProvider(id))
      ..invalidate(assetMovementsProvider(id));
    _refreshLists();
  }

  void _refreshLists() {
    if (!ref.mounted) return;
    ref
      ..invalidate(assetListProvider)
      ..invalidate(assetStatisticsProvider);
  }
}

final NotifierProvider<AssetFormController, SubmissionState>
assetFormControllerProvider =
    NotifierProvider.autoDispose<AssetFormController, SubmissionState>(
      AssetFormController.new,
    );
