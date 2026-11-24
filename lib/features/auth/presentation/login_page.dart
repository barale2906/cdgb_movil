import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_brand_mark.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/auth/application/auth_controllers.dart';
import 'package:sga_bojanini/features/auth/application/validators.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final ok = await ref
        .read(loginControllerProvider.notifier)
        .submit(email: _email.text, password: _password.text);
    // Al fallar se limpia la contraseña; el router lleva a Inicio si entró.
    if (!ok) _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(loginControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final notice = _noticeFor(l10n, ref.watch(sessionControllerProvider));
    final error = submission.error;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.dark),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSizes.loginCardMaxWidth,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sheet),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: AutofillGroup(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Center(
                              child: AppBrandMark(size: AppBrandMarkSize.large),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              l10n.loginTitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              l10n.loginSubtitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            if (notice != null) ...[
                              const SizedBox(height: AppSpacing.md),
                              AlertBanner(
                                message: notice,
                                kind: StatusKind.info,
                              ),
                            ],
                            const SizedBox(height: AppSpacing.lg),
                            BojaniTextField(
                              label: l10n.fieldEmail,
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.username],
                              enabled: !submission.isSubmitting,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              ],
                              validator: (value) =>
                                  Validators.email(l10n, value),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            BojaniTextField(
                              label: l10n.fieldPassword,
                              controller: _password,
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              autofillHints: const [AutofillHints.password],
                              enabled: !submission.isSubmitting,
                              onFieldSubmitted: (_) => _submit(),
                              validator: (value) =>
                                  Validators.requiredPassword(l10n, value),
                            ),
                            if (error != null) ...[
                              const SizedBox(height: AppSpacing.md),
                              AlertBanner(
                                message: _errorMessage(l10n, error, isProd),
                                kind: StatusKind.error,
                                icon: Icons.error_outline,
                              ),
                            ],
                            const SizedBox(height: AppSpacing.lg),
                            BojaniButton(
                              label: l10n.loginButton,
                              isLoading: submission.isSubmitting,
                              onPressed: _submit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// El 401 y el 409 del login traen un mensaje apto para el usuario.
  String _errorMessage(
    AppLocalizations l10n,
    ApiException error,
    bool isProd,
  ) => ApiErrorMessage.loginMessage(l10n, error, isProd: isProd);

  String? _noticeFor(AppLocalizations l10n, SessionState session) {
    if (session is! SessionUnauthenticated) return null;
    return switch (session.reason) {
      SessionEndReason.expired => l10n.sessionEndedExpired,
      SessionEndReason.accountDisabled => l10n.sessionEndedAccountDisabled,
      SessionEndReason.shiftEnded => l10n.sessionEndedShift,
      null => null,
    };
  }
}
