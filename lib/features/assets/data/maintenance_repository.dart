import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/signing/signoff.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_requests.dart';

/// Filtros del listado de mantenimientos.
@immutable
class MaintenanceQuery {
  const MaintenanceQuery({this.status, this.overdue = false, this.search = ''});

  final MaintenanceStatus? status;
  final bool overdue;
  final String search;

  Map<String, Object> toParams() => {
    if (status != null) 'status': status!.value,
    if (overdue) 'overdue': true,
    if (search.trim().isNotEmpty) 'search': search.trim(),
  };

  @override
  bool operator ==(Object other) =>
      other is MaintenanceQuery &&
      other.status == status &&
      other.overdue == overdue &&
      other.search == search;

  @override
  int get hashCode => Object.hash(status, overdue, search);
}

/// Ejecución de un mantenimiento (`POST …/complete`).
@immutable
class CompleteMaintenanceRequest {
  const CompleteMaintenanceRequest({
    required this.performedAt,
    required this.internal,
    required this.activities,
    required this.result,
    this.technicianId,
    this.supplierId,
    this.externalTechnicianName,
    this.findings,
    this.recommendations,
    this.parts = const [],
    this.cost,
    this.signoff,
  });

  /// Hora de Colombia en la que se hizo (no puede ser futura).
  final DateTime performedAt;
  final bool internal;
  final String activities;
  final MaintenanceResult result;
  final int? technicianId;
  final int? supplierId;
  final String? externalTechnicianName;
  final String? findings;
  final String? recommendations;
  final List<ReplacedPart> parts;
  final double? cost;

  /// Firmas opcionales de quien entrega y quien recibe el equipo.
  final ConfirmRequest? signoff;

  Map<String, Object> toJson() => {
    'performed_at': ColombiaTime.format(performedAt),
    'performed_by_type': internal ? 'internal' : 'external',
    'activities_performed': activities.trim(),
    'result': result.value,
    'technician_id': ?(internal ? technicianId : null),
    'supplier_id': ?(internal ? null : supplierId),
    if (!internal && (externalTechnicianName ?? '').trim().isNotEmpty)
      'external_technician_name': externalTechnicianName!.trim(),
    if ((findings ?? '').trim().isNotEmpty) 'findings': findings!.trim(),
    if ((recommendations ?? '').trim().isNotEmpty)
      'recommendations': recommendations!.trim(),
    if (parts.isNotEmpty)
      'parts_replaced': [
        for (final part in parts)
          {
            'name': part.name.trim(),
            'quantity': part.quantity ?? 1,
            'cost': ?part.cost,
          },
      ],
    'cost': ?cost,
    ...?signoff?.toJson().cast<String, Object>(),
  };
}

/// Mantenimientos de activos. Iniciar, completar y cancelar son escrituras:
/// nunca se reintentan solas.
class MaintenanceRepository {
  const MaintenanceRepository(this._dio);

  final Dio _dio;

  Future<PagedList<AssetMaintenance>> list(
    MaintenanceQuery query, {
    int page = 1,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/assets/maintenances',
      queryParameters: {
        ...query.toParams(),
        'page': page,
        'per_page': ApiResponse.defaultPageSize,
      },
    );
    return ApiResponse.page(response, AssetMaintenance.fromJson);
  });

  Future<AssetMaintenance> get(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/assets/maintenances/$id');
    return AssetMaintenance.fromJson(ApiResponse.object(response));
  });

  Future<List<MaintenancePlan>> plans(int assetId) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/assets/$assetId/maintenance-plans',
    );
    return ApiResponse.list(response, MaintenancePlan.fromJson);
  });

  /// Programa un mantenimiento puntual del activo. Escritura: no se reintenta.
  Future<AssetMaintenance> schedule(
    int assetId,
    ScheduleMaintenanceRequest request,
  ) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/assets/$assetId/maintenances',
      data: request.toJson(),
    );
    return AssetMaintenance.fromJson(ApiResponse.object(response));
  });

  /// Cambia la fecha (y la falla reportada) de un mantenimiento programado.
  Future<AssetMaintenance> reschedule(
    int id,
    DateTime date, {
    String? reportedFailure,
  }) => apiCall(() async {
    final response = await _dio.put<dynamic>(
      '/assets/maintenances/$id',
      data: {
        'scheduled_date': ColombiaTime.formatDate(date),
        if ((reportedFailure ?? '').trim().isNotEmpty)
          'reported_failure': reportedFailure!.trim(),
      },
    );
    return AssetMaintenance.fromJson(ApiResponse.object(response));
  });

  Future<MaintenancePlan> createPlan(
    int assetId,
    MaintenancePlanRequest request,
  ) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/assets/$assetId/maintenance-plans',
      data: request.toJson(),
    );
    return MaintenancePlan.fromJson(ApiResponse.object(response));
  });

  Future<MaintenancePlan> updatePlan(
    int planId,
    MaintenancePlanRequest request,
  ) => apiCall(() async {
    final response = await _dio.put<dynamic>(
      '/assets/maintenance-plans/$planId',
      data: request.toJson(),
    );
    return MaintenancePlan.fromJson(ApiResponse.object(response));
  });

  Future<AssetMaintenance> start(int id) => _post(id, 'start');

  Future<AssetMaintenance> complete(
    int id,
    CompleteMaintenanceRequest request,
  ) => _post(id, 'complete', data: request.toJson());

  Future<AssetMaintenance> cancel(int id, String reason) =>
      _post(id, 'cancel', data: {'reason': reason.trim()});

  /// Reporte del mantenimiento en PDF (binario).
  Future<Uint8List> report(int id) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/assets/maintenances/$id/report',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? const []);
  });

  Future<AssetMaintenance> _post(
    int id,
    String action, {
    Map<String, Object>? data,
  }) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/assets/maintenances/$id/$action',
      data: data,
    );
    return AssetMaintenance.fromJson(ApiResponse.object(response));
  });
}

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>(
  (ref) => MaintenanceRepository(ref.watch(dioProvider)),
);
