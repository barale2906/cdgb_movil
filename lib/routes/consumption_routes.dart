import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/widgets/clinical_pickers.dart';
import 'package:sga_bojanini/features/consumptions/application/consumption_permissions.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_detail_page.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_paths.dart';
import 'package:sga_bojanini/features/consumptions/presentation/new_consumption_page.dart';
import 'package:sga_bojanini/routes/route_guards.dart';

/// Consumos: nuevo consumo (con su selector de insumos) y detalle (la lista es
/// la sección `/consumptions`). `new` va antes de `:id`.
List<GoRoute> consumptionRoutes(Ref ref) => [
  GoRoute(
    path: ConsumptionPaths.newConsumption,
    redirect: requiresAll(ref, newConsumptionPermissions),
    builder: (_, _) => const NewConsumptionPage(),
    routes: [
      GoRoute(path: 'product', builder: (_, _) => const ProductPickerPage()),
    ],
  ),
  GoRoute(
    path: '${AppSection.consumptions.path}/:id',
    redirect: requires(ref, 'consumos.ver'),
    builder: (_, state) => ConsumptionDetailPage(consumptionId: routeId(state)),
  ),
];
