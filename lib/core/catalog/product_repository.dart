import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';

/// Consulta de productos genéricos (solo lectura). El backend no pagina
/// este listado: se acota con `search`.
class ProductRepository {
  const ProductRepository(this._dio);

  final Dio _dio;

  Future<List<GenericProduct>> products({String search = ''}) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/generic-products',
          queryParameters: {
            'is_active': true,
            if (search.isNotEmpty) 'search': search,
          },
        );
        return ApiResponse.list(response, GenericProduct.fromJson);
      });

  Future<GenericProduct> product(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/generic-products/$id');
    return GenericProduct.fromJson(ApiResponse.object(response));
  });
}

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepository(ref.watch(dioProvider)),
);
