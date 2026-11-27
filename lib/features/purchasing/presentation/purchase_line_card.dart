import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/features/purchasing/application/purchase_draft_controller.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class PurchaseLineCard extends ConsumerStatefulWidget {
  const PurchaseLineCard({
    required this.line,
    required this.enabled,
    required this.provider,
    super.key,
  });

  final PurchaseLine line;
  final bool enabled;
  final NotifierProvider<PurchaseDraftNotifier, PurchaseDraftState> provider;

  @override
  ConsumerState<PurchaseLineCard> createState() => _PurchaseLineCardState();
}

class _PurchaseLineCardState extends ConsumerState<PurchaseLineCard> {
  late final _quantity = TextEditingController(
    text: widget.line.quantity?.toString() ?? '',
  );
  late final _price = TextEditingController(
    text: AppFormat.plain(widget.line.unitPrice),
  );
  late final _tax = TextEditingController(
    text: AppFormat.plain(widget.line.taxRate),
  );

  @override
  void dispose() {
    for (final c in [_quantity, _price, _tax]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final notifier = ref.read(widget.provider.notifier);
    final line = widget.line;
    final enabled = widget.enabled;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(line.productName, style: textTheme.titleSmall),
            Text(
              [
                ?line.variantLabel,
                line.presentationName,
              ].join(' · '),
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BojaniTextField(
                    label: l10n.draftQuantity,
                    controller: _quantity,
                    enabled: enabled,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) => (int.tryParse(v ?? '') ?? 0) >= 1
                        ? null
                        : l10n.validationPositive,
                    onChanged: (v) => notifier.update(
                      line.key,
                      (l) => l.copyWith(quantity: () => int.tryParse(v)),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
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
                      line.key,
                      (l) => l.copyWith(unitPrice: () => double.tryParse(v)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            BojaniTextField(
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
                line.key,
                (l) => l.copyWith(taxRate: () => AppFormat.parseDecimal(v)),
              ),
            ),
            BojaniButton(
              label: l10n.removeItem,
              icon: Icons.delete_outline,
              kind: BojaniButtonKind.tertiary,
              expand: false,
              onPressed: enabled ? () => notifier.removeLine(line.key) : null,
            ),
          ],
        ),
      ),
    );
  }
}
