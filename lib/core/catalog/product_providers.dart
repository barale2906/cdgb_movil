import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/catalog/expiring_elsewhere.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/catalog/product_presentation.dart';
import 'package:sga_bojanini/core/catalog/product_repository.dart';
import 'package:sga_bojanini/core/catalog/supplier.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';

/// Productos activos filtrados por texto (nombre, código de barras o
/// referencia de marca). Texto vacío = todos.
final FutureProviderFamily<List<GenericProduct>, String> productSearchProvider =
    FutureProvider.autoDispose.family<List<GenericProduct>, String>(
      (ref, search) =>
          ref.watch(productRepositoryProvider).products(search: search),
    );

/// Unidades de un kit que se pueden armar con el stock del almacén activo;
/// `null` si el usuario no tiene `stock.ver` o aún no hay almacén activo.
final FutureProviderFamily<double?, int> kitAvailabilityProvider =
    FutureProvider.autoDispose.family<double?, int>((ref, productId) {
      final canSee = ref.watch(
        permissionServiceProvider.select((p) => p.can('stock.ver')),
      );
      final warehouseId = ref.watch(activeWarehouseProvider)?.id;
      if (!canSee || warehouseId == null) return null;
      return ref
          .watch(productRepositoryProvider)
          .kitAvailability(
            genericProductId: productId,
            warehouseId: warehouseId,
          );
    });

/// Presentaciones de un producto.
final FutureProviderFamily<List<ProductPresentation>, int>
presentationsProvider = FutureProvider.autoDispose
    .family<List<ProductPresentation>, int>(
      (ref, genericId) =>
          ref.watch(productRepositoryProvider).presentations(genericId),
    );

final FutureProviderFamily<GenericProduct, int> productDetailProvider =
    FutureProvider.autoDispose.family<GenericProduct, int>(
      (ref, id) => ref.watch(productRepositoryProvider).product(id),
    );

/// Lotes del producto que vencen pronto en otros almacenes (todos menos el
/// activo); `null` si el usuario no tiene `lotes.ver`.
final FutureProviderFamily<ExpiringElsewhere?, int>
otherWarehousesExpiringProvider = FutureProvider.autoDispose
    .family<ExpiringElsewhere?, int>((ref, productId) {
      final canSee = ref.watch(
        permissionServiceProvider.select((p) => p.can('lotes.ver')),
      );
      if (!canSee) return null;
      return ref
          .watch(productRepositoryProvider)
          .otherWarehousesExpiring(
            genericProductId: productId,
            excludeWarehouseId: ref.watch(activeWarehouseProvider)?.id,
          );
    });

/// Proveedores de una variante; `null` si el usuario no tiene
/// `proveedores.ver`.
final FutureProviderFamily<List<Supplier>?, int> variantSuppliersProvider =
    FutureProvider.autoDispose.family<List<Supplier>?, int>((ref, variantId) {
      final canSee = ref.watch(
        permissionServiceProvider.select((p) => p.can('proveedores.ver')),
      );
      if (!canSee) return null;
      return ref.watch(productRepositoryProvider).variantSuppliers(variantId);
    });
