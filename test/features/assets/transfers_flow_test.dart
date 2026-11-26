import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _view = ['activos.ver'];
const _menu = 'auth/menu_assets_response.json';

Map<String, dynamic> _assetBody({
  bool pending = false,
  bool offPremises = false,
}) {
  final body = fixture('assets/asset_response.json');
  final data = body['data'] as Map<String, dynamic>;
  if (!pending) data['pending_transfer'] = null;
  if (offPremises) {
    (data['location'] as Map<String, dynamic>)['is_off_premises'] = true;
  }
  return body;
}

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openAssets(
    WidgetTester tester, {
    List<String> permissions = _view,
    void Function()? before,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    before?.call();
    harness
      ..stubSignedInUser(permissions: permissions, menu: _menu)
      ..stubAssetsReads()
      ..storeSession();
    harness.adapter.on(
      'GET',
      '/auth/me/signature',
      body: fixture('inventory/signature_response.json'),
    );
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Activos'),
      ),
    );
    await AppHarness.settle(tester);
  }

  Future<void> openTransfersTab(WidgetTester tester) async {
    await tester.tap(find.widgetWithText(Tab, 'Traslados'));
    await AppHarness.settle(tester);
  }

  Future<void> openPendingTransfer(
    WidgetTester tester, {
    List<String> permissions = _view,
  }) async {
    await openAssets(tester, permissions: permissions);
    await openTransfersTab(tester);
    await tester.tap(find.text('Monitor de signos vitales'));
    await AppHarness.settle(tester);
  }

  Future<void> pickOption(
    WidgetTester tester,
    String label,
    String option,
  ) async {
    await tester.tap(
      find.byWidgetPredicate(
        (w) => w is DropdownButtonFormField && w.decoration.labelText == label,
      ),
    );
    await AppHarness.settle(tester, frames: 4);
    await tester.tap(find.text(option).last);
    await AppHarness.settle(tester, frames: 4);
  }

  group('lista de traslados', () {
    testWidgets('por defecto muestra los pendientes de firma', (tester) async {
      await openAssets(tester);
      await openTransfersTab(tester);

      expect(find.text('Monitor de signos vitales'), findsOneWidget);
      expect(find.textContaining('Préstamo externo'), findsOneWidget);
      expect(find.text('PENDIENTE DE FIRMA'), findsWidgets);
      expect(
        harness.adapter
            .callsTo('GET', '/assets/transfers')
            .any((c) => c.queryParameters['status'] == 'pending_signature'),
        isTrue,
      );
    });

    testWidgets('"Todos" pide sin filtro de estado', (tester) async {
      await openAssets(tester);
      await openTransfersTab(tester);
      await tester.tap(find.widgetWithText(ChoiceChip, 'Todas'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/assets/transfers')
            .any((c) => !c.queryParameters.containsKey('status')),
        isTrue,
      );
      expect(find.text('Portátil administrativo'), findsOneWidget);
      expect(find.text('CONFIRMADO'), findsWidgets);
    });

    testWidgets('sin traslados: mensaje', (tester) async {
      await openAssets(
        tester,
        before: () => harness.adapter.on(
          'GET',
          '/assets/transfers',
          body: pagedBody(<dynamic>[]),
        ),
      );
      await openTransfersTab(tester);
      expect(find.text('No hay traslados para mostrar.'), findsOneWidget);
    });
  });

  group('detalle y confirmación', () {
    testWidgets('sin permiso de confirmar solo se ve el acta', (tester) async {
      await openPendingTransfer(tester);

      expect(find.text('Clínica Aliada'), findsWidgets);
      expect(find.text('Confirmar y firmar'), findsNothing);
      expect(find.text('Cancelar traslado'), findsNothing);
      expect(find.text('Acta del traslado (PDF)'), findsOneWidget);
    });

    testWidgets('el acta se abre como PDF', (tester) async {
      await openPendingTransfer(tester);
      harness.adapter.onBytes('GET', '/assets/transfers/12/act', [1, 2, 3]);

      await tester.scrollUntilVisible(
        find.text('Acta del traslado (PDF)'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text('Acta del traslado (PDF)'));
      await AppHarness.settle(tester);

      expect(find.text('PDF 3 bytes'), findsOneWidget);
    });

    testWidgets('confirma con firma registrada y PIN del receptor', (
      tester,
    ) async {
      await openPendingTransfer(
        tester,
        permissions: [..._view, 'activos_traslados.confirmar'],
      );
      harness.adapter.on(
        'POST',
        '/assets/transfers/12/confirm',
        body: fixture('assets/transfer_confirmed_response.json'),
      );

      await tester.scrollUntilVisible(
        find.text('Confirmar y firmar'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text('Confirmar y firmar'));
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'PIN de 3 dígitos'),
        '123',
      );
      await tester.tap(find.text('Confirmar y firmar').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('POST', '/assets/transfers/12/confirm')
            .single
            .data,
        {
          'received_by': {'pin': '123'},
        },
      );
      expect(find.text('Traslado confirmado.'), findsOneWidget);
    });

    testWidgets('PIN incompleto: no se envía', (tester) async {
      await openPendingTransfer(
        tester,
        permissions: [..._view, 'activos_traslados.confirmar'],
      );
      await tester.scrollUntilVisible(
        find.text('Confirmar y firmar'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text('Confirmar y firmar'));
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'PIN de 3 dígitos'),
        '12',
      );
      await tester.tap(find.text('Confirmar y firmar').last);
      await AppHarness.settle(tester);

      expect(find.text('Ingrese los 3 dígitos del PIN.'), findsOneWidget);
      expect(
        harness.adapter.callsTo('POST', '/assets/transfers/12/confirm'),
        isEmpty,
      );
    });

    testWidgets('cancelar exige motivo y lo envía', (tester) async {
      await openPendingTransfer(
        tester,
        permissions: [..._view, 'activos_traslados.confirmar'],
      );
      harness.adapter.on(
        'POST',
        '/assets/transfers/12/cancel',
        body: fixture('assets/transfer_confirmed_response.json'),
      );
      await tester.scrollUntilVisible(
        find.text('Cancelar traslado'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text('Cancelar traslado'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Cancelar traslado').last);
      await AppHarness.settle(tester);
      expect(find.text('Este campo es obligatorio.'), findsOneWidget);
      expect(
        harness.adapter.callsTo('POST', '/assets/transfers/12/cancel'),
        isEmpty,
      );

      await tester.enterText(
        find.byType(TextFormField).last,
        'Ya no se necesita',
      );
      await tester.tap(find.text('Cancelar traslado').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('POST', '/assets/transfers/12/cancel')
            .single
            .data,
        {'reason': 'Ya no se necesita'},
      );
      expect(find.text('Traslado cancelado.'), findsOneWidget);
    });

    testWidgets('409 al cancelar: muestra el mensaje del servidor', (
      tester,
    ) async {
      await openPendingTransfer(
        tester,
        permissions: [..._view, 'activos_traslados.confirmar'],
      );
      harness.adapter.on(
        'POST',
        '/assets/transfers/12/cancel',
        status: 409,
        body: errorBody('El traslado ya no está pendiente.'),
      );
      await tester.scrollUntilVisible(
        find.text('Cancelar traslado'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text('Cancelar traslado'));
      await AppHarness.settle(tester);
      await tester.enterText(find.byType(TextFormField).last, 'Motivo');
      await tester.tap(find.text('Cancelar traslado').last);
      await AppHarness.settle(tester);

      expect(find.text('El traslado ya no está pendiente.'), findsOneWidget);
      expect(
        harness.adapter.callsTo('POST', '/assets/transfers/12/cancel'),
        hasLength(1),
      );
    });

    testWidgets('un traslado confirmado muestra firmas y no acciones', (
      tester,
    ) async {
      await openAssets(
        tester,
        permissions: [..._view, 'activos_traslados.confirmar'],
      );
      await openTransfersTab(tester);
      await tester.tap(find.widgetWithText(ChoiceChip, 'Confirmado'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Portátil administrativo').first);
      await AppHarness.settle(tester);

      expect(find.textContaining('Otra Persona'), findsOneWidget);
      expect(find.text('Confirmar y firmar'), findsNothing);
      expect(find.text('Cancelar traslado'), findsNothing);
    });
  });

  group('solicitar traslado', () {
    const request = [..._view, 'activos_traslados.solicitar'];

    Future<void> openRequest(
      WidgetTester tester, {
      List<String> permissions = request,
      bool pending = false,
      bool offPremises = false,
    }) async {
      await openAssets(
        tester,
        permissions: permissions,
        before: () => harness.adapter.on(
          'GET',
          '/assets/7',
          body: _assetBody(pending: pending, offPremises: offPremises),
        ),
      );
      await tester.tap(find.text('Monitor de signos vitales'));
      await AppHarness.settle(tester);
    }

    Future<void> goToForm(WidgetTester tester) async {
      await tester.scrollUntilVisible(
        find.text('Solicitar traslado'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text('Solicitar traslado'));
      await AppHarness.settle(tester);
    }

    testWidgets('sin permiso no hay botón', (tester) async {
      await openRequest(tester, permissions: _view);
      expect(find.text('Solicitar traslado'), findsNothing);
    });

    testWidgets('con un traslado pendiente no se ofrece otro', (tester) async {
      await openRequest(tester, pending: true);
      expect(find.text('Solicitar traslado'), findsNothing);
    });

    testWidgets('en las instalaciones: sin devolución; baja solo con permiso', (
      tester,
    ) async {
      await openRequest(tester);
      await goToForm(tester);
      await tester.tap(
        find.byWidgetPredicate(
          (w) =>
              w is DropdownButtonFormField &&
              w.decoration.labelText == 'Tipo de traslado',
        ),
      );
      await AppHarness.settle(tester, frames: 4);

      expect(find.text('Traslado interno'), findsWidgets);
      expect(find.text('Préstamo externo'), findsWidgets);
      expect(find.text('Retorno a las instalaciones'), findsNothing);
      expect(find.text('Baja'), findsNothing);
    });

    testWidgets('fuera de las instalaciones: devolución y baja', (
      tester,
    ) async {
      await openRequest(
        tester,
        permissions: [...request, 'activos.dar_baja'],
        offPremises: true,
      );
      await goToForm(tester);
      await tester.tap(
        find.byWidgetPredicate(
          (w) =>
              w is DropdownButtonFormField &&
              w.decoration.labelText == 'Tipo de traslado',
        ),
      );
      await AppHarness.settle(tester, frames: 4);

      expect(find.text('Retorno a las instalaciones'), findsWidgets);
      expect(find.text('Baja'), findsWidgets);
      expect(find.text('Traslado interno'), findsNothing);
    });

    testWidgets('préstamo: destino obligatorio, queda pendiente de firma', (
      tester,
    ) async {
      await openRequest(tester);
      harness.adapter
        ..on(
          'POST',
          '/assets/7/transfers',
          status: 201,
          body: fixture('assets/transfer_requested_pending_response.json'),
        )
        ..on(
          'GET',
          '/assets/transfers/14',
          body: fixture('assets/transfer_requested_pending_response.json'),
        );
      await goToForm(tester);
      await pickOption(tester, 'Tipo de traslado', 'Préstamo externo');
      expect(
        find.textContaining('queda pendiente hasta que se confirme'),
        findsOneWidget,
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Solicitar traslado'));
      await AppHarness.settle(tester);
      expect(find.text('Este campo es obligatorio.'), findsOneWidget);
      expect(harness.adapter.callsTo('POST', '/assets/7/transfers'), isEmpty);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Destino externo'),
        'Clínica Aliada',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Solicitar traslado'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/assets/7/transfers').single.data,
        {
          'type': 'loan',
          'external_destination': 'Clínica Aliada',
        },
      );
      expect(find.text('Traslado'), findsOneWidget, reason: 'abre el detalle');
    });

    testWidgets('traslado interno: elige sede y lugar y se aplica', (
      tester,
    ) async {
      await openRequest(tester);
      harness.adapter.on(
        'POST',
        '/assets/7/transfers',
        status: 201,
        body: fixture('assets/transfer_applied_response.json'),
      );
      await goToForm(tester);
      await pickOption(tester, 'Tipo de traslado', 'Traslado interno');
      await pickOption(tester, 'Sede', 'Sede Principal');
      await pickOption(tester, 'Lugar', 'Bodega');
      await tester.tap(find.widgetWithText(FilledButton, 'Solicitar traslado'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/assets/7/transfers').single.data,
        {
          'type': 'relocation',
          'to_place_id': 5,
        },
      );
      expect(find.text('Traslado aplicado.'), findsOneWidget);
    });

    testWidgets('409 (otro traslado pendiente): muestra el mensaje', (
      tester,
    ) async {
      await openRequest(tester);
      harness.adapter.on(
        'POST',
        '/assets/7/transfers',
        status: 409,
        body: errorBody('El activo ya tiene un traslado pendiente.'),
      );
      await goToForm(tester);
      await pickOption(tester, 'Tipo de traslado', 'Traslado interno');
      await pickOption(tester, 'Sede', 'Sede Principal');
      await pickOption(tester, 'Lugar', 'Bodega');
      await tester.tap(find.widgetWithText(FilledButton, 'Solicitar traslado'));
      await AppHarness.settle(tester);

      expect(
        find.text('El activo ya tiene un traslado pendiente.'),
        findsOneWidget,
      );
      expect(
        harness.adapter.callsTo('POST', '/assets/7/transfers'),
        hasLength(1),
      );
    });
  });
}
