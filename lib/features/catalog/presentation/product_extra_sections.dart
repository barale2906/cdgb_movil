import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/catalog/expiring_elsewhere.dart';
import 'package:sga_bojanini/core/catalog/product_providers.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/inline_error.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Lotes del producto que vencen pronto en otros almacenes. Si el usuario no
/// puede verlos, no hay ninguno o la consulta falla, no se muestra nada: la
/// ficha sigue completa sin esta sección.
class ExpiringElsewhereSection extends ConsumerWidget {
  const ExpiringElsewhereSection({required this.productId, super.key});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(otherWarehousesExpiringProvider(productId)).value;
    if (result == null || result.items.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.md),
        Text(l10n.productExpiringElsewhere, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.productExpiringElsewhereHelp(result.days),
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final batch in result.items) _ExpiringBatchTile(batch: batch),
      ],
    );
  }
}

class _ExpiringBatchTile extends StatelessWidget {
  const _ExpiringBatchTile({required this.batch});

  final ExpiringBatch batch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = batch.expirationDate;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(l10n.expiringBatchTitle(batch.lotNumber)),
        subtitle: Text(
          l10n.expiringBatchSubtitle(
            batch.warehouse?.name ?? l10n.notAvailable,
            date == null ? l10n.notAvailable : AppFormat.date(date),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(AppFormat.decimal(batch.quantity ?? 0)),
            Text(
              l10n.expiringBatchDays(batch.daysUntilExpiry),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// Proveedores de una variante. Se pide al abrir la sección (no una consulta
/// por variante al abrir la ficha) y solo con `proveedores.ver`.
class VariantSuppliers extends ConsumerWidget {
  const VariantSuppliers({required this.variantId, super.key});

  final int variantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSee = ref.watch(
      permissionServiceProvider.select((p) => p.can('proveedores.ver')),
    );
    if (!canSee) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          l10n.variantSuppliers,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        // Los hijos se construyen al abrir: la consulta se hace entonces.
        children: [_SupplierList(variantId: variantId)],
      ),
    );
  }
}

class _SupplierList extends ConsumerWidget {
  const _SupplierList({required this.variantId});

  final int variantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final suppliers = ref.watch(variantSuppliersProvider(variantId));
    return suppliers.when(
      loading: () => const LinearProgressIndicator(),
      error: (error, _) => InlineError(
        error: error,
        onRetry: () => ref.invalidate(variantSuppliersProvider(variantId)),
      ),
      data: (items) => (items ?? const []).isEmpty
          ? Align(
              alignment: Alignment.centerLeft,
              child: Text(l10n.variantNoSuppliers),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final supplier in items!)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(supplier.name),
                    subtitle: supplier.taxId == null
                        ? null
                        : Text(supplier.taxId!),
                  ),
              ],
            ),
    );
  }
}
