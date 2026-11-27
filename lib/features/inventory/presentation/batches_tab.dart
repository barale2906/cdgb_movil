import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_queries.dart';
import 'package:sga_bojanini/features/inventory/presentation/inventory_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

enum _BatchFilter { all, expiring, expired }

/// Lotes: todos, por vencer (30 días) o vencidos.
class BatchesTab extends ConsumerStatefulWidget {
  const BatchesTab({required this.warehouseId, super.key});

  final int warehouseId;

  @override
  ConsumerState<BatchesTab> createState() => _BatchesTabState();
}

class _BatchesTabState extends ConsumerState<BatchesTab> {
  _BatchFilter _filter = _BatchFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        ChoiceFilterBar<_BatchFilter>(
          options: {
            _BatchFilter.all: l10n.batchFilterAll,
            _BatchFilter.expiring: l10n.batchFilterExpiring,
            _BatchFilter.expired: l10n.batchFilterExpired,
          },
          selected: _filter,
          onSelected: (value) => setState(() => _filter = value),
        ),
        Expanded(
          child: switch (_filter) {
            _BatchFilter.all => _AllBatches(warehouseId: widget.warehouseId),
            _BatchFilter.expiring => _SimpleBatchList(
              provider: expiringBatchesProvider,
            ),
            _BatchFilter.expired => _SimpleBatchList(
              provider: expiredBatchesProvider,
            ),
          },
        ),
      ],
    );
  }
}

class _AllBatches extends ConsumerWidget {
  const _AllBatches({required this.warehouseId});

  final int warehouseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final provider = batchListProvider(BatchQuery(warehouseId: warehouseId));
    final notifier = ref.read(provider.notifier);
    return PagedListView<Batch>(
      state: ref.watch(provider),
      onRefresh: notifier.refresh,
      onLoadMore: notifier.loadMore,
      onRetry: notifier.retry,
      emptyMessage: l10n.batchesEmpty,
      itemBuilder: (context, batch) => BatchTile(batch: batch),
    );
  }
}

class _SimpleBatchList extends ConsumerWidget {
  const _SimpleBatchList({required this.provider});

  final FutureProvider<List<Batch>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ref
        .watch(provider)
        .when(
          loading: () => const SkeletonList(),
          error: (error, _) => ErrorState(
            error: error,
            onRetry: () => ref.invalidate(provider),
          ),
          data: (batches) => batches.isEmpty
              ? EmptyState(
                  icon: Icons.inventory_2_outlined,
                  message: l10n.batchesEmpty,
                )
              : RefreshIndicator(
                  onRefresh: () => ref.refresh(provider.future),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: batches.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) =>
                        BatchTile(batch: batches[index]),
                  ),
                ),
        );
  }
}

class BatchTile extends StatelessWidget {
  const BatchTile({required this.batch, super.key});

  final Batch batch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final expiration = batch.expirationDate;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(
          batch.productName.isEmpty
              ? l10n.batchLot(batch.lotNumber)
              : batch.productName,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (batch.productName.isNotEmpty)
              Text(l10n.batchLot(batch.lotNumber)),
            if (expiration != null)
              Text(l10n.batchExpires(AppFormat.date(expiration))),
            const SizedBox(height: AppSpacing.xs),
            BatchStatusChip(batch: batch),
          ],
        ),
        trailing: Text(
          AppFormat.decimal(batch.quantityAvailable ?? 0, maxDecimals: 3),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        onTap: () => context.push('/inventory/batches/${batch.id}'),
      ),
    );
  }
}
