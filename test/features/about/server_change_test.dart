import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/config/server_override.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';

Future<void> _tapChangeServer(WidgetTester tester) async {
  final button = find.text('Cambiar servidor', skipOffstage: false);
  await tester.ensureVisible(button);
  await tester.pumpAndSettle();
  await tester.tap(button);
}

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openAbout(WidgetTester tester) async {
    harness
      ..stubSignedInUser(permissions: [])
      ..storeSession();
    await harness.pump(tester);
    await tester.tap(find.byTooltip('Abrir perfil'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Acerca de'));
    await AppHarness.settle(tester);
  }

  testWidgets('rechaza una dirección inválida', (tester) async {
    await openAbout(tester);
    await _tapChangeServer(tester);
    await AppHarness.settle(tester, frames: 3);

    await tester.enterText(find.byType(TextFormField), 'no es una url');
    await tester.tap(find.text('Aceptar'));
    await AppHarness.settle(tester, frames: 3);

    expect(find.textContaining('Ingrese una dirección válida'), findsOneWidget);
    expect(harness.adapter.callsTo('POST', '/auth/logout'), isEmpty);
  });

  testWidgets('guarda el servidor, cierra la sesión y vuelve al login', (
    tester,
  ) async {
    await openAbout(tester);
    harness.adapter.on('POST', '/auth/logout', body: envelope(null));

    await _tapChangeServer(tester);
    await AppHarness.settle(tester, frames: 3);
    await tester.enterText(
      find.byType(TextFormField),
      'http://192.168.1.10:8000/api/v1',
    );
    await tester.tap(find.text('Aceptar'));
    await AppHarness.settle(tester);

    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(harness.store.session, isNull);
    expect(
      ServerOverride(await harness.preferences()).current,
      'http://192.168.1.10:8000/api/v1',
    );
  });

  testWidgets('elegir "Producción clínica" cambia de servidor en un toque', (
    tester,
  ) async {
    await openAbout(tester);
    harness.adapter.on('POST', '/auth/logout', body: envelope(null));

    await _tapChangeServer(tester);
    await AppHarness.settle(tester, frames: 3);
    expect(find.text('Servidores disponibles'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget, reason: 'en uso');
    await tester.tap(find.text('Producción clínica'));
    await AppHarness.settle(tester);

    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(harness.store.session, isNull);
    expect(
      ServerOverride(await harness.preferences()).current,
      'https://sga.ad.bojaniniexperts.co/api/v1',
    );
  });

  testWidgets('"Usar el servidor original" quita el cambio guardado', (
    tester,
  ) async {
    await openAbout(tester);
    harness.adapter.on('POST', '/auth/logout', body: envelope(null));
    await ServerOverride(
      await harness.preferences(),
    ).save(Uri.parse('https://sga.ad.bojaniniexperts.co/api/v1'));

    await _tapChangeServer(tester);
    await AppHarness.settle(tester, frames: 3);
    await tester.tap(find.text('Usar el servidor original'));
    await AppHarness.settle(tester);

    expect(ServerOverride(await harness.preferences()).current, isNull);
  });
}
