import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/navigation/app_section_label.dart';
import 'package:sga_bojanini/core/navigation/menu_provider.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Destino "Más": secciones que no caben en la barra inferior y accesos al
/// perfil.
class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  static const path = '/more';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sections = ref.watch(navigationPlanProvider).value?.more ?? const [];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        for (final section in sections)
          ListTile(
            minTileHeight: AppSizes.minTouchTarget,
            leading: Icon(section.icon),
            title: Text(section.label(l10n)),
            onTap: () => context.go(section.path),
          ),
        if (sections.isNotEmpty) const Divider(),
        ListTile(
          minTileHeight: AppSizes.minTouchTarget,
          leading: const Icon(Icons.person_outline),
          title: Text(l10n.profileTitle),
          onTap: () => context.push(Routes.profile),
        ),
      ],
    );
  }
}
