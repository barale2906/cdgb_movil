import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/purchasing/application/order_actions.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_widgets.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_workflow.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Orden de compra: datos, líneas, totales y acciones del flujo.
class PurchaseOrderDetailPage extends ConsumerWidget {
  const PurchaseOrderDetailPage({required this.orderId, super.key});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final order = ref.watch(purchaseOrderDetailProvider(orderId));
    return Scaffold(
      appBar: AppBar(title: Text(order.value?.code ?? l10n.orderDetailTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: order.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(purchaseOrderDetailProvider(orderId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(purchaseOrderDetailProvider(orderId).future),
                  child: _Content(order: data),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.order});

  final PurchaseOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                order.supplier?.name ?? order.code,
                style: textTheme.titleMedium,
              ),
            ),
            OrderStatusChip(status: order.status),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        InfoRow(label: l10n.orderWarehouse, value: order.warehouse?.name),
        InfoRow(label: l10n.orderCostCenter, value: order.costCenter?.name),
        InfoRow(
          label: l10n.orderExpectedDate,
          value: _date(order.expectedDeliveryDate),
        ),
        InfoRow(label: l10n.orderCreatedAt, value: _dateTime(order.createdAt)),
        InfoRow(label: l10n.orderSentAt, value: _dateTime(order.sentAt)),
        InfoRow(
          label: l10n.orderReceivedAt,
          value: _dateTime(order.receivedAt),
        ),
        InfoRow(label: l10n.orderNotes, value: order.notes),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.orderLines, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        for (final item in order.items) _ItemCard(item: item),
        const SizedBox(height: AppSpacing.sm),
        OrderTotals(
          subtotal: order.subtotal,
          tax: order.taxAmount,
          total: order.totalAmount,
        ),
        const SizedBox(height: AppSpacing.lg),
        OrderWorkflowButtons(
          orderId: order.id,
          status: order.status,
          permissionPrefix: 'ordenes_compra',
          actions: purchaseOrderActionsProvider,
          onReceive: () =>
              context.push('/purchasing/orders/${order.id}/receive'),
          onEdit: () => context.push('/purchasing/orders/${order.id}/edit'),
        ),
      ],
    );
  }

  static String? _date(String? raw) => raw == null ? null : AppFormat.date(raw);

  static String? _dateTime(String? raw) =>
      raw == null ? null : AppFormat.dateTime(raw);
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item});

  final PurchaseOrderItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detail = [
      if (item.presentation != null) item.presentation!.name,
      l10n.orderQuantities(
        AppFormat.decimal(item.quantityRequested ?? 0),
        AppFormat.decimal(item.quantityReceived ?? 0),
      ),
      l10n.orderUnitPrice(money(item.unitPrice)),
    ].join(' · ');
    return Card(
      child: ListTile(
        title: Text(item.productName ?? l10n.notAvailable),
        subtitle: Text(detail),
        trailing: Text(money(item.totalPrice)),
      ),
    );
  }
}
