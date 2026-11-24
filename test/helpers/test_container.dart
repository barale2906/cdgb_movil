import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:sga_bojanini/core/auth/device_name.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_http_adapter.dart';
import 'in_memory_token_store.dart';

final testEnvironment = AppEnvironment.fromValues(
  env: 'dev',
  apiBaseUrl: 'http://localhost:8000/api/v1',
  serverPresets: [
    'Producción clínica|https://sga.ad.bojaniniexperts.co/api/v1',
    'Local USB|http://localhost:8000/api/v1',
  ].join(';'),
);

/// Reloj manual para pruebas deterministas.
class TestClock {
  TestClock(this.now);

  DateTime now;

  DateTime call() => now;

  void advance(Duration duration) => now = now.add(duration);
}

/// Servidor falso, almacén de token en memoria y reloj manual.
List<Override> serverOverrides({
  required FakeHttpAdapter adapter,
  required InMemoryTokenStore store,
  required TestClock clock,
}) => [
  tokenStoreProvider.overrideWithValue(store),
  clockProvider.overrideWithValue(clock.call),
  httpClientAdapterProvider.overrideWithValue(adapter),
];

/// Overrides comunes: servidor falso, almacén de token en memoria, reloj y
/// preferencias vacías.
Future<List<Override>> baseOverrides({
  required FakeHttpAdapter adapter,
  required InMemoryTokenStore store,
  required TestClock clock,
  AppEnvironment? environment,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return [
    appEnvironmentProvider.overrideWithValue(environment ?? testEnvironment),
    ...serverOverrides(adapter: adapter, store: store, clock: clock),
    sharedPreferencesProvider.overrideWithValue(prefs),
    deviceNameProvider.overrideWithValue('Equipo de pruebas'),
  ];
}
