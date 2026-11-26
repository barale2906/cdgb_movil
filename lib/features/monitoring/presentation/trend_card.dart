import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Resultado del análisis de tendencia del sensor en el periodo.
class TrendCard extends ConsumerWidget {
  const TrendCard({required this.range, super.key});

  final SensorRange range;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final trend = ref.watch(trendProvider(range));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.trendTitle, style: textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            trend.when(
              loading: () => const Skeleton(height: AppSpacing.lg),
              // La tendencia es complementaria: si falla no estorba.
              error: (_, _) =>
                  Text(l10n.dashBlockError, style: textTheme.bodySmall),
              data: (data) => _body(context, l10n, data),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    AppLocalizations l10n,
    TrendAnalysis data,
  ) {
    final textTheme = Theme.of(context).textTheme;
    if (!data.overallTrend) {
      return Text(l10n.trendNone, style: textTheme.bodyMedium);
    }
    final up =
        data.overallDirection == 'up' || data.overallDirection == 'increasing';
    final confidence = switch (data.confidence) {
      'high' => l10n.confidenceHigh,
      'medium' => l10n.confidenceMedium,
      _ => l10n.confidenceLow,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            StatusChip(
              label: up ? l10n.trendUp : l10n.trendDown,
              kind: StatusKind.warning,
              icon: up ? Icons.trending_up : Icons.trending_down,
            ),
            StatusChip(
              label: l10n.trendConfidence(confidence),
              kind: StatusKind.info,
            ),
          ],
        ),
        if ((data.linearRegression?.interpretation ?? '').isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            data.linearRegression!.interpretation!,
            style: textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
