import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';
import 'package:sga_bojanini/features/purchasing/data/orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_widgets.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Órdenes de compra con filtro por estado.
class PurchaseOrdersTab extends ConsumerStatefulWidget {
  const PurchaseOrdersTab({super.key});

  @override
  ConsumerState<PurchaseOrdersTab> createState() => _PurchaseOrdersTabState();
}

class _PurchaseOrdersTabState extends ConsumerState<PurchaseOrdersTab> {
  OrderStatus? _status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = purchaseOrderListProvider(OrderQuery(status: _status));
    final notifier = ref.read(provider.notifier);
    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        OrderStatusFilterBar(
          selected: _status,
          onSelected: (value) => setState(() => _status = value),
        ),
        Expanded(
          child: PagedListView<PurchaseOrder>(
            state: ref.watch(provider),
            onRefresh: notifier.refresh,
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.purchaseOrdersEmpty,
            emptyIcon: Icons.shopping_cart_outlined,
            itemBuilder: (context, order) => OrderTile(
              code: order.code,
              supplier: order.supplier?.name,
              total: order.totalAmount,
              status: order.status,
              date: order.createdAt,
              onTap: () => context.push('/purchasing/orders/${order.id}'),
            ),
          ),
        ),
      ],
    );
  }
}

/// Órdenes de gasto con filtros por estado y por estado de pago.
class ExpenseOrdersTab extends ConsumerStatefulWidget {
  const ExpenseOrdersTab({super.key});

  @override
  ConsumerState<ExpenseOrdersTab> createState() => _ExpenseOrdersTabState();
}

class _ExpenseOrdersTabState extends ConsumerState<ExpenseOrdersTab> {
  OrderStatus? _status;
  PaymentStatus? _payment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = expenseOrderListProvider(
      OrderQuery(status: _status, paymentStatus: _payment),
    );
    final notifier = ref.read(provider.notifier);
    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        OrderStatusFilterBar(
          selected: _status,
          onSelected: (value) => setState(() => _status = value),
        ),
        const SizedBox(height: AppSpacing.xs),
        ChoiceFilterBar<PaymentStatus?>(
          options: {
            null: l10n.filterAnyPayment,
            PaymentStatus.unpaid: paymentStatusLabel(
              l10n,
              PaymentStatus.unpaid,
            ),
            PaymentStatus.partial: paymentStatusLabel(
              l10n,
              PaymentStatus.partial,
            ),
            PaymentStatus.paid: paymentStatusLabel(l10n, PaymentStatus.paid),
          },
          selected: _payment,
          onSelected: (value) => setState(() => _payment = value),
        ),
        Expanded(
          child: PagedListView<ExpenseOrder>(
            state: ref.watch(provider),
            onRefresh: notifier.refresh,
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.expenseOrdersEmpty,
            emptyIcon: Icons.request_quote_outlined,
            itemBuilder: (context, order) => OrderTile(
              code: order.code,
              supplier: order.supplier?.name,
              total: order.totalAmount,
              status: order.status,
              date: order.createdAt,
              trailing: PaymentStatusChip(status: order.paymentStatus),
              onTap: () => context.push('/purchasing/expenses/${order.id}'),
            ),
          ),
        ),
      ],
    );
  }
}
