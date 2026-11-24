import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/features/catalog/data/catalog_repository.dart';
import 'package:sga_bojanini/features/catalog/data/generic_product.dart';
import 'package:sga_bojanini/features/catalog/data/supplier.dart';

/// Productos activos filtrados por texto (nombre, código de barras o
/// referencia de marca). Texto vacío = todos.
final FutureProviderFamily<List<GenericProduct>, String> productSearchProvider =
    FutureProvider.autoDispose.family<List<GenericProduct>, String>(
      (ref, search) =>
          ref.watch(catalogRepositoryProvider).products(search: search),
    );

final FutureProviderFamily<GenericProduct, int> productDetailProvider =
    FutureProvider.autoDispose.family<GenericProduct, int>(
      (ref, id) => ref.watch(catalogRepositoryProvider).product(id),
    );

final FutureProviderFamily<List<Supplier>, String> supplierSearchProvider =
    FutureProvider.autoDispose.family<List<Supplier>, String>(
      (ref, search) =>
          ref.watch(catalogRepositoryProvider).suppliers(search: search),
    );

final FutureProviderFamily<Supplier, int> supplierDetailProvider =
    FutureProvider.autoDispose.family<Supplier, int>(
      (ref, id) => ref.watch(catalogRepositoryProvider).supplier(id),
    );
