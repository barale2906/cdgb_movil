import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
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
