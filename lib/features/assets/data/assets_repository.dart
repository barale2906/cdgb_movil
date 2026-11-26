import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/data/asset_events.dart';

/// Filtros del listado de activos.
@immutable
class AssetQuery {
  const AssetQuery({
    this.search = '',
    this.status,
    this.siteId,
    this.maintenanceOverdue = false,
    this.offPremises = false,
  });

  final String search;
  final AssetStatus? status;
  final int? siteId;
  final bool maintenanceOverdue;
  final bool offPremises;

  Map<String, Object> toParams() => {
    if (search.trim().isNotEmpty) 'search': search.trim(),
    if (status != null) 'status': status!.value,
    'site_id': ?siteId,
    if (maintenanceOverdue) 'maintenance_overdue': true,
    if (offPremises) 'is_off_premises': true,
  };

  @override
  bool operator ==(Object other) =>
      other is AssetQuery &&
      other.search == search &&
      other.status == status &&
      other.siteId == siteId &&
      other.maintenanceOverdue == maintenanceOverdue &&
      other.offPremises == offPremises;

  @override
  int get hashCode =>
      Object.hash(search, status, siteId, maintenanceOverdue, offPremises);
}

/// Activos (`docs/app-movil/15-assets.md` del backend): consulta, hoja de
/// vida y comentarios.
class AssetsRepository {
  const AssetsRepository(this._dio);

  final Dio _dio;

  Future<PagedList<Asset>> list(AssetQuery query, {int page = 1}) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/assets',
          queryParameters: {
            ...query.toParams(),
            'page': page,
            'per_page': ApiResponse.defaultPageSize,
          },
        );
        return ApiResponse.page(response, Asset.fromJson);
      });

  /// Activo por el código de su etiqueta; `null` si no existe. La búsqueda
  /// del servidor es parcial: se exige coincidencia exacta del código.
  Future<Asset?> byCode(String code) async {
    final page = await list(AssetQuery(search: code));
    for (final asset in page.items) {
      if (asset.code == code.trim()) return asset;
    }
    return null;
  }

  Future<Asset> get(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/assets/$id');
    return Asset.fromJson(ApiResponse.object(response));
  });

  Future<AssetFilters> filters() => apiCall(() async {
    final response = await _dio.get<dynamic>('/assets/filters');
    return AssetFilters.fromJson(ApiResponse.object(response));
  });

  Future<AssetStatistics> statistics() => apiCall(() async {
    final response = await _dio.get<dynamic>('/assets/statistics');
    return AssetStatistics.fromJson(ApiResponse.object(response));
  });

  Future<PagedList<AssetMovement>> movements(int id, {int page = 1}) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/assets/$id/movements',
          queryParameters: {
            'page': page,
            'per_page': ApiResponse.defaultPageSize,
          },
        );
        return ApiResponse.page(response, AssetMovement.fromJson);
      });

  Future<List<LocationRecord>> locationHistory(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/assets/$id/location-history');
    return ApiResponse.list(response, LocationRecord.fromJson);
  });

  Future<List<AssetComment>> comments(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/assets/$id/comments');
    return ApiResponse.list(response, AssetComment.fromJson);
  });

  /// Agrega un comentario (no se edita ni elimina). Escritura: no se reintenta.
  Future<AssetComment> addComment(int id, String comment) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/assets/$id/comments',
      data: {'comment': comment.trim()},
    );
    return AssetComment.fromJson(ApiResponse.object(response));
  });

  /// Cambia el estado (operativo, en mantenimiento, fuera de servicio,
  /// disponible). Escritura: no se reintenta.
  Future<Asset> changeStatus(int id, AssetStatus status, {String? reason}) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/assets/$id/status',
          data: {
            'status': status.value,
            if ((reason ?? '').trim().isNotEmpty) 'reason': reason!.trim(),
          },
        );
        return Asset.fromJson(ApiResponse.object(response));
      });

  /// Hoja de vida en PDF (binario).
  Future<Uint8List> lifeSheet(int id) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/assets/$id/life-sheet',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? const []);
  });
}

final assetsRepositoryProvider = Provider<AssetsRepository>(
  (ref) => AssetsRepository(ref.watch(dioProvider)),
);
