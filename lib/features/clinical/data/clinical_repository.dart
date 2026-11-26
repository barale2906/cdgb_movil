import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_record.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/clinical/data/evolution.dart';
import 'package:sga_bojanini/features/clinical/data/sale_request.dart';

/// Filtros de la lista de registros. El servidor no pagina esta lista: se
/// acota siempre por fechas para no traer el historial completo.
@immutable
class RecordsQuery {
  const RecordsQuery({
    required this.dateFrom,
    required this.dateTo,
    this.document = '',
  });

  /// `AAAA-MM-DD`.
  final String dateFrom;
  final String dateTo;

  /// Documento del paciente; vacío = todos.
  final String document;

  Map<String, Object> toParams() => {
    'service_date_from': dateFrom,
    'service_date_to': dateTo,
    if (document.isNotEmpty) 'patient_document': document,
  };

  @override
  bool operator ==(Object other) =>
      other is RecordsQuery &&
      other.dateFrom == dateFrom &&
      other.dateTo == dateTo &&
      other.document == document;

  @override
  int get hashCode => Object.hash(dateFrom, dateTo, document);
}

/// Citas de MedSys, registros de procedimientos, ventas e historial
/// (`docs/app-movil/10-medsys.md` y `13-cost-center.md` del backend).
class ClinicalRepository {
  const ClinicalRepository(this._dio);

  final Dio _dio;

  Future<List<MedsysAppointment>> appointments(String patientCode) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/medsys/patients/${Uri.encodeComponent(patientCode)}/appointments',
        );
        return ApiResponse.list(response, MedsysAppointment.fromJson);
      });

  Future<List<ProcedureRecord>> records(RecordsQuery query) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/patient-procedure-records',
          queryParameters: query.toParams(),
        );
        return ApiResponse.list(response, ProcedureRecord.fromJson);
      });

  Future<ProcedureRecord> record(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/patient-procedure-records/$id');
    return ProcedureRecord.fromJson(ApiResponse.object(response));
  });

  /// Registra una venta (escritura: nunca se reintenta sola).
  Future<ProcedureRecord> createRecord(SaleRecordRequest request) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/patient-procedure-records',
          data: request.toJson(),
        );
        return ProcedureRecord.fromJson(ApiResponse.object(response));
      });

  Future<List<Evolution>> evolutions(int recordId) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/patient-procedure-records/$recordId/evolutions',
    );
    return ApiResponse.list(response, Evolution.fromJson);
  });

  /// Registra una evolución (escritura: nunca se reintenta sola). [html] es
  /// el contenido ya convertido a párrafos.
  Future<Evolution> createEvolution(int recordId, String html) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/patient-procedure-records/$recordId/evolutions',
          data: {'content': html},
        );
        return Evolution.fromJson(ApiResponse.object(response));
      });

  Future<Evolution> updateEvolution(
    int recordId,
    int evolutionId,
    String html,
  ) => apiCall(() async {
    final response = await _dio.put<dynamic>(
      '/patient-procedure-records/$recordId/evolutions/$evolutionId',
      data: {'content': html},
    );
    return Evolution.fromJson(ApiResponse.object(response));
  });

  Future<List<ProcedureMedication>> medications(int recordId) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/patient-procedure-records/$recordId/medications',
        );
        return ApiResponse.list(response, ProcedureMedication.fromJson);
      });

  Future<PatientHistory> history(String patientExternalId) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/patients/${Uri.encodeComponent(patientExternalId)}/procedure-records',
    );
    return PatientHistory.fromJson(ApiResponse.object(response));
  });
}

final clinicalRepositoryProvider = Provider<ClinicalRepository>(
  (ref) => ClinicalRepository(ref.watch(dioProvider)),
);
