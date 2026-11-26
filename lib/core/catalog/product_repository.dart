import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/cache/read_cache.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
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

  Future<GenericProduct> product(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/generic-products/$id');
    return GenericProduct.fromJson(ApiResponse.object(response));
  });
}

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) =>
      ProductRepository(ref.watch(dioProvider), ref.watch(readCacheProvider)),
);
