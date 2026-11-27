import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';

/// Crear un borrador de gasto exige crearlo y poder elegir el proveedor.
const newExpensePermissions = ['ordenes_gasto.crear', 'proveedores.ver'];

/// Crear un borrador de compra exige crearlo y poder elegir proveedor,
/// almacén y producto.
const newPurchasePermissions = [
  'ordenes_compra.crear',
  'proveedores.ver',
  'almacenes.ver',
  'generic-products.ver',
];

final Provider<bool> canCreateExpenseProvider = Provider<bool>(
  (ref) => ref.watch(permissionServiceProvider).canAll(newExpensePermissions),
);

final Provider<bool> canCreatePurchaseProvider = Provider<bool>(
  (ref) => ref.watch(permissionServiceProvider).canAll(newPurchasePermissions),
);
