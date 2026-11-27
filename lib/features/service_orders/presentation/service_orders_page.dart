import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/features/service_orders/application/service_order_permissions.dart';
import 'package:sga_bojanini/features/service_orders/presentation/discounts_tab.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_paths.dart';
import 'package:sga_bojanini/features/service_orders/presentation/orders_tab.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Órdenes de servicio: listado con búsqueda y filtros, descuentos por aprobar
/// (con permiso) y creación de una nueva orden (con permiso).
class ServiceOrdersPage extends ConsumerWidget {
  const ServiceOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canCreate = ref.watch(canCreateOrderProvider);
    final canApprove = ref.watch(canApproveDiscountProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: canCreate
          ? FloatingActionButton.extended(
              onPressed: () => context.push(OrderPaths.newOrder),
              icon: const Icon(Icons.add),
              label: Text(l10n.serviceOrderNew),
            )
          : null,
      body: canApprove
          ? DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Material(
                    color: AppColors.surface,
                    child: TabBar(
                      tabs: [
                        Tab(text: l10n.serviceOrderTabOrders),
                        Tab(text: l10n.serviceOrderTabDiscounts),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [OrdersTab(), DiscountsTab()],
                    ),
                  ),
                ],
              ),
            )
          : const OrdersTab(),
    );
  }
}
