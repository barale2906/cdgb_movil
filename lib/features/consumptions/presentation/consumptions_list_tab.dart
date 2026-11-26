import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/features/consumptions/application/consumptions_providers.dart';
import 'package:sga_bojanini/features/consumptions/data/consumption_record.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_detail_page.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Consumos con filtro por estado de sincronización.
class ConsumptionsListTab extends ConsumerStatefulWidget {
  const ConsumptionsListTab({super.key});

  @override
  ConsumerState<ConsumptionsListTab> createState() =>
      _ConsumptionsListTabState();
}

class _ConsumptionsListTabState extends ConsumerState<ConsumptionsListTab> {
  SyncStatus? _status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = consumptionListProvider(_status);
    final notifier = ref.read(provider.notifier);
    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        ChoiceFilterBar<SyncStatus?>(
          options: {
            null: l10n.filterAll,
            SyncStatus.pending: l10n.syncPending,
            SyncStatus.synced: l10n.syncSynced,
            SyncStatus.failed: l10n.syncFailed,
          },
          selected: _status,
          onSelected: (status) => setState(() => _status = status),
        ),
        Expanded(
          child: PagedListView<ConsumptionRecord>(
            state: ref.watch(provider),
            onRefresh: notifier.refresh,
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.consumptionsEmpty,
            emptyIcon: Icons.receipt_long_outlined,
            itemBuilder: (context, record) => _ConsumptionTile(record: record),
          ),
        ),
      ],
    );
  }
}

class _ConsumptionTile extends StatelessWidget {
  const _ConsumptionTile({required this.record});

  final ConsumptionRecord record;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = record.consumedAt;
    final lot = record.lotNumber;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(consumptionTitle(record, l10n)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (lot != null) Text(l10n.consumptionLotValue(lot)),
            if (date != null) Text(AppFormat.dateTime(date)),
            const SizedBox(height: AppSpacing.xs),
            SyncChip(status: record.syncStatus),
          ],
        ),
        trailing: record.quantity == null
            ? null
            : Text(AppFormat.decimal(record.quantity!)),
        onTap: () => context.push(ConsumptionDetailPage.pathFor(record.id)),
      ),
    );
  }
}
