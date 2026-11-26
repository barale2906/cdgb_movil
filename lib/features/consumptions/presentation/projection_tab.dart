import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/consumptions/application/consumptions_providers.dart';
import 'package:sga_bojanini/features/consumptions/data/consumption_record.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Proyección de consumo por servicio según las citas futuras de MedSys.
class ProjectionTab extends ConsumerStatefulWidget {
  const ProjectionTab({super.key});

  /// Horizontes que se pueden consultar, en días.
  static const horizons = [7, 15, 30];

  @override
  ConsumerState<ProjectionTab> createState() => _ProjectionTabState();
}

class _ProjectionTabState extends ConsumerState<ProjectionTab> {
  int _days = ProjectionTab.horizons.last;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final projection = ref.watch(projectionProvider(_days));
    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        ChoiceFilterBar<int>(
          options: {
            for (final days in ProjectionTab.horizons)
              days: l10n.projectionDays(days),
          },
          selected: _days,
          onSelected: (days) => setState(() => _days = days),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            l10n.projectionNote,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Expanded(
          child: projection.when(
            skipLoadingOnReload: true,
            loading: () => const SkeletonList(),
            error: (error, _) => ErrorState(
              error: error,
              onRetry: () => ref.invalidate(projectionProvider(_days)),
            ),
            data: (items) => items.isEmpty
                ? EmptyState(
                    icon: Icons.insights_outlined,
                    message: l10n.projectionEmpty,
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        ref.refresh(projectionProvider(_days).future),
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        0,
                        AppSpacing.md,
                        AppSpacing.md,
                      ),
                      itemCount: items.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) =>
                          _ProjectionTile(item: items[index]),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _ProjectionTile extends StatelessWidget {
  const _ProjectionTile({required this.item});

  final ServiceProjection item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(item.serviceName),
        subtitle: Text(
          l10n.projectionAverage(
            item.futureAppointments,
            AppFormat.decimal(item.avgUnitsPerAppointment ?? 0),
          ),
        ),
        trailing: Text(
          l10n.projectionUnits(item.projectedUnits),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
