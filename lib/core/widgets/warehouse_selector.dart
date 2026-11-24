import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_summary.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Selector global del almacén activo para la barra superior. Con un solo
/// almacén asignado solo muestra el nombre; sin almacenes no aparece.
class WarehouseSelector extends ConsumerWidget {
  const WarehouseSelector({super.key});

  static const _maxLabelWidth = 150.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final warehouses = ref.watch(warehousesProvider).value ?? const [];
    if (warehouses.isEmpty) return const SizedBox.shrink();

    final active = ref.watch(activeWarehouseProvider);
    final label = active?.name ?? l10n.warehouseNone;
    final canChoose = warehouses.length > 1;

    return Semantics(
      button: canChoose,
      label: canChoose ? l10n.warehouseSelectorHint : null,
      child: TextButton.icon(
        onPressed: canChoose ? () => _choose(context, ref, warehouses) : null,
        icon: const Icon(Icons.warehouse_outlined, size: AppSizes.iconCompact),
        label: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxLabelWidth),
          child: Text(label, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }

  Future<void> _choose(
    BuildContext context,
    WidgetRef ref,
    List<WarehouseSummary> warehouses,
  ) async {
    final l10n = AppLocalizations.of(context);
    final activeId = ref.read(activeWarehouseProvider)?.id;
    final selected = await showModalBottomSheet<int>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                l10n.warehouseSelectTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final warehouse in warehouses)
              ListTile(
                title: Text(warehouse.name),
                subtitle: warehouse.code == null ? null : Text(warehouse.code!),
                selected: warehouse.id == activeId,
                trailing: warehouse.id == activeId
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => Navigator.of(context).pop(warehouse.id),
              ),
          ],
        ),
      ),
    );
    if (selected != null) {
      await ref.read(activeWarehouseIdProvider.notifier).select(selected);
    }
  }
}
