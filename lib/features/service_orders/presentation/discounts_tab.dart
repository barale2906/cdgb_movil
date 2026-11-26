import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/service_orders/application/service_orders_providers.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_detail_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Órdenes con descuentos por aprobar (solo para quien puede aprobar).
class DiscountsTab extends ConsumerWidget {
  const DiscountsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final orders = ref.watch(pendingDiscountsProvider);
    return orders.when(
      skipLoadingOnReload: true,
      loading: () => const SkeletonList(),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(pendingDiscountsProvider),
      ),
      data: (items) => items.isEmpty
          ? EmptyState(
              icon: Icons.task_alt_outlined,
              message: l10n.serviceOrderDiscountsEmpty,
            )
          : RefreshIndicator(
              onRefresh: () => ref.refresh(pendingDiscountsProvider.future),
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: items.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) =>
                    _DiscountTile(order: items[index]),
              ),
            ),
    );
  }
}

class _DiscountTile extends StatelessWidget {
  const _DiscountTile({required this.order});

  final DiscountOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
            Text(
              l10n.serviceOrderDiscountOf(AppFormat.cop(order.totalDiscount)),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(OrderDetailPage.pathFor(order.orderNumber)),
      ),
    );
  }
}
