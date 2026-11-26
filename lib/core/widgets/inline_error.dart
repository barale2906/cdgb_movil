import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Error de una sección dentro de una pantalla que se desplaza, con
/// reintento manual. `ErrorState` ocupa toda la pantalla; este no.
class InlineError extends ConsumerWidget {
  const InlineError({required this.error, required this.onRetry, super.key});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    return AlertBanner(
      message: ApiErrorMessage.of(
        l10n,
        error is ApiException ? error as ApiException : null,
        isProd: isProd,
      ),
      kind: StatusKind.error,
      icon: Icons.error_outline,
      actionLabel: l10n.actionRetry,
      onAction: onRetry,
    );
  }
}
