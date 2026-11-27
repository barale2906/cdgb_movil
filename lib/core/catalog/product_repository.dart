import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/cache/read_cache.dart';
import 'package:sga_bojanini/core/catalog/expiring_elsewhere.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/catalog/product_presentation.dart';
import 'package:sga_bojanini/core/catalog/supplier.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';

/// Consulta de productos genéricos (solo lectura). El backend no pagina
/// este listado: se acota con `search`.
class ProductRepository {
  const ProductRepository(this._dio, this._cache);

  final Dio _dio;
  final ReadCache _cache;

  /// Productos activos. El listado completo (sin texto) guarda copia local y,
  /// sin red, se usa; las búsquedas con texto siempre son en línea.
  Future<List<GenericProduct>> products({String search = ''}) {
    Future<List<Json>> fetch() => apiCall(() async {
      final response = await _dio.get<dynamic>(
        '/generic-products',
        queryParameters: {
          'is_active': true,
          if (search.isNotEmpty) 'search': search,
        },
      );
      return ApiResponse.rawList(response);
    });
    if (search.isNotEmpty) {
      return fetch().then((raw) => raw.map(GenericProduct.fromJson).toList());
    }
    return cachedList(
      cache: _cache,
      key: 'products',
      fetch: fetch,
      parse: GenericProduct.fromJson,
    );
  }

  /// Producto por código de barras (`generic-products.barcode`); lanza
  /// `NotFoundException` si no existe.
  Future<GenericProduct> byBarcode(String code) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/generic-products/barcode/${Uri.encodeComponent(code)}',
    );
    return GenericProduct.fromJson(ApiResponse.object(response));
  });

  /// Unidades de kit que se pueden armar con el stock de componentes del
  /// almacén (`stock.ver`).
  Future<double> kitAvailability({
    required int genericProductId,
    required int warehouseId,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/generic-products/$genericProductId/kit-availability',
      queryParameters: {'warehouse_id': warehouseId},
    );
    final value = ApiResponse.object(response)['available_kits'];
    return value is num ? value.toDouble() : 0;
  });

  /// Lotes del producto que vencen pronto en otros almacenes (`lotes.ver`).
  /// El servidor decide la ventana de días y solo devuelve los almacenes a
  /// los que el usuario tiene acceso.
  Future<ExpiringElsewhere> otherWarehousesExpiring({
    required int genericProductId,
    int? excludeWarehouseId,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/generic-products/$genericProductId/batches/other-warehouses-expiring',
      queryParameters: {'exclude_warehouse_id': ?excludeWarehouseId},
    );
    return ExpiringElsewhere.fromJson(ApiResponse.object(response));
  });

  /// Proveedores de una variante (`proveedores.ver`).
  Future<List<Supplier>> variantSuppliers(int variantId) => apiCall(() async {
    final response = await _dio.get<dynamic>('/variants/$variantId/suppliers');
    return ApiResponse.list(response, Supplier.fromJson);
  });

  /// Presentaciones (caja, blíster…) de un producto, con su factor a unidad
  /// base.
  Future<List<ProductPresentation>> presentations(int genericProductId) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/generic-products/$genericProductId/presentations',
        );
        return ApiResponse.list(response, ProductPresentation.fromJson);
      });

  Future<GenericProduct> product(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/generic-products/$id');
    return GenericProduct.fromJson(ApiResponse.object(response));
  });
}

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) =>
      ProductRepository(ref.watch(dioProvider), ref.watch(readCacheProvider)),
);
