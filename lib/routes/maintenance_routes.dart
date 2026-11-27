import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/widgets/pdf_preview_page.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/presentation/complete_maintenance_page.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_detail_page.dart';
import 'package:sga_bojanini/features/assets/presentation/reschedule_maintenance_page.dart';
import 'package:sga_bojanini/routes/route_guards.dart';

/// Detalle, ejecución y reporte de un mantenimiento (la lista es la sección
/// `/maintenance`).
List<GoRoute> maintenanceRoutes(Ref ref) => [
  GoRoute(
    path: '/maintenance/:id',
    redirect: requires(ref, 'activos_mantenimientos.ver'),
    builder: (_, state) => MaintenanceDetailPage(maintenanceId: routeId(state)),
    routes: [
      GoRoute(
        path: 'complete',
        redirect: requires(ref, 'activos_mantenimientos.ejecutar'),
        builder: (_, state) =>
            CompleteMaintenancePage(maintenanceId: routeId(state)),
      ),
      GoRoute(
        path: 'reschedule',
        redirect: requires(ref, 'activos_mantenimientos.programar'),
        builder: (_, state) =>
            RescheduleMaintenancePage(maintenanceId: routeId(state)),
      ),
      GoRoute(
        path: 'report',
        builder: (_, state) => PdfPreviewPage(
          provider: maintenanceReportProvider(routeId(state)),
          fileName: 'mantenimiento-${routeId(state)}.pdf',
        ),
      ),
    ],
  ),
];
