import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/utils/file_sharer.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/line_chart_view.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_repository.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Lecturas del periodo; solo existe si el usuario tiene `lecturas.ver`
/// (así no se piden al servidor sin permiso).
class ReadingsBlock extends ConsumerWidget {
  const ReadingsBlock({required this.sensor, required this.range, super.key});

  final Sensor sensor;
  final SensorRange range;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(readingsProvider(range))
        .when(
          loading: () => const Skeleton(height: 180),
          error: (error, _) => ErrorState(
            error: error,
            onRetry: () => ref.invalidate(readingsProvider(range)),
          ),
          data: (items) => ReadingsSection(sensor: sensor, readings: items),
        );
  }
}

class ReadingsSection extends StatelessWidget {
  const ReadingsSection({
    required this.sensor,
    required this.readings,
    super.key,
  });

  final Sensor sensor;
  final List<Reading> readings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final points = [
      for (final reading in readings)
        if (reading.value != null &&
            ColombiaTime.parse(reading.recordedAt) != null)
          ChartPoint(
            time: ColombiaTime.parse(reading.recordedAt)!,
            value: reading.value!,
          ),
    ]..sort((a, b) => a.time.compareTo(b.time));

    if (points.isEmpty) {
      return Text(l10n.readingsEmptyPeriod, style: textTheme.bodyMedium);
    }

    final values = [for (final p in points) p.value];
    final avg = values.reduce((a, b) => a + b) / values.length;
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    String f(double v) => '${AppFormat.decimal(v)} ${sensor.unit}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LineChartView(
          points: points,
          min: sensor.allowedMin,
          max: sensor.allowedMax,
          unit: sensor.unit,
          semanticLabel:
              '${l10n.readingsStats}: ${l10n.statMin} ${f(min)}, '
              '${l10n.statMax} ${f(max)}, ${l10n.statAvg} ${f(avg)}',
        ),
        const SizedBox(height: AppSpacing.md),
        Text(l10n.readingsStats, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.sm,
          children: [
            ReadingStat(label: l10n.statMin, value: f(min)),
            ReadingStat(label: l10n.statMax, value: f(max)),
            ReadingStat(label: l10n.statAvg, value: f(avg)),
            ReadingStat(label: l10n.statCount, value: '${points.length}'),
          ],
        ),
      ],
    );
  }
}

class ReadingStat extends StatelessWidget {
  const ReadingStat({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: textTheme.titleSmall),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}

/// Descarga el Excel de lecturas del periodo y lo comparte.
Future<void> exportReadings(
  BuildContext context,
  WidgetRef ref,
  SensorRange range,
) async {
  final l10n = AppLocalizations.of(context);
  final now = ColombiaTime.now(ref.read(clockProvider));
  final from = now.subtract(range.period.length);
  try {
    final bytes = await ref
        .read(monitoringRepositoryProvider)
        .exportReadings(range.sensorId, from: from, to: now);
    final stamp = ColombiaTime.formatDate(now);
    await ref.read(fileSharerProvider)(
      bytes,
      'lecturas-sensor-${range.sensorId}-$stamp.xlsx',
    );
  } on Object {
    if (context.mounted) {
      AppSnackbar.show(
        context,
        l10n.errorGeneric,
        kind: AppSnackbarKind.error,
        closeLabel: l10n.actionClose,
      );
    }
  }
}
