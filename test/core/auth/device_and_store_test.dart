import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/device_identity.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('DeviceIdentity', () {
    test('genera un identificador estable por instalación', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final first = DeviceIdentity.deviceName(prefs, random: Random(1));
      final second = DeviceIdentity.deviceName(prefs, random: Random(2));

      expect(first, startsWith('SGA '));
      expect(second, first, reason: 'se reutiliza el id guardado');
      expect(first.length, lessThanOrEqualTo(100), reason: 'máx. del backend');
    });
  });

  group('SecureTokenStore', () {
    late SecureTokenStore store;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      store = SecureTokenStore();
    });

    final session = StoredSession(
      token: '1|abc',
      startedAt: DateTime.utc(2026, 11, 24, 8),
      tokenIssuedAt: DateTime.utc(2026, 11, 24, 9),
      lastActiveAt: DateTime.utc(2026, 11, 24, 10),
    );

    test('guarda y lee la sesión completa', () async {
      await store.write(session);
      final read = await store.read();

      expect(read?.token, '1|abc');
      expect(read?.startedAt, session.startedAt);
      expect(read?.tokenIssuedAt, session.tokenIssuedAt);
      expect(read?.lastActiveAt, session.lastActiveAt);
    });

    test('sin datos o incompleto devuelve null', () async {
      expect(await store.read(), isNull);
      FlutterSecureStorage.setMockInitialValues({'auth_token': 'x'});
      expect(await SecureTokenStore().read(), isNull);
    });

    test('lastActiveAt es opcional y se puede quitar', () async {
      await store.write(
        StoredSession(
          token: 't',
          startedAt: session.startedAt,
          tokenIssuedAt: session.tokenIssuedAt,
        ),
      );
      expect((await store.read())?.lastActiveAt, isNull);
    });

    test('clear no deja ningún dato del usuario anterior', () async {
      await store.write(session);
      await store.clear();
      expect(await store.read(), isNull);
    });
  });
}
