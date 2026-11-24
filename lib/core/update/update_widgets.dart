import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/update/update_providers.dart';
import 'package:sga_bojanini/core/update/update_service.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/app_brand_mark.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Si la versión instalada ya no es compatible, reemplaza la app por una
/// pantalla bloqueante; si no, deja pasar [child].
class UpdateGate extends ConsumerWidget {
  const UpdateGate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final check = ref.watch(updateCheckProvider).value;
    final info = check?.info;
    if (check?.status == UpdateStatus.required && info != null) {
      return _UpdateRequiredPage(version: info.latest, url: info.url);
    }
    return child;
  }
}

class _UpdateRequiredPage extends ConsumerWidget {
  const _UpdateRequiredPage({required this.version, required this.url});

  final String version;
  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppBrandMark(size: AppBrandMarkSize.large),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.updateRequiredTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.updateRequiredBody(version),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                BojaniButton(
                  label: l10n.updateDownload,
                  icon: Icons.download_outlined,
                  onPressed: () =>
                      unawaited(ref.read(urlOpenerProvider)(Uri.parse(url))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Aviso descartable de versión nueva (Inicio / barra superior).
class UpdateAvailableBanner extends ConsumerWidget {
  const UpdateAvailableBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final check = ref.watch(updateCheckProvider).value;
    final info = check?.info;
    final dismissed = ref.watch(updateDismissedProvider);
    if (check?.status != UpdateStatus.available || info == null || dismissed) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: AlertBanner(
        message:
            '${l10n.updateAvailableTitle}. '
            '${l10n.updateAvailableBody(info.latest)}',
        kind: StatusKind.info,
        icon: Icons.system_update_outlined,
        actionLabel: l10n.updateDownload,
        onAction: () =>
            unawaited(ref.read(urlOpenerProvider)(Uri.parse(info.url))),
      ),
    );
  }
}
