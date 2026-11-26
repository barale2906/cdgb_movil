import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/cache/read_cache.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/cost_centers/data/medical_service_node.dart';

/// Servicios médicos y tarifas, solo lectura
/// (`docs/app-movil/13-cost-center.md` del backend).
class ServiceCatalogRepository {
  const ServiceCatalogRepository(this._dio, this._cache);

  final Dio _dio;
  final ReadCache _cache;

  /// Árbol de servicios activos; sin red, la última copia.
  Future<List<MedicalServiceNode>> tree() => cachedList(
    cache: _cache,
    key: 'service_tree',
    fetch: () => apiCall(() async {
      final response = await _dio.get<dynamic>(
        '/medical-services/tree',
        queryParameters: {'only_active': 1},
      );
      return ApiResponse.rawList(response);
    }),
    parse: MedicalServiceNode.fromJson,
  );

  Future<List<ProcedurePrice>> prices(int procedureId) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/procedures/$procedureId/prices',
    );
    return ApiResponse.list(response, ProcedurePrice.fromJson);
  });
}

final serviceCatalogRepositoryProvider = Provider<ServiceCatalogRepository>(
  (ref) => ServiceCatalogRepository(
    ref.watch(dioProvider),
    ref.watch(readCacheProvider),
  ),
);
