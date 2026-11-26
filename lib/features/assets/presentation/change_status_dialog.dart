import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Estado nuevo y motivo opcional. `null` si se cancela. Se ofrecen los
/// estados que el servidor permite fijar a mano, salvo el actual.
Future<({AssetStatus status, String? reason})?> askNewStatus(
  BuildContext context, {
  required List<AssetStatus> options,
}) => showDialog<({AssetStatus status, String? reason})>(
  context: context,
  builder: (_) => _ChangeStatusDialog(options: options),
);

class _ChangeStatusDialog extends StatefulWidget {
  const _ChangeStatusDialog({required this.options});

  final List<AssetStatus> options;

  @override
  State<_ChangeStatusDialog> createState() => _ChangeStatusDialogState();
}

class _ChangeStatusDialogState extends State<_ChangeStatusDialog> {
  final _formKey = GlobalKey<FormState>();
  final _reason = TextEditingController();
  AssetStatus? _status;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.assetChangeStatus),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OptionDropdown<AssetStatus>(
                label: l10n.assetNewStatus,
                options: {
                  for (final s in widget.options) s: assetStatusLabel(l10n, s),
                },
                value: _status,
                validator: (v) => v == null ? l10n.validationRequired : null,
                onChanged: (value) => setState(() => _status = value),
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _reason,
                maxLines: 3,
                maxLength: 1000,
                decoration: InputDecoration(labelText: l10n.assetStatusReason),
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
            Navigator.of(context).pop((
              status: _status!,
              reason: _reason.text.trim(),
            ));
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
