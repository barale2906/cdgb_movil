import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/inline_error.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/data/evolution.dart';
import 'package:sga_bojanini/features/clinical/presentation/evolution_form_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Evoluciones del registro, con agregar y editar según permisos.
class EvolutionsSection extends ConsumerWidget {
  const EvolutionsSection({required this.recordId, super.key});

  final int recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final permissions = ref.watch(permissionServiceProvider);
    if (!permissions.can('evoluciones_clinicas.ver')) {
      return const SizedBox.shrink();
    }
    final evolutions = ref.watch(recordEvolutionsProvider(recordId));
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.clinicalEvolutionsTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          evolutions.when(
            loading: () => const Skeleton(height: AppSizes.minTouchTarget),
            error: (error, _) => InlineError(
              error: error,
              onRetry: () => ref.invalidate(recordEvolutionsProvider(recordId)),
            ),
            data: (items) => items.isEmpty
                ? Text(l10n.clinicalEvolutionsEmpty)
                : Column(
                    children: [
                      for (final item in items)
                        _EvolutionTile(
                          recordId: recordId,
                          evolution: item,
                          canEdit: permissions.can(
                            'evoluciones_clinicas.editar',
                          ),
                        ),
                    ],
                  ),
          ),
          if (permissions.can('evoluciones_clinicas.crear')) ...[
            const SizedBox(height: AppSpacing.sm),
            BojaniButton(
              label: l10n.clinicalEvolutionAdd,
              icon: Icons.add,
              kind: BojaniButtonKind.secondary,
              onPressed: () =>
                  context.push(EvolutionFormPage.pathFor(recordId)),
            ),
          ],
        ],
      ),
    );
  }
}

class _EvolutionTile extends StatelessWidget {
  const _EvolutionTile({
    required this.recordId,
    required this.evolution,
    required this.canEdit,
  });

  final int recordId;
  final Evolution evolution;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final recordedAt = evolution.recordedAt;
    final author = evolution.userName;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(evolution.text),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.clinicalEvolutionBy(
                author ?? '',
                recordedAt == null ? '' : AppFormat.dateTime(recordedAt),
              ),
              style: textTheme.bodySmall,
            ),
            if (canEdit)
              BojaniButton(
                label: l10n.clinicalEvolutionEdit,
                icon: Icons.edit_outlined,
                kind: BojaniButtonKind.tertiary,
                expand: false,
                onPressed: () => context.push(
                  EvolutionFormPage.pathFor(recordId),
                  extra: evolution,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Medicamentos despachados con el procedimiento (solo lectura). Sin ellos o
/// si fallan, no se muestra nada: el detalle sigue completo.
class MedicationsSection extends ConsumerWidget {
  const MedicationsSection({required this.recordId, super.key});

  final int recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowed = ref.watch(
      permissionServiceProvider.select(
        (p) => p.can('medicamentos_procedimiento.ver'),
      ),
    );
    if (!allowed) return const SizedBox.shrink();
    final items = ref.watch(recordMedicationsProvider(recordId)).value;
    if (items == null || items.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.clinicalMedicationsTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final item in items)
            Card(
              child: ListTile(
                title: Text(item.productName),
                subtitle: Text(
                  l10n.clinicalMedicationDetail(
                    item.lotNumber ?? '-',
                    item.expirationDate == null
                        ? '-'
                        : AppFormat.date(item.expirationDate!),
                  ),
                ),
                trailing: item.quantity == null
                    ? null
                    : Text(AppFormat.decimal(item.quantity!)),
              ),
            ),
        ],
      ),
    );
  }
}
