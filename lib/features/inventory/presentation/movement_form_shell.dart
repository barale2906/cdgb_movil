import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Texto de error de una escritura. Un timeout se explica aparte: el
/// movimiento pudo haberse registrado, así que se pide revisar antes de
/// repetirlo (la API no tiene idempotencia).
String writeErrorMessage(
  AppLocalizations l10n,
  ApiException error, {
  required bool isProd,
}) {
  if (error is NetworkException && error.kind == NetworkFailureKind.timeout) {
    return l10n.movementTimeoutWarning;
  }
  return ApiErrorMessage.of(l10n, error, isProd: isProd);
}

/// Estructura común de los formularios de movimiento: aviso sin conexión,
/// contenido con scroll, error de envío y el botón principal anclado abajo.
class MovementFormShell extends ConsumerWidget {
  const MovementFormShell({
    required this.title,
    required this.submission,
    required this.onSubmit,
    required this.children,
    super.key,
  });

  final String title;
  final SubmissionState submission;
  final VoidCallback onSubmit;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final canWrite = ref.watch(canWriteProvider);
    final error = submission.error;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...children,
                    if (error != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      AlertBanner(
                        message: writeErrorMessage(l10n, error, isProd: isProd),
                        kind: StatusKind.error,
                        icon: Icons.error_outline,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: BojaniButton(
                label: l10n.submitRegister,
                isLoading: submission.isSubmitting,
                onPressed: canWrite ? onSubmit : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta de una línea ya agregada al movimiento.
class LineDraftCard extends StatelessWidget {
  const LineDraftCard({
    required this.title,
    required this.subtitle,
    required this.onRemove,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: subtitle.isEmpty ? null : Text(subtitle),
        trailing: IconButton(
          tooltip: l10n.removeItem,
          constraints: const BoxConstraints(
            minWidth: AppSizes.minTouchTarget,
            minHeight: AppSizes.minTouchTarget,
          ),
          icon: const Icon(Icons.delete_outline),
          onPressed: onRemove,
        ),
      ),
    );
  }
}

/// Encabezado de la sección de líneas con el botón "Agregar producto".
class LinesHeader extends StatelessWidget {
  const LinesHeader({
    required this.onAdd,
    super.key,
    this.errorText,
    this.enabled = true,
  });

  final VoidCallback onAdd;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.itemsTitle, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        BojaniButton(
          label: l10n.addItem,
          icon: Icons.add,
          kind: BojaniButtonKind.secondary,
          onPressed: enabled ? onAdd : null,
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
      ],
    );
  }
}

/// Hoja de captura de una línea: título, campos y botón "Agregar".
class LineSheet extends StatelessWidget {
  const LineSheet({
    required this.title,
    required this.onAdd,
    required this.child,
    super.key,
  });

  final String title;
  final VoidCallback onAdd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.md),
            child,
            const SizedBox(height: AppSpacing.lg),
            BojaniButton(label: l10n.lineAdded, onPressed: onAdd),
          ],
        ),
      ),
    );
  }
}
