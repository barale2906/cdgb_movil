import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Planes periódicos del activo. Con permiso de programar y si el activo lo
/// admite ([canEdit]) se pueden agregar y editar (no se eliminan: se
/// desactivan). Si no hay planes o la consulta falla, no se muestra nada: la
/// ficha sigue completa sin ellos.
class MaintenancePlansSection extends ConsumerWidget {
  const MaintenancePlansSection({
    required this.assetId,
    super.key,
    this.canEdit = false,
  });

  final int assetId;
  final bool canEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(maintenancePlansProvider(assetId)).value;
    final canProgram =
        canEdit &&
        ref
            .watch(permissionServiceProvider)
            .can('activos_mantenimientos.programar');
    if (plans == null || (plans.isEmpty && !canProgram)) {
      return const SizedBox.shrink();
    }
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
        for (final plan in plans)
          _PlanTile(
            plan,
            onEdit: canProgram
                ? () => unawaited(
                    context.push('/assets/$assetId/plans/${plan.id}/edit'),
                  )
                : null,
          ),
        if (canProgram)
          BojaniButton(
            label: l10n.planAdd,
            icon: Icons.add,
            kind: BojaniButtonKind.secondary,
            onPressed: () =>
                unawaited(context.push('/assets/$assetId/plans/new')),
          ),
      ],
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile(this.plan, {this.onEdit});

  final MaintenancePlan plan;
  final VoidCallback? onEdit;

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
        trailing: onEdit == null
            ? null
            : IconButton(
                tooltip: l10n.planEdit,
                icon: const Icon(Icons.edit_outlined),
                onPressed: onEdit,
              ),
      ),
    );
  }
}
