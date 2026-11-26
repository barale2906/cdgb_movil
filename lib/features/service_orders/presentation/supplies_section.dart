import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/service_orders/application/new_order_controller.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_paths.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Insumos de un procedimiento: salen del inventario al crear la orden, todos
/// del mismo almacén.
class SuppliesSection extends ConsumerWidget {
  const SuppliesSection({required this.line, required this.enabled, super.key});

  final OrderLine line;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(newOrderProvider.notifier);
    final warehouses = ref.watch(warehousesProvider);
    final activeId = ref.watch(activeWarehouseProvider)?.id;

    Future<void> add() async {
      final product = await context.push<GenericProduct>(
        OrderPaths.product,
      );
      if (product == null) return;
      notifier.addSupply(line.key, product);
      // Primer insumo: propone el almacén activo.
      if (line.warehouseId == null && activeId != null) {
        notifier.setWarehouse(line.key, activeId);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.serviceOrderSupplies,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        if (line.supplies.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          AsyncOptionDropdown<int>(
            label: l10n.serviceOrderSupplyWarehouse,
            options: warehouses.whenData(
              (items) => [for (final item in items) item.id],
            ),
            labelOf: (id) =>
                warehouses.value
                    ?.where((w) => w.id == id)
                    .map((w) => w.name)
                    .firstOrNull ??
                '$id',
            value: line.warehouseId,
            onChanged: (id) => notifier.setWarehouse(line.key, id),
            onRetry: () => ref.invalidate(warehousesProvider),
            validator: (id) =>
                id == null ? l10n.serviceOrderSupplyWarehouseRequired : null,
          ),
          Text(
            l10n.serviceOrderSupplyNote,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          for (final supply in line.supplies)
            _SupplyRow(
              key: ValueKey(supply.key),
              lineKey: line.key,
              supply: supply,
              enabled: enabled,
            ),
        ],
        BojaniButton(
          label: l10n.serviceOrderAddSupply,
          icon: Icons.add,
          kind: BojaniButtonKind.tertiary,
          onPressed: enabled ? () => unawaited(add()) : null,
        ),
      ],
    );
  }
}

class _SupplyRow extends ConsumerStatefulWidget {
  const _SupplyRow({
    required this.lineKey,
    required this.supply,
    required this.enabled,
    super.key,
  });

  final int lineKey;
  final SupplyDraft supply;
  final bool enabled;

  @override
  ConsumerState<_SupplyRow> createState() => _SupplyRowState();
}

class _SupplyRowState extends ConsumerState<_SupplyRow> {
  late final TextEditingController _quantity = TextEditingController(
    text: widget.supply.quantity == null
        ? ''
        : AppFormat.decimal(widget.supply.quantity!, maxDecimals: 4),
  );

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(newOrderProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Text(widget.supply.product.name),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: BojaniTextField(
              label: l10n.serviceOrderSupplyQuantity,
              controller: _quantity,
              enabled: widget.enabled,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ],
              validator: (value) => (AppFormat.parseDecimal(value) ?? 0) > 0
                  ? null
                  : l10n.validationPositive,
              onChanged: (value) => notifier.setSupplyQuantity(
                widget.lineKey,
                widget.supply.key,
                AppFormat.parseDecimal(value),
              ),
            ),
          ),
          IconButton(
            tooltip: l10n.removeItem,
            constraints: const BoxConstraints(
              minWidth: AppSizes.minTouchTarget,
              minHeight: AppSizes.minTouchTarget,
            ),
            icon: const Icon(Icons.delete_outline),
            onPressed: widget.enabled
                ? () => notifier.removeSupply(widget.lineKey, widget.supply.key)
                : null,
          ),
        ],
      ),
    );
  }
}
