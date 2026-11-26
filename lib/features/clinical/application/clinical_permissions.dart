import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/navigation/quick_action_permissions.dart';

/// Permisos con los que el backend deja buscar pacientes y citas en MedSys
/// (`routes/api/medsys.php`). Los pacientes solo existen en MedSys: quien
/// registra procedimientos o genera órdenes necesita buscarlos aunque no
/// administre integraciones.
const patientLookupPermissions = [
  'integraciones.ver',
  'registros_procedimientos.crear',
  'ordenes_servicio.crear',
];

/// El usuario puede buscar pacientes de MedSys.
final Provider<bool> canLookUpPatientsProvider = Provider<bool>(
  (ref) =>
      ref.watch(permissionServiceProvider).canAny(patientLookupPermissions),
);

final Provider<bool> canSellProvider = Provider<bool>(
  (ref) =>
      ref.watch(permissionServiceProvider).canAll(QuickActionPermissions.sale),
);
