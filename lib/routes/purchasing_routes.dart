import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/widgets/clinical_pickers.dart';
import 'package:sga_bojanini/features/purchasing/application/draft_permissions.dart';
import 'package:sga_bojanini/features/purchasing/presentation/consolidate_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/consolidated_order_detail_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/expense_draft_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/expense_order_detail_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchase_draft_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchase_order_detail_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/receive_expense_page.dart';
import 'package:sga_bojanini/features/purchasing/presentation/receive_purchase_page.dart';
import 'package:sga_bojanini/routes/route_guards.dart';

/// Detalles, recepción y consolidación de compras. Cada ruta exige además
/// su propio permiso (el de la sección es solo `ordenes_compra.ver`).
List<GoRoute> purchasingRoutes(Ref ref) {
  const base = '/purchasing';
  return [
    GoRoute(
      path: PurchaseDraftPage.newPath,
      redirect: requiresAll(ref, newPurchasePermissions),
      builder: (_, _) => const PurchaseDraftPage(),
      routes: [
        GoRoute(path: 'product', builder: (_, _) => const ProductPickerPage()),
      ],
    ),
    GoRoute(
      path: ExpenseDraftPage.newPath,
      redirect: requiresAll(ref, newExpensePermissions),
      builder: (_, _) => const ExpenseDraftPage(),
    ),
    GoRoute(
      path: '$base/orders/:id',
      redirect: requires(ref, 'ordenes_compra.ver'),
      builder: (_, state) => PurchaseOrderDetailPage(orderId: routeId(state)),
      routes: [
        GoRoute(
          path: 'receive',
          redirect: requires(ref, 'ordenes_compra.recibir'),
          builder: (_, state) => ReceivePurchasePage(orderId: routeId(state)),
        ),
        GoRoute(
          path: 'edit',
          redirect: requiresAll(ref, newPurchasePermissions),
          builder: (_, state) => PurchaseDraftEditPage(orderId: routeId(state)),
        ),
      ],
    ),
    GoRoute(
      path: '$base/expenses/:id',
      redirect: requires(ref, 'ordenes_gasto.ver'),
      builder: (_, state) => ExpenseOrderDetailPage(orderId: routeId(state)),
      routes: [
        GoRoute(
          path: 'receive',
          redirect: requires(ref, 'ordenes_gasto.recibir'),
          builder: (_, state) => ReceiveExpensePage(orderId: routeId(state)),
        ),
        GoRoute(
          path: 'edit',
          redirect: requiresAll(ref, newExpensePermissions),
          builder: (_, state) => ExpenseDraftEditPage(orderId: routeId(state)),
        ),
      ],
    ),
    GoRoute(
      path: '$base/consolidate',
      redirect: requires(ref, 'ordenes_compra.consolidar'),
      builder: (_, _) => const ConsolidatePage(),
    ),
    GoRoute(
      path: '$base/consolidated/:id',
      redirect: requires(ref, 'ordenes_compra.ver'),
      builder: (_, state) =>
          ConsolidatedOrderDetailPage(orderId: routeId(state)),
    ),
  ];
}
