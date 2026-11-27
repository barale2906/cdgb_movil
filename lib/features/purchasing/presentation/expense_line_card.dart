import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/features/purchasing/application/expense_draft_controller.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class ExpenseLineCard extends ConsumerStatefulWidget {
  const ExpenseLineCard({
    required this.line,
    required this.enabled,
    required this.provider,
    required this.canRemove,
    super.key,
  });

  final ExpenseLine line;
  final bool enabled;
  final NotifierProvider<ExpenseDraftNotifier, ExpenseDraftState> provider;
  final bool canRemove;

  @override
  ConsumerState<ExpenseLineCard> createState() => _ExpenseLineCardState();
}

class _ExpenseLineCardState extends ConsumerState<ExpenseLineCard> {
  late final _description = TextEditingController(
    text: widget.line.description,
  );
  late final _unit = TextEditingController(text: widget.line.unit);
  late final _quantity = TextEditingController(
    text: AppFormat.plain(widget.line.quantity),
  );
  late final _price = TextEditingController(
    text: AppFormat.plain(widget.line.unitPrice),
  );
  late final _tax = TextEditingController(
    text: AppFormat.plain(widget.line.taxRate),
  );

  @override
  void dispose() {
    for (final c in [_description, _unit, _quantity, _price, _tax]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(widget.provider.notifier);
    final key = widget.line.key;
    final enabled = widget.enabled;
    String? required(String? value) =>
        (value ?? '').trim().isEmpty ? l10n.validationRequired : null;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BojaniTextField(
              label: l10n.draftDescription,
              controller: _description,
              enabled: enabled,
              validator: required,
              onChanged: (v) =>
                  notifier.update(key, (l) => l.copyWith(description: v)),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BojaniTextField(
                    label: l10n.draftUnit,
                    controller: _unit,
                    enabled: enabled,
                    validator: required,
                    onChanged: (v) =>
                        notifier.update(key, (l) => l.copyWith(unit: v)),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: BojaniTextField(
                    label: l10n.draftQuantity,
                    controller: _quantity,
                    enabled: enabled,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                    validator: (v) => (AppFormat.parseDecimal(v) ?? 0) >= 0.001
                        ? null
                        : l10n.validationPositive,
                    onChanged: (v) => notifier.update(
                      key,
                      (l) => l.copyWith(
                        quantity: () => AppFormat.parseDecimal(v),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BojaniTextField(
                    label: l10n.draftUnitPrice,
                    controller: _price,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) => double.tryParse(v ?? '') == null
                        ? l10n.validationRequired
                        : null,
                    onChanged: (v) => notifier.update(
                      key,
                      (l) => l.copyWith(unitPrice: () => double.tryParse(v)),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: BojaniTextField(
                    label: l10n.draftTaxRate,
                    controller: _tax,
                    enabled: enabled,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                    validator: (v) {
                      final rate = AppFormat.parseDecimal(v);
                      return (v ?? '').isEmpty ||
                              (rate != null && rate >= 0 && rate <= 100)
                          ? null
                          : l10n.draftTaxInvalid;
                    },
                    onChanged: (v) => notifier.update(
                      key,
                      (l) => l.copyWith(
                        taxRate: () => AppFormat.parseDecimal(v),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (widget.canRemove)
              BojaniButton(
                label: l10n.removeItem,
                icon: Icons.delete_outline,
                kind: BojaniButtonKind.tertiary,
                expand: false,
                onPressed: enabled ? () => notifier.removeLine(key) : null,
              ),
          ],
        ),
      ),
    );
  }
}
