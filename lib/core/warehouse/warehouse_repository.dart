import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/cache/read_cache.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_summary.dart';

class WarehouseRepository {
  const WarehouseRepository(this._dio, this._cache);

  final Dio _dio;
  final ReadCache _cache;

  /// Almacenes del usuario (el backend ya filtra por asignación); sin red,
  /// la última copia.
  Future<List<WarehouseSummary>> list() => cachedList(
    cache: _cache,
    key: 'warehouses',
    fetch: () => apiCall(() async {
      final response = await _dio.get<dynamic>('/warehouses');
      return ApiResponse.rawList(response);
    }),
    parse: WarehouseSummary.fromJson,
  );
}

final warehouseRepositoryProvider = Provider<WarehouseRepository>(
  (ref) =>
      WarehouseRepository(ref.watch(dioProvider), ref.watch(readCacheProvider)),
);
