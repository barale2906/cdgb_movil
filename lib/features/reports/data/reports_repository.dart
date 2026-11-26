import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';

/// Sensor mínimo para el filtro del reporte de condiciones.
class ReportSensor {
  const ReportSensor({required this.id, required this.name});

  final int id;
  final String name;
}

/// Reportes y exportaciones (`docs/app-movil/11-reports.md`).
class ReportsRepository {
  const ReportsRepository(this._dio);

  final Dio _dio;

  /// Pide un reporte. Lo pequeño llega como archivo (200); lo grande se
  /// genera en segundo plano (202) y se sigue en las exportaciones.
  Future<ReportResult> generate(
    ReportType type,
    ReportFormat format, {
    Map<String, Object?> filters = const {},
    DateTime? now,
  }) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/reports/${type.path}',
      queryParameters: {
        'format': format.value,
        for (final entry in filters.entries)
          if (entry.value != null) entry.key: entry.value,
      },
      options: Options(
        responseType: ResponseType.bytes,
        validateStatus: (status) =>
            status != null && status >= 200 && status < 300,
      ),
    );
    final bytes = Uint8List.fromList(response.data ?? const []);
    if (response.statusCode == 202) return ReportQueued(_exportId(bytes));
    final stamp = (now ?? DateTime.now()).toIso8601String().substring(0, 10);
    return ReportFile(
      bytes: bytes,
      fileName: '${type.path}_$stamp.${format.extension}',
      format: format,
    );
  });

  Future<PagedList<ReportExport>> exports({int page = 1}) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/reports/exports',
      queryParameters: {'page': page, 'per_page': ApiResponse.defaultPageSize},
    );
    return ApiResponse.page(response, ReportExport.fromJson);
  });

  Future<Uint8List> downloadExport(String id) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/reports/exports/$id/download',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? const []);
  });

  /// Sensores asignados (id y nombre) para el reporte de condiciones.
  Future<List<ReportSensor>> sensors() => apiCall(() async {
    final response = await _dio.get<dynamic>('/sensors');
    return ApiResponse.list(
      response,
      (json) => ReportSensor(id: json['id'] as int, name: '${json['name']}'),
    );
  });

  static String _exportId(Uint8List bytes) {
    final body = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    final data = body['data'] as Map<String, dynamic>;
    return '${data['export_id']}';
  }
}

final reportsRepositoryProvider = Provider<ReportsRepository>(
  (ref) => ReportsRepository(ref.watch(dioProvider)),
);
