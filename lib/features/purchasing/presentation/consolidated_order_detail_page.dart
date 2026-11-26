import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/features/purchasing/presentation/consolidation_summary.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Orden consolidada: periodo, líneas agrupadas, totales y órdenes de origen.
class ConsolidatedOrderDetailPage extends ConsumerWidget {
  const ConsolidatedOrderDetailPage({required this.orderId, super.key});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final order = ref.watch(consolidatedDetailProvider(orderId));
    return Scaffold(
      appBar: AppBar(
        title: Text(order.value?.code ?? l10n.consolidatedDetailTitle),
      ),
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
                      ref.invalidate(consolidatedDetailProvider(orderId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(consolidatedDetailProvider(orderId).future),
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

  final ConsolidatedOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        InfoRow(label: l10n.fieldSupplier, value: order.supplier?.name),
        InfoRow(
          label: l10n.consolidatedPeriod,
          value: order.periodFrom == null || order.periodTo == null
              ? null
              : l10n.periodRange(
                  AppFormat.date(order.periodFrom!),
                  AppFormat.date(order.periodTo!),
                ),
        ),
        InfoRow(label: l10n.orderNotes, value: order.notes),
        ConsolidationSummary(
          items: order.items,
          subtotal: order.subtotal,
          tax: order.taxAmount,
          total: order.totalAmount,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.consolidateOrders,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final source in order.purchaseOrders)
          Card(
            child: ListTile(
              title: Text(source.code),
              subtitle: Text(source.warehouse?.name ?? ''),
              trailing: Text(money(source.totalAmount)),
              onTap: () => context.push('/purchasing/orders/${source.id}'),
            ),
          ),
      ],
    );
  }
}
