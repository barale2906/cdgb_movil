import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/audit/data/audit_log.dart';

/// Bitácora de auditoría, solo consulta (`docs/app-movil/08-audit.md` del
/// backend; `export` queda fuera de la app).
class AuditRepository {
  const AuditRepository(this._dio);

  final Dio _dio;

  /// Registros del más reciente al más antiguo. [dateFrom] y [dateTo] son
  /// `AAAA-MM-DD`.
  Future<PagedList<AuditLog>> list({
    String? action,
    String? dateFrom,
    String? dateTo,
    int page = 1,
    int perPage = ApiResponse.defaultPageSize,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/audit-logs',
      queryParameters: {
        'action': ?action,
        'date_from': ?dateFrom,
        'date_to': ?dateTo,
        'page': page,
        'per_page': perPage,
      },
    );
    return ApiResponse.pageInData(response, AuditLog.fromJson);
  });

  Future<AuditLog> detail(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/audit-logs/$id');
    return AuditLog.fromJson(ApiResponse.object(response));
  });

  Future<AuditSummary> summary({
    required String dateFrom,
    required String dateTo,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/audit-logs/summary',
      queryParameters: {'date_from': dateFrom, 'date_to': dateTo},
    );
    return AuditSummary.fromJson(ApiResponse.object(response));
  });
}

final auditRepositoryProvider = Provider<AuditRepository>(
  (ref) => AuditRepository(ref.watch(dioProvider)),
);
