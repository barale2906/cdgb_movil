import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Diálogo de confirmación con botones apilados a todo el ancho.
/// Devuelve `true` solo si el usuario confirma.
abstract final class ConfirmDialog {
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    bool destructive = false,
  }) async {
    final l10n = AppLocalizations.of(context);
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actionsPadding: const EdgeInsets.all(AppSpacing.md),
        actionsOverflowDirection: VerticalDirection.down,
        actions: [
          BojaniButton(
            label: confirmLabel,
            kind: destructive
                ? BojaniButtonKind.destructive
                : BojaniButtonKind.primary,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.actionCancel,
            kind: BojaniButtonKind.tertiary,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
