import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/app.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/utils/file_sharer.dart';
import 'package:sga_bojanini/core/widgets/barcode_scanner_view.dart';
import 'package:sga_bojanini/core/widgets/pdf_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_connectivity.dart';
import 'fake_http_adapter.dart';
import 'fixtures.dart';
import 'in_memory_token_store.dart';
import 'pump_app.dart';
import 'test_container.dart';

/// App completa (router, guardas, sesión) contra un servidor falso.
class AppHarness {
  AppHarness({DateTime? now, this.initialPrefs = const {}})
    : adapter = FakeHttpAdapter(),
      store = InMemoryTokenStore(),
      connectivity = FakeConnectivitySource(),
      clock = TestClock(now ?? DateTime(2026, 11, 24, 8));

  final FakeHttpAdapter adapter;
  final InMemoryTokenStore store;
  final FakeConnectivitySource connectivity;
  final TestClock clock;

  /// Preferencias iniciales (p. ej. almacén activo ya elegido).
  final Map<String, Object> initialPrefs;

  /// Código que devuelve el escáner simulado al pulsar "Simular lectura".
  String scanCode = '100005';

  /// Archivos que se "compartieron" (nombre y tamaño).
  final List<(String, int)> sharedFiles = [];

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

  /// Lecturas habituales de inventario con el almacén 1 ya elegido.
  void stubInventoryReads({Map<String, dynamic>? documentDetail}) {
    final doc = fixture('inventory/document_response.json')['data'];
    adapter
      ..on('GET', '/stock', body: fixture('inventory/stock_response.json'))
      ..on(
        'GET',
        '/stock/low',
        body: envelope([
          (fixture('inventory/stock_response.json')['data'] as List).first,
        ]),
      )
      ..on('GET', '/batches', body: fixture('inventory/batches_response.json'))
      ..on(
        'GET',
        '/batches/expiring',
        body: envelope([
          (fixture('inventory/batches_response.json')['data'] as List).first,
        ]),
      )
      ..on(
        'GET',
        '/batches/expired',
        body: envelope([
          (fixture('inventory/batches_response.json')['data'] as List).last,
        ]),
      )
      ..on(
        'GET',
        '/batches/70',
        body: envelope(
          (fixture('inventory/batches_response.json')['data'] as List).first,
        ),
      )
      ..on('GET', '/movement-documents', body: pagedBody([doc]))
      ..on(
        'GET',
        '/movement-documents/900',
        body: documentDetail ?? fixture('inventory/document_response.json'),
      )
      ..on(
        'GET',
        '/movements',
        body: pagedBody((doc as Map)['movements'] as List),
      );
  }

  /// Bloques del tablero y notificaciones (sin leer: [unread]).
  void stubDashboard({int unread = 2}) {
    adapter
      ..on(
        'GET',
        '/dashboard/inventory',
        body: fixture('dashboard/inventory_response.json'),
      )
      ..on(
        'GET',
        '/dashboard/purchasing',
        body: fixture('dashboard/purchasing_response.json'),
      )
      ..on(
        'GET',
        '/dashboard/monitoring',
        body: fixture('dashboard/monitoring_response.json'),
      )
      ..on(
        'GET',
        '/dashboard/activity',
        body: fixture('dashboard/activity_response.json'),
      )
      ..on(
        'GET',
        '/dashboard/alerts',
        body: fixture('dashboard/alerts_response.json'),
      )
      ..on(
        'GET',
        '/notifications/unread-count',
        body: envelope({'count': unread}),
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
      prefs: initialPrefs,
    );
    _prefs = widgetOverrides.whereType<Object>().isNotEmpty
        ? await SharedPreferences.getInstance()
        : null;
    final overrides = <Override>[
      ...serverOverrides(adapter: adapter, store: store, clock: clock),
      ...widgetOverrides,
      scannerBuilderProvider.overrideWithValue(
        (context, onCode) => Center(
          child: FilledButton(
            onPressed: () => onCode(scanCode),
            child: const Text('Simular lectura'),
          ),
        ),
      ),
      pdfViewBuilderProvider.overrideWithValue(
        (context, bytes) => Center(child: Text('PDF ${bytes.length} bytes')),
      ),
      fileSharerProvider.overrideWithValue((bytes, name) async {
        sharedFiles.add((name, bytes.length));
      }),
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
