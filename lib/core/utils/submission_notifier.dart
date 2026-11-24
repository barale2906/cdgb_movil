import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';

/// Estado de un formulario que escribe en el servidor.
@immutable
class SubmissionState {
  const SubmissionState({this.isSubmitting = false, this.error});

  final bool isSubmitting;
  final ApiException? error;
}

/// Base de los controladores de formularios: bloquea envíos simultáneos y
/// **nunca reintenta** (la API no tiene idempotencia, CLAUDE.md §5).
abstract class SubmissionNotifier extends Notifier<SubmissionState> {
  @override
  SubmissionState build() => const SubmissionState();

  /// Ejecuta [action]; devuelve `true` si terminó sin [ApiException].
  @protected
  Future<bool> run(Future<void> Function() action) async {
    if (state.isSubmitting) return false;
    state = const SubmissionState(isSubmitting: true);
    try {
      await action();
      if (ref.mounted) state = const SubmissionState();
      return true;
    } on ApiException catch (error) {
      if (ref.mounted) state = SubmissionState(error: error);
      return false;
    }
  }
}
