import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/auth/application/auth_controllers.dart';
import 'package:sga_bojanini/features/auth/application/validators.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final l10n = AppLocalizations.of(context);
    final ok = await ref
        .read(changePasswordControllerProvider.notifier)
        .submit(currentPassword: _current.text, newPassword: _new.text);
    if (!ok || !mounted) return;
    AppSnackbar.show(context, l10n.passwordChanged);
    unawaited(Navigator.of(context).maybePop());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(changePasswordControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final canWrite = ref.watch(canWriteProvider);
    final error = submission.error;
    final validation = error is ValidationException ? error : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.changePasswordTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BojaniTextField(
                        label: l10n.fieldCurrentPassword,
                        controller: _current,
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                        enabled: !submission.isSubmitting,
                        errorText: validation?.firstErrorFor(
                          'current_password',
                        ),
                        validator: (value) =>
                            Validators.requiredPassword(l10n, value),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      BojaniTextField(
                        label: l10n.fieldNewPassword,
                        controller: _new,
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                        enabled: !submission.isSubmitting,
                        errorText: validation?.firstErrorFor('new_password'),
                        validator: (value) => Validators.newPassword(
                          l10n,
                          value,
                          currentPassword: _current.text,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      BojaniTextField(
                        label: l10n.fieldConfirmPassword,
                        controller: _confirm,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        enabled: !submission.isSubmitting,
                        onFieldSubmitted: (_) => _submit(),
                        validator: (value) => Validators.confirmation(
                          l10n,
                          value,
                          original: _new.text,
                        ),
                      ),
                      if (error != null && validation == null) ...[
                        const SizedBox(height: AppSpacing.md),
                        AlertBanner(
                          message: ApiErrorMessage.of(
                            l10n,
                            error,
                            isProd: isProd,
                          ),
                          kind: StatusKind.error,
                          icon: Icons.error_outline,
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      BojaniButton(
                        label: l10n.actionSave,
                        isLoading: submission.isSubmitting,
                        onPressed: canWrite ? _submit : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
