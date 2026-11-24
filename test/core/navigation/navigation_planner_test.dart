import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/menu_item.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/navigation/navigation_planner.dart';

MenuItem _leaf(String route) =>
    MenuItem(key: route, label: route, route: route);

MenuItem _group(List<MenuItem> children) =>
    MenuItem(key: 'group', label: 'Grupo', children: children);

NavigationPlan _plan(
  List<String> routes,
  List<String> permissions, {
  void Function(String)? onUnknown,
}) => NavigationPlanner.plan(
  menu: [_group(routes.map(_leaf).toList())],
  permissions: PermissionService(permissions),
  onUnknownRoute: onUnknown,
);

void main() {
  test('Inicio siempre está, aunque no haya módulos', () {
    final plan = _plan([], []);
    expect(plan.bottomBar, [AppSection.dashboard]);
    expect(plan.hasMore, isFalse);
  });

  test('la barra toma Inventario, Compras y Activos en ese orden', () {
    final plan = _plan(
      ['assets.index', 'purchase-orders.index', 'stock.index'],
      ['activos.ver', 'ordenes_compra.ver', 'stock.ver'],
    );
    expect(plan.bottomBar, [
      AppSection.dashboard,
      AppSection.inventory,
      AppSection.purchasing,
      AppSection.assets,
    ]);
    expect(plan.hasMore, isFalse, reason: '≤ 4 módulos: sin "Más"');
  });

  test('el resto de secciones va a "Más"', () {
    final plan = _plan(
      ['stock.index', 'reports.index', 'audit.index'],
      ['stock.ver', 'reportes.ver', 'auditoria.ver'],
    );
    expect(plan.bottomBar, [AppSection.dashboard, AppSection.inventory]);
    expect(plan.more, [AppSection.reports, AppSection.audit]);
    expect(plan.hasMore, isTrue);
  });

  test('el menú no basta: falta el permiso de entrada', () {
    final plan = _plan(['stock.index'], []);
    expect(plan.all, [AppSection.dashboard]);
  });

  test('el permiso no basta: el menú del backend manda qué se ve', () {
    final plan = _plan([], ['stock.ver']);
    expect(plan.all, [AppSection.dashboard]);
  });

  test('catálogo se valida con generic-products.ver, no con productos.ver', () {
    final withBackendName = _plan(['products.index'], ['productos.ver']);
    final withRealName = _plan(['products.index'], ['generic-products.ver']);
    expect(withBackendName.all, isNot(contains(AppSection.catalog)));
    expect(withRealName.all, contains(AppSection.catalog));
  });

  test('varias claves del menú activan una sola sección', () {
    final plan = _plan(
      ['zones.index', 'locations.index', 'warehouses.index'],
      ['almacenes.ver'],
    );
    expect(plan.more, [AppSection.warehouses]);
  });

  test('las claves solo-escritorio se ocultan sin avisar', () {
    final unknown = <String>[];
    final plan = _plan(
      [
        'integrations.index',
        'users.index',
        'roles.index',
        'asset-catalogs.index',
        'price-lists.index',
      ],
      ['integraciones.ver', 'usuarios.ver', 'roles.ver', 'activos.ver'],
      onUnknown: unknown.add,
    );
    expect(plan.all, [AppSection.dashboard]);
    expect(unknown, isEmpty);
  });

  test('una clave desconocida se ignora y se reporta', () {
    final unknown = <String>[];
    final plan = _plan(['nueva-cosa.index'], [], onUnknown: unknown.add);
    expect(plan.all, [AppSection.dashboard]);
    expect(unknown, ['nueva-cosa.index']);
  });

  group('AppSection', () {
    test('fromLocation reconoce subrutas', () {
      expect(AppSection.fromLocation('/inventory'), AppSection.inventory);
      expect(
        AppSection.fromLocation('/inventory/stock/3'),
        AppSection.inventory,
      );
      expect(AppSection.fromLocation('/inventorying'), isNull);
      expect(AppSection.fromLocation('/profile'), isNull);
    });

    test('las rutas y claves de menú no se repiten entre secciones', () {
      final paths = AppSection.values.map((s) => s.path);
      expect(paths.toSet(), hasLength(AppSection.values.length));
      final routes = AppSection.values.expand((s) => s.menuRoutes);
      expect(routes.toSet(), hasLength(routes.length));
    });
  });
}
