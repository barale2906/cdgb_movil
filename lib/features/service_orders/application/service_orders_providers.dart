import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show FutureProviderFamily, NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/features/service_orders/data/order_query.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';
import 'package:sga_bojanini/features/service_orders/data/service_orders_repository.dart';

/// Orden por número.
final FutureProviderFamily<ServiceOrder, String> serviceOrderProvider =
    FutureProvider.autoDispose.family<ServiceOrder, String>(
      (ref, number) => ref.watch(serviceOrdersRepositoryProvider).order(number),
    );

/// Órdenes con descuentos por aprobar.
final FutureProvider<List<DiscountOrder>> pendingDiscountsProvider =
    FutureProvider.autoDispose<List<DiscountOrder>>(
      (ref) => ref.watch(serviceOrdersRepositoryProvider).pendingDiscounts(),
    );

class OrderListNotifier extends PagedNotifier<ServiceOrder> {
  OrderListNotifier(this.query);

  final OrderQuery query;

  @override
  Future<PagedList<ServiceOrder>> fetchPage(int page) =>
      ref.read(serviceOrdersRepositoryProvider).list(query, page: page);
}

/// Listado paginado de órdenes según los filtros.
final NotifierProviderFamily<
  OrderListNotifier,
  PagedState<ServiceOrder>,
  OrderQuery
>
orderListProvider = NotifierProvider.autoDispose
    .family<OrderListNotifier, PagedState<ServiceOrder>, OrderQuery>(
      OrderListNotifier.new,
    );
