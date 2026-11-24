import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/app.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_connectivity.dart';
import 'fake_http_adapter.dart';
import 'fixtures.dart';
import 'in_memory_token_store.dart';
import 'pump_app.dart';
import 'test_container.dart';

/// App completa (router, guardas, sesión) contra un servidor falso.
class AppHarness {
  AppHarness({DateTime? now})
    : adapter = FakeHttpAdapter(),
      store = InMemoryTokenStore(),
      connectivity = FakeConnectivitySource(),
      clock = TestClock(now ?? DateTime(2026, 11, 24, 8));

  final FakeHttpAdapter adapter;
  final InMemoryTokenStore store;
  final FakeConnectivitySource connectivity;
  final TestClock clock;

  /// Respuestas habituales para un usuario con permisos de bodega.
  void stubSignedInUser({
    List<String>? permissions,
    bool includeMe = true,
    bool includeMenu = true,
    String menu = 'auth/menu_response.json',
  }) {
    final me = fixture('auth/me_response.json');
    if (permissions != null) {
      (me['data'] as Map<String, dynamic>)['permissions'] = permissions;
    }
    if (includeMe) adapter.on('GET', '/auth/me', body: me);
    if (includeMenu) {
      adapter.on('GET', '/auth/menu', body: fixture(menu));
    }
    adapter.on(
      'GET',
      '/warehouses',
      body: fixture('auth/warehouses_response.json'),
    );
  }

  void stubLogin({List<String>? permissions}) {
    final login = fixture('auth/login_response.json');
    if (permissions != null) {
      final user =
          (login['data'] as Map<String, dynamic>)['user']
              as Map<String, dynamic>;
      user['permissions'] = permissions;
    }
    adapter
      ..on('POST', '/auth/login', body: login)
      ..on('GET', '/auth/menu', body: fixture('auth/menu_response.json'))
      ..on(
        'GET',
        '/warehouses',
        body: fixture('auth/warehouses_response.json'),
      );
  }

  /// Sesión guardada como si el usuario hubiera ingresado hace poco.
  void storeSession({Duration activeAgo = const Duration(minutes: 1)}) {
    final now = clock.now;
    store.session = StoredSession(
      token: 'token-guardado',
      startedAt: now.subtract(const Duration(hours: 1)),
      tokenIssuedAt: now.subtract(const Duration(hours: 1)),
      lastActiveAt: now.subtract(activeAgo),
    );
  }

  SharedPreferences? _prefs;

  Future<SharedPreferences> preferences() async => _prefs!;

  Future<void> pump(WidgetTester tester) async {
    final widgetOverrides = await widgetTestOverrides(
      connectivity: connectivity,
    );
    _prefs = widgetOverrides.whereType<Object>().isNotEmpty
        ? await SharedPreferences.getInstance()
        : null;
    final overrides = <Override>[
      ...serverOverrides(adapter: adapter, store: store, clock: clock),
      ...widgetOverrides,
    ];
    await tester.pumpWidget(
      ProviderScope(
        retry: noAutoRetry,
        overrides: overrides,
        child: const SgaApp(),
      ),
    );
    await settle(tester);
  }

  /// Avanza el reloj de pruebas varios cuadros (sin `pumpAndSettle`: hay
  /// animaciones infinitas como el esqueleto de carga).
  static Future<void> settle(WidgetTester tester, {int frames = 10}) async {
    for (var i = 0; i < frames; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> login(
    WidgetTester tester, {
    String email = 'usuario.prueba@example.com',
    String password = 'secreto123',
  }) async {
    await tester.enterText(find.byType(TextFormField).at(0), email);
    await tester.enterText(find.byType(TextFormField).at(1), password);
    await tester.tap(find.text('Ingresar'));
    await settle(tester);
  }
}
