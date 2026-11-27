import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/features/monitoring/presentation/alert_rules_page.dart';
import 'package:sga_bojanini/features/monitoring/presentation/calibrations_page.dart';
import 'package:sga_bojanini/features/monitoring/presentation/sensor_detail_page.dart';
import 'package:sga_bojanini/routes/route_guards.dart';

/// Monitoreo: detalle de sensor, calibraciones y reglas de alerta.
List<GoRoute> monitoringRoutes(Ref ref) {
  const base = '/monitoring/sensors/:id';
  return [
    GoRoute(
      path: base,
      builder: (_, state) => SensorDetailPage(sensorId: routeId(state)),
      routes: [
        GoRoute(
          path: 'calibrations',
          builder: (_, state) => CalibrationsPage(sensorId: routeId(state)),
        ),
        GoRoute(
          path: 'alert-rules',
          redirect: requires(ref, 'reglas_alerta.ver'),
          builder: (_, state) => AlertRulesPage(sensorId: routeId(state)),
        ),
      ],
    ),
  ];
}
