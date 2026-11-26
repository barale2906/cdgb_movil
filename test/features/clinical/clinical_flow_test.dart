import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _menu = 'auth/menu_clinical_response.json';
const _readRecords = ['registros_procedimientos.ver'];
const _withPatients = ['registros_procedimientos.ver', 'integraciones.ver'];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openClinical(
    WidgetTester tester, {
    List<String> permissions = _withPatients,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: permissions, menu: _menu)
      ..storeSession();
    harness.adapter
      ..on(
        'GET',
        '/patient-procedure-records',
        body: fixture('clinical/records_response.json'),
      )
      ..on(
        'GET',
        '/patient-procedure-records/22',
        body: fixture('clinical/record_response.json'),
      )
      ..on(
        'GET',
        '/patients/P00002/procedure-records',
        body: fixture('clinical/history_response.json'),
      )
      ..on(
        'GET',
        '/medsys/patients',
        body: fixture('clinical/patients_response.json'),
      )
      ..on(
        'GET',
        '/medsys/patients/P00001/appointments',
        body: fixture('clinical/appointments_response.json'),
      )
      ..on(
        'GET',
        '/patients/P00001/procedure-records',
        body: fixture('clinical/history_response.json'),
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

  testWidgets('lista los registros con paciente, total y facturación', (
    tester,
  ) async {
    await openClinical(tester);

    expect(find.text('Curaciones simples'), findsWidgets);
    expect(find.text('Ana María Pérez Gómez'), findsOneWidget);
    expect(find.text('24/11/2026'), findsOneWidget);
    expect(find.text(r'$100.000'), findsOneWidget);
    expect(find.text('SIN FACTURAR'), findsOneWidget);
    expect(find.text('FACTURADO'), findsOneWidget);
    expect(find.text('ANULADO'), findsOneWidget);
  });

  testWidgets('pide solo los últimos 30 días en hora de Colombia', (
    tester,
  ) async {
    await openClinical(tester);

    final call = harness.adapter
        .callsTo('GET', '/patient-procedure-records')
        .first;
    expect(call.queryParameters, {
      'service_date_from': '2026-10-25',
      'service_date_to': '2026-11-24',
    });
  });

  testWidgets('filtra por documento del paciente', (tester) async {
    await openClinical(tester);

    await tester.enterText(find.byType(TextField).first, '1000000002');
    await AppHarness.settle(tester);

    expect(
      harness.adapter
          .callsTo('GET', '/patient-procedure-records')
          .last
          .queryParameters,
      containsPair('patient_document', '1000000002'),
    );
  });

  testWidgets('sin registros: mensaje con la ventana de días', (tester) async {
    harness.adapter.on(
      'GET',
      '/patient-procedure-records',
      body: envelope(<dynamic>[]),
    );
    await openClinical(tester);

    expect(
      find.text('No hay registros en los últimos 30 días.'),
      findsOneWidget,
    );
  });

  testWidgets('error del servidor: mensaje y reintento manual', (
    tester,
  ) async {
    harness.adapter
      ..on(
        'GET',
        '/patient-procedure-records',
        status: 500,
        body: errorBody('Error interno'),
      )
      ..on(
        'GET',
        '/patient-procedure-records',
        body: fixture('clinical/records_response.json'),
      );
    await openClinical(tester);

    expect(find.text('Reintentar'), findsOneWidget);
    await tester.tap(find.text('Reintentar'));
    await AppHarness.settle(tester);

    expect(find.text('Ana María Pérez Gómez'), findsOneWidget);
  });

  testWidgets('el detalle muestra importes, descuento y orden', (
    tester,
  ) async {
    await openClinical(tester);

    await tester.tap(find.text('Consulta dermatología'));
    await AppHarness.settle(tester);

    expect(find.text('Registro de procedimiento'), findsOneWidget);
    expect(find.text('OS-2026-0007'), findsOneWidget);
    expect(
      find.text(r'$150.000'),
      findsNWidgets(2),
      reason: 'valor unitario y total (cantidad 1)',
    );
    expect(find.text(r'$15.000'), findsOneWidget, reason: 'descuento');
    expect(find.text(r'$135.000'), findsOneWidget, reason: 'total neto');
    expect(find.text('Remitente Prueba'), findsOneWidget);
    expect(find.text('FACTURADO'), findsOneWidget);
  });

  testWidgets('desde el detalle se abre el historial del paciente', (
    tester,
  ) async {
    await openClinical(tester);
    await tester.tap(find.text('Consulta dermatología'));
    await AppHarness.settle(tester);

    await tester.tap(find.text('Ver historial del paciente'));
    await AppHarness.settle(tester);

    expect(find.text('Historial de procedimientos'), findsOneWidget);
    expect(find.text('Procedimientos'), findsOneWidget);
    expect(find.text(r'$200.000'), findsOneWidget);
    expect(find.text('20/11/2026'), findsWidgets);
  });

  group('pacientes de MedSys', () {
    Future<void> openPatientsTab(WidgetTester tester) async {
      await openClinical(tester);
      await tester.tap(find.text('Pacientes'));
      await AppHarness.settle(tester);
    }

    testWidgets('sin integraciones.ver no hay pestaña de pacientes', (
      tester,
    ) async {
      await openClinical(tester, permissions: _readRecords);

      expect(find.text('Pacientes'), findsNothing);
      expect(find.text('Registros'), findsNothing);
      expect(find.text('Ana María Pérez Gómez'), findsOneWidget);
      expect(harness.adapter.callsTo('GET', '/medsys/patients'), isEmpty);
    });

    testWidgets('quien registra procedimientos u órdenes también busca', (
      tester,
    ) async {
      for (final extra in const [
        'registros_procedimientos.crear',
        'ordenes_servicio.crear',
      ]) {
        harness = AppHarness();
        await openClinical(
          tester,
          permissions: ['registros_procedimientos.ver', extra],
        );
        expect(find.text('Pacientes'), findsOneWidget, reason: extra);
        await tester.pumpWidget(const SizedBox());
      }
    });

    testWidgets('solo ver registros u órdenes no habilita la búsqueda', (
      tester,
    ) async {
      await openClinical(
        tester,
        permissions: ['registros_procedimientos.ver', 'ordenes_servicio.ver'],
      );

      expect(find.text('Pacientes'), findsNothing);
    });

    testWidgets('pide escribir al menos 3 caracteres y no consulta antes', (
      tester,
    ) async {
      await openPatientsTab(tester);

      expect(
        find.textContaining('Escriba al menos 3 caracteres'),
        findsOneWidget,
      );
      await tester.enterText(find.byType(TextField).last, 'an');
      await AppHarness.settle(tester);

      expect(
        find.textContaining('Escriba al menos 3 caracteres'),
        findsOneWidget,
        reason: 'con 2 caracteres sigue la indicación, no "sin resultados"',
      );
      expect(harness.adapter.callsTo('GET', '/medsys/patients'), isEmpty);
    });

    testWidgets('busca por documento y lista nombre limpio y documento', (
      tester,
    ) async {
      await openPatientsTab(tester);

      await tester.enterText(find.byType(TextField).last, '1000000001');
      await AppHarness.settle(tester);

      expect(find.text('ANA MARIA PEREZ GOMEZ'), findsOneWidget);
      expect(find.text('Documento 1000000001'), findsOneWidget);
      expect(find.text('LUIS RAMIREZ'), findsOneWidget);
      expect(
        harness.adapter
            .callsTo('GET', '/medsys/patients')
            .single
            .queryParameters,
        {'search': '1000000001'},
      );
    });

    testWidgets('búsqueda sin resultados: mensaje', (tester) async {
      harness.adapter.on(
        'GET',
        '/medsys/patients',
        body: envelope({'patients': <dynamic>[]}),
      );
      await openPatientsTab(tester);

      await tester.enterText(find.byType(TextField).last, 'zzzz');
      await AppHarness.settle(tester);

      expect(find.text('No se encontraron resultados.'), findsOneWidget);
    });

    testWidgets('la ficha muestra citas activas e historial', (tester) async {
      await openPatientsTab(tester);
      await tester.enterText(find.byType(TextField).last, '1000000001');
      await AppHarness.settle(tester);

      await tester.tap(find.text('ANA MARIA PEREZ GOMEZ'));
      await AppHarness.settle(tester);

      expect(find.text('Documento 1000000001'), findsOneWidget);
      expect(find.text('Citas activas'), findsOneWidget);
      expect(find.text('Dermatología'), findsOneWidget);
      expect(find.textContaining('09:00 a. m.'), findsOneWidget);
      expect(find.textContaining('01:15 p. m.'), findsOneWidget);
      expect(find.text('Historial de procedimientos'), findsOneWidget);
      expect(find.text('Consulta dermatología'), findsOneWidget);
    });

    testWidgets('si fallan las citas, el historial sigue visible', (
      tester,
    ) async {
      harness.adapter.on(
        'GET',
        '/medsys/patients/P00001/appointments',
        status: 500,
        body: errorBody('Error interno'),
      );
      await openPatientsTab(tester);
      await tester.enterText(find.byType(TextField).last, '1000000001');
      await AppHarness.settle(tester);

      await tester.tap(find.text('ANA MARIA PEREZ GOMEZ'));
      await AppHarness.settle(tester);

      expect(find.text('Reintentar'), findsOneWidget);
      expect(find.text('Consulta dermatología'), findsOneWidget);
    });
  });
}
