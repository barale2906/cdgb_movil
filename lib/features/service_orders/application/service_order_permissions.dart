import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';

/// Crear una orden exige `ordenes_servicio.crear` y poder buscar el
/// procedimiento (`medical-services/search`).
const newOrderPermissions = ['ordenes_servicio.crear', 'servicios_medicos.ver'];

/// Los insumos se buscan en el catálogo de productos y salen de un almacén
/// del usuario.
const supplyPermissions = ['generic-products.ver', 'almacenes.ver'];

final Provider<bool> canCreateOrderProvider = Provider<bool>(
  (ref) => ref.watch(permissionServiceProvider).canAll(newOrderPermissions),
);

final Provider<bool> canApproveDiscountProvider = Provider<bool>(
  (ref) => ref.watch(permissionServiceProvider).can('ordenes_servicio.aprobar'),
);

/// El backend solo exige `ordenes_servicio.ver` para facturar y anular; la app
/// lo reserva a quien crea o aprueba órdenes.
final Provider<bool> canManageBillingProvider = Provider<bool>(
  (ref) => ref.watch(permissionServiceProvider).canAny([
    'ordenes_servicio.crear',
    'ordenes_servicio.aprobar',
  ]),
);

final Provider<bool> canAddSuppliesProvider = Provider<bool>(
  (ref) => ref.watch(permissionServiceProvider).canAll(supplyPermissions),
);
