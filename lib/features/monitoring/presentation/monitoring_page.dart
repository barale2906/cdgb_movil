import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/features/monitoring/presentation/monitoring_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Sensores asignados con su última lectura, estado de rango y calibración.
class MonitoringPage extends ConsumerWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sensors = ref.watch(sensorsProvider);
    return sensors.when(
      loading: () => const SkeletonList(),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(sensorsProvider),
      ),
      data: (items) => items.isEmpty
          ? EmptyState(
              icon: Icons.sensors_off_outlined,
              message: l10n.monitoringEmpty,
            )
          : RefreshIndicator(
              onRefresh: () => ref.refresh(sensorsProvider.future),
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: items.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) =>
                    SensorTile(sensor: items[index]),
              ),
            ),
    );
  }
}

class SensorTile extends StatelessWidget {
  const SensorTile({required this.sensor, super.key});

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final last = sensor.lastReading;
    final value = last?.value;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.control),
        onTap: () => context.push('/monitoring/sensors/${sensor.id}'),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(sensorTypeIcon(sensor.type)),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(sensor.name, style: textTheme.titleSmall),
                  ),
                  if (value != null)
                    Text(
                      '${AppFormat.decimal(value)} ${sensor.unit}',
                      style: textTheme.titleMedium,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                [
                  sensor.zone?.warehouseName,
                  sensor.zone?.name,
                ].whereType<String>().join(' · '),
                style: textTheme.bodySmall,
              ),
              Text(
                last?.recordedAt == null
                    ? l10n.sensorNoReadings
                    : '${l10n.sensorLastReading}: '
                          '${AppFormat.dateTime(last!.recordedAt)}',
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
            ],
          ),
        ),
      ),
    );
  }
}
