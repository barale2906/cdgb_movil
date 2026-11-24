import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openChangePassword(WidgetTester tester) async {
    harness
      ..stubSignedInUser(permissions: [])
      ..storeSession();
    await harness.pump(tester);
    await tester.tap(find.byTooltip('Abrir perfil'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Cambiar contraseña'));
    await AppHarness.settle(tester);
  }

  Future<void> fill(
    WidgetTester tester, {
    String current = 'vieja1234',
    String next = 'nueva1234',
    String confirm = 'nueva1234',
  }) async {
    await tester.enterText(find.byType(TextFormField).at(0), current);
    await tester.enterText(find.byType(TextFormField).at(1), next);
    await tester.enterText(find.byType(TextFormField).at(2), confirm);
    await tester.tap(find.text('Guardar'));
    await AppHarness.settle(tester);
  }

  testWidgets('valida longitud, igualdad y confirmación antes de enviar', (
    tester,
  ) async {
    await openChangePassword(tester);

    await fill(tester, next: 'corta', confirm: 'otra');

    expect(find.text('Use al menos 8 caracteres.'), findsOneWidget);
    expect(find.text('Las contraseñas no coinciden.'), findsOneWidget);
    expect(harness.adapter.callsTo('PUT', '/auth/password'), isEmpty);
  });

  testWidgets('la nueva contraseña debe ser distinta de la actual', (
    tester,
  ) async {
    await openChangePassword(tester);

    await fill(
      tester,
      current: 'igual1234',
      next: 'igual1234',
      confirm: 'igual1234',
    );

    expect(
      find.text('La nueva contraseña debe ser distinta de la actual.'),
      findsOneWidget,
    );
  });

  testWidgets('éxito: avisa y vuelve al perfil', (tester) async {
    await openChangePassword(tester);
    harness.adapter.on('PUT', '/auth/password', body: envelope(null));

    await fill(tester);

    expect(find.text('Contraseña actualizada.'), findsOneWidget);
    expect(find.text('Mi perfil'), findsOneWidget);
    expect(harness.adapter.callsTo('PUT', '/auth/password'), hasLength(1));
  });

  testWidgets('422: muestra el error del servidor en el campo', (tester) async {
    await openChangePassword(tester);
    harness.adapter.on(
      'PUT',
      '/auth/password',
      status: 422,
      body: errorBody(
        'Inválido',
        extra: {
          'errors': {
            'current_password': ['La contraseña actual no es correcta.'],
          },
        },
      ),
    );

    await fill(tester);

    expect(find.text('La contraseña actual no es correcta.'), findsOneWidget);
    expect(find.text('Cambiar contraseña'), findsOneWidget);
  });

  testWidgets('nunca reintenta solo: un fallo de red = una sola petición', (
    tester,
  ) async {
    await openChangePassword(tester);
    harness.adapter.onSocketFailure('PUT', '/auth/password');

    await fill(tester);

    expect(harness.adapter.callsTo('PUT', '/auth/password'), hasLength(1));
    expect(find.textContaining('No se pudo conectar'), findsOneWidget);
  });
}
