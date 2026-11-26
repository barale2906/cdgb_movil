import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/dashboard/data/dashboard_models.dart';
import 'package:sga_bojanini/features/dashboard/data/dashboard_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  test('InventoryDashboard: claves expiring_7_days y decimales como texto', () {
    final data = InventoryDashboard.fromJson(
      fixture('dashboard/inventory_response.json')['data'] as Json,
    );
    expect(data.totalProducts, 120);
    expect(data.expiring7Days, 4, reason: 'clave expiring_7_days');
    expect(data.expiring30Days, 12);
    expect(data.stockCriticalCount, 10);
    expect(data.topConsumedProducts.first.totalConsumed, 320);
    expect(data.topConsumedProducts.last.totalConsumed, 80);
  });

  test('un tablero vacío usa ceros', () {
    final data = InventoryDashboard.fromJson(<String, dynamic>{});
    expect(data.totalUnits, 0);
    expect(data.topConsumedProducts, isEmpty);
  });

  test('Purchasing, Monitoring, Activity y Alerts (contrato)', () {
    expect(
      PurchasingDashboard.fromJson(
        fixture('dashboard/purchasing_response.json')['data'] as Json,
      ).totalMonth,
      1250000.5,
    );
    expect(
      MonitoringDashboard.fromJson(
        fixture('dashboard/monitoring_response.json')['data'] as Json,
      ).alertsToday,
      2,
    );
    final activity =
        (fixture('dashboard/activity_response.json')['data'] as List<dynamic>)
            .map((e) => ActivityEntry.fromJson(e as Json))
            .toList();
    expect(activity.first.userName, 'Usuario Prueba');
    expect(activity.last.auditableType, isNull);
    final alerts =
        (fixture('dashboard/alerts_response.json')['data'] as List<dynamic>)
            .map((e) => DashboardAlert.fromJson(e as Json))
            .toList();
    expect(alerts.single.severity, 'critical');
  });

  test('DashboardRepository pide cada bloque a su endpoint', () async {
    final adapter = FakeHttpAdapter()
      ..on(
        'GET',
        '/dashboard/inventory',
        body: fixture('dashboard/inventory_response.json'),
      )
      ..on(
        'GET',
        '/dashboard/purchasing',
        body: fixture('dashboard/purchasing_response.json'),
      )
      ..on(
        'GET',
        '/dashboard/monitoring',
        body: fixture('dashboard/monitoring_response.json'),
      )
      ..on(
        'GET',
        '/dashboard/activity',
        body: fixture('dashboard/activity_response.json'),
      )
      ..on(
        'GET',
        '/dashboard/alerts',
        body: fixture('dashboard/alerts_response.json'),
      );
    final container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: InMemoryTokenStore(),
        clock: TestClock(DateTime(2026, 11, 24)),
      ),
    );
    addTearDown(container.dispose);
    final repository = container.read(dashboardRepositoryProvider);

    expect((await repository.inventory()).totalProducts, 120);
    expect((await repository.purchasing()).pendingOrders, 3);
    expect((await repository.monitoring()).activeSensors, 8);
    expect(await repository.activity(), hasLength(2));
    expect(await repository.alerts(), hasLength(1));
  });
}
