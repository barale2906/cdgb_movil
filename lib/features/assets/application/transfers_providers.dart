import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show FutureProviderFamily, NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/core/signing/signoff.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_transfer.dart';
import 'package:sga_bojanini/features/assets/data/transfers_repository.dart';

class TransferListNotifier extends PagedNotifier<AssetTransfer> {
  TransferListNotifier(this.status);

  final TransferStatus? status;

  @override
  Future<PagedList<AssetTransfer>> fetchPage(int page) =>
      ref.read(transfersRepositoryProvider).list(status: status, page: page);
}

final NotifierProviderFamily<
  TransferListNotifier,
  PagedState<AssetTransfer>,
  TransferStatus?
>
transferListProvider = NotifierProvider.autoDispose
    .family<TransferListNotifier, PagedState<AssetTransfer>, TransferStatus?>(
      TransferListNotifier.new,
    );

final FutureProviderFamily<AssetTransfer, int> transferDetailProvider =
    FutureProvider.autoDispose.family<AssetTransfer, int>(
      (ref, id) => ref.watch(transfersRepositoryProvider).get(id),
    );

final FutureProviderFamily<Uint8List, int> transferActProvider = FutureProvider
    .autoDispose
    .family<Uint8List, int>(
      (ref, id) => ref.watch(transfersRepositoryProvider).act(id),
    );

/// Acciones sobre traslados. Escrituras: botón bloqueado en vuelo y nunca se
/// reintentan; tras un timeout se vuelve a consultar antes de repetir.
class TransferActions extends SubmissionNotifier {
  TransfersRepository get _repository => ref.read(transfersRepositoryProvider);

  /// Solicita el traslado; devuelve el traslado creado o `null` si falló.
  Future<AssetTransfer?> request(int assetId, TransferRequest request) async {
    final transfer = await runValue(
      () => _repository.request(assetId, request),
    );
    _refreshAsset(assetId);
    return transfer;
  }

  Future<bool> confirm(int id, ConfirmRequest request) async {
    final transfer = await runValue(() => _repository.confirm(id, request));
    _refreshTransfer(id, assetId: transfer?.asset?.id);
    return transfer != null;
  }

  Future<bool> cancel(int id, String reason) async {
    final transfer = await runValue(() => _repository.cancel(id, reason));
    _refreshTransfer(id, assetId: transfer?.asset?.id);
    return transfer != null;
  }

  void _refreshTransfer(int id, {int? assetId}) {
    ref
      ..invalidate(transferDetailProvider(id))
      ..invalidate(transferListProvider);
    if (assetId != null) _refreshAsset(assetId);
  }

  void _refreshAsset(int assetId) {
    ref
      ..invalidate(assetDetailProvider(assetId))
      ..invalidate(assetListProvider)
      ..invalidate(assetStatisticsProvider)
      ..invalidate(locationHistoryProvider(assetId))
      ..invalidate(assetMovementsProvider(assetId))
      ..invalidate(transferListProvider);
  }
}

final NotifierProvider<TransferActions, SubmissionState>
transferActionsProvider =
    NotifierProvider.autoDispose<TransferActions, SubmissionState>(
      TransferActions.new,
    );
