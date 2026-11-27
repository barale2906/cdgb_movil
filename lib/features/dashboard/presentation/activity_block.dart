import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/features/dashboard/application/dashboard_providers.dart';
import 'package:sga_bojanini/features/dashboard/data/dashboard_models.dart';
import 'package:sga_bojanini/features/dashboard/presentation/dashboard_card.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class ActivityBlock extends ConsumerWidget {
  const ActivityBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return DashboardCard<List<ActivityEntry>>(
      title: l10n.dashActivity,
      value: ref.watch(activityDashboardProvider),
      onRetry: () => ref.invalidate(activityDashboardProvider),
      builder: (context, entries) => entries.isEmpty
          ? Text(l10n.dashNoActivity)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final entry in entries.take(6))
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          [
                            _action(l10n, entry.action),
                            _entity(entry.auditableType),
                          ].where((part) => part.isNotEmpty).join(' '),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          [
                            ?entry.userName,
                            AppFormat.dateTime(entry.createdAt),
                          ].join(' · '),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  static String _action(AppLocalizations l10n, String action) =>
      switch (action) {
        'created' => l10n.auditCreated,
        'updated' => l10n.auditUpdated,
        'deleted' => l10n.auditDeleted,
        _ => action.isEmpty ? l10n.auditUnknown : action,
      };

  /// `App\...\MovementDocumentModel` → `MovementDocument`.
  static String _entity(String? type) {
    if (type == null || type.isEmpty) return '';
    final name = type.split(r'\').last.replaceAll('Model', '');
    return name.replaceAllMapped(RegExp('(?<=[a-z])(?=[A-Z])'), (_) => ' ');
  }
}
