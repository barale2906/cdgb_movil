import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Sesión persistida: el token y las marcas de tiempo para turno, bloqueo
/// y renovación.
class StoredSession {
  const StoredSession({
    required this.token,
    required this.startedAt,
    required this.tokenIssuedAt,
    this.lastActiveAt,
  });

  final String token;

  /// Inicio del turno (login). No cambia al desbloquear ni al renovar.
  final DateTime startedAt;

  /// Cuándo se emitió el token actual (para la renovación periódica).
  final DateTime tokenIssuedAt;

  /// Última vez que la app pasó a segundo plano; `null` = bloquear al abrir.
  final DateTime? lastActiveAt;

  StoredSession copyWith({
    String? token,
    DateTime? tokenIssuedAt,
    DateTime? lastActiveAt,
  }) => StoredSession(
    token: token ?? this.token,
    startedAt: startedAt,
    tokenIssuedAt: tokenIssuedAt ?? this.tokenIssuedAt,
    lastActiveAt: lastActiveAt ?? this.lastActiveAt,
  );
}

/// Persistencia segura de la sesión (Keystore en Android).
abstract interface class TokenStore {
  Future<StoredSession?> read();
  Future<void> write(StoredSession session);
  Future<void> clear();
}

class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';
  static const _startedKey = 'session_started_at';
  static const _issuedKey = 'token_issued_at';
  static const _activeKey = 'last_active_at';

  final FlutterSecureStorage _storage;

  @override
  Future<StoredSession?> read() async {
    final token = await _storage.read(key: _tokenKey);
    final startedAt = _parse(await _storage.read(key: _startedKey));
    final issuedAt = _parse(await _storage.read(key: _issuedKey));
    if (token == null || startedAt == null || issuedAt == null) return null;
    return StoredSession(
      token: token,
      startedAt: startedAt,
      tokenIssuedAt: issuedAt,
      lastActiveAt: _parse(await _storage.read(key: _activeKey)),
    );
  }

  @override
  Future<void> write(StoredSession session) async {
    await _storage.write(key: _tokenKey, value: session.token);
    await _storage.write(
      key: _startedKey,
      value: session.startedAt.toIso8601String(),
    );
    await _storage.write(
      key: _issuedKey,
      value: session.tokenIssuedAt.toIso8601String(),
    );
    final lastActive = session.lastActiveAt;
    if (lastActive == null) {
      await _storage.delete(key: _activeKey);
    } else {
      await _storage.write(
        key: _activeKey,
        value: lastActive.toIso8601String(),
      );
    }
  }

  @override
  Future<void> clear() => _storage.deleteAll();

  static DateTime? _parse(String? raw) =>
      raw == null ? null : DateTime.tryParse(raw);
}

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());
