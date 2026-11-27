import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/service_orders/application/new_order_controller.dart';
import 'package:sga_bojanini/features/service_orders/application/order_draft.dart';
import 'package:sga_bojanini/features/service_orders/application/service_order_permissions.dart';
import 'package:sga_bojanini/features/service_orders/presentation/supplies_section.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Un procedimiento de la orden: cantidad, valor, descuento e insumos.
class OrderLineCard extends ConsumerStatefulWidget {
  const OrderLineCard({required this.line, super.key});

  final OrderLine line;

  @override
  ConsumerState<OrderLineCard> createState() => _OrderLineCardState();
}

class _OrderLineCardState extends ConsumerState<OrderLineCard> {
  late final TextEditingController _quantity = TextEditingController(
    text: widget.line.quantity?.toString() ?? '',
  );
  late final TextEditingController _price = TextEditingController(
    text: AppFormat.plain(widget.line.unitPrice),
  );
  late final TextEditingController _discount = TextEditingController(
    text: AppFormat.plain(widget.line.discountValue),
  );
  late final TextEditingController _evolution = TextEditingController(
    text: widget.line.evolution,
  );

  @override
  void didUpdateWidget(OrderLineCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // La plantilla llega después de agregar el procedimiento.
    if (widget.line.evolution != _evolution.text) {
      _evolution.text = widget.line.evolution;
    }
  }

  @override
  void dispose() {
    _quantity.dispose();
    _price.dispose();
    _discount.dispose();
    _evolution.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final line = widget.line;
    final notifier = ref.read(newOrderProvider.notifier);
    final busy = ref.watch(newOrderProvider.select((s) => s.isSubmitting));
    final canSupply = ref.watch(canAddSuppliesProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(line.procedure.name, style: textTheme.titleSmall),
                      Text(line.procedure.code, style: textTheme.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l10n.removeItem,
                  constraints: const BoxConstraints(
                    minWidth: AppSizes.minTouchTarget,
                    minHeight: AppSizes.minTouchTarget,
                  ),
                  icon: const Icon(Icons.delete_outline),
                  onPressed: busy ? null : () => notifier.removeLine(line.key),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BojaniTextField(
                    label: l10n.saleQuantity,
                    controller: _quantity,
                    enabled: !busy,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => (int.tryParse(value ?? '') ?? 0) >= 1
                        ? null
                        : l10n.validationPositive,
                    onChanged: (value) =>
                        notifier.setQuantity(line.key, int.tryParse(value)),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: BojaniTextField(
                    label: l10n.saleUnitPrice,
                    controller: _price,
                    enabled: !busy,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => double.tryParse(value ?? '') == null
                        ? l10n.validationRequired
                        : null,
                    onChanged: (value) =>
                        notifier.setUnitPrice(line.key, double.tryParse(value)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _DiscountFields(line: line, controller: _discount, enabled: !busy),
            if (canSupply) SuppliesSection(line: line, enabled: !busy),
            const SizedBox(height: AppSpacing.sm),
            _EvolutionField(line: line, controller: _evolution, enabled: !busy),
            const SizedBox(height: AppSpacing.sm),
            Text(AppFormat.cop(line.netTotal), style: textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}

class _DiscountFields extends ConsumerWidget {
  const _DiscountFields({
    required this.line,
    required this.controller,
    required this.enabled,
  });

  final OrderLine line;
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(newOrderProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.serviceOrderDiscountToggle),
          value: line.hasDiscount,
          onChanged: enabled
              ? (on) {
                  if (!on) controller.clear();
                  notifier.setDiscountKind(
                    line.key,
                    on ? DiscountKind.percentage : null,
                  );
                }
              : null,
        ),
        if (line.hasDiscount) ...[
          OptionDropdown<DiscountKind>(
            label: l10n.serviceOrderDiscountType,
            options: {
              DiscountKind.percentage: l10n.serviceOrderDiscountPercent,
              DiscountKind.fixed: l10n.serviceOrderDiscountFixed,
            },
            value: line.discountKind,
            onChanged: (kind) => notifier.setDiscountKind(line.key, kind),
          ),
          const SizedBox(height: AppSpacing.sm),
          BojaniTextField(
            label: line.discountKind == DiscountKind.percentage
                ? l10n.serviceOrderDiscountPercentValue
                : l10n.serviceOrderDiscountFixedValue,
            controller: controller,
            enabled: enabled,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (_) => line.isDiscountValid
                ? null
                : line.discountKind == DiscountKind.percentage
                ? l10n.serviceOrderDiscountPercentInvalid
                : l10n.serviceOrderDiscountInvalid,
            helperText: l10n.serviceOrderDiscountNote,
            onChanged: (value) =>
                notifier.setDiscountValue(line.key, double.tryParse(value)),
          ),
        ],
      ],
    );
  }
}

class _EvolutionField extends ConsumerWidget {
  const _EvolutionField({
    required this.line,
    required this.controller,
    required this.enabled,
  });

  final OrderLine line;
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return TextFormField(
      controller: controller,
      enabled: enabled,
      minLines: 3,
      maxLines: 8,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: l10n.orderEvolutionLabel,
        helperText: l10n.orderEvolutionHelp(maxEvolutionLength),
        counterText: l10n.orderEvolutionCounter(
          line.evolutionHtml.length,
          maxEvolutionLength,
        ),
        alignLabelWithHint: true,
      ),
      validator: (_) {
        if (line.evolutionHtml.isEmpty) return l10n.orderEvolutionRequired;
        if (!line.isEvolutionValid) {
          return l10n.orderEvolutionTooLong(maxEvolutionLength);
        }
        return null;
      },
      onChanged: (value) =>
          ref.read(newOrderProvider.notifier).setEvolution(line.key, value),
    );
  }
}
