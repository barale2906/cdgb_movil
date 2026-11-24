import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/auth/application/signature_controllers.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Muestra el PIN una sola vez; obliga a confirmar que se anotó.
Future<void> showPinDialog(BuildContext context, String pin) {
  final l10n = AppLocalizations.of(context);
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(l10n.signaturePinTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.signaturePinBody),
            const SizedBox(height: AppSpacing.md),
            Semantics(
              label: pin.split('').join(' '),
              child: ExcludeSemantics(
                child: Text(
                  pin,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontFamilyFallback: const ['monospace'],
                    letterSpacing: AppSpacing.sm,
                  ),
                ),
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.all(AppSpacing.md),
        actions: [
          BojaniButton(
            label: l10n.signaturePinConfirm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ),
  );
}

/// Pide la contraseña y genera un PIN nuevo; si sale bien lo muestra.
Future<void> regeneratePinFlow(BuildContext context) async {
  final pin = await showDialog<String>(
    context: context,
    builder: (_) => const _RegeneratePinDialog(),
  );
  if (pin != null && context.mounted) await showPinDialog(context, pin);
}

class _RegeneratePinDialog extends ConsumerStatefulWidget {
  const _RegeneratePinDialog();

  @override
  ConsumerState<_RegeneratePinDialog> createState() =>
      _RegeneratePinDialogState();
}

class _RegeneratePinDialogState extends ConsumerState<_RegeneratePinDialog> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final result = await ref
        .read(regeneratePinControllerProvider.notifier)
        .submit(_password.text);
    if (result?.pin != null && mounted) Navigator.of(context).pop(result!.pin);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(regeneratePinControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final error = submission.error;
    final fieldError = error is ValidationException
        ? error.firstErrorFor('current_password')
        : null;

    return AlertDialog(
      title: Text(l10n.signaturePinRegenerate),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.signaturePinRegenerateBody),
            const SizedBox(height: AppSpacing.md),
            BojaniTextField(
              label: l10n.fieldPassword,
              controller: _password,
              isPassword: true,
              errorText: fieldError,
              validator: (v) =>
                  (v ?? '').isEmpty ? l10n.validationPasswordRequired : null,
              onFieldSubmitted: (_) => _submit(),
            ),
            if (error != null && fieldError == null) ...[
              const SizedBox(height: AppSpacing.md),
              AlertBanner(
                message: ApiErrorMessage.of(l10n, error, isProd: isProd),
                kind: StatusKind.error,
              ),
            ],
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.all(AppSpacing.md),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        BojaniButton(
          label: l10n.signaturePinRegenerate,
          isLoading: submission.isSubmitting,
          onPressed: _submit,
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
