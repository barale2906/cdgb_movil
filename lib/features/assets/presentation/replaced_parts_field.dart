import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Repuestos cambiados en un mantenimiento: lista con alta y baja.
class ReplacedPartsField extends StatelessWidget {
  const ReplacedPartsField({
    required this.parts,
    required this.onChanged,
    super.key,
  });

  final List<ReplacedPart> parts;
  final ValueChanged<List<ReplacedPart>> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.maintenanceParts,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        for (var i = 0; i < parts.length; i++)
          Card(
            child: ListTile(
              title: Text(parts[i].name),
              subtitle: Text(
                l10n.orderQuantity(AppFormat.decimal(parts[i].quantity ?? 1)),
              ),
              trailing: IconButton(
                tooltip: l10n.maintenancePartRemove,
                icon: const Icon(Icons.delete_outline),
                onPressed: () => onChanged([...parts]..removeAt(i)),
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        BojaniButton(
          label: l10n.maintenancePartAdd,
          icon: Icons.add,
          kind: BojaniButtonKind.secondary,
          onPressed: () => unawaited(_add(context)),
        ),
      ],
    );
  }

  Future<void> _add(BuildContext context) async {
    final part = await showDialog<ReplacedPart>(
      context: context,
      builder: (_) => const _PartDialog(),
    );
    if (part != null) onChanged([...parts, part]);
  }
}

class _PartDialog extends StatefulWidget {
  const _PartDialog();

  @override
  State<_PartDialog> createState() => _PartDialogState();
}

class _PartDialogState extends State<_PartDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _quantity = TextEditingController(text: '1');
  final _cost = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    _cost.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.maintenancePartAdd),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: l10n.maintenancePartName,
                ),
                validator: (v) =>
                    (v ?? '').trim().isEmpty ? l10n.validationRequired : null,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _quantity,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: l10n.fieldQuantity),
                validator: (v) {
                  final number = AppFormat.parseDecimal(v);
                  return number == null || number <= 0
                      ? l10n.validationPositive
                      : null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _cost,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: l10n.maintenanceCost),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(AppSpacing.md),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        BojaniButton(
          label: l10n.actionSave,
          onPressed: () {
            if (!(_formKey.currentState?.validate() ?? false)) return;
            Navigator.of(context).pop(
              ReplacedPart(
                name: _name.text.trim(),
                quantity: AppFormat.parseDecimal(_quantity.text),
                cost: AppFormat.parseDecimal(_cost.text),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        BojaniButton(
          label: l10n.actionCancel,
          kind: BojaniButtonKind.tertiary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
