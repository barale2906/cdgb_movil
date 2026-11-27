import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/billing_chip.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/core/widgets/search_field.dart';
import 'package:sga_bojanini/features/service_orders/application/service_orders_providers.dart';
import 'package:sga_bojanini/features/service_orders/data/order_query.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_detail_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Órdenes de servicio, la más reciente primero: búsqueda por número de orden
/// o documento del paciente y filtro por estado de facturación.
class OrdersTab extends ConsumerStatefulWidget {
  const OrdersTab({super.key});

  @override
  ConsumerState<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends ConsumerState<OrdersTab> {
  String _search = '';
  OrderBillingFilter _billing = OrderBillingFilter.all;

  String _label(AppLocalizations l10n, OrderBillingFilter filter) =>
      switch (filter) {
        OrderBillingFilter.all => l10n.filterAll,
        OrderBillingFilter.unbilled => l10n.billingPending,
        OrderBillingFilter.billed => l10n.billingBilled,
        OrderBillingFilter.cancelled => l10n.billingCancelled,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = orderListProvider(
      OrderQuery(search: _search, billing: _billing),
    );
    final notifier = ref.read(provider.notifier);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SearchField(
            hint: l10n.serviceOrderSearchHint,
            onChanged: (value) => setState(() => _search = value),
          ),
        ),
        ChoiceFilterBar<OrderBillingFilter>(
          options: {
            for (final filter in OrderBillingFilter.values)
              filter: _label(l10n, filter),
          },
          selected: _billing,
          onSelected: (value) => setState(() => _billing = value),
        ),
        Expanded(
          child: PagedListView<ServiceOrder>(
            state: ref.watch(provider),
            onRefresh: notifier.refresh,
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.serviceOrdersEmpty,
            emptyIcon: Icons.assignment_outlined,
            itemBuilder: (context, order) => _OrderTile(order: order),
          ),
        ),
      ],
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({required this.order});

  final ServiceOrder order;

  @override
  Widget build(BuildContext context) {
    final date = order.serviceDate;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(order.orderNumber),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.patientName),
            if (date != null) Text(AppFormat.date(date)),
            if (order.netTotal != null) Text(AppFormat.cop(order.netTotal!)),
            const SizedBox(height: AppSpacing.xs),
            Align(
              alignment: Alignment.centerLeft,
              child: BillingChip(status: order.billingStatus),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(OrderDetailPage.pathFor(order.orderNumber)),
      ),
    );
  }
}
