import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/navigation/quick_action_permissions.dart';
import 'package:sga_bojanini/core/widgets/clinical_pickers.dart';
import 'package:sga_bojanini/features/service_orders/presentation/new_order_page.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_detail_page.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_paths.dart';
import 'package:sga_bojanini/routes/route_guards.dart';

/// Órdenes de servicio: nueva orden (con sus selectores) y detalle (la lista de
/// entrada es la sección `/service-orders`). `new` va antes de `:number`.
List<GoRoute> serviceOrderRoutes(Ref ref) => [
  GoRoute(
    path: OrderPaths.newOrder,
    redirect: requiresAll(ref, QuickActionPermissions.newOrder),
    builder: (_, _) => const NewOrderPage(),
    routes: [
      GoRoute(path: 'patient', builder: (_, _) => const PatientPickerPage()),
      GoRoute(path: 'service', builder: (_, _) => const ServicePickerPage()),
      GoRoute(path: 'product', builder: (_, _) => const ProductPickerPage()),
    ],
  ),
  GoRoute(
    path: '${AppSection.serviceOrders.path}/:number',
    redirect: requires(ref, 'ordenes_servicio.ver'),
    builder: (_, state) =>
        OrderDetailPage(orderNumber: state.pathParameters['number']!),
  ),
];
