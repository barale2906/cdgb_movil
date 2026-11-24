import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/catalog/data/supplier.dart';

/// Consulta de proveedores (solo lectura).
class SupplierRepository {
  const SupplierRepository(this._dio);

  final Dio _dio;

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

final supplierRepositoryProvider = Provider<SupplierRepository>(
  (ref) => SupplierRepository(ref.watch(dioProvider)),
);
