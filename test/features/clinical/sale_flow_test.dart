import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _menu = 'auth/menu_clinical_response.json';
const _seller = [
  'registros_procedimientos.ver',
  'registros_procedimientos.crear',
  'servicios_medicos.ver',
];
const _create = '/patient-procedure-records';

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openSale(
    WidgetTester tester, {
    List<String> permissions = _seller,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: permissions, menu: _menu)
      ..storeSession();
    harness.adapter
      ..on('GET', _create, body: fixture('clinical/records_response.json'))
      ..on(
        'GET',
        '/medsys/patients',
        body: fixture('clinical/patients_response.json'),
      )
      ..on(
        'GET',
        '/medical-services/search',
        body: fixture('clinical/procedures_response.json'),
      );
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Registros clínicos').last);
    await AppHarness.settle(tester);
  }

  Future<void> startSale(WidgetTester tester) async {
    await tester.tap(find.text('Registrar venta'));
    await AppHarness.settle(tester);
  }

  Future<void> choosePatient(WidgetTester tester) async {
    await tester.tap(find.text('Buscar paciente'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextField).first, '1000000001');
    await AppHarness.settle(tester);
    await tester.tap(find.text('ANA MARIA PEREZ GOMEZ'));
    await AppHarness.settle(tester);
  }

  Future<void> addService(WidgetTester tester, String name) async {
    await tester.tap(find.text('Agregar servicio'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextField).first, 'cu');
    await AppHarness.settle(tester);
    await tester.tap(find.text(name));
    await AppHarness.settle(tester);
  }

  Future<void> fillSellerAndReferrer(WidgetTester tester) async {
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Vendedor Prueba',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Remitente Prueba',
    );
  }

  Future<void> submit(WidgetTester tester) async {
    await tester.tap(find.widgetWithText(FilledButton, 'Registrar venta'));
    await AppHarness.settle(tester);
  }

  testWidgets('sin crear registros o sin ver servicios no hay venta', (
    tester,
  ) async {
    await openSale(tester, permissions: ['registros_procedimientos.ver']);
    expect(find.text('Registrar venta'), findsNothing);

    await openSale(
      tester,
      permissions: ['registros_procedimientos.ver', 'servicios_medicos.ver'],
    );
    expect(find.text('Registrar venta'), findsNothing);
  });

  testWidgets('arma la venta: paciente, servicio con tarifa y total', (
    tester,
  ) async {
    await openSale(tester);
    await startSale(tester);

    await choosePatient(tester);
    expect(find.text('ANA MARIA PEREZ GOMEZ'), findsOneWidget);
    expect(find.text('Documento 1000000001'), findsOneWidget);

    await addService(tester, 'Curaciones simples');
    expect(find.text('Curaciones simples'), findsOneWidget);
    expect(find.text(r'Total de la venta: $50.000'), findsOneWidget);
  });

  testWidgets('registra la venta, avisa y vuelve a los registros', (
    tester,
  ) async {
    harness.adapter.on(
      'POST',
      _create,
      status: 201,
      body: fixture('clinical/record_response.json'),
    );
    await openSale(tester);
    await startSale(tester);
    await choosePatient(tester);
    await addService(tester, 'Curaciones simples');
    await fillSellerAndReferrer(tester);

    await submit(tester);

    final body =
        harness.adapter.callsTo('POST', _create).single.data
            as Map<String, dynamic>;
    expect(body['medical_service_id'], 3);
    expect(body['patient_external_id'], 'P00001');
    expect(body['patient_first_name'], 'ANA MARIA');
    expect(body['service_date'], '2026-11-24');
    expect(body['seller'], 'Vendedor Prueba');
    expect(find.text('Venta registrada.'), findsOneWidget);
    expect(
      find.text('Registrar venta'),
      findsOneWidget,
      reason: 'de vuelta en la lista (queda el botón de la sección)',
    );
  });

  testWidgets('faltan datos: pide completarlos y no envía nada', (
    tester,
  ) async {
    await openSale(tester);
    await startSale(tester);

    await submit(tester);

    expect(find.text('Elija el paciente al que se le vende.'), findsOneWidget);
    expect(find.text('Agregue al menos un servicio.'), findsOneWidget);
    expect(find.text('Este campo es obligatorio.'), findsWidgets);
    expect(harness.adapter.callsTo('POST', _create), isEmpty);
  });

  testWidgets('un servicio sin tarifa exige escribir el valor', (
    tester,
  ) async {
    await openSale(tester);
    await startSale(tester);
    await choosePatient(tester);
    await addService(tester, 'Consulta dermatología');
    await fillSellerAndReferrer(tester);

    await submit(tester);

    expect(harness.adapter.callsTo('POST', _create), isEmpty);
    expect(find.text('Este campo es obligatorio.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(3), '150000');
    await AppHarness.settle(tester);
    expect(find.text(r'Total de la venta: $150.000'), findsOneWidget);
  });

  testWidgets(
    'falla la segunda línea: la primera queda registrada y bloqueada',
    (
      tester,
    ) async {
      harness.adapter
        ..on('POST', _create, body: fixture('clinical/record_response.json'))
        ..on(
          'POST',
          _create,
          status: 422,
          body: errorBody('El servicio no admite esa cantidad.'),
        );
      await openSale(tester);
      await startSale(tester);
      await choosePatient(tester);
      await addService(tester, 'Curaciones simples');
      await addService(tester, 'Consulta dermatología');
      await fillSellerAndReferrer(tester);
      await tester.enterText(find.byType(TextFormField).at(5), '150000');

      await submit(tester);

      expect(find.text('REGISTRADO'), findsOneWidget);
      expect(find.text('NO SE REGISTRÓ'), findsOneWidget);
      expect(find.text('El servicio no admite esa cantidad.'), findsOneWidget);
      expect(find.textContaining('ya quedaron registrados'), findsOneWidget);
      expect(find.text('Venta registrada.'), findsNothing);
      expect(harness.adapter.callsTo('POST', _create), hasLength(2));
    },
  );

  testWidgets('sin respuesta: avisa que puede estar registrada y no reenvía', (
    tester,
  ) async {
    harness.adapter.onError('POST', _create, DioExceptionType.receiveTimeout);
    await openSale(tester);
    await startSale(tester);
    await choosePatient(tester);
    await addService(tester, 'Curaciones simples');
    await fillSellerAndReferrer(tester);

    await submit(tester);

    expect(find.text('SIN CONFIRMAR'), findsOneWidget);
    expect(
      find.textContaining('puede que sí se haya registrado'),
      findsOneWidget,
    );

    await submit(tester);
    expect(
      harness.adapter.callsTo('POST', _create),
      hasLength(1),
      reason: 'no se reenvía hasta que el usuario lo confirme',
    );
  });

  testWidgets('el paciente se puede cambiar antes de enviar', (tester) async {
    await openSale(tester);
    await startSale(tester);
    await choosePatient(tester);

    await tester.tap(find.text('Cambiar paciente'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextField).first, '1000000002');
    await AppHarness.settle(tester);
    await tester.tap(find.text('LUIS RAMIREZ'));
    await AppHarness.settle(tester);

    expect(find.text('LUIS RAMIREZ'), findsOneWidget);
    expect(find.text('ANA MARIA PEREZ GOMEZ'), findsNothing);
  });

  group('acceso rápido del inicio', () {
    Future<void> openHome(WidgetTester tester, List<String> permissions) async {
      tester.view
        ..physicalSize = const Size(800, 3000)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      harness
        ..stubSignedInUser(permissions: permissions, menu: _menu)
        ..storeSession();
      await harness.pump(tester);
    }

    testWidgets('con permisos abre el formulario de venta', (tester) async {
      await openHome(tester, _seller);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Registrar venta'));
      await AppHarness.settle(tester);

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Registrar venta'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('sin ver servicios médicos no aparece', (tester) async {
      await openHome(tester, [
        'registros_procedimientos.ver',
        'registros_procedimientos.crear',
      ]);

      expect(find.text('Registrar venta'), findsNothing);
    });

    testWidgets('el formulario no se abre por URL sin permisos', (
      tester,
    ) async {
      await openHome(tester, ['registros_procedimientos.ver']);
      // Sin el permiso la ruta redirige al inicio.
      expect(find.text('Elegir paciente'), findsNothing);
    });
  });
}
