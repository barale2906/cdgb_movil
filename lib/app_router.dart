import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/files/file_picker_gateway.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/navigation/quick_action_permissions.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/core/widgets/clinical_pickers.dart';
import 'package:sga_bojanini/core/widgets/pdf_preview_page.dart';
import 'package:sga_bojanini/features/about/presentation/about_page.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/application/transfers_providers.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_detail_page.dart';
import 'package:sga_bojanini/features/assets/presentation/assets_page.dart';
import 'package:sga_bojanini/features/assets/presentation/complete_maintenance_page.dart';
import 'package:sga_bojanini/features/assets/presentation/document_upload_page.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_detail_page.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_page.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_confirm_page.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_detail_page.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_request_page.dart';
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
import 'package:sga_bojanini/features/clinical/data/evolution.dart';
import 'package:sga_bojanini/features/clinical/presentation/clinical_page.dart';
import 'package:sga_bojanini/features/clinical/presentation/evolution_form_page.dart';
import 'package:sga_bojanini/features/clinical/presentation/patient_detail_page.dart';
import 'package:sga_bojanini/features/clinical/presentation/record_detail_page.dart';
import 'package:sga_bojanini/features/clinical/presentation/sale_page.dart';
import 'package:sga_bojanini/features/consumptions/application/consumption_permissions.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_detail_page.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_paths.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumptions_page.dart';
import 'package:sga_bojanini/features/consumptions/presentation/new_consumption_page.dart';
import 'package:sga_bojanini/features/cost_centers/presentation/cost_centers_page.dart';
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
import 'package:sga_bojanini/features/purchasing/application/draft_permissions.dart';
import 'package:sga_bojanini/features/purchasing/presentation/consolidate_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/consolidated_order_detail_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/expense_draft_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/expense_order_detail_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchase_draft_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchase_order_detail_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/receive_expense_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/receive_purchase_page.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/features/reports/presentation/exports_page.dart';
import 'package:sga_bojanini/features/reports/presentation/report_form_page.dart';
import 'package:sga_bojanini/features/reports/presentation/report_viewer_page.dart';
import 'package:sga_bojanini/features/reports/presentation/reports_page.dart';
import 'package:sga_bojanini/features/service_orders/presentation/new_order_page.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_detail_page.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_paths.dart';
import 'package:sga_bojanini/features/service_orders/presentation/service_orders_page.dart';
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
      ..._purchasingRoutes(ref),
      ..._assetRoutes(ref),
      ..._maintenanceRoutes(ref),
      ..._reportRoutes(ref),
      ..._monitoringRoutes(ref),
      ..._clinicalRoutes(ref),
      ..._serviceOrderRoutes(ref),
      ..._consumptionRoutes(ref),
      GoRoute(
        path: '${AppSection.audit.path}/:id',
        redirect: _requires(ref, 'auditoria.ver'),
        builder: (_, state) => AuditDetailPage(logId: _id(state)),
      ),
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

/// Redirección que exige un permiso concreto además del de la sección
/// (cada ruta y acción valida el suyo, CLAUDE.md §5).
GoRouterRedirect _requires(Ref ref, String permission) =>
    (context, state) => ref.read(permissionServiceProvider).can(permission)
    ? null
    : Routes.home;

/// Como [_requires], exigiendo todos los permisos.
GoRouterRedirect _requiresAll(Ref ref, List<String> permissions) =>
    (context, state) => ref.read(permissionServiceProvider).canAll(permissions)
    ? null
    : Routes.home;

/// Como [_requires], con cualquiera de los permisos.
GoRouterRedirect _requiresAny(Ref ref, List<String> permissions) =>
    (context, state) => ref.read(permissionServiceProvider).canAny(permissions)
    ? null
    : Routes.home;

int _id(GoRouterState state) => int.parse(state.pathParameters['id']!);

/// Detalle, ejecución y reporte de un mantenimiento (la lista es la sección
/// `/maintenance`).
List<GoRoute> _maintenanceRoutes(Ref ref) => [
  GoRoute(
    path: '/maintenance/:id',
    redirect: _requires(ref, 'activos_mantenimientos.ver'),
    builder: (_, state) => MaintenanceDetailPage(maintenanceId: _id(state)),
    routes: [
      GoRoute(
        path: 'complete',
        redirect: _requires(ref, 'activos_mantenimientos.ejecutar'),
        builder: (_, state) =>
            CompleteMaintenancePage(maintenanceId: _id(state)),
      ),
      GoRoute(
        path: 'report',
        builder: (_, state) => PdfPreviewPage(
          provider: maintenanceReportProvider(_id(state)),
          fileName: 'mantenimiento-${_id(state)}.pdf',
        ),
      ),
    ],
  ),
];

/// Ficha y hoja de vida de un activo (la lista es la sección `/assets`).
List<GoRoute> _assetRoutes(Ref ref) => [
  GoRoute(
    path: '/assets/transfers/:id',
    redirect: _requires(ref, 'activos.ver'),
    builder: (_, state) => TransferDetailPage(transferId: _id(state)),
    routes: [
      GoRoute(
        path: 'confirm',
        redirect: _requires(ref, 'activos_traslados.confirmar'),
        builder: (_, state) => TransferConfirmPage(transferId: _id(state)),
      ),
      GoRoute(
        path: 'act',
        builder: (_, state) => PdfPreviewPage(
          provider: transferActProvider(_id(state)),
          fileName: 'acta-traslado-${_id(state)}.pdf',
        ),
      ),
    ],
  ),
  GoRoute(
    path: '/assets/:id',
    redirect: _requires(ref, 'activos.ver'),
    builder: (_, state) => AssetDetailPage(assetId: _id(state)),
    routes: [
      GoRoute(
        path: 'transfer',
        redirect: _requires(ref, 'activos_traslados.solicitar'),
        builder: (_, state) => TransferRequestPage(assetId: _id(state)),
      ),
      GoRoute(
        path: 'documents/new',
        redirect: _requires(ref, 'activos_documentos.cargar'),
        // El archivo elegido viaja en memoria (extra); sin él no hay nada
        // que subir.
        builder: (_, state) => state.extra is PickedFile
            ? DocumentUploadPage(
                assetId: _id(state),
                file: state.extra! as PickedFile,
              )
            : const SectionPlaceholderPage(section: AppSection.assets),
      ),
      GoRoute(
        path: 'life-sheet',
        builder: (_, state) => PdfPreviewPage(
          provider: lifeSheetProvider(_id(state)),
          fileName: 'hoja-de-vida-${_id(state)}.pdf',
        ),
      ),
    ],
  ),
];

/// Detalles, recepción y consolidación de compras. Cada ruta exige además
/// su propio permiso (el de la sección es solo `ordenes_compra.ver`).
List<GoRoute> _purchasingRoutes(Ref ref) {
  const base = '/purchasing';
  return [
    GoRoute(
      path: PurchaseDraftPage.newPath,
      redirect: _requiresAll(ref, newPurchasePermissions),
      builder: (_, _) => const PurchaseDraftPage(),
      routes: [
        GoRoute(path: 'product', builder: (_, _) => const ProductPickerPage()),
      ],
    ),
    GoRoute(
      path: ExpenseDraftPage.newPath,
      redirect: _requiresAll(ref, newExpensePermissions),
      builder: (_, _) => const ExpenseDraftPage(),
    ),
    GoRoute(
      path: '$base/orders/:id',
      redirect: _requires(ref, 'ordenes_compra.ver'),
      builder: (_, state) => PurchaseOrderDetailPage(orderId: _id(state)),
      routes: [
        GoRoute(
          path: 'receive',
          redirect: _requires(ref, 'ordenes_compra.recibir'),
          builder: (_, state) => ReceivePurchasePage(orderId: _id(state)),
        ),
        GoRoute(
          path: 'edit',
          redirect: _requiresAll(ref, newPurchasePermissions),
          builder: (_, state) => PurchaseDraftEditPage(orderId: _id(state)),
        ),
      ],
    ),
    GoRoute(
      path: '$base/expenses/:id',
      redirect: _requires(ref, 'ordenes_gasto.ver'),
      builder: (_, state) => ExpenseOrderDetailPage(orderId: _id(state)),
      routes: [
        GoRoute(
          path: 'receive',
          redirect: _requires(ref, 'ordenes_gasto.recibir'),
          builder: (_, state) => ReceiveExpensePage(orderId: _id(state)),
        ),
        GoRoute(
          path: 'edit',
          redirect: _requiresAll(ref, newExpensePermissions),
          builder: (_, state) => ExpenseDraftEditPage(orderId: _id(state)),
        ),
      ],
    ),
    GoRoute(
      path: '$base/consolidate',
      redirect: _requires(ref, 'ordenes_compra.consolidar'),
      builder: (_, _) => const ConsolidatePage(),
    ),
    GoRoute(
      path: '$base/consolidated/:id',
      redirect: _requires(ref, 'ordenes_compra.ver'),
      builder: (_, state) => ConsolidatedOrderDetailPage(orderId: _id(state)),
    ),
  ];
}

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
      // La cámara es común: la usan productos y activos, y el destino que
      // abre el código valida su propio permiso.
      redirect: _requiresAny(ref, ['generic-products.barcode', 'activos.ver']),
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

/// Registros clínicos: detalle de un registro y ficha del paciente (la lista
/// es la sección `/clinical-records`).
List<GoRoute> _clinicalRoutes(Ref ref) {
  const base = '/clinical-records';
  const permission = 'registros_procedimientos.ver';
  return [
    GoRoute(
      path: SalePage.path,
      redirect: _requiresAll(ref, QuickActionPermissions.sale),
      builder: (_, _) => const SalePage(),
      routes: [
        GoRoute(path: 'patient', builder: (_, _) => const PatientPickerPage()),
        GoRoute(path: 'service', builder: (_, _) => const ServicePickerPage()),
      ],
    ),
    GoRoute(
      path: '$base/records/:id',
      redirect: _requires(ref, permission),
      builder: (_, state) => RecordDetailPage(recordId: _id(state)),
      routes: [
        GoRoute(
          path: 'evolution',
          redirect: (context, state) =>
              ref.read(permissionServiceProvider).canAny(const [
                'evoluciones_clinicas.crear',
                'evoluciones_clinicas.editar',
              ])
              ? null
              : Routes.home,
          builder: (_, state) => EvolutionFormPage(
            recordId: _id(state),
            evolution: state.extra is Evolution
                ? state.extra! as Evolution
                : null,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '$base/patients/:id',
      redirect: _requires(ref, permission),
      builder: (_, state) => PatientDetailPage(
        externalId: state.pathParameters['id']!,
        patient: state.extra is MedsysPatient
            ? state.extra! as MedsysPatient
            : null,
      ),
    ),
  ];
}

/// Órdenes de servicio: nueva orden (con sus selectores) y detalle (la lista de
/// entrada es la sección `/service-orders`). `new` va antes de `:number`.
List<GoRoute> _serviceOrderRoutes(Ref ref) => [
  GoRoute(
    path: OrderPaths.newOrder,
    redirect: _requiresAll(ref, QuickActionPermissions.newOrder),
    builder: (_, _) => const NewOrderPage(),
    routes: [
      GoRoute(path: 'patient', builder: (_, _) => const PatientPickerPage()),
      GoRoute(path: 'service', builder: (_, _) => const ServicePickerPage()),
      GoRoute(path: 'product', builder: (_, _) => const ProductPickerPage()),
    ],
  ),
  GoRoute(
    path: '${AppSection.serviceOrders.path}/:number',
    redirect: _requires(ref, 'ordenes_servicio.ver'),
    builder: (_, state) =>
        OrderDetailPage(orderNumber: state.pathParameters['number']!),
  ),
];

/// Consumos: nuevo consumo (con su selector de insumos) y detalle (la lista es
/// la sección `/consumptions`). `new` va antes de `:id`.
List<GoRoute> _consumptionRoutes(Ref ref) => [
  GoRoute(
    path: ConsumptionPaths.newConsumption,
    redirect: _requiresAll(ref, newConsumptionPermissions),
    builder: (_, _) => const NewConsumptionPage(),
    routes: [
      GoRoute(path: 'product', builder: (_, _) => const ProductPickerPage()),
    ],
  ),
  GoRoute(
    path: '${AppSection.consumptions.path}/:id',
    redirect: _requires(ref, 'consumos.ver'),
    builder: (_, state) => ConsumptionDetailPage(consumptionId: _id(state)),
  ),
];
