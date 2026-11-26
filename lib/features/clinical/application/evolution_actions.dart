import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/clinical_text.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';

/// Crear o editar una evolución. Es una escritura: bloquea el botón en vuelo
/// y **nunca se reintenta** sola. Tras un timeout se vuelve a consultar la
/// lista por si la evolución sí se guardó.
class EvolutionActions extends SubmissionNotifier {
  ClinicalRepository get _repository => ref.read(clinicalRepositoryProvider);

  /// Guarda [text] como evolución nueva ([evolutionId] `null`) o como edición
  /// de [evolutionId]. Devuelve `true` si el servidor la aceptó.
  Future<bool> save(int recordId, String text, {int? evolutionId}) async {
    final html = ClinicalText.toHtml(text);
    if (html.isEmpty) return false;
    final result = await runValue(
      () => evolutionId == null
          ? _repository.createEvolution(recordId, html)
          : _repository.updateEvolution(recordId, evolutionId, html),
    );
    final error = state.error;
    final timedOut =
        error is NetworkException && error.kind == NetworkFailureKind.timeout;
    if (result != null || timedOut) {
      ref.invalidate(recordEvolutionsProvider(recordId));
    }
    return result != null;
  }
}

final NotifierProvider<EvolutionActions, SubmissionState>
evolutionActionsProvider =
    NotifierProvider.autoDispose<EvolutionActions, SubmissionState>(
      EvolutionActions.new,
    );
