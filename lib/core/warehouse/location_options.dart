import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/warehouse/warehouse_capacity_provider.dart';

/// Ubicación elegible en un formulario: "Zona · Ubicación".
@immutable
class LocationOption {
  const LocationOption({required this.id, required this.label});

  final int id;
  final String label;
}

/// Ubicaciones de un almacén, aplanadas desde el árbol de capacidad (así
/// solo hace falta `almacenes.ver`, no `ubicaciones.ver`).
final FutureProviderFamily<List<LocationOption>, int> locationOptionsProvider =
    FutureProvider.autoDispose.family<List<LocationOption>, int>((
      ref,
      warehouseId,
    ) async {
      final capacity = await ref.watch(
        warehouseCapacityProvider(warehouseId).future,
      );
      return [
        for (final zone in capacity.zones)
          for (final location in zone.locations)
            LocationOption(
              id: location.id,
              label: '${zone.name} · ${location.name}',
            ),
      ];
    });
