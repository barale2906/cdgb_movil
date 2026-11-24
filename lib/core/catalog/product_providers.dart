import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/catalog/product_repository.dart';

/// Productos activos filtrados por texto (nombre, código de barras o
/// referencia de marca). Texto vacío = todos.
final FutureProviderFamily<List<GenericProduct>, String> productSearchProvider =
    FutureProvider.autoDispose.family<List<GenericProduct>, String>(
      (ref, search) =>
          ref.watch(productRepositoryProvider).products(search: search),
    );

final FutureProviderFamily<GenericProduct, int> productDetailProvider =
    FutureProvider.autoDispose.family<GenericProduct, int>(
      (ref, id) => ref.watch(productRepositoryProvider).product(id),
    );
