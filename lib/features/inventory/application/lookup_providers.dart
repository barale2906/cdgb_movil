import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_repository.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/product_presentation.dart';

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
