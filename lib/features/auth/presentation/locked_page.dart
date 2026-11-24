import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_brand_mark.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/auth/application/auth_controllers.dart';
import 'package:sga_bojanini/features/auth/application/validators.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Pantalla de sesión bloqueada: pide la contraseña del mismo usuario o
/// permite cambiar de usuario. No muestra datos más allá del nombre.
class LockedPage extends ConsumerStatefulWidget {
  const LockedPage({super.key});

  @override
  ConsumerState<LockedPage> createState() => _LockedPageState();
}

class _LockedPageState extends ConsumerState<LockedPage> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _unlock() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final ok = await ref
        .read(unlockControllerProvider.notifier)
        .submit(_password.text);
    if (!ok) _password.clear();
  }

  Future<void> _switchUser() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.switchUserConfirmTitle,
      message: l10n.switchUserConfirmBody,
      confirmLabel: l10n.switchUser,
      destructive: true,
    );
    if (confirmed) await ref.read(sessionControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final submission = ref.watch(unlockControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final error = submission.error;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.loginCardMaxWidth,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: AppBrandMark(size: AppBrandMarkSize.large),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Icon(
                      Icons.lock_outline,
                      size: AppSizes.emptyStateIcon,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.lockedTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.lockedSubtitle(user?.name ?? ''),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    BojaniTextField(
                      label: l10n.fieldPassword,
                      controller: _password,
                      isPassword: true,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      enabled: !submission.isSubmitting,
                      onFieldSubmitted: (_) => _unlock(),
                      validator: (value) =>
                          Validators.requiredPassword(l10n, value),
                    ),
                    if (error != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      AlertBanner(
                        message: _message(l10n, error, isProd),
                        kind: StatusKind.error,
                        icon: Icons.error_outline,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    BojaniButton(
                      label: l10n.lockedUnlock,
                      isLoading: submission.isSubmitting,
                      onPressed: _unlock,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    BojaniButton(
                      label: l10n.switchUser,
                      kind: BojaniButtonKind.tertiary,
                      onPressed: submission.isSubmitting ? null : _switchUser,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _message(AppLocalizations l10n, ApiException error, bool isProd) =>
      error is UnauthenticatedException
      ? l10n.lockedWrongPassword
      : ApiErrorMessage.of(l10n, error, isProd: isProd);
}
