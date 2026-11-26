import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/features/about/presentation/about_page.dart';
import 'package:sga_bojanini/features/auth/presentation/change_password_page.dart';
import 'package:sga_bojanini/features/auth/presentation/locked_page.dart';
import 'package:sga_bojanini/features/auth/presentation/login_page.dart';
import 'package:sga_bojanini/features/auth/presentation/my_signature_page.dart';
import 'package:sga_bojanini/features/auth/presentation/profile_page.dart';
import 'package:sga_bojanini/features/auth/presentation/splash_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/catalog_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/product_detail_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/supplier_detail_page.dart';
import 'package:sga_bojanini/features/home/presentation/app_shell.dart';
import 'package:sga_bojanini/features/home/presentation/home_page.dart';
import 'package:sga_bojanini/features/home/presentation/more_page.dart';
import 'package:sga_bojanini/features/home/presentation/section_placeholder_page.dart';
import 'package:sga_bojanini/features/inventory/application/movement_permissions.dart';
import 'package:sga_bojanini/features/inventory/presentation/batch_detail_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/confirm_document_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/document_detail_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/document_pdf_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/entry_form_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/exit_form_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/inventory_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/new_movement_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/scan_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/single_movement_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/transfer_form_page.dart';
import 'package:sga_bojanini/features/monitoring/presentation/alert_rules_page.dart';
import 'package:sga_bojanini/features/monitoring/presentation/calibrations_page.dart';
import 'package:sga_bojanini/features/monitoring/presentation/monitoring_page.dart';
import 'package:sga_bojanini/features/monitoring/presentation/sensor_detail_page.dart';
import 'package:sga_bojanini/features/notifications/application/notifications_providers.dart';
import 'package:sga_bojanini/features/notifications/presentation/notifications_page.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/features/reports/presentation/exports_page.dart';
import 'package:sga_bojanini/features/reports/presentation/report_form_page.dart';
import 'package:sga_bojanini/features/reports/presentation/report_viewer_page.dart';
import 'package:sga_bojanini/features/reports/presentation/reports_page.dart';
import 'package:sga_bojanini/features/warehouse/presentation/warehouse_detail_page.dart';
import 'package:sga_bojanini/features/warehouse/presentation/warehouses_page.dart';

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
      ..._inventoryRoutes(ref),
      ..._reportRoutes(ref),
      ..._monitoringRoutes(ref),
      GoRoute(
        path: NotificationsPage.path,
        redirect: _requires(ref, notificationsPermission),
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
  AppSection.monitoring => const MonitoringPage(),
  AppSection.reports => const ReportsPage(),
  _ => SectionPlaceholderPage(section: section),
};

/// Redirección que exige un permiso concreto además del de la sección
/// (cada ruta y acción valida el suyo, CLAUDE.md §5).
GoRouterRedirect _requires(Ref ref, String permission) =>
    (context, state) => ref.read(permissionServiceProvider).can(permission)
    ? null
    : Routes.home;

int _id(GoRouterState state) => int.parse(state.pathParameters['id']!);

/// Pantallas de inventario fuera de la barra inferior (detalles, formularios
/// de movimiento, confirmación, PDF y escáner).
List<GoRoute> _inventoryRoutes(Ref ref) {
  const base = '/inventory';
  return [
    GoRoute(
      path: '$base/batches/:id',
      redirect: _requires(ref, 'lotes.ver'),
      builder: (_, state) => BatchDetailPage(batchId: _id(state)),
    ),
    GoRoute(
      path: '$base/documents/:id',
      builder: (_, state) => DocumentDetailPage(documentId: _id(state)),
      routes: [
        GoRoute(
          path: 'confirm',
          redirect: _requires(ref, 'movimientos.confirmar'),
          builder: (_, state) => ConfirmDocumentPage(documentId: _id(state)),
        ),
        GoRoute(
          path: 'pdf',
          builder: (_, state) => DocumentPdfPage(documentId: _id(state)),
        ),
      ],
    ),
    GoRoute(
      path: NewMovementPage.path,
      builder: (_, _) => const NewMovementPage(),
    ),
    GoRoute(
      path: MovementKind.entry.path,
      redirect: _requires(ref, MovementKind.entry.permission),
      builder: (_, _) => const EntryFormPage(),
    ),
    GoRoute(
      path: MovementKind.exit.path,
      redirect: _requires(ref, MovementKind.exit.permission),
      builder: (_, _) => const ExitFormPage(),
    ),
    GoRoute(
      path: MovementKind.transfer.path,
      redirect: _requires(ref, MovementKind.transfer.permission),
      builder: (_, _) => const TransferFormPage(),
    ),
    for (final kind in [
      MovementKind.adjustment,
      MovementKind.returnStock,
      MovementKind.writeOff,
      MovementKind.loss,
    ])
      GoRoute(
        path: kind.path,
        redirect: _requires(ref, kind.permission),
        builder: (_, _) => SingleMovementPage(kind: kind),
      ),
    GoRoute(
      path: ScanPage.path,
      redirect: _requires(ref, 'generic-products.barcode'),
      builder: (_, _) => const ScanPage(),
    ),
  ];
}

/// Reportes: catálogo, formularios por tipo, visor de PDF y exportaciones.
List<GoRoute> _reportRoutes(Ref ref) {
  const base = '/reports';
  return [
    GoRoute(
      path: '$base/exports',
      builder: (_, _) => const ExportsPage(),
    ),
    GoRoute(
      path: '$base/view',
      redirect: (_, state) => state.extra is ReportFile ? null : base,
      builder: (_, state) => ReportViewerPage(file: state.extra! as ReportFile),
    ),
    GoRoute(
      path: '$base/:type',
      redirect: (context, state) {
        final type = ReportType.fromPath(state.pathParameters['type']!);
        if (type == null) return base;
        final extra = type.extraPermission;
        return extra == null || ref.read(permissionServiceProvider).can(extra)
            ? null
            : base;
      },
      builder: (_, state) => ReportFormPage(
        type: ReportType.fromPath(state.pathParameters['type']!)!,
        sensorId: int.tryParse(state.uri.queryParameters['sensor_id'] ?? ''),
      ),
    ),
  ];
}

/// Monitoreo: detalle de sensor, calibraciones y reglas de alerta.
List<GoRoute> _monitoringRoutes(Ref ref) {
  const base = '/monitoring/sensors/:id';
  return [
    GoRoute(
      path: base,
      builder: (_, state) => SensorDetailPage(sensorId: _id(state)),
      routes: [
        GoRoute(
          path: 'calibrations',
          builder: (_, state) => CalibrationsPage(sensorId: _id(state)),
        ),
        GoRoute(
          path: 'alert-rules',
          redirect: _requires(ref, 'reglas_alerta.ver'),
          builder: (_, state) => AlertRulesPage(sensorId: _id(state)),
        ),
      ],
    ),
  ];
}
