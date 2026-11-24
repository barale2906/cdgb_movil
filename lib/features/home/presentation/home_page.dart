import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/navigation/app_section_label.dart';
import 'package:sga_bojanini/core/navigation/menu_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Inicio: saludo y accesos a los módulos del usuario. El tablero con
/// indicadores llega en la fase 3.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final name = ref.watch(currentUserProvider.select((user) => user?.name));
    final plan = ref.watch(navigationPlanProvider);

    return plan.when(
      loading: () => const SkeletonList(),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(menuProvider),
      ),
      data: (plan) {
        final modules = plan.all.skip(1).toList();
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              l10n.homeGreeting(name ?? ''),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (modules.isEmpty)
              EmptyState(
                icon: Icons.lock_outline,
                message: l10n.homeNoModules,
              )
            else ...[
              Text(
                l10n.homeModules,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final section in modules)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Card(
                    child: ListTile(
                      minTileHeight: AppSizes.minTouchTarget,
                      leading: Icon(section.icon),
                      title: Text(section.label(l10n)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.go(section.path),
                    ),
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}
