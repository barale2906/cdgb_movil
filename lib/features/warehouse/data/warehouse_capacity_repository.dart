import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/warehouse/data/warehouse_capacity.dart';

class WarehouseCapacityRepository {
  const WarehouseCapacityRepository(this._dio);

  final Dio _dio;

  Future<WarehouseCapacity> capacity(int warehouseId) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/warehouses/$warehouseId/capacity',
    );
    return WarehouseCapacity.fromJson(ApiResponse.object(response));
  });
}

final warehouseCapacityRepositoryProvider =
    Provider<WarehouseCapacityRepository>(
      (ref) => WarehouseCapacityRepository(ref.watch(dioProvider)),
    );
