import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Error de carga con acción de reintento (estado obligatorio en pantallas
/// de datos, CLAUDE.md §6).
class ErrorState extends ConsumerWidget {
  const ErrorState({required this.error, required this.onRetry, super.key});

  /// Error capturado; si no es un [ApiException] se muestra el genérico.
  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final apiError = error is ApiException ? error as ApiException : null;
    return EmptyState(
      icon: Icons.error_outline,
      message: ApiErrorMessage.of(l10n, apiError, isProd: isProd),
      actionLabel: l10n.actionRetry,
      onAction: onRetry,
    );
  }
}
