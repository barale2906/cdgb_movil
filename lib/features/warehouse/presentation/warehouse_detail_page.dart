import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_summary.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/warehouse/application/warehouse_providers.dart';
import 'package:sga_bojanini/features/warehouse/data/warehouse_capacity.dart';
import 'package:sga_bojanini/features/warehouse/presentation/capacity_bars.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Detalle de un almacén: datos básicos y capacidad por zona y ubicación.
class WarehouseDetailPage extends ConsumerWidget {
  const WarehouseDetailPage({required this.warehouseId, super.key});

  final int warehouseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final capacity = ref.watch(warehouseCapacityProvider(warehouseId));
    final summary = ref
        .watch(warehousesProvider)
        .value
        ?.where((w) => w.id == warehouseId)
        .firstOrNull;

    return Scaffold(
      appBar: AppBar(title: Text(summary?.name ?? l10n.warehouseDetailTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: capacity.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(warehouseCapacityProvider(warehouseId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () => ref.refresh(
                    warehouseCapacityProvider(warehouseId).future,
                  ),
                  child: _Content(summary: summary, capacity: data),
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
  const _Content({required this.summary, required this.capacity});

  final WarehouseSummary? summary;
  final WarehouseCapacity capacity;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        InfoRow(
          label: l10n.warehouseCode,
          value: summary?.code ?? capacity.code,
          mono: true,
        ),
        InfoRow(label: l10n.warehouseAddress, value: summary?.address),
        InfoRow(label: l10n.warehouseDescription, value: summary?.description),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.capacityTitle, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: CapacityBars(
              volume: capacity.capacityVolume,
              weight: capacity.capacityWeight,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(l10n.capacityZones, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        if (capacity.zones.isEmpty)
          EmptyState(
            icon: Icons.layers_outlined,
            message: l10n.capacityNoZones,
          )
        else
          for (final zone in capacity.zones) _ZoneTile(zone: zone),
      ],
    );
  }
}

class _ZoneTile extends StatelessWidget {
  const _ZoneTile({required this.zone});

  final ZoneCapacity zone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          title: Text(zone.name),
          subtitle: Text(l10n.capacityLocationCount(zone.locations.length)),
          childrenPadding: const EdgeInsets.all(AppSpacing.md),
          children: [
            CapacityBars(
              volume: zone.capacityVolume,
              weight: zone.capacityWeight,
            ),
            for (final location in zone.locations) ...[
              const Divider(height: AppSpacing.lg),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  location.code == null
                      ? location.name
                      : '${location.name} · ${location.code}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              CapacityBars(
                volume: location.capacityVolume,
                weight: location.capacityWeight,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
