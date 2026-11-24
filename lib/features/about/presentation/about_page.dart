import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/app_typography.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';
import 'package:sga_bojanini/core/widgets/app_brand_mark.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// "Acerca de": muestra ambiente y servidor activos. En la fase 0 es la
/// pantalla inicial, para verificar a qué backend apunta cada build.
class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final environment = ref.watch(appEnvironmentProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            const SizedBox(height: AppSpacing.lg),
            const Center(child: AppBrandMark(size: AppBrandMarkSize.large)),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.appTitle,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.brandSubtitle,
              textAlign: TextAlign.center,
              style: AppTypography.brandSubtitle,
            ),
            const SizedBox(height: AppSpacing.lg),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(
                      label: l10n.aboutEnvironment,
                      child: _EnvironmentChip(env: environment.env),
                    ),
                    const Divider(height: AppSpacing.lg),
                    _InfoRow(
                      label: l10n.aboutServer,
                      child: SelectableText(
                        environment.apiBaseUrl.toString(),
                        style: AppTypography.code,
                      ),
                    ),
                    const Divider(height: AppSpacing.lg),
                    _InfoRow(
                      label: l10n.aboutUpdates,
                      child: Text(
                        environment.updateUrl?.toString() ??
                            l10n.aboutUpdatesDisabled,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    const Divider(height: AppSpacing.lg),
                    Text(
                      l10n.aboutSessionPolicy(
                        environment.inactivityLockMinutes,
                        environment.sessionMaxHours,
                      ),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.setupInProgress,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Theme.of(context).textTheme.labelMedium),
      const SizedBox(height: AppSpacing.xs),
      child,
    ],
  );
}

class _EnvironmentChip extends StatelessWidget {
  const _EnvironmentChip({required this.env});

  final AppEnv env;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = env == AppEnv.prod
        ? context.statusColors.success
        : context.statusColors.warning;
    final label = env == AppEnv.prod ? l10n.envProd : l10n.envDev;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: palette.chip,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: palette.chipText),
      ),
    );
  }
}
