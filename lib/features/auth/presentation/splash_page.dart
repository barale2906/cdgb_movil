import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/app_brand_mark.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Pantalla inicial mientras se verifica la sesión guardada. Si no hay
/// conexión, ofrece reintentar (sin dejar al usuario fuera de su sesión).
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: switch (session) {
          SessionRestoreFailed(:final error) => ColoredBox(
            color: AppColors.background,
            child: Column(
              children: [
                Expanded(
                  child: ErrorState(
                    error: error,
                    onRetry: () =>
                        ref.read(sessionControllerProvider.notifier).restore(),
                  ),
                ),
              ],
            ),
          ),
          _ => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppBrandMark(size: AppBrandMarkSize.large),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: AppSizes.icon,
                  height: AppSizes.icon,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                    semanticsLabel: l10n.loading,
                  ),
                ),
              ],
            ),
          ),
        },
      ),
    );
  }
}
