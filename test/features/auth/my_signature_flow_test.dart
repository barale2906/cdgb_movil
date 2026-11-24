import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/widgets/signature_pad.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openMySignature(
    WidgetTester tester, {
    required bool registered,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 2000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: [])
      ..storeSession();
    harness.adapter.on(
      'GET',
      '/auth/me/signature',
      body: fixture(
        registered
            ? 'inventory/signature_response.json'
            : 'inventory/signature_none_response.json',
      ),
    );
    await harness.pump(tester);
    await tester.tap(find.byTooltip('Abrir perfil'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Mi firma'));
    await AppHarness.settle(tester);
  }

  Future<void> draw(WidgetTester tester) async {
    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(SignaturePad)),
    );
    await gesture.moveBy(const Offset(50, 20));
    await gesture.up();
    await tester.pump();
  }

  testWidgets(
    'sin firma: valida documento, firma y contraseña antes de enviar',
    (tester) async {
      await openMySignature(tester, registered: false);

      await tester.tap(find.text('Guardar firma').last);
      await AppHarness.settle(tester);

      expect(find.text('Use entre 4 y 20 letras o números.'), findsOneWidget);
      expect(find.text('La firma es obligatoria.'), findsOneWidget);
      expect(find.text('Ingrese su contraseña.'), findsOneWidget);
      expect(harness.adapter.callsTo('PUT', '/auth/me/signature'), isEmpty);
    },
  );

  testWidgets(
    'primer registro: muestra el PIN una sola vez y obliga a confirmar',
    (tester) async {
      await openMySignature(tester, registered: false);
      harness.adapter.on(
        'PUT',
        '/auth/me/signature',
        status: 201,
        body: fixture('inventory/signature_saved_response.json'),
      );
      harness.adapter.on(
        'GET',
        '/auth/me/signature',
        body: fixture('inventory/signature_response.json'),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Número de documento'),
        '1000000001',
      );
      await draw(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Contraseña'),
        'secreto123',
      );
      await tester.runAsync(() async {
        await tester.tap(find.text('Guardar firma').last);
        await Future<void>.delayed(const Duration(milliseconds: 300));
      });
      await AppHarness.settle(tester);

      final body =
          harness.adapter.callsTo('PUT', '/auth/me/signature').single.data
              as Map;
      expect(body['document_type'], 'CC');
      expect(body['document_number'], '1000000001');
      expect(body['current_password'], 'secreto123');
      expect(body['signature'], startsWith('data:image/png;base64,'));
      expect(find.text('Anote su PIN'), findsOneWidget);
      expect(find.text('482'), findsOneWidget);

      await tester.tap(find.text('Ya anoté mi PIN'));
      await AppHarness.settle(tester);
      expect(
        find.text('482'),
        findsNothing,
        reason: 'el PIN no vuelve a mostrarse',
      );
      expect(find.text('PIN ACTIVO'), findsOneWidget);
    },
  );

  testWidgets('contraseña incorrecta (422): error en el campo', (tester) async {
    await openMySignature(tester, registered: false);
    harness.adapter.on(
      'PUT',
      '/auth/me/signature',
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

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Número de documento'),
      'AB1234',
    );
    await draw(tester);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Contraseña'),
      'mala',
    );
    await tester.runAsync(() async {
      await tester.tap(find.text('Guardar firma').last);
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await AppHarness.settle(tester);

    expect(find.text('La contraseña actual no es correcta.'), findsOneWidget);
    expect(find.text('Anote su PIN'), findsNothing);
  });

  testWidgets('con firma registrada: resumen y regeneración de PIN', (
    tester,
  ) async {
    await openMySignature(tester, registered: true);
    harness.adapter.on(
      'POST',
      '/auth/me/signature/pin',
      body: envelope({
        'signature':
            (fixture('inventory/signature_response.json')['data']
                as Map)['signature'],
        'pin': '907',
      }),
    );

    expect(find.text('Usuario Prueba'), findsWidgets);
    expect(find.text('PIN ACTIVO'), findsOneWidget);

    await tester.tap(find.text('Generar PIN nuevo'));
    await AppHarness.settle(tester);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Contraseña'),
      'secreto123',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Generar PIN nuevo'));
    await AppHarness.settle(tester);

    expect(find.text('907'), findsOneWidget);
    final body =
        harness.adapter.callsTo('POST', '/auth/me/signature/pin').single.data
            as Map;
    expect(body, {'current_password': 'secreto123'});
  });
}
