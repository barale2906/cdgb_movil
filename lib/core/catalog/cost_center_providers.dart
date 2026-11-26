import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/cache/read_cache.dart';
import 'package:sga_bojanini/core/catalog/cost_center.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';

/// Centros de costo (`GET /cost-centers`, `centros_costo.ver`).
class CostCenterRepository {
  const CostCenterRepository(this._dio, this._cache);

  final Dio _dio;
  final ReadCache _cache;

  /// Activos, filtrados por texto (nombre o código); vacío = todos. El
  /// listado completo guarda copia local y, sin red, se usa.
  Future<List<CostCenter>> list({String search = ''}) {
    Future<List<Json>> fetch() => apiCall(() async {
      final response = await _dio.get<dynamic>(
        '/cost-centers',
        queryParameters: {
          'is_active': 1,
          if (search.isNotEmpty) 'search': search,
        },
      );
      return ApiResponse.rawList(response);
    });
    if (search.isNotEmpty) {
      return fetch().then((raw) => raw.map(CostCenter.fromJson).toList());
    }
    return cachedList(
      cache: _cache,
      key: 'cost_centers',
      fetch: fetch,
      parse: CostCenter.fromJson,
    );
  }
}

final costCenterRepositoryProvider = Provider<CostCenterRepository>(
  (ref) => CostCenterRepository(
    ref.watch(dioProvider),
    ref.watch(readCacheProvider),
  ),
);

/// Centros de costo activos filtrados por texto.
final FutureProviderFamily<List<CostCenter>, String> costCenterListProvider =
    FutureProvider.autoDispose.family<List<CostCenter>, String>(
      (ref, search) =>
          ref.watch(costCenterRepositoryProvider).list(search: search),
    );
