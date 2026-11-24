import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/config/app_restart.dart';
import 'package:sga_bojanini/core/config/package_info_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/app_typography.dart';
import 'package:sga_bojanini/core/widgets/app_brand_mark.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/about/application/server_change.dart';
import 'package:sga_bojanini/features/about/presentation/server_change_dialog.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// "Acerca de": versión, ambiente y servidor activos (útil para soporte).
/// En dev permite cambiar de servidor sin recompilar.
class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final environment = ref.watch(appEnvironmentProvider);
    final version = ref.watch(packageInfoProvider).value;
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
                    if (version != null) ...[
                      _InfoRow(
                        label: l10n.aboutVersion,
                        child: Text(
                          '${version.version} (${version.buildNumber})',
                          style: AppTypography.code,
                        ),
                      ),
                      const Divider(height: AppSpacing.lg),
                    ],
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
            if (environment.isDev) ...[
              BojaniButton(
                label: l10n.aboutChangeServer,
                kind: BojaniButtonKind.secondary,
                icon: Icons.dns_outlined,
                onPressed: () => _changeServer(context, ref, environment),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            BojaniButton(
              label: l10n.aboutLicenses,
              kind: BojaniButtonKind.tertiary,
              onPressed: () => showLicensePage(
                context: context,
                applicationName: l10n.appTitle,
                applicationVersion: version?.version,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeServer(
    BuildContext context,
    WidgetRef ref,
    AppEnvironment environment,
  ) async {
    final restart = AppRestart.maybeOf(context)?.restart;
    final choice = await showServerChangeDialog(
      context,
      currentUrl: environment.apiBaseUrl.toString(),
    );
    if (choice == null) return;
    await changeServer(ref, choice.url);
    await restart?.call();
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
    return env == AppEnv.prod
        ? StatusChip(label: l10n.envProd, kind: StatusKind.success)
        : StatusChip(label: l10n.envDev, kind: StatusKind.warning);
  }
}
