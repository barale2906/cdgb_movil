import 'package:flutter/material.dart';

/// Secciones de la app. Cada una declara su permiso de entrada (el mismo que
/// usa la guarda del web) y las claves `route` del menú que la activan.
/// Mapa: `docs/plan/02-arquitectura.md` §4.4.
enum AppSection {
  dashboard(
    path: '/home',
    icon: Icons.home_outlined,
    permission: 'tablero.ver',
    menuRoutes: {'dashboard'},
  ),
  inventory(
    path: '/inventory',
    icon: Icons.inventory_2_outlined,
    permission: 'stock.ver',
    menuRoutes: {'stock.index', 'batches.index', 'movements.index'},
  ),
  purchasing(
    path: '/purchasing',
    icon: Icons.shopping_cart_outlined,
    permission: 'ordenes_compra.ver',
    menuRoutes: {'purchase-orders.index'},
  ),
  assets(
    path: '/assets',
    icon: Icons.devices_other_outlined,
    permission: 'activos.ver',
    menuRoutes: {'assets.index', 'asset-transfers.index'},
  ),
  maintenance(
    path: '/maintenance',
    icon: Icons.build_outlined,
    permission: 'activos_mantenimientos.ver',
    menuRoutes: {'asset-maintenance.index'},
  ),
  warehouses(
    path: '/warehouses',
    icon: Icons.warehouse_outlined,
    permission: 'almacenes.ver',
    menuRoutes: {'warehouses.index', 'zones.index', 'locations.index'},
  ),
  catalog(
    path: '/catalog',
    icon: Icons.category_outlined,
    // El menú del backend referencia `productos.ver`, que no existe: la app
    // valida el permiso real.
    permission: 'generic-products.ver',
    menuRoutes: {
      'products.index',
      'categories.index',
      'units-of-measure.index',
      'product-classifications.index',
      'suppliers.index',
    },
  ),
  serviceOrders(
    path: '/service-orders',
    icon: Icons.assignment_outlined,
    permission: 'ordenes_servicio.ver',
    menuRoutes: {'service-orders.index', 'service-orders.discounts'},
  ),
  clinicalRecords(
    path: '/clinical-records',
    icon: Icons.medical_services_outlined,
    permission: 'registros_procedimientos.ver',
    menuRoutes: {'patient-procedure-records.index'},
  ),
  costCenters(
    path: '/cost-centers',
    icon: Icons.account_balance_outlined,
    permission: 'centros_costo.ver',
    menuRoutes: {
      'cost-centers.index',
      'medical-services.index',
      'procedures.index',
    },
  ),
  monitoring(
    path: '/monitoring',
    icon: Icons.thermostat_outlined,
    permission: 'sensores.ver',
    menuRoutes: {'sensors.index', 'sensor-readings.index', 'alert-rules.index'},
  ),
  consumptions(
    path: '/consumptions',
    icon: Icons.receipt_long_outlined,
    permission: 'consumos.ver',
    menuRoutes: {'consumptions.index'},
  ),
  reports(
    path: '/reports',
    icon: Icons.bar_chart_outlined,
    permission: 'reportes.ver',
    menuRoutes: {'reports.index'},
  ),
  audit(
    path: '/audit',
    icon: Icons.verified_user_outlined,
    permission: 'auditoria.ver',
    menuRoutes: {'audit.index'},
  )
  ;

  const AppSection({
    required this.path,
    required this.icon,
    required this.permission,
    required this.menuRoutes,
  });

  final String path;
  final IconData icon;

  /// Permiso de entrada de la sección.
  final String permission;

  /// Claves `route` del menú que habilitan la sección.
  final Set<String> menuRoutes;

  /// Sección que atiende una ruta de la app (`/inventory/...` incluida).
  static AppSection? fromLocation(String location) {
    for (final section in values) {
      if (location == section.path || location.startsWith('${section.path}/')) {
        return section;
      }
    }
    return null;
  }

  /// Sección de una clave `route` del menú; `null` si no tiene pantalla móvil
  /// (integraciones, listas de precios, catálogos de activos, usuarios, roles).
  static AppSection? fromMenuRoute(String route) {
    for (final section in values) {
      if (section.menuRoutes.contains(route)) return section;
    }
    return null;
  }
}
