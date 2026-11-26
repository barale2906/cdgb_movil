import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/dashboard/data/dashboard_models.dart';

/// Tablero (`tablero.ver`). El backend calcula cada bloque para toda la
/// clínica y lo guarda 5 minutos.
class DashboardRepository {
  const DashboardRepository(this._dio);

  final Dio _dio;

  Future<InventoryDashboard> inventory() => apiCall(() async {
    final response = await _dio.get<dynamic>('/dashboard/inventory');
    return InventoryDashboard.fromJson(ApiResponse.object(response));
  });

  Future<PurchasingDashboard> purchasing() => apiCall(() async {
    final response = await _dio.get<dynamic>('/dashboard/purchasing');
    return PurchasingDashboard.fromJson(ApiResponse.object(response));
  });

  Future<MonitoringDashboard> monitoring() => apiCall(() async {
    final response = await _dio.get<dynamic>('/dashboard/monitoring');
    return MonitoringDashboard.fromJson(ApiResponse.object(response));
  });

  Future<List<ActivityEntry>> activity() => apiCall(() async {
    final response = await _dio.get<dynamic>('/dashboard/activity');
    return ApiResponse.list(response, ActivityEntry.fromJson);
  });

  Future<List<DashboardAlert>> alerts() => apiCall(() async {
    final response = await _dio.get<dynamic>('/dashboard/alerts');
    return ApiResponse.list(response, DashboardAlert.fromJson);
  });
}

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepository(ref.watch(dioProvider)),
);
