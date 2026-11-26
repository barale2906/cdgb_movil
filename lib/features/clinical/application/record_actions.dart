import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';

/// Eliminar un registro de procedimiento. Es irreversible y es una escritura:
/// el botón se bloquea en vuelo y no se repite sola; tras un timeout se
/// vuelven a consultar las listas por si sí se eliminó.
class RecordActions extends SubmissionNotifier {
  Future<bool> delete(int id) async {
    final done = await run(
      () => ref.read(clinicalRepositoryProvider).deleteRecord(id),
    );
    final error = state.error;
    final timedOut =
        error is NetworkException && error.kind == NetworkFailureKind.timeout;
    if (done || timedOut) {
      ref
        ..invalidate(procedureRecordsProvider)
        ..invalidate(patientHistoryProvider)
        ..invalidate(procedureRecordProvider(id));
    }
    return done;
  }
}

final NotifierProvider<RecordActions, SubmissionState> recordActionsProvider =
    NotifierProvider.autoDispose<RecordActions, SubmissionState>(
      RecordActions.new,
    );
