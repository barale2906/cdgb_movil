import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/features/dashboard/data/dashboard_models.dart';
import 'package:sga_bojanini/features/dashboard/data/dashboard_repository.dart';

final FutureProvider<InventoryDashboard> inventoryDashboardProvider =
    FutureProvider.autoDispose<InventoryDashboard>(
      (ref) => ref.watch(dashboardRepositoryProvider).inventory(),
    );

final FutureProvider<PurchasingDashboard> purchasingDashboardProvider =
    FutureProvider.autoDispose<PurchasingDashboard>(
      (ref) => ref.watch(dashboardRepositoryProvider).purchasing(),
    );

final FutureProvider<MonitoringDashboard> monitoringDashboardProvider =
    FutureProvider.autoDispose<MonitoringDashboard>(
      (ref) => ref.watch(dashboardRepositoryProvider).monitoring(),
    );

final FutureProvider<List<ActivityEntry>> activityDashboardProvider =
    FutureProvider.autoDispose<List<ActivityEntry>>(
      (ref) => ref.watch(dashboardRepositoryProvider).activity(),
    );

final FutureProvider<List<DashboardAlert>> alertsDashboardProvider =
    FutureProvider.autoDispose<List<DashboardAlert>>(
      (ref) => ref.watch(dashboardRepositoryProvider).alerts(),
    );

/// Todos los bloques; "tirar para recargar" los invalida juntos.
void invalidateDashboard(WidgetRef ref) {
  ref
    ..invalidate(inventoryDashboardProvider)
    ..invalidate(purchasingDashboardProvider)
    ..invalidate(monitoringDashboardProvider)
    ..invalidate(activityDashboardProvider)
    ..invalidate(alertsDashboardProvider);
}
