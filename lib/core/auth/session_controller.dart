import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/auth_repository.dart';
import 'package:sga_bojanini/core/auth/auth_token_provider.dart';
import 'package:sga_bojanini/core/auth/auth_user.dart';
import 'package:sga_bojanini/core/auth/device_name.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';

/// Dueño de la sesión: login, restauración, bloqueo, turno y cierre.
/// Plan: `docs/plan/02-arquitectura.md` §4.
class SessionController extends Notifier<SessionState> {
  static const tokenRefreshInterval = Duration(hours: 24);

  Future<void>? _refreshInFlight;
  bool _reloadingUser = false;

  AuthRepository get _repository => ref.read(authRepositoryProvider);
  TokenStore get _store => ref.read(tokenStoreProvider);
  DateTime get _now => ref.read(clockProvider)();

  @override
  SessionState build() {
    unawaited(Future.microtask(restore));
    return const SessionState.restoring();
  }

  /// Verifica la sesión guardada al abrir la app.
  Future<void> restore() async {
    state = const SessionState.restoring();
    final stored = await _store.read();
    if (!ref.mounted) return;
    if (stored == null) {
      state = const SessionState.unauthenticated();
      return;
    }
    if (_shiftExpired(stored.startedAt)) {
      await _endSession(SessionEndReason.shiftEnded, serverToken: stored.token);
      return;
    }

    ref.read(authTokenProvider.notifier).replace(stored.token);
    try {
      final user = await _repository.me();
      if (!ref.mounted) return;
      state = SessionState.authenticated(
        user: user,
        startedAt: stored.startedAt,
        locked: _lockedAtStartup(stored),
      );
      unawaited(_refreshTokenIfStale(stored));
    } on UnauthenticatedException {
      await _endSession(SessionEndReason.expired);
    } on ForbiddenException catch (error) {
      if (!error.accountDisabled) {
        if (ref.mounted) state = SessionState.restoreFailed(error);
        return;
      }
      await _endSession(SessionEndReason.accountDisabled);
    } on ApiException catch (error) {
      if (ref.mounted) state = SessionState.restoreFailed(error);
    }
  }

  /// Inicia sesión; lanza [ApiException] para que el formulario la muestre.
  Future<void> login({required String email, required String password}) async {
    final result = await _repository.login(
      email: email,
      password: password,
      deviceName: ref.read(deviceNameProvider),
    );
    final now = _now;
    await _persist(
      StoredSession(
        token: result.token,
        startedAt: now,
        tokenIssuedAt: now,
        lastActiveAt: now,
      ),
    );
    state = SessionState.authenticated(user: result.user, startedAt: now);
  }

  void lock() {
    final current = state;
    if (current is SessionAuthenticated && !current.locked) {
      state = current.copyWith(locked: true);
    }
  }

  /// Desbloquea con la contraseña: nuevo login, cierre del token anterior y
  /// reemplazo. El inicio del turno no cambia.
  Future<void> unlock(String password) async {
    final current = state;
    if (current is! SessionAuthenticated) return;

    final oldToken = ref.read(authTokenProvider);
    final result = await _repository.login(
      email: current.user.email,
      password: password,
      deviceName: ref.read(deviceNameProvider),
    );
    final now = _now;
    await _persist(
      StoredSession(
        token: result.token,
        startedAt: current.startedAt,
        tokenIssuedAt: now,
        lastActiveAt: now,
      ),
    );
    state = current.copyWith(user: result.user, locked: false);
    if (oldToken != null) await _revokeQuietly(oldToken);
  }

  /// Cierre voluntario ("Cerrar sesión" / "Cambiar de usuario").
  Future<void> logout() => _endSession(null, serverToken: _currentToken);

  /// Llamado por el interceptor: el token ya no sirve (401 / cuenta
  /// desactivada). No hay nada que revocar en el servidor.
  Future<void> handleInvalidSession(ApiException error) {
    if (state is! SessionAuthenticated && state is! SessionRestoring) {
      return Future.value();
    }
    final reason = error is ForbiddenException
        ? SessionEndReason.accountDisabled
        : SessionEndReason.expired;
    return _endSession(reason);
  }

  /// Cierra el turno si superó el máximo de horas.
  Future<void> enforceShiftLimit() async {
    final current = state;
    if (current is SessionAuthenticated && _shiftExpired(current.startedAt)) {
      await _endSession(
        SessionEndReason.shiftEnded,
        serverToken: _currentToken,
      );
    }
  }

  /// Marca el paso a segundo plano: el siguiente arranque en frío decide
  /// si bloquea según el tiempo transcurrido.
  Future<void> recordBackground() async {
    final stored = await _store.read();
    if (stored == null) return;
    await _store.write(stored.copyWith(lastActiveAt: _now));
  }

  /// Vuelve a pedir `GET /auth/me` (los permisos pudieron cambiar). Es
  /// silencioso: un fallo aquí no debe molestar al usuario.
  Future<void> reloadUser() async {
    final current = state;
    if (current is! SessionAuthenticated || _reloadingUser) return;
    _reloadingUser = true;
    try {
      final user = await _repository.me();
      final latest = state;
      if (ref.mounted && latest is SessionAuthenticated) {
        state = latest.copyWith(user: user);
      }
    } on ApiException {
      // Se conserva el usuario actual.
    } finally {
      _reloadingUser = false;
    }
  }

  String? get _currentToken => ref.read(authTokenProvider);

  bool _shiftExpired(DateTime startedAt) {
    final maxHours = ref.read(appEnvironmentProvider).sessionMaxHours;
    return _now.difference(startedAt) >= Duration(hours: maxHours);
  }

  bool _lockedAtStartup(StoredSession stored) {
    final lastActive = stored.lastActiveAt;
    if (lastActive == null) return true;
    final minutes = ref.read(appEnvironmentProvider).inactivityLockMinutes;
    return _now.difference(lastActive) >= Duration(minutes: minutes);
  }

  Future<void> _persist(StoredSession session) async {
    await _store.write(session);
    ref.read(authTokenProvider.notifier).replace(session.token);
  }

  Future<void> _refreshTokenIfStale(StoredSession stored) {
    if (_now.difference(stored.tokenIssuedAt) < tokenRefreshInterval) {
      return Future.value();
    }
    // Un solo vuelo: dos renovaciones simultáneas invalidarían el token.
    return _refreshInFlight ??= _refreshToken(stored).whenComplete(() {
      _refreshInFlight = null;
    });
  }

  Future<void> _refreshToken(StoredSession stored) async {
    try {
      final token = await _repository.refresh();
      await _persist(stored.copyWith(token: token, tokenIssuedAt: _now));
    } on ApiException {
      // La renovación es oportunista: si falla se reintenta al abrir de nuevo.
    }
  }

  Future<void> _endSession(
    SessionEndReason? reason, {
    String? serverToken,
  }) async {
    if (serverToken != null) await _revokeQuietly(serverToken);
    await _store.clear();
    if (!ref.mounted) return;
    ref.read(authTokenProvider.notifier).replace(null);
    state = SessionState.unauthenticated(reason: reason);
  }

  Future<void> _revokeQuietly(String token) async {
    try {
      await _repository.logout(token: token);
    } on ApiException {
      // Sin red o token ya revocado: igual se descarta localmente.
    }
  }
}

final sessionControllerProvider =
    NotifierProvider<SessionController, SessionState>(SessionController.new);

/// Usuario autenticado actual, o `null` (restaurando / sin sesión).
final currentUserProvider = Provider<AuthUser?>((ref) {
  final session = ref.watch(sessionControllerProvider);
  return session is SessionAuthenticated ? session.user : null;
});
