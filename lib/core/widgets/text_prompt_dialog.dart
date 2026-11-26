import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Pide un texto (comentarios, motivo). Devuelve el texto escrito, o `null`
/// si la persona cancela. Con [required] no deja continuar sin escribir.
Future<String?> promptText(
  BuildContext context, {
  required String title,
  required String confirmLabel,
  required String fieldLabel,
  bool destructive = false,
  bool required = false,
}) => showDialog<String>(
  context: context,
  builder: (_) => _TextPromptDialog(
    title: title,
    confirmLabel: confirmLabel,
    fieldLabel: fieldLabel,
    destructive: destructive,
    required: required,
  ),
);

class _TextPromptDialog extends StatefulWidget {
  const _TextPromptDialog({
    required this.title,
    required this.confirmLabel,
    required this.fieldLabel,
    required this.destructive,
    required this.required,
  });

  final String title;
  final String confirmLabel;
  final String fieldLabel;
  final bool destructive;
  final bool required;

  @override
  State<_TextPromptDialog> createState() => _TextPromptDialogState();
}

class _TextPromptDialogState extends State<_TextPromptDialog> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          maxLines: 3,
          decoration: InputDecoration(labelText: widget.fieldLabel),
          validator: (value) => widget.required && (value ?? '').trim().isEmpty
              ? l10n.validationRequired
              : null,
        ),
      ),
      actionsPadding: const EdgeInsets.all(AppSpacing.md),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        BojaniButton(
          label: widget.confirmLabel,
          kind: widget.destructive
              ? BojaniButtonKind.destructive
              : BojaniButtonKind.primary,
          onPressed: _confirm,
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
