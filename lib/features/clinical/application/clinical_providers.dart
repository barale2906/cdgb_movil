import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show FutureProviderFamily;
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';
import 'package:sga_bojanini/features/clinical/data/medsys_patient.dart';
import 'package:sga_bojanini/features/clinical/data/procedure_record.dart';

/// Ventana de la lista de registros (el servidor no la pagina).
const recordsWindowDays = 30;

/// Búsqueda de pacientes; con menos de 3 caracteres no consulta.
final FutureProviderFamily<List<MedsysPatient>, String> patientSearchProvider =
    FutureProvider.autoDispose.family<List<MedsysPatient>, String>(
      (ref, term) => term.length < ClinicalRepository.minSearchLength
          ? const []
          : ref.watch(clinicalRepositoryProvider).searchPatients(term),
    );

final FutureProviderFamily<List<MedsysAppointment>, String>
patientAppointmentsProvider = FutureProvider.autoDispose
    .family<List<MedsysAppointment>, String>(
      (ref, code) => ref.watch(clinicalRepositoryProvider).appointments(code),
    );

/// Registros de los últimos `recordsWindowDays` días; el texto buscado filtra
/// por documento del paciente.
final FutureProviderFamily<List<ProcedureRecord>, String>
procedureRecordsProvider = FutureProvider.autoDispose
    .family<List<ProcedureRecord>, String>((ref, document) {
      final today = ColombiaTime.now(ref.watch(clockProvider));
      return ref
          .watch(clinicalRepositoryProvider)
          .records(
            RecordsQuery(
              dateFrom: ColombiaTime.formatDate(
                today.subtract(const Duration(days: recordsWindowDays)),
              ),
              dateTo: ColombiaTime.formatDate(today),
              document: document,
            ),
          );
    });

final FutureProviderFamily<ProcedureRecord, int> procedureRecordProvider =
    FutureProvider.autoDispose.family<ProcedureRecord, int>(
      (ref, id) => ref.watch(clinicalRepositoryProvider).record(id),
    );

final FutureProviderFamily<PatientHistory, String> patientHistoryProvider =
    FutureProvider.autoDispose.family<PatientHistory, String>(
      (ref, externalId) =>
          ref.watch(clinicalRepositoryProvider).history(externalId),
    );
