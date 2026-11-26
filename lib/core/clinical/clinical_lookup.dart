import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';

/// Búsquedas que comparten registros clínicos y órdenes de servicio:
/// pacientes de MedSys y procedimientos con su tarifa vigente.
class ClinicalLookupRepository {
  const ClinicalLookupRepository(this._dio);

  /// Largo mínimo del término de búsqueda de pacientes que acepta el servidor.
  static const minPatientSearchLength = 3;

  /// Largo mínimo del texto al buscar procedimientos.
  static const minProcedureSearchLength = 2;

  final Dio _dio;

  /// Pacientes por documento (solo dígitos) o por nombre. El servidor
  /// responde `{patients: [...]}` aunque la búsqueda sea por documento.
  Future<List<MedsysPatient>> searchPatients(String term) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/medsys/patients',
      queryParameters: {'search': term},
    );
    final patients = ApiResponse.object(response)['patients'];
    if (patients is! List<dynamic>) return const [];
    return [
      for (final item in patients)
        MedsysPatient.fromJson(item as Map<String, dynamic>),
    ];
  });

  /// Procedimientos por nombre o código, con su tarifa vigente.
  Future<List<ProcedureMatch>> searchProcedures(String query) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/medical-services/search',
          queryParameters: {'q': query},
        );
        return ApiResponse.list(response, ProcedureMatch.fromJson);
      });
}

final clinicalLookupRepositoryProvider = Provider<ClinicalLookupRepository>(
  (ref) => ClinicalLookupRepository(ref.watch(dioProvider)),
);

/// Búsqueda de pacientes; con menos de 3 caracteres no consulta.
final FutureProviderFamily<List<MedsysPatient>, String> patientSearchProvider =
    FutureProvider.autoDispose.family<List<MedsysPatient>, String>(
      (ref, term) =>
          term.length < ClinicalLookupRepository.minPatientSearchLength
          ? const []
          : ref.watch(clinicalLookupRepositoryProvider).searchPatients(term),
    );

/// Búsqueda de procedimientos; con menos de 2 caracteres no consulta.
final FutureProviderFamily<List<ProcedureMatch>, String>
procedureSearchProvider = FutureProvider.autoDispose
    .family<List<ProcedureMatch>, String>(
      (ref, term) =>
          term.length < ClinicalLookupRepository.minProcedureSearchLength
          ? const []
          : ref.watch(clinicalLookupRepositoryProvider).searchProcedures(term),
    );
