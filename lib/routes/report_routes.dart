import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/features/reports/presentation/exports_page.dart';
import 'package:sga_bojanini/features/reports/presentation/report_form_page.dart';
import 'package:sga_bojanini/features/reports/presentation/report_viewer_page.dart';

/// Reportes: catálogo, formularios por tipo, visor de PDF y exportaciones.
List<GoRoute> reportRoutes(Ref ref) {
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
