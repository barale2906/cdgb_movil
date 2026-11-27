import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/features/about/presentation/about_page.dart';
import 'package:sga_bojanini/features/assets/presentation/assets_page.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_page.dart';
import 'package:sga_bojanini/features/audit/presentation/audit_detail_page.dart';
import 'package:sga_bojanini/features/audit/presentation/audit_page.dart';
import 'package:sga_bojanini/features/auth/presentation/change_password_page.dart';
import 'package:sga_bojanini/features/auth/presentation/locked_page.dart';
import 'package:sga_bojanini/features/auth/presentation/login_page.dart';
import 'package:sga_bojanini/features/auth/presentation/my_signature_page.dart';
import 'package:sga_bojanini/features/auth/presentation/profile_page.dart';
import 'package:sga_bojanini/features/auth/presentation/splash_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/catalog_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/product_detail_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/supplier_detail_page.dart';
import 'package:sga_bojanini/features/clinical/presentation/clinical_page.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumptions_page.dart';
import 'package:sga_bojanini/features/cost_centers/presentation/cost_centers_page.dart';
import 'package:sga_bojanini/features/home/presentation/app_shell.dart';
import 'package:sga_bojanini/features/home/presentation/home_page.dart';
import 'package:sga_bojanini/features/home/presentation/more_page.dart';
import 'package:sga_bojanini/features/home/presentation/section_placeholder_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/inventory_page.dart';
import 'package:sga_bojanini/features/monitoring/presentation/monitoring_page.dart';
import 'package:sga_bojanini/features/notifications/application/notifications_providers.dart';
import 'package:sga_bojanini/features/notifications/presentation/notifications_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_page.dart';
import 'package:sga_bojanini/features/reports/presentation/reports_page.dart';
import 'package:sga_bojanini/features/service_orders/presentation/service_orders_page.dart';
import 'package:sga_bojanini/features/warehouse/presentation/warehouse_detail_page.dart';
import 'package:sga_bojanini/features/warehouse/presentation/warehouses_page.dart';
import 'package:sga_bojanini/routes/asset_routes.dart';
import 'package:sga_bojanini/routes/clinical_routes.dart';
import 'package:sga_bojanini/routes/consumption_routes.dart';
import 'package:sga_bojanini/routes/inventory_routes.dart';
import 'package:sga_bojanini/routes/maintenance_routes.dart';
import 'package:sga_bojanini/routes/monitoring_routes.dart';
import 'package:sga_bojanini/routes/purchasing_routes.dart';
import 'package:sga_bojanini/routes/report_routes.dart';
import 'package:sga_bojanini/routes/route_guards.dart';
import 'package:sga_bojanini/routes/service_order_routes.dart';

/// Mapa de rutas y guardas. Vive en la raíz (no en `core/`) porque es el
/// único lugar que compone pantallas de varias features.
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref
    // Fuera de la fase de construcción: el listener corre durante el flush
    // de Riverpod, que ocurre dentro de `build`.
    ..listen(
      sessionControllerProvider,
      (_, _) => scheduleMicrotask(() => refresh.value++),
    )
    ..onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) => resolveRedirect(
      session: ref.read(sessionControllerProvider),
      permissions: ref.read(permissionServiceProvider),
      location: state.matchedLocation,
    ),
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashPage()),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginPage()),
      GoRoute(path: Routes.locked, builder: (_, _) => const LockedPage()),
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(path: Routes.home, builder: (_, _) => const HomePage()),
          GoRoute(path: MorePage.path, builder: (_, _) => const MorePage()),
          for (final section in AppSection.values)
            if (section != AppSection.dashboard)
              GoRoute(
                path: section.path,
                builder: (_, _) => _sectionPage(section),
              ),
        ],
      ),
      GoRoute(
        path: '${AppSection.warehouses.path}/:id',
        builder: (_, state) => WarehouseDetailPage(
          warehouseId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '${AppSection.catalog.path}/products/:id',
        builder: (_, state) => ProductDetailPage(
          productId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '${AppSection.catalog.path}/suppliers/:id',
        builder: (_, state) => SupplierDetailPage(
          supplierId: int.parse(state.pathParameters['id']!),
        ),
      ),
      ...inventoryRoutes(ref),
      ...purchasingRoutes(ref),
      ...assetRoutes(ref),
      ...maintenanceRoutes(ref),
      ...reportRoutes(ref),
      ...monitoringRoutes(ref),
      ...clinicalRoutes(ref),
      ...serviceOrderRoutes(ref),
      ...consumptionRoutes(ref),
      GoRoute(
        path: '${AppSection.audit.path}/:id',
        redirect: requires(ref, 'auditoria.ver'),
        builder: (_, state) => AuditDetailPage(logId: routeId(state)),
      ),
      GoRoute(
        path: NotificationsPage.path,
        redirect: requires(ref, notificationsPermission),
        builder: (_, _) => const NotificationsPage(),
      ),
      GoRoute(
        path: Routes.profile,
        builder: (_, _) => const ProfilePage(),
        routes: [
          GoRoute(
            path: 'password',
            builder: (_, _) => const ChangePasswordPage(),
          ),
          GoRoute(
            path: 'signature',
            builder: (_, _) => const MySignaturePage(),
          ),
        ],
      ),
      GoRoute(path: Routes.about, builder: (_, _) => const AboutPage()),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Pantalla de cada sección; las de fases futuras muestran "Próximamente".
Widget _sectionPage(AppSection section) => switch (section) {
  AppSection.warehouses => const WarehousesPage(),
  AppSection.catalog => const CatalogPage(),
  AppSection.inventory => const InventoryPage(),
  AppSection.purchasing => const PurchasingPage(),
  AppSection.assets => const AssetsPage(),
  AppSection.maintenance => const MaintenancePage(),
  AppSection.monitoring => const MonitoringPage(),
  AppSection.reports => const ReportsPage(),
  AppSection.clinicalRecords => const ClinicalPage(),
  AppSection.serviceOrders => const ServiceOrdersPage(),
  AppSection.costCenters => const CostCentersPage(),
  AppSection.consumptions => const ConsumptionsPage(),
  AppSection.audit => const AuditPage(),
  _ => SectionPlaceholderPage(section: section),
};
