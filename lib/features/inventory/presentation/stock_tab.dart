import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/stock_item.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

const _catalogPermission = 'generic-products.ver';

/// Existencias del almacén activo; con el filtro "Bajo mínimo" solo los
/// productos por debajo de su punto de reorden.
class StockTab extends ConsumerStatefulWidget {
  const StockTab({required this.warehouseId, super.key});

  final int warehouseId;

  @override
  ConsumerState<StockTab> createState() => _StockTabState();
}

class _StockTabState extends ConsumerState<StockTab> {
  bool _onlyLow = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FilterChip(
              label: Text(l10n.stockLowFilter),
              avatar: const Icon(
                Icons.trending_down,
                size: AppSizes.iconCompact,
              ),
              selected: _onlyLow,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onSelected: (value) => setState(() => _onlyLow = value),
            ),
          ),
        ),
        Expanded(
          child: _onlyLow
              ? _LowStockList(warehouseId: widget.warehouseId)
              : _AllStockList(warehouseId: widget.warehouseId),
        ),
      ],
    );
  }
}

class _AllStockList extends ConsumerWidget {
  const _AllStockList({required this.warehouseId});

  final int warehouseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final provider = stockListProvider(warehouseId);
    final notifier = ref.read(provider.notifier);
    return PagedListView<StockItem>(
      state: ref.watch(provider),
      onRefresh: notifier.refresh,
      onLoadMore: notifier.loadMore,
      onRetry: notifier.retry,
      emptyMessage: l10n.stockEmpty,
      itemBuilder: (context, item) => StockTile(item: item),
    );
  }
}

class _LowStockList extends ConsumerWidget {
  const _LowStockList({required this.warehouseId});

  final int warehouseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final low = ref.watch(lowStockProvider(warehouseId));
    return low.when(
      loading: () => const SkeletonList(),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(lowStockProvider(warehouseId)),
      ),
      data: (items) => items.isEmpty
          ? EmptyState(
              icon: Icons.thumb_up_alt_outlined,
              message: l10n.stockLowEmpty,
            )
          : RefreshIndicator(
              onRefresh: () =>
                  ref.refresh(lowStockProvider(warehouseId).future),
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: items.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) => StockTile(item: items[index]),
              ),
            ),
    );
  }
}

class StockTile extends ConsumerWidget {
  const StockTile({required this.item, super.key});

  final StockItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canOpen = ref
        .watch(permissionServiceProvider)
        .can(_catalogPermission);
    final genericId = item.genericProductId;
    final available = AppFormat.decimal(
      item.availableQuantity ?? 0,
      maxDecimals: 3,
    );

    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(
          item.productName.isEmpty ? l10n.notAvailable : item.productName,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.variant.labBrand != null) Text(item.variant.labBrand!),
            Text(
              l10n.stockTotals(
                AppFormat.decimal(item.totalQuantity ?? 0, maxDecimals: 3),
                AppFormat.decimal(item.reservedQuantity ?? 0, maxDecimals: 3),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: Text(
          l10n.stockAvailable(available),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        onTap: canOpen && genericId != null
            ? () => context.push('/catalog/products/$genericId')
            : null,
      ),
    );
  }
}
