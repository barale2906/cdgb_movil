import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show FutureProviderFamily, NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_orders_repository.dart';

class PurchaseOrderListNotifier extends PagedNotifier<PurchaseOrder> {
  PurchaseOrderListNotifier(this.query);

  final OrderQuery query;

  @override
  Future<PagedList<PurchaseOrder>> fetchPage(int page) =>
      ref.read(purchaseOrdersRepositoryProvider).list(query, page: page);
}

final NotifierProviderFamily<
  PurchaseOrderListNotifier,
  PagedState<PurchaseOrder>,
  OrderQuery
>
purchaseOrderListProvider = NotifierProvider.autoDispose
    .family<PurchaseOrderListNotifier, PagedState<PurchaseOrder>, OrderQuery>(
      PurchaseOrderListNotifier.new,
    );

final FutureProviderFamily<PurchaseOrder, int> purchaseOrderDetailProvider =
    FutureProvider.autoDispose.family<PurchaseOrder, int>(
      (ref, id) => ref.watch(purchaseOrdersRepositoryProvider).get(id),
    );

class ExpenseOrderListNotifier extends PagedNotifier<ExpenseOrder> {
  ExpenseOrderListNotifier(this.query);

  final OrderQuery query;

  @override
  Future<PagedList<ExpenseOrder>> fetchPage(int page) =>
      ref.read(expenseOrdersRepositoryProvider).list(query, page: page);
}

final NotifierProviderFamily<
  ExpenseOrderListNotifier,
  PagedState<ExpenseOrder>,
  OrderQuery
>
expenseOrderListProvider = NotifierProvider.autoDispose
    .family<ExpenseOrderListNotifier, PagedState<ExpenseOrder>, OrderQuery>(
      ExpenseOrderListNotifier.new,
    );

final FutureProviderFamily<ExpenseOrder, int> expenseOrderDetailProvider =
    FutureProvider.autoDispose.family<ExpenseOrder, int>(
      (ref, id) => ref.watch(expenseOrdersRepositoryProvider).get(id),
    );

final FutureProvider<List<ReorderSuggestion>> suggestionsProvider =
    FutureProvider.autoDispose<List<ReorderSuggestion>>(
      (ref) => ref.watch(purchaseOrdersRepositoryProvider).suggestions(),
    );

final FutureProvider<List<ConsolidableSupplier>> consolidableSuppliersProvider =
    FutureProvider.autoDispose<List<ConsolidableSupplier>>(
      (ref) =>
          ref.watch(purchaseOrdersRepositoryProvider).consolidableSuppliers(),
    );

final FutureProviderFamily<ConsolidableOrders, int> consolidableOrdersProvider =
    FutureProvider.autoDispose.family<ConsolidableOrders, int>(
      (ref, supplierId) =>
          ref.watch(purchaseOrdersRepositoryProvider).consolidable(supplierId),
    );

class ConsolidatedListNotifier extends PagedNotifier<ConsolidatedOrder> {
  @override
  Future<PagedList<ConsolidatedOrder>> fetchPage(int page) =>
      ref.read(purchaseOrdersRepositoryProvider).consolidatedOrders(page: page);
}

final NotifierProvider<ConsolidatedListNotifier, PagedState<ConsolidatedOrder>>
consolidatedListProvider =
    NotifierProvider.autoDispose<
      ConsolidatedListNotifier,
      PagedState<ConsolidatedOrder>
    >(ConsolidatedListNotifier.new);

final FutureProviderFamily<ConsolidatedOrder, int> consolidatedDetailProvider =
    FutureProvider.autoDispose.family<ConsolidatedOrder, int>(
      (ref, id) =>
          ref.watch(purchaseOrdersRepositoryProvider).consolidatedOrder(id),
    );
