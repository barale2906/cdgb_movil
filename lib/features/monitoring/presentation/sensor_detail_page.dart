import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/utils/file_sharer.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/charts.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_repository.dart';
import 'package:sga_bojanini/features/monitoring/presentation/monitoring_labels.dart';
import 'package:sga_bojanini/features/monitoring/presentation/register_reading_sheet.dart';
import 'package:sga_bojanini/features/monitoring/presentation/trend_card.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Detalle de un sensor: última lectura, límites, gráfica del periodo,
/// resumen, tendencia y acciones (registrar lectura, calibraciones, reglas).
class SensorDetailPage extends ConsumerStatefulWidget {
  const SensorDetailPage({required this.sensorId, super.key});

  final int sensorId;

  @override
  ConsumerState<SensorDetailPage> createState() => _SensorDetailPageState();
}

class _SensorDetailPageState extends ConsumerState<SensorDetailPage> {
  MonitoringPeriod _period = MonitoringPeriod.week;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sensor = ref.watch(sensorProvider(widget.sensorId));
    return Scaffold(
      appBar: AppBar(title: Text(sensor.value?.name ?? l10n.sensorDetailTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: sensor.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(sensorProvider(widget.sensorId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () async {
                    ref
                      ..invalidate(sensorsProvider)
                      ..invalidate(readingsProvider)
                      ..invalidate(trendProvider);
                  },
                  child: _Content(
                    sensor: data,
                    period: _period,
                    onPeriod: (value) => setState(() => _period = value),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({
    required this.sensor,
    required this.period,
    required this.onPeriod,
  });

  final Sensor sensor;
  final MonitoringPeriod period;
  final ValueChanged<MonitoringPeriod> onPeriod;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final permissions = ref.watch(permissionServiceProvider);
    final range = SensorRange(sensor.id, period);
    final last = sensor.lastReading;
    final value = last?.value;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sensorTypeLabel(l10n, sensor.type),
                  style: textTheme.labelMedium,
                ),
                Text(
                  value == null
                      ? l10n.sensorNoReadings
                      : '${AppFormat.decimal(value)} ${sensor.unit}',
                  style: textTheme.headlineSmall,
                ),
                if (last?.recordedAt != null)
                  Text(
                    '${AppFormat.dateTime(last!.recordedAt)}'
                    '${last.userName == null ? '' : ' · ${last.userName}'}',
                    style: textTheme.bodySmall,
                  ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    if (value != null && sensor.hasLimits)
                      RangeChip(outOfRange: sensor.isOutOfRange(value)),
                    if (sensor.calibration != null)
                      CalibrationChip(
                        status: sensor.calibration!.status,
                        daysLeft: sensor.calibration!.daysLeft,
                      ),
                  ],
                ),
                if (sensor.hasLimits) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.sensorLimits(
                      AppFormat.decimal(sensor.allowedMin!),
                      AppFormat.decimal(sensor.allowedMax!),
                      sensor.unit,
                    ),
                    style: textTheme.bodySmall,
                  ),
                ],
                if (sensor.zone != null)
                  Text(
                    '${l10n.sensorZone}: ${_zoneName(sensor.zone!)}',
                    style: textTheme.bodySmall,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (permissions.can('lecturas.crear'))
          BojaniButton(
            label: l10n.readingRegister,
            icon: Icons.add,
            onPressed: () =>
                unawaited(showRegisterReadingSheet(context, sensor)),
          ),
        const SizedBox(height: AppSpacing.md),
        if (permissions.can('lecturas.ver')) ...[
          ChoiceFilterBar<MonitoringPeriod>(
            options: {
              MonitoringPeriod.day: l10n.periodDay,
              MonitoringPeriod.week: l10n.periodWeek,
              MonitoringPeriod.month: l10n.periodMonth,
            },
            selected: period,
            onSelected: onPeriod,
          ),
          const SizedBox(height: AppSpacing.md),
          _ReadingsBlock(sensor: sensor, range: range),
          const SizedBox(height: AppSpacing.md),
          TrendCard(range: range),
          const SizedBox(height: AppSpacing.md),
          BojaniButton(
            label: l10n.readingsExportAction,
            icon: Icons.table_chart_outlined,
            kind: BojaniButtonKind.secondary,
            onPressed: () => unawaited(_exportReadings(context, ref, range)),
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        BojaniButton(
          label: l10n.calibrationsTitle,
          icon: Icons.verified_outlined,
          kind: BojaniButtonKind.secondary,
          onPressed: () =>
              context.push('/monitoring/sensors/${sensor.id}/calibrations'),
        ),
        if (permissions.can('reglas_alerta.ver')) ...[
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.alertRulesTitle,
            icon: Icons.rule,
            kind: BojaniButtonKind.secondary,
            onPressed: () =>
                context.push('/monitoring/sensors/${sensor.id}/alert-rules'),
          ),
        ],
        if (permissions.can('reportes.ver')) ...[
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.conditionsReportAction,
            icon: Icons.picture_as_pdf_outlined,
            kind: BojaniButtonKind.tertiary,
            onPressed: () =>
                context.push('/reports/conditions?sensor_id=${sensor.id}'),
          ),
        ],
      ],
    );
  }
}

/// Lecturas del periodo; solo existe si el usuario tiene `lecturas.ver`
/// (así no se piden al servidor sin permiso).
class _ReadingsBlock extends ConsumerWidget {
  const _ReadingsBlock({required this.sensor, required this.range});

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
          data: (items) => _ReadingsSection(sensor: sensor, readings: items),
        );
  }
}

String _zoneName(SensorZone zone) =>
    [zone.warehouseName, zone.name].whereType<String>().join(' · ');

class _ReadingsSection extends StatelessWidget {
  const _ReadingsSection({required this.sensor, required this.readings});

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
            _Stat(label: l10n.statMin, value: f(min)),
            _Stat(label: l10n.statMax, value: f(max)),
            _Stat(label: l10n.statAvg, value: f(avg)),
            _Stat(label: l10n.statCount, value: '${points.length}'),
          ],
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

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
Future<void> _exportReadings(
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
