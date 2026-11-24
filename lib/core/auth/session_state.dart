import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/auth/auth_user.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';

part 'session_state.freezed.dart';

/// Por qué terminó la sesión; el login lo explica al usuario.
enum SessionEndReason { expired, accountDisabled, shiftEnded }

@freezed
sealed class SessionState with _$SessionState {
  /// Leyendo el token guardado y verificándolo con `GET /auth/me`.
  const factory SessionState.restoring() = SessionRestoring;

  /// No se pudo verificar la sesión guardada (sin red / servidor caído).
  const factory SessionState.restoreFailed(ApiException error) =
      SessionRestoreFailed;

  const factory SessionState.unauthenticated({SessionEndReason? reason}) =
      SessionUnauthenticated;

  const factory SessionState.authenticated({
    required AuthUser user,
    required DateTime startedAt,
    @Default(false) bool locked,
  }) = SessionAuthenticated;
}
