import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/cost_centers/data/medical_service_node.dart';

/// Servicios médicos y tarifas, solo lectura
/// (`docs/app-movil/13-cost-center.md` del backend).
class ServiceCatalogRepository {
  const ServiceCatalogRepository(this._dio);

  final Dio _dio;

  Future<List<MedicalServiceNode>> tree() => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/medical-services/tree',
      queryParameters: {'only_active': 1},
    );
    return ApiResponse.list(response, MedicalServiceNode.fromJson);
  });

  Future<List<ProcedurePrice>> prices(int procedureId) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/procedures/$procedureId/prices',
    );
    return ApiResponse.list(response, ProcedurePrice.fromJson);
  });
}

final serviceCatalogRepositoryProvider = Provider<ServiceCatalogRepository>(
  (ref) => ServiceCatalogRepository(ref.watch(dioProvider)),
);
