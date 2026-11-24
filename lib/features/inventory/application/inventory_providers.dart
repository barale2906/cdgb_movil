import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show FutureProviderFamily, NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_repository.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/stock_item.dart';

class StockListNotifier extends PagedNotifier<StockItem> {
  StockListNotifier(this.warehouseId);

  final int warehouseId;

  @override
  Future<PagedList<StockItem>> fetchPage(int page) => ref
      .read(inventoryRepositoryProvider)
      .stock(warehouseId: warehouseId, page: page);
}

final NotifierProviderFamily<StockListNotifier, PagedState<StockItem>, int>
stockListProvider = NotifierProvider.autoDispose
    .family<StockListNotifier, PagedState<StockItem>, int>(
      StockListNotifier.new,
    );

final FutureProviderFamily<List<StockItem>, int> lowStockProvider =
    FutureProvider.autoDispose.family<List<StockItem>, int>(
      (ref, warehouseId) => ref
          .watch(inventoryRepositoryProvider)
          .lowStock(warehouseId: warehouseId),
    );

class BatchListNotifier extends PagedNotifier<Batch> {
  BatchListNotifier(this.query);

  final BatchQuery query;

  @override
  Future<PagedList<Batch>> fetchPage(int page) =>
      ref.read(inventoryRepositoryProvider).batches(query, page: page);
}

final NotifierProviderFamily<BatchListNotifier, PagedState<Batch>, BatchQuery>
batchListProvider = NotifierProvider.autoDispose
    .family<BatchListNotifier, PagedState<Batch>, BatchQuery>(
      BatchListNotifier.new,
    );

/// Lotes que vencen en los próximos 30 días.
final FutureProvider<List<Batch>> expiringBatchesProvider =
    FutureProvider.autoDispose<List<Batch>>(
      (ref) => ref.watch(inventoryRepositoryProvider).expiringBatches(),
    );

final FutureProvider<List<Batch>> expiredBatchesProvider =
    FutureProvider.autoDispose<List<Batch>>(
      (ref) => ref.watch(inventoryRepositoryProvider).expiredBatches(),
    );

final FutureProviderFamily<Batch, int> batchDetailProvider = FutureProvider
    .autoDispose
    .family<Batch, int>(
      (ref, id) => ref.watch(inventoryRepositoryProvider).batch(id),
    );

class DocumentListNotifier extends PagedNotifier<MovementDocument> {
  DocumentListNotifier(this.query);

  final DocumentQuery query;

  @override
  Future<PagedList<MovementDocument>> fetchPage(int page) =>
      ref.read(inventoryRepositoryProvider).documents(query, page: page);
}

final NotifierProviderFamily<
  DocumentListNotifier,
  PagedState<MovementDocument>,
  DocumentQuery
>
documentListProvider = NotifierProvider.autoDispose
    .family<DocumentListNotifier, PagedState<MovementDocument>, DocumentQuery>(
      DocumentListNotifier.new,
    );

final FutureProviderFamily<MovementDocument, int> documentDetailProvider =
    FutureProvider.autoDispose.family<MovementDocument, int>(
      (ref, id) => ref.watch(inventoryRepositoryProvider).document(id),
    );

class MovementListNotifier extends PagedNotifier<MovementLine> {
  MovementListNotifier(this.warehouseId);

  final int warehouseId;

  @override
  Future<PagedList<MovementLine>> fetchPage(int page) => ref
      .read(inventoryRepositoryProvider)
      .movements(warehouseId: warehouseId, page: page);
}

final NotifierProviderFamily<
  MovementListNotifier,
  PagedState<MovementLine>,
  int
>
movementListProvider = NotifierProvider.autoDispose
    .family<MovementListNotifier, PagedState<MovementLine>, int>(
      MovementListNotifier.new,
    );
