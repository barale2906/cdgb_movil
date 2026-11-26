import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/consumptions/data/consumption_record.dart';
import 'package:sga_bojanini/features/consumptions/data/new_consumption_request.dart';

/// Consumos y proyección (`docs/app-movil/09-integration.md` y `10-medsys.md`
/// del backend).
class ConsumptionsRepository {
  const ConsumptionsRepository(this._dio);

  /// Días de historia con los que MedSys calcula el promedio por cita.
  static const historicalDays = 90;

  final Dio _dio;

  /// Consumos, del más reciente al más antiguo. A diferencia de otras listas,
  /// este endpoint responde `data: {items, meta}`.
  Future<PagedList<ConsumptionRecord>> list({
    SyncStatus? status,
    int page = 1,
    int perPage = ApiResponse.defaultPageSize,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/consumptions',
      queryParameters: {
        if (status != null) 'sync_status': status.value,
        'page': page,
        'per_page': perPage,
      },
    );
    final data = ApiResponse.object(response);
    final items = data['items'];
    final meta = data['meta'];
    if (items is! List<dynamic> || meta is! Json) {
      throw ServerException(
        'Respuesta inesperada del servidor.',
        statusCode: response.statusCode,
      );
    }
    return PagedList(
      items: [
        for (final item in items)
          ConsumptionRecord.fromJson(item as Map<String, dynamic>),
      ],
      meta: PageMeta.fromJson(meta),
    );
  });

  Future<ConsumptionRecord> detail(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/consumptions/$id');
    return ConsumptionRecord.fromJson(ApiResponse.object(response));
  });

  /// Registra el consumo (escritura: nunca se reintenta sola). El servidor lo
  /// guarda todo o nada.
  Future<List<ConsumptionRecord>> create(NewConsumptionRequest request) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/consumptions',
          data: request.toJson(),
        );
        final records = ApiResponse.object(response)['records'];
        return [
          if (records is List<dynamic>)
            for (final record in records)
              ConsumptionRecord.fromJson(record as Map<String, dynamic>),
        ];
      });

  /// Vuelve a encolar la sincronización de un consumo fallido.
  Future<void> retrySync(int id) => apiCall(() async {
    final response = await _dio.post<dynamic>('/consumptions/$id/retry-sync');
    ApiResponse.message(response);
  });

  /// Proyección de consumo por servicio para los próximos [days] días.
  Future<List<ServiceProjection>> projection({required int days}) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/medsys/consumption-projection',
          queryParameters: {'days': days, 'historical_days': historicalDays},
        );
        return ApiResponse.list(response, ServiceProjection.fromJson);
      });
}

final consumptionsRepositoryProvider = Provider<ConsumptionsRepository>(
  (ref) => ConsumptionsRepository(ref.watch(dioProvider)),
);
