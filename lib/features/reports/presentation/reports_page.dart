import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/features/reports/presentation/report_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Catálogo de reportes (cada uno con su permiso) y acceso a las
/// exportaciones propias.
class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final permissions = ref.watch(permissionServiceProvider);
    final available = ReportType.values.where(
      (type) =>
          type.extraPermission == null ||
          permissions.can(type.extraPermission!),
    );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          l10n.reportsCatalogTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final type in available)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Card(
              child: ListTile(
                minTileHeight: AppSizes.minTouchTarget,
                leading: Icon(type.icon),
                title: Text(type.label(l10n)),
                subtitle: Text(type.hint(l10n)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/reports/${type.path}'),
              ),
            ),
          ),
        const Divider(height: AppSpacing.lg),
        Card(
          child: ListTile(
            minTileHeight: AppSizes.minTouchTarget,
            leading: const Icon(Icons.download_for_offline_outlined),
            title: Text(l10n.reportsMyExports),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/reports/exports'),
          ),
        ),
      ],
    );
  }
}
