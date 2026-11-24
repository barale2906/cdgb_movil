import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/catalog/data/generic_product.dart';
import 'package:sga_bojanini/features/catalog/data/supplier.dart';

/// Consulta del catálogo (solo lectura). El backend no pagina estos
/// listados: se acotan con `search`.
class CatalogRepository {
  const CatalogRepository(this._dio);

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

  Future<List<Supplier>> suppliers({String search = ''}) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/suppliers',
      queryParameters: {
        'is_active': true,
        if (search.isNotEmpty) 'search': search,
      },
    );
    return ApiResponse.list(response, Supplier.fromJson);
  });

  Future<Supplier> supplier(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/suppliers/$id');
    return Supplier.fromJson(ApiResponse.object(response));
  });
}

final catalogRepositoryProvider = Provider<CatalogRepository>(
  (ref) => CatalogRepository(ref.watch(dioProvider)),
);
