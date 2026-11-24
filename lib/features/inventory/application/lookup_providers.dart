import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/warehouse/warehouse_capacity_provider.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_repository.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/product_presentation.dart';

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

final FutureProvider<List<CostCenterRef>> costCentersProvider =
    FutureProvider.autoDispose<List<CostCenterRef>>(
      (ref) => ref.watch(inventoryRepositoryProvider).costCenters(),
    );

final FutureProviderFamily<List<ProductPresentation>, int>
presentationsProvider = FutureProvider.autoDispose
    .family<List<ProductPresentation>, int>(
      (ref, genericId) =>
          ref.watch(inventoryRepositoryProvider).presentations(genericId),
    );

/// Consulta de lotes de un producto para los selectores de movimientos.
@immutable
class ProductBatchQuery {
  const ProductBatchQuery({
    required this.genericProductId,
    this.warehouseId,
    this.availableForExit = false,
  });

  final int genericProductId;
  final int? warehouseId;
  final bool availableForExit;

  @override
  bool operator ==(Object other) =>
      other is ProductBatchQuery &&
      other.genericProductId == genericProductId &&
      other.warehouseId == warehouseId &&
      other.availableForExit == availableForExit;

  @override
  int get hashCode =>
      Object.hash(genericProductId, warehouseId, availableForExit);
}

final FutureProviderFamily<List<Batch>, ProductBatchQuery>
productBatchesProvider = FutureProvider.autoDispose
    .family<List<Batch>, ProductBatchQuery>(
      (ref, query) => ref
          .watch(inventoryRepositoryProvider)
          .productBatches(
            query.genericProductId,
            warehouseId: query.warehouseId,
            availableForExit: query.availableForExit,
          ),
    );
