import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _menu = 'auth/menu_clinical_response.json';
const _record = '/patient-procedure-records/22';
const _evolutions = '$_record/evolutions';
const _read = ['registros_procedimientos.ver', 'evoluciones_clinicas.ver'];
const List<String> _writer = [
  ..._read,
  'evoluciones_clinicas.crear',
  'evoluciones_clinicas.editar',
];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openRecord(
    WidgetTester tester, {
    List<String> permissions = _writer,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 4000)
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
      ..on('GET', _record, body: fixture('clinical/record_response.json'))
      ..on(
        'GET',
        _evolutions,
        body: fixture('clinical/evolutions_response.json'),
      )
      ..on(
        'GET',
        '$_record/medications',
        body: fixture('clinical/medications_response.json'),
      )
      ..on(
        'GET',
        '/clinical-templates/for-service/4',
        body: fixture('clinical/template_response.json'),
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
    await tester.tap(find.text('Consulta dermatología'));
    await AppHarness.settle(tester);
  }

  testWidgets('lista las evoluciones como texto, con autor y fecha', (
    tester,
  ) async {
    await openRecord(tester);

    expect(find.text('Evoluciones clínicas'), findsOneWidget);
    expect(
      find.text('Paciente estable.\nSe indica control en 8 días.'),
      findsOneWidget,
    );
    expect(find.text('Nota en texto simple'), findsOneWidget);
    expect(
      find.text('Usuario Prueba · 23/11/2026 10:30 a. m.'),
      findsOneWidget,
    );
  });

  testWidgets('sin evoluciones: mensaje', (tester) async {
    harness.adapter.on('GET', _evolutions, body: envelope(<dynamic>[]));
    await openRecord(tester);

    expect(find.text('Este registro no tiene evoluciones.'), findsOneWidget);
  });

  testWidgets('sin evoluciones_clinicas.ver no se ve ni se pide la sección', (
    tester,
  ) async {
    await openRecord(tester, permissions: ['registros_procedimientos.ver']);

    expect(find.text('Evoluciones clínicas'), findsNothing);
    expect(harness.adapter.callsTo('GET', _evolutions), isEmpty);
  });

  testWidgets('los botones de agregar y editar dependen del permiso', (
    tester,
  ) async {
    await openRecord(tester, permissions: _read);

    expect(find.text('Agregar evolución'), findsNothing);
    expect(find.text('Editar evolución'), findsNothing);
  });

  testWidgets('muestra los medicamentos aplicados con permiso', (tester) async {
    await openRecord(
      tester,
      permissions: [..._read, 'medicamentos_procedimiento.ver'],
    );

    expect(find.text('Medicamentos aplicados'), findsOneWidget);
    expect(find.text('Lidocaína 2% ampolla'), findsOneWidget);
    expect(find.text('Lote LOT-2026-A · vence 31/03/2027'), findsOneWidget);
  });

  testWidgets('sin permiso de medicamentos no se piden', (tester) async {
    await openRecord(tester);

    expect(find.text('Medicamentos aplicados'), findsNothing);
    expect(harness.adapter.callsTo('GET', '$_record/medications'), isEmpty);
  });

  testWidgets(
    'agregar: precarga la plantilla, guarda como párrafos y recarga',
    (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        _evolutions,
        status: 201,
        body: fixture('clinical/evolution_response.json'),
      );
      await openRecord(
        tester,
        permissions: [..._writer, 'plantillas_clinicas.ver'],
      );

      await tester.tap(find.text('Agregar evolución'));
      await AppHarness.settle(tester);
      expect(find.text('Nueva evolución'), findsOneWidget);
      expect(
        find.text(
          'Se cargó la plantilla del servicio. Ajústela antes de guardar.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Guardar evolución'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', _evolutions).single.data,
        {'content': '<p>Motivo: curación</p><p>Estado de la herida:</p>'},
      );
      expect(find.text('Evolución guardada.'), findsOneWidget);
      expect(harness.adapter.callsTo('GET', _evolutions), hasLength(2));
    },
  );

  testWidgets('agregar sin permiso de plantillas: el campo empieza vacío', (
    tester,
  ) async {
    await openRecord(tester);

    await tester.tap(find.text('Agregar evolución'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Guardar evolución'));
    await AppHarness.settle(tester);

    expect(find.text('Este campo es obligatorio.'), findsOneWidget);
    expect(harness.adapter.callsTo('POST', _evolutions), isEmpty);
    expect(
      harness.adapter.callsTo('GET', '/clinical-templates/for-service/4'),
      isEmpty,
    );
  });

  testWidgets('editar: carga el texto actual y guarda con PUT', (tester) async {
    harness.adapter.on(
      'PUT',
      '$_evolutions/7',
      body: fixture('clinical/evolution_response.json'),
    );
    await openRecord(tester);

    await tester.tap(find.text('Editar evolución').first);
    await AppHarness.settle(tester);
    expect(find.text('Editar evolución'), findsOneWidget);
    await tester.enterText(
      find.byType(TextFormField),
      'Paciente en buen estado.',
    );
    await tester.tap(find.text('Guardar evolución'));
    await AppHarness.settle(tester);

    expect(
      harness.adapter.callsTo('PUT', '$_evolutions/7').single.data,
      {'content': '<p>Paciente en buen estado.</p>'},
    );
    expect(harness.adapter.callsTo('POST', _evolutions), isEmpty);
  });

  testWidgets('sin respuesta: avisa que pudo guardarse y no reintenta', (
    tester,
  ) async {
    harness.adapter.onError(
      'POST',
      _evolutions,
      DioExceptionType.receiveTimeout,
    );
    await openRecord(tester);

    await tester.tap(find.text('Agregar evolución'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextFormField), 'Texto');
    await tester.tap(find.text('Guardar evolución'));
    await AppHarness.settle(tester);

    expect(
      find.textContaining('es posible que sí se haya guardado'),
      findsOneWidget,
    );
    expect(harness.adapter.callsTo('POST', _evolutions), hasLength(1));
  });

  testWidgets(
    'un 403 al guardar muestra el mensaje y se queda en el formulario',
    (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        _evolutions,
        status: 403,
        body: errorBody('No tiene permiso para esta acción.'),
      );
      await openRecord(tester);

      await tester.tap(find.text('Agregar evolución'));
      await AppHarness.settle(tester);
      await tester.enterText(find.byType(TextFormField), 'Texto');
      await tester.tap(find.text('Guardar evolución'));
      await AppHarness.settle(tester);

      expect(find.text('No tiene permiso para esta acción.'), findsOneWidget);
      expect(find.text('Nueva evolución'), findsOneWidget);
    },
  );
}
