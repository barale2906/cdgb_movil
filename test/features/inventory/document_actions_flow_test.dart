import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/widgets/signature_pad.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _permissions = [
  'stock.ver',
  'almacenes.ver',
  'movimientos.confirmar',
  'movimientos.cancelar',
  'movimientos.enviar_correo',
];

/// PNG de 1x1 de la fixture de "Mi firma".
final String _signatureImage =
    ((fixture('inventory/signature_response.json')['data']
                as Map<String, dynamic>)['signature']
            as Map<String, dynamic>)['signature_data']
        as String;

Map<String, dynamic> _confirmedDocument() {
  final body = fixture('inventory/document_response.json');
  final data = body['data'] as Map<String, dynamic>;
  data['status'] = 'confirmed';
  (data['movements'] as List).cast<Map<String, dynamic>>().first['status'] =
      'confirmed';
  data['signatures'] = [
    {
      'id': 1,
      'role': 'delivered_by',
      'method': 'pad',
      'signer_name': 'Usuario Prueba',
      'signer_document': '1000000001',
      'signed_at': '2026-11-24T09:00:00-05:00',
    },
    {
      'id': 2,
      'role': 'received_by',
      'method': 'pin',
      'signer_name': 'Receptor Uno',
      'signer_document': '2000000002',
      'signed_at': '2026-11-24T09:00:00-05:00',
    },
  ];
  return body;
}

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}));

  Future<void> openDocument(
    WidgetTester tester, {
    List<String> permissions = _permissions,
    bool registeredSignature = true,
    Map<String, dynamic>? document,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 2200)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(
        permissions: permissions,
        menu: 'auth/menu_inventory_response.json',
      )
      ..stubInventoryReads(documentDetail: document)
      ..storeSession();
    harness.adapter.on(
      'GET',
      '/auth/me/signature',
      body: fixture(
        registeredSignature
            ? 'inventory/signature_response.json'
            : 'inventory/signature_none_response.json',
      ),
    );
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Inventario'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Comprobantes'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('SAL-2026-000123'));
    await AppHarness.settle(tester);
  }

  Future<void> goToConfirm(WidgetTester tester) async {
    await tester.tap(find.text('Confirmar y firmar'));
    await AppHarness.settle(tester);
  }

  testWidgets('sin permisos de acción solo ofrece el PDF', (tester) async {
    await openDocument(tester, permissions: ['stock.ver', 'almacenes.ver']);

    expect(find.text('Confirmar y firmar'), findsNothing);
    expect(find.text('Cancelar comprobante'), findsNothing);
    expect(find.text('Enviar por correo'), findsNothing);
    expect(find.text('Ver PDF'), findsOneWidget);
  });

  group('confirmar', () {
    testWidgets('con firma registrada y PIN: no envía delivered_by', (
      tester,
    ) async {
      await openDocument(tester);
      harness.adapter.on(
        'POST',
        '/movement-documents/900/confirm',
        body: _confirmedDocument(),
      );
      await goToConfirm(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'PIN de 3 dígitos'),
        '123',
      );
      await tester.tap(find.text('Confirmar y firmar'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter
                  .callsTo('POST', '/movement-documents/900/confirm')
                  .single
                  .data
              as Map;
      expect(body, {
        'received_by': {'pin': '123'},
      });
      expect(find.text('Comprobante confirmado.'), findsOneWidget);
    });

    testWidgets('el PIN debe tener 3 dígitos antes de enviar', (tester) async {
      await openDocument(tester);
      await goToConfirm(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'PIN de 3 dígitos'),
        '12',
      );
      await tester.tap(find.text('Confirmar y firmar'));
      await AppHarness.settle(tester);

      expect(find.text('Ingrese los 3 dígitos del PIN.'), findsOneWidget);
      expect(
        harness.adapter.callsTo('POST', '/movement-documents/900/confirm'),
        isEmpty,
      );
    });

    testWidgets('PIN inválido (422): error en el campo y se puede corregir', (
      tester,
    ) async {
      await openDocument(tester);
      harness.adapter.on(
        'POST',
        '/movement-documents/900/confirm',
        status: 422,
        body: errorBody(
          'PIN inválido',
          extra: {
            'errors': {
              'received_by.pin': ['El PIN no es válido.'],
            },
          },
        ),
      );
      await goToConfirm(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'PIN de 3 dígitos'),
        '000',
      );
      await tester.tap(find.text('Confirmar y firmar'));
      await AppHarness.settle(tester);

      expect(find.text('El PIN no es válido.'), findsOneWidget);
    });

    testWidgets('PIN bloqueado (429) muestra el aviso', (tester) async {
      await openDocument(tester);
      harness.adapter.on(
        'POST',
        '/movement-documents/900/confirm',
        status: 429,
        body: errorBody('Demasiados intentos.'),
      );
      await goToConfirm(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'PIN de 3 dígitos'),
        '111',
      );
      await tester.tap(find.text('Confirmar y firmar'));
      await AppHarness.settle(tester);

      expect(
        find.text('Demasiados intentos. Espere un momento e intente de nuevo.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'entrega y recibe iguales (409): muestra el mensaje del servidor',
      (tester) async {
        await openDocument(tester);
        harness.adapter.on(
          'POST',
          '/movement-documents/900/confirm',
          status: 409,
          body: errorBody(
            'Quien entrega y quien recibe no pueden ser la misma persona.',
          ),
        );
        await goToConfirm(tester);

        await tester.enterText(
          find.widgetWithText(TextFormField, 'PIN de 3 dígitos'),
          '111',
        );
        await tester.tap(find.text('Confirmar y firmar'));
        await AppHarness.settle(tester);

        expect(
          find.text(
            'Quien entrega y quien recibe no pueden ser la misma persona.',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets('sin firma registrada: avisa y exige firmar en pantalla', (
      tester,
    ) async {
      await openDocument(tester, registeredSignature: false);
      await goToConfirm(tester);

      expect(
        find.text(
          'Aún no tiene firma registrada. Regístrela para poder entregar.',
        ),
        findsOneWidget,
      );
      expect(
        find.byType(SignaturePad),
        findsOneWidget,
        reason: 'firma de quien entrega',
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'PIN de 3 dígitos'),
        '123',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nombre completo'),
        'Usuario Prueba',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Documento'),
        '1000000001',
      );
      await tester.tap(find.text('Confirmar y firmar'));
      await AppHarness.settle(tester);

      expect(find.text('La firma es obligatoria.'), findsOneWidget);
      expect(
        harness.adapter.callsTo('POST', '/movement-documents/900/confirm'),
        isEmpty,
      );
    });

    testWidgets('receptor externo: envía nombre, documento y firma PNG', (
      tester,
    ) async {
      await openDocument(tester);
      harness.adapter.on(
        'POST',
        '/movement-documents/900/confirm',
        body: _confirmedDocument(),
      );
      await goToConfirm(tester);

      await tester.tap(find.text('Persona externa'));
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nombre completo'),
        'Receptor Externo',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Documento'),
        '3000000003',
      );
      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(SignaturePad)),
      );
      await gesture.moveBy(const Offset(60, 20));
      await gesture.up();
      await tester.pump();

      // La exportación del PNG usa el motor real (async fuera del reloj falso).
      await tester.runAsync(() async {
        await tester.tap(find.text('Confirmar y firmar'));
        await Future<void>.delayed(const Duration(milliseconds: 300));
      });
      await AppHarness.settle(tester);

      final body =
          harness.adapter
                  .callsTo('POST', '/movement-documents/900/confirm')
                  .single
                  .data
              as Map;
      final received = body['received_by'] as Map;
      expect(received['name'], 'Receptor Externo');
      expect(received['document'], '3000000003');
      expect(received['signature'], startsWith('data:image/png;base64,'));
      expect(received.containsKey('pin'), isFalse);
    });
  });

  group('cancelar', () {
    testWidgets('pide confirmación y anula el comprobante pendiente', (
      tester,
    ) async {
      await openDocument(tester);
      harness.adapter.on(
        'DELETE',
        '/movement-documents/900/pending',
        body: envelope(null),
      );

      await tester.tap(find.text('Cancelar comprobante'));
      await AppHarness.settle(tester);
      expect(find.text('¿Cancelar este comprobante?'), findsOneWidget);
      await tester.tap(
        find.widgetWithText(FilledButton, 'Cancelar comprobante'),
      );
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('DELETE', '/movement-documents/900/pending'),
        hasLength(1),
      );
      expect(find.text('Comprobante cancelado.'), findsOneWidget);
    });

    testWidgets('"Cancelar" en el diálogo no anula nada', (tester) async {
      await openDocument(tester);

      await tester.tap(find.text('Cancelar comprobante'));
      await AppHarness.settle(tester);
      await tester.tap(find.widgetWithText(TextButton, 'Cancelar'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('DELETE', '/movement-documents/900/pending'),
        isEmpty,
      );
    });

    testWidgets(
      'un comprobante confirmado ya no se puede cancelar ni confirmar',
      (tester) async {
        await openDocument(tester, document: _confirmedDocument());

        expect(find.text('Cancelar comprobante'), findsNothing);
        expect(find.text('Confirmar y firmar'), findsNothing);
        expect(find.text('CONFIRMADO'), findsOneWidget);
      },
    );
  });

  group('firmas, PDF y correo', () {
    testWidgets(
      'un comprobante confirmado muestra quién firmó y la imagen bajo demanda',
      (tester) async {
        await openDocument(tester, document: _confirmedDocument());
        harness.adapter.on(
          'GET',
          '/movement-documents/900/signature/received_by',
          body: envelope({
            'role': 'received_by',
            'signature_data': _signatureImage,
          }),
        );

        expect(find.text('Entrega: Usuario Prueba'), findsOneWidget);
        expect(find.text('Recibe: Receptor Uno'), findsOneWidget);
        expect(
          harness.adapter.callsTo(
            'GET',
            '/movement-documents/900/signature/received_by',
          ),
          isEmpty,
        );

        await tester.runAsync(() async {
          await tester.tap(find.text('Ver firma').last);
          await Future<void>.delayed(const Duration(milliseconds: 200));
        });
        await AppHarness.settle(tester);

        expect(
          harness.adapter.callsTo(
            'GET',
            '/movement-documents/900/signature/received_by',
          ),
          hasLength(1),
        );
        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets('ver PDF descarga con autenticación y permite compartirlo', (
      tester,
    ) async {
      await openDocument(tester);
      harness.adapter.onBytes('GET', '/movement-documents/900/pdf', [
        37,
        80,
        68,
        70,
        45,
      ]);

      await tester.tap(find.text('Ver PDF'));
      await AppHarness.settle(tester);
      expect(find.text('PDF 5 bytes'), findsOneWidget);
      expect(
        harness.adapter
            .callsTo('GET', '/movement-documents/900/pdf')
            .single
            .headers['Authorization'],
        startsWith('Bearer'),
      );

      await tester.tap(find.byTooltip('Compartir PDF'));
      await AppHarness.settle(tester);
      expect(harness.sharedFiles, [('comprobante-900.pdf', 5)]);
    });

    testWidgets('falla la descarga del PDF: ofrece reintentar', (tester) async {
      await openDocument(tester);
      harness.adapter
        ..onSocketFailure('GET', '/movement-documents/900/pdf')
        ..onBytes('GET', '/movement-documents/900/pdf', [1, 2, 3]);

      await tester.tap(find.text('Ver PDF'));
      await AppHarness.settle(tester);
      expect(find.text('Reintentar'), findsOneWidget);

      await tester.tap(find.text('Reintentar'));
      await AppHarness.settle(tester);
      expect(find.text('PDF 3 bytes'), findsOneWidget);
    });

    testWidgets('correo: valida las direcciones y envía la lista', (
      tester,
    ) async {
      await openDocument(tester);
      harness.adapter.on(
        'POST',
        '/movement-documents/900/send-email',
        body: envelope(null),
      );
      await tester.tap(find.text('Enviar por correo'));
      await AppHarness.settle(tester);

      await tester.enterText(find.byType(TextFormField), 'no-es-correo');
      await tester.tap(find.widgetWithText(FilledButton, 'Enviar por correo'));
      await AppHarness.settle(tester);
      expect(
        find.text('Ingrese correos válidos separados por comas.'),
        findsOneWidget,
      );
      expect(
        harness.adapter.callsTo('POST', '/movement-documents/900/send-email'),
        isEmpty,
      );

      await tester.enterText(
        find.byType(TextFormField),
        'a@example.com, b@example.com',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Enviar por correo'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter
                  .callsTo('POST', '/movement-documents/900/send-email')
                  .single
                  .data
              as Map;
      expect(body['recipients'], ['a@example.com', 'b@example.com']);
      expect(find.text('Correo enviado.'), findsOneWidget);
    });
  });
}
