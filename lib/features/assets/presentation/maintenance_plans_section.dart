import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Planes periódicos del activo (solo consulta). Si no hay o fallan, no se
/// muestra nada: la ficha sigue completa sin ellos.
class MaintenancePlansSection extends ConsumerWidget {
  const MaintenancePlansSection({required this.assetId, super.key});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(maintenancePlansProvider(assetId)).value;
    if (plans == null || plans.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.assetMaintenancePlans,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final plan in plans) _PlanTile(plan),
      ],
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile(this.plan);

  final MaintenancePlan plan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unit = plan.frequencyUnit == 'months'
        ? l10n.planUnitMonths
        : l10n.planUnitDays;
    return Card(
      child: ListTile(
        title: Text(maintenanceTypeLabel(l10n, plan.type)),
        subtitle: Text(
          [
            l10n.planEvery(plan.frequencyValue ?? 0, unit),
            if (plan.nextDate != null)
              l10n.planNext(AppFormat.date(plan.nextDate!)),
            if (!plan.isActive) l10n.planInactive,
          ].join(' · '),
        ),
      ),
    );
  }
}
