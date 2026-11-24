import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/presentation/inventory_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class BatchDetailPage extends ConsumerWidget {
  const BatchDetailPage({required this.batchId, super.key});

  final int batchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final batch = ref.watch(batchDetailProvider(batchId));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          batch.value == null
              ? l10n.batchDetailTitle
              : l10n.batchLot(batch.value!.lotNumber),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: batch.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(batchDetailProvider(batchId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(batchDetailProvider(batchId).future),
                  child: _Content(batch: data),
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
  const _Content({required this.batch});

  final Batch batch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    String? date(String? iso) => iso == null ? null : AppFormat.date(iso);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: BatchStatusChip(batch: batch),
        ),
        const SizedBox(height: AppSpacing.md),
        InfoRow(label: l10n.fieldProduct, value: batch.productName),
        InfoRow(label: l10n.fieldLot, value: batch.lotNumber, mono: true),
        InfoRow(label: l10n.fieldExpiration, value: date(batch.expirationDate)),
        InfoRow(
          label: l10n.batchManufacturing,
          value: date(batch.manufacturingDate),
        ),
        InfoRow(
          label: l10n.batchQuantity,
          value: AppFormat.decimal(
            batch.quantityAvailable ?? 0,
            maxDecimals: 3,
          ),
        ),
        InfoRow(label: l10n.fieldNotes, value: batch.notes),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.batchLocations, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        if (batch.locations.where((l) => (l.quantity ?? 0) > 0).isEmpty)
          Text(l10n.batchNoLocations, style: textTheme.bodyMedium)
        else
          for (final location in batch.locations.where(
            (l) => (l.quantity ?? 0) > 0,
          ))
            Card(
              child: ListTile(
                title: Text(location.locationName ?? l10n.notAvailable),
                subtitle: Text(
                  [
                    location.zone?.warehouseName,
                    location.zone?.zoneName,
                    location.locationCode,
                  ].whereType<String>().join(' · '),
                ),
                trailing: Text(
                  AppFormat.decimal(location.quantity ?? 0, maxDecimals: 3),
                  style: textTheme.labelLarge,
                ),
              ),
            ),
      ],
    );
  }
}
