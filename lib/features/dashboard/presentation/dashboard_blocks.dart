import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/charts.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/dashboard/application/dashboard_providers.dart';
import 'package:sga_bojanini/features/dashboard/data/dashboard_models.dart';
import 'package:sga_bojanini/features/dashboard/presentation/dashboard_card.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

String _int(num value) => AppFormat.decimal(value, maxDecimals: 0);

class InventoryBlock extends ConsumerWidget {
  const InventoryBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final colors = context.statusColors;
    return DashboardCard<InventoryDashboard>(
      title: l10n.dashInventory,
      value: ref.watch(inventoryDashboardProvider),
      onRetry: () => ref.invalidate(inventoryDashboardProvider),
      onTap: () => context.go('/inventory'),
      builder: (context, data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.md,
            children: [
              StatTile(
                label: l10n.dashProducts,
                value: _int(data.totalProducts),
              ),
              StatTile(label: l10n.dashUnits, value: _int(data.totalUnits)),
              StatTile(
                label: l10n.dashMovementsToday,
                value: _int(data.movementsToday),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.dashStockHealth,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          SegmentedBar(
            segments: [
              BarSegment(
                label: l10n.dashStockOk,
                value: data.stockOkCount,
                color: colors.success.icon,
              ),
              BarSegment(
                label: l10n.dashStockLow,
                value: data.stockLowCount,
                color: colors.warning.icon,
              ),
              BarSegment(
                label: l10n.dashStockCritical,
                value: data.stockCriticalCount,
                color: colors.error.icon,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.dashExpiring,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              StatusChip(
                label: '${l10n.dashExpiringToday}: ${_int(data.expiringToday)}',
                kind: data.expiringToday > 0
                    ? StatusKind.error
                    : StatusKind.success,
              ),
              StatusChip(
                label: '${l10n.dashExpiring7}: ${_int(data.expiring7Days)}',
                kind: data.expiring7Days > 0
                    ? StatusKind.warning
                    : StatusKind.success,
              ),
              StatusChip(
                label: '${l10n.dashExpiring30}: ${_int(data.expiring30Days)}',
                kind: data.expiring30Days > 0
                    ? StatusKind.info
                    : StatusKind.success,
              ),
            ],
          ),
          if (data.topConsumedProducts.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.dashTopConsumed,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            BarList(
              items: [
                for (final product in data.topConsumedProducts.take(5))
                  BarItem(
                    label: product.name,
                    value: product.totalConsumed ?? 0,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class PurchasingBlock extends ConsumerWidget {
  const PurchasingBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return DashboardCard<PurchasingDashboard>(
      title: l10n.dashPurchasing,
      value: ref.watch(purchasingDashboardProvider),
      onRetry: () => ref.invalidate(purchasingDashboardProvider),
      onTap: () => context.go('/purchasing'),
      builder: (context, data) => Wrap(
        spacing: AppSpacing.lg,
        runSpacing: AppSpacing.md,
        children: [
          StatTile(
            label: l10n.dashPendingOrders,
            value: _int(data.pendingOrders),
          ),
          StatTile(
            label: l10n.dashApprovedOrders,
            value: _int(data.approvedOrders),
          ),
          StatTile(
            label: l10n.dashMonthTotal,
            value: AppFormat.cop(data.totalMonth ?? 0),
          ),
        ],
      ),
    );
  }
}

class MonitoringBlock extends ConsumerWidget {
  const MonitoringBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return DashboardCard<MonitoringDashboard>(
      title: l10n.dashMonitoring,
      value: ref.watch(monitoringDashboardProvider),
      onRetry: () => ref.invalidate(monitoringDashboardProvider),
      onTap: () => context.go('/monitoring'),
      builder: (context, data) => Wrap(
        spacing: AppSpacing.lg,
        runSpacing: AppSpacing.md,
        children: [
          StatTile(
            label: l10n.dashActiveSensors,
            value: _int(data.activeSensors),
          ),
          StatTile(label: l10n.dashAlertsToday, value: _int(data.alertsToday)),
          StatTile(
            label: l10n.dashReadingsToday,
            value: _int(data.readingsToday),
          ),
        ],
      ),
    );
  }
}

class AlertsBlock extends ConsumerWidget {
  const AlertsBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return DashboardCard<List<DashboardAlert>>(
      title: l10n.dashAlerts,
      value: ref.watch(alertsDashboardProvider),
      onRetry: () => ref.invalidate(alertsDashboardProvider),
      onTap: () => context.push('/notifications'),
      builder: (context, alerts) => alerts.isEmpty
          ? Text(l10n.dashNoAlerts)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final alert in alerts.take(5))
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            StatusChip(
                              label: _severityLabel(l10n, alert.severity),
                              kind: _severityKind(alert.severity),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                alert.title,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                        if (alert.message.isNotEmpty) Text(alert.message),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  static StatusKind _severityKind(String severity) => switch (severity) {
    'critical' || 'error' => StatusKind.error,
    'warning' => StatusKind.warning,
    'success' => StatusKind.success,
    _ => StatusKind.info,
  };

  static String _severityLabel(AppLocalizations l10n, String severity) =>
      switch (severity) {
        'critical' || 'error' => l10n.severityCritical,
        'warning' => l10n.severityWarning,
        'success' => l10n.severitySuccess,
        _ => l10n.severityInfo,
      };
}

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
