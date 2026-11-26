import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_events.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Historial de ubicaciones y bitácora de eventos del activo.
class AssetHistoryTab extends ConsumerWidget {
  const AssetHistoryTab({required this.assetId, super.key});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locations = ref.watch(locationHistoryProvider(assetId));
    final movements = ref.watch(assetMovementsProvider(assetId));
    final movementsNotifier = ref.read(
      assetMovementsProvider(assetId).notifier,
    );
    final textTheme = Theme.of(context).textTheme;

    Future<void> refresh() async {
      ref.invalidate(locationHistoryProvider(assetId));
      await movementsNotifier.refresh();
    }

    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(l10n.assetLocationHistory, style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          locations.when(
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () => ref.invalidate(locationHistoryProvider(assetId)),
            ),
            data: (items) => items.isEmpty
                ? Text(l10n.assetLocationHistoryEmpty)
                : Column(
                    children: [for (final item in items) _LocationTile(item)],
                  ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.assetEvents, style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          if (movements.isInitialLoading)
            const LinearProgressIndicator()
          else if (movements.isInitialError)
            ErrorState(
              error: movements.error!,
              onRetry: movementsNotifier.retry,
            )
          else if (movements.isEmpty)
            EmptyState(icon: Icons.history, message: l10n.assetEventsEmpty)
          else ...[
            for (final item in movements.items) _EventTile(item),
            if (movements.hasMore)
              TextButton(
                onPressed: movementsNotifier.loadMore,
                child: Text(l10n.loadMore),
              ),
          ],
        ],
      ),
    );
  }
}

class _LocationTile extends StatelessWidget {
  const _LocationTile(this.item);

  final LocationRecord item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final from = item.fromDate == null ? '' : AppFormat.date(item.fromDate!);
    final to = item.toDate == null
        ? l10n.assetUntilNow
        : AppFormat.date(item.toDate!);
    return Card(
      child: ListTile(
        leading: Icon(
          item.isOffPremises
              ? Icons.local_shipping_outlined
              : Icons.place_outlined,
        ),
        title: Text(item.location ?? l10n.notAvailable),
        subtitle: Text(
          [
            l10n.periodRange(from, to),
            if (item.transferLabel != null) item.transferLabel!,
          ].join(' · '),
        ),
        trailing: item.isCurrent ? Text(l10n.assetCurrent) : null,
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile(this.item);

  final AssetMovement item;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      title: Text(item.typeLabel ?? item.type ?? ''),
      subtitle: Text(
        [
          if ((item.description ?? '').isNotEmpty) item.description!,
          if (item.user != null) item.user!.name,
          if (item.createdAt != null) AppFormat.dateTime(item.createdAt),
        ].join('\n'),
      ),
      isThreeLine: (item.description ?? '').isNotEmpty,
    ),
  );
}
