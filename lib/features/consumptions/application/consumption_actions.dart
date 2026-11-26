import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/consumptions/application/consumptions_providers.dart';
import 'package:sga_bojanini/features/consumptions/data/consumptions_repository.dart';

/// Reintentar la sincronización de un consumo fallido. Es una escritura: el
/// botón se bloquea en vuelo y no se repite sola; tras un timeout se vuelve a
/// consultar el consumo por si sí se reencoló.
class ConsumptionActions extends SubmissionNotifier {
  Future<bool> retrySync(int id) async {
    final done = await run(
      () => ref.read(consumptionsRepositoryProvider).retrySync(id),
    );
    final error = state.error;
    final timedOut =
        error is NetworkException && error.kind == NetworkFailureKind.timeout;
    if (done || timedOut) {
      ref
        ..invalidate(consumptionDetailProvider(id))
        ..invalidate(consumptionListProvider);
    }
    return done;
  }
}

final NotifierProvider<ConsumptionActions, SubmissionState>
consumptionActionsProvider =
    NotifierProvider.autoDispose<ConsumptionActions, SubmissionState>(
      ConsumptionActions.new,
    );
