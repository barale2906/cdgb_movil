import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/features/warehouse/data/warehouse_capacity.dart';
import 'package:sga_bojanini/features/warehouse/data/warehouse_capacity_repository.dart';

/// Capacidad de un almacén (volumen y peso por zona y ubicación). Se
/// descarta al salir de la pantalla: los datos cambian con cada movimiento.
final FutureProviderFamily<WarehouseCapacity, int> warehouseCapacityProvider =
    FutureProvider.autoDispose.family<WarehouseCapacity, int>(
      (ref, id) => ref.watch(warehouseCapacityRepositoryProvider).capacity(id),
    );
