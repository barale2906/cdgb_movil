import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Indicadores del parque de activos. Si fallan no estorban: la lista sigue
/// funcionando sin ellos.
class AssetStatsHeader extends ConsumerWidget {
  const AssetStatsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(assetStatisticsProvider).value;
    if (stats == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        0,
      ),
      child: Row(
        children: [
          _Stat(label: l10n.assetStatTotal, value: stats.total),
          _Stat(
            label: l10n.assetStatInMaintenance,
            value: stats.maintenance.inProgress,
          ),
          _Stat(
            label: l10n.assetStatOverdue,
            value: stats.maintenance.overdue,
            highlight: stats.maintenance.overdue > 0,
          ),
          _Stat(
            label: l10n.assetStatPendingTransfers,
            value: stats.pendingTransfers,
          ),
          _Stat(label: l10n.assetStatOffPremises, value: stats.offPremises),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final int value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Semantics(
            label: '$label: $value',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$value', style: textTheme.titleLarge),
                Text(label, style: textTheme.labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
