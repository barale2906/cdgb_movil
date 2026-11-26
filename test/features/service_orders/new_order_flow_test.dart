import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _menu = 'auth/menu_service_orders_response.json';
const _number = 'OS-20261124-000001';
const _creator = [
  'ordenes_servicio.ver',
  'ordenes_servicio.crear',
  'servicios_medicos.ver',
];
const List<String> _withSupplies = [
  ..._creator,
  'generic-products.ver',
  'almacenes.ver',
];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Finder field(String label) => find.widgetWithText(TextFormField, label);

  Future<void> openForm(
    WidgetTester tester, {
    List<String> permissions = _creator,
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
        '/medsys/patients',
        body: fixture('clinical/patients_response.json'),
      )
      ..on(
        'GET',
        '/medical-services/search',
        body: fixture('clinical/procedures_response.json'),
      )
      ..on(
        'GET',
        '/generic-products',
        body: fixture('catalog/products_list_response.json'),
      )
      ..on(
        'GET',
        '/service-orders/$_number',
        body: fixture('service_orders/order_pending_response.json'),
      );
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Órdenes de servicio').last);
    await AppHarness.settle(tester);
    await tester.tap(find.text('Nueva orden'));
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

  Future<void> addProcedure(WidgetTester tester, String name) async {
    await tester.tap(find.text('Agregar servicio'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextField).first, 'cu');
    await AppHarness.settle(tester);
    await tester.tap(find.text(name));
    await AppHarness.settle(tester);
  }

  Future<void> submit(WidgetTester tester) async {
    await tester.tap(find.text('Crear orden'));
    await AppHarness.settle(tester);
  }

  Future<void> writeEvolution(WidgetTester tester) async {
    await tester.enterText(
      field('Evolución clínica'),
      'Paciente estable.\nSin dolor.',
    );
    await AppHarness.settle(tester);
  }

  Future<void> fillValid(WidgetTester tester) async {
    await choosePatient(tester);
    await addProcedure(tester, 'Curaciones simples');
    await writeEvolution(tester);
  }

  testWidgets('crea la orden con descuento y abre su detalle', (tester) async {
    harness.adapter.on(
      'POST',
      '/service-orders',
      status: 201,
      body: fixture('service_orders/order_pending_response.json'),
    );
    await openForm(tester);
    await fillValid(tester);
    await tester.enterText(field('Vendedor'), 'Vendedor Prueba');
    await tester.tap(find.byType(Switch));
    await AppHarness.settle(tester);
    await tester.enterText(field('Porcentaje (%)'), '10');
    await AppHarness.settle(tester);

    expect(find.text(r'Total: $50.000'), findsOneWidget);
    expect(find.text(r'Descuento: $5.000'), findsOneWidget);
    expect(find.text(r'Total neto: $45.000'), findsOneWidget);

    await submit(tester);

    final data =
        harness.adapter.callsTo('POST', '/service-orders').single.data
            as Map<String, dynamic>;
    expect(data['patient_first_name'], 'ANA MARIA');
    expect(data['patient_phone'], '3000000001');
    expect(data['seller'], 'Vendedor Prueba');
    expect(data.containsKey('referrer'), isFalse);
    expect(data['procedures'], [
      {
        'medical_service_id': 3,
        'quantity': 1.0,
        'unit_price': 50000.0,
        'discount_type': 'percentage',
        'discount_value': 10.0,
        'notes': '<p>Paciente estable.</p><p>Sin dolor.</p>',
      },
    ]);
    expect(find.text('Orden $_number creada.'), findsOneWidget);
    expect(find.text('DESCUENTO POR APROBAR'), findsOneWidget);
  });

  testWidgets('faltan datos: pide completarlos y no envía', (tester) async {
    await openForm(tester);

    await submit(tester);

    expect(find.text('Elija el paciente al que se le vende.'), findsOneWidget);
    expect(find.text('Agregue al menos un servicio.'), findsOneWidget);
    expect(harness.adapter.callsTo('POST', '/service-orders'), isEmpty);
  });

  testWidgets('un descuento fuera de rango impide enviar', (tester) async {
    await openForm(tester);
    await fillValid(tester);
    await tester.tap(find.byType(Switch));
    await AppHarness.settle(tester);
    await tester.enterText(field('Porcentaje (%)'), '150');

    await submit(tester);

    expect(find.text('Debe estar entre 0 y 100.'), findsOneWidget);
    expect(harness.adapter.callsTo('POST', '/service-orders'), isEmpty);
  });

  testWidgets('un procedimiento sin tarifa exige escribir el valor', (
    tester,
  ) async {
    await openForm(tester);
    await choosePatient(tester);
    await addProcedure(tester, 'Consulta dermatología');
    await writeEvolution(tester);

    await submit(tester);

    expect(find.text('Este campo es obligatorio.'), findsOneWidget);
    expect(harness.adapter.callsTo('POST', '/service-orders'), isEmpty);
  });

  testWidgets('un 409 muestra el mensaje y avisa que pudo quedar a medias', (
    tester,
  ) async {
    harness.adapter.on(
      'POST',
      '/service-orders',
      status: 409,
      body: errorBody('Stock insuficiente para Gasa estéril.'),
    );
    await openForm(tester);
    await fillValid(tester);

    await submit(tester);

    expect(find.text('Stock insuficiente para Gasa estéril.'), findsOneWidget);
    expect(find.textContaining('pudo quedar a medias'), findsOneWidget);
    expect(
      find.text('Crear orden'),
      findsOneWidget,
      reason: 'lo escrito se conserva y se puede corregir',
    );
  });

  testWidgets('sin respuesta: bloquea el envío hasta que el usuario confirme', (
    tester,
  ) async {
    harness.adapter
      ..onError('POST', '/service-orders', DioExceptionType.receiveTimeout)
      ..on(
        'POST',
        '/service-orders',
        body: fixture('service_orders/order_pending_response.json'),
      );
    await openForm(tester);
    await fillValid(tester);

    await submit(tester);

    expect(find.textContaining('La orden pudo haberse creado'), findsOneWidget);
    await submit(tester);
    expect(
      harness.adapter.callsTo('POST', '/service-orders'),
      hasLength(1),
      reason: 'el botón queda bloqueado',
    );

    await tester.tap(find.text('Ya revisé: no se creó, enviar de nuevo'));
    await AppHarness.settle(tester);
    await submit(tester);
    expect(harness.adapter.callsTo('POST', '/service-orders'), hasLength(2));
  });

  group('evolución clínica', () {
    testWidgets('es obligatoria: sin ella no se envía', (tester) async {
      await openForm(tester);
      await choosePatient(tester);
      await addProcedure(tester, 'Curaciones simples');

      await submit(tester);

      expect(
        find.text('Escriba la evolución clínica del procedimiento.'),
        findsOneWidget,
      );
      expect(harness.adapter.callsTo('POST', '/service-orders'), isEmpty);
    });

    testWidgets('muestra cuántos caracteres lleva y avisa si se pasa', (
      tester,
    ) async {
      await openForm(tester);
      await choosePatient(tester);
      await addProcedure(tester, 'Curaciones simples');

      await tester.enterText(field('Evolución clínica'), 'x' * 600);
      await AppHarness.settle(tester);
      await submit(tester);

      expect(find.text('607 de 500'), findsOneWidget);
      expect(
        find.text('La evolución es demasiado larga (máximo 500 caracteres).'),
        findsOneWidget,
      );
      expect(harness.adapter.callsTo('POST', '/service-orders'), isEmpty);
    });

    testWidgets('con permiso se precarga la plantilla del servicio', (
      tester,
    ) async {
      harness.adapter.on(
        'GET',
        '/clinical-templates/for-service/3',
        body: fixture('clinical/template_response.json'),
      );
      await openForm(
        tester,
        permissions: [..._creator, 'plantillas_clinicas.ver'],
      );
      await choosePatient(tester);
      await addProcedure(tester, 'Curaciones simples');

      expect(
        find.text('Motivo: curación\nEstado de la herida:'),
        findsOneWidget,
      );
    });
  });

  group('insumos', () {
    testWidgets('sin catálogo y almacenes no se ofrecen', (tester) async {
      await openForm(tester);
      await fillValid(tester);

      expect(find.text('Agregar insumo'), findsNothing);
    });

    testWidgets('salen de un almacén y viajan en el procedimiento', (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        '/service-orders',
        status: 201,
        body: fixture('service_orders/order_pending_response.json'),
      );
      await openForm(tester, permissions: _withSupplies);
      await fillValid(tester);

      await tester.tap(find.text('Agregar insumo'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Gasa estéril 10x10'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Almacén de donde salen'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Farmacia').last);
      await AppHarness.settle(tester);
      await tester.enterText(field('Cantidad').last, '2,5');
      await AppHarness.settle(tester);

      await submit(tester);

      final data =
          harness.adapter.callsTo('POST', '/service-orders').single.data
              as Map<String, dynamic>;
      final procedure = (data['procedures'] as List).single as Map;
      expect(procedure['supplies'], [
        {'warehouse_id': 2, 'generic_product_id': 5, 'quantity': 2.5},
      ]);
    });

    testWidgets('sin almacén o cantidad no se envía', (tester) async {
      await openForm(tester, permissions: _withSupplies);
      await fillValid(tester);
      await tester.tap(find.text('Agregar insumo'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Gasa estéril 10x10'));
      await AppHarness.settle(tester);

      await submit(tester);

      expect(find.text('Elija el almacén de los insumos.'), findsOneWidget);
      expect(harness.adapter.callsTo('POST', '/service-orders'), isEmpty);
    });
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

    testWidgets('con permisos abre el formulario de la orden', (tester) async {
      await openHome(tester, _creator);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Nueva orden'));
      await AppHarness.settle(tester);

      expect(find.text('Nueva orden de servicio'), findsOneWidget);
    });

    testWidgets('sin ver servicios médicos no aparece', (tester) async {
      await openHome(tester, [
        'ordenes_servicio.ver',
        'ordenes_servicio.crear',
      ]);

      expect(find.text('Nueva orden'), findsNothing);
    });
  });
}
