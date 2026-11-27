import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/cache/read_cache.dart';
import 'package:sga_bojanini/core/catalog/supplier.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';

/// Consulta de proveedores (solo lectura).
class SupplierRepository {
  const SupplierRepository(this._dio, this._cache);

  final Dio _dio;
  final ReadCache _cache;

  /// Proveedores activos. El listado completo (sin texto) guarda copia local
  /// y, sin red, se usa; las búsquedas con texto siempre son en línea.
  Future<List<Supplier>> suppliers({String search = ''}) {
    Future<List<Json>> fetch() => apiCall(() async {
      final response = await _dio.get<dynamic>(
        '/suppliers',
        queryParameters: {
          'is_active': true,
          if (search.isNotEmpty) 'search': search,
        },
      );
      return ApiResponse.rawList(response);
    });
    if (search.isNotEmpty) {
      return fetch().then((raw) => raw.map(Supplier.fromJson).toList());
    }
    return cachedList(
      cache: _cache,
      key: 'suppliers',
      fetch: fetch,
      parse: Supplier.fromJson,
    );
  }

  Future<Supplier> supplier(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/suppliers/$id');
    return Supplier.fromJson(ApiResponse.object(response));
  });
}

final supplierRepositoryProvider = Provider<SupplierRepository>(
  (ref) =>
      SupplierRepository(ref.watch(dioProvider), ref.watch(readCacheProvider)),
);
