import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Órdenes consolidadas por proveedor y periodo; permite crear una nueva a
/// quien tenga `ordenes_compra.consolidar`.
class ConsolidatedOrdersTab extends ConsumerWidget {
  const ConsolidatedOrdersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(consolidatedListProvider.notifier);
    final canConsolidate = ref
        .watch(permissionServiceProvider)
        .can('ordenes_compra.consolidar');
    return Column(
      children: [
        if (canConsolidate)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.consolidateAction,
              icon: Icons.merge_type,
              onPressed: () => context.push('/purchasing/consolidate'),
            ),
          ),
        Expanded(
          child: PagedListView<ConsolidatedOrder>(
            state: ref.watch(consolidatedListProvider),
            onRefresh: notifier.refresh,
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.consolidatedEmpty,
            emptyIcon: Icons.merge_type,
            itemBuilder: (context, order) => Card(
              child: ListTile(
                minTileHeight: AppSizes.minTouchTarget,
                title: Text(order.code),
                subtitle: Text(
                  [
                    if (order.supplier != null) order.supplier!.name,
                    if (order.periodFrom != null && order.periodTo != null)
                      l10n.periodRange(
                        AppFormat.date(order.periodFrom!),
                        AppFormat.date(order.periodTo!),
                      ),
                  ].join('\n'),
                ),
                isThreeLine: true,
                trailing: Text(money(order.totalAmount)),
                onTap: () =>
                    context.push('/purchasing/consolidated/${order.id}'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
