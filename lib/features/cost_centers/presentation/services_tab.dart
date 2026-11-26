import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/cost_centers/application/cost_centers_providers.dart';
import 'package:sga_bojanini/features/cost_centers/data/medical_service_node.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Servicios médicos con sus procedimientos; con `procedimientos.ver`, tocar
/// un procedimiento muestra sus tarifas.
class ServicesTab extends ConsumerWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tree = ref.watch(serviceTreeProvider);
    return tree.when(
      skipLoadingOnReload: true,
      loading: () => const SkeletonList(),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(serviceTreeProvider),
      ),
      data: (services) => services.isEmpty
          ? EmptyState(
              icon: Icons.medical_services_outlined,
              message: l10n.servicesEmpty,
            )
          : RefreshIndicator(
              onRefresh: () => ref.refresh(serviceTreeProvider.future),
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: services.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) =>
                    _ServiceTile(service: services[index]),
              ),
            ),
    );
  }
}

class _ServiceTile extends ConsumerWidget {
  const _ServiceTile({required this.service});

  final MedicalServiceNode service;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSeePrices = ref.watch(
      permissionServiceProvider.select((p) => p.can('procedimientos.ver')),
    );
    return Card(
      child: ExpansionTile(
        title: Text(service.name),
        subtitle: service.code == null ? null : Text(service.code!),
        shape: const Border(),
        children: [
          for (final procedure in service.children)
            ListTile(
              minTileHeight: AppSizes.minTouchTarget,
              title: Text(procedure.name),
              subtitle: procedure.code == null ? null : Text(procedure.code!),
              trailing: canSeePrices ? const Icon(Icons.chevron_right) : null,
              onTap: canSeePrices
                  ? () => _showPrices(context, procedure)
                  : null,
            ),
        ],
      ),
    );
  }

  void _showPrices(BuildContext context, MedicalServiceNode procedure) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => _PricesSheet(procedure: procedure),
      ),
    );
  }
}

class _PricesSheet extends ConsumerWidget {
  const _PricesSheet({required this.procedure});

  final MedicalServiceNode procedure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final prices = ref.watch(procedurePricesProvider(procedure.id));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.servicePricesTitle(procedure.name),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            prices.when(
              loading: () => const Skeleton(height: AppSizes.minTouchTarget),
              error: (error, _) => Text(l10n.errorGeneric),
              data: (items) => items.isEmpty
                  ? Text(l10n.servicePricesEmpty)
                  : Column(
                      children: [for (final price in items) _PriceRow(price)],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow(this.price);

  final ProcedurePrice price;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final from = price.effectiveFrom;
    final until = price.effectiveTo;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        price.unitPrice == null ? '-' : AppFormat.cop(price.unitPrice!),
      ),
      subtitle: Text(
        [
          if (from != null) l10n.servicePriceFrom(AppFormat.date(from)),
          if (until != null) l10n.servicePriceUntil(AppFormat.date(until)),
        ].join(' '),
      ),
      trailing: price.isCurrentlyValid
          ? StatusChip(
              label: l10n.servicePriceCurrent,
              kind: StatusKind.success,
              icon: Icons.check_circle_outline,
            )
          : null,
    );
  }
}
