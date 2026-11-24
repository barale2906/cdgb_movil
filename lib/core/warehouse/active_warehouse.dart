import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/utils/preferences.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_repository.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_summary.dart';

const _warehousePermission = 'almacenes.ver';
const _activeWarehouseKey = 'active_warehouse_id';

/// Almacenes del usuario actual; vacío si no tiene `almacenes.ver`.
final warehousesProvider = FutureProvider<List<WarehouseSummary>>((ref) {
  final userId = ref.watch(currentUserProvider.select((user) => user?.id));
  final allowed = ref.watch(
    permissionServiceProvider.select((p) => p.can(_warehousePermission)),
  );
  if (userId == null || !allowed) return const [];
  return ref.watch(warehouseRepositoryProvider).list();
});

/// Id del almacén elegido, persistido en el equipo. Se borra al terminar
/// la sesión: en un teléfono compartido no debe pasar al siguiente usuario.
class ActiveWarehouseIdNotifier extends Notifier<int?> {
  @override
  int? build() {
    ref.listen(sessionControllerProvider, (_, session) {
      if (session is SessionUnauthenticated) unawaited(clear());
    });
    return ref.read(sharedPreferencesProvider).getInt(_activeWarehouseKey);
  }

  Future<void> select(int id) async {
    state = id;
    await ref.read(sharedPreferencesProvider).setInt(_activeWarehouseKey, id);
  }

  Future<void> clear() async {
    state = null;
    await ref.read(sharedPreferencesProvider).remove(_activeWarehouseKey);
  }
}

final activeWarehouseIdProvider =
    NotifierProvider<ActiveWarehouseIdNotifier, int?>(
      ActiveWarehouseIdNotifier.new,
    );

/// Almacén activo: el elegido si sigue asignado; si el usuario solo tiene
/// uno, ese. `null` si hay que elegir (o aún no cargan).
final activeWarehouseProvider = Provider<WarehouseSummary?>((ref) {
  final warehouses = ref.watch(warehousesProvider).value;
  if (warehouses == null || warehouses.isEmpty) return null;
  final selectedId = ref.watch(activeWarehouseIdProvider);
  for (final warehouse in warehouses) {
    if (warehouse.id == selectedId) return warehouse;
  }
  return warehouses.length == 1 ? warehouses.single : null;
});
