import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';

/// Registrar un consumo exige crearlo y poder elegir almacén, centro de costo
/// e insumos.
const newConsumptionPermissions = [
  'consumos.crear',
  'almacenes.ver',
  'centros_costo.ver',
  'generic-products.ver',
];

/// La proyección viene de MedSys y la protege `integraciones.ver`.
const projectionPermission = 'integraciones.ver';

final Provider<bool> canCreateConsumptionProvider = Provider<bool>(
  (ref) =>
      ref.watch(permissionServiceProvider).canAll(newConsumptionPermissions),
);

final Provider<bool> canSeeProjectionProvider = Provider<bool>(
  (ref) => ref.watch(permissionServiceProvider).can(projectionPermission),
);
