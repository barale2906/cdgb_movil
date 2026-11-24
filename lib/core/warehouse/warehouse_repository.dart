import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_summary.dart';

class WarehouseRepository {
  const WarehouseRepository(this._dio);

  final Dio _dio;

  /// Almacenes del usuario (el backend ya filtra por asignación).
  Future<List<WarehouseSummary>> list() => apiCall(() async {
    final response = await _dio.get<dynamic>('/warehouses');
    return ApiResponse.list(response, WarehouseSummary.fromJson);
  });
}

final warehouseRepositoryProvider = Provider<WarehouseRepository>(
  (ref) => WarehouseRepository(ref.watch(dioProvider)),
);
