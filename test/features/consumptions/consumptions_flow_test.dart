import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _menu = 'auth/menu_consumptions_response.json';
const _view = ['consumos.ver'];
const List<String> _creator = [
  'consumos.ver',
  'consumos.crear',
  'almacenes.ver',
  'centros_costo.ver',
  'generic-products.ver',
];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openConsumptions(
    WidgetTester tester, {
    List<String> permissions = _view,
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
        '/consumptions',
        body: fixture('consumptions/consumptions_response.json'),
      )
      ..on(
        'GET',
        '/consumptions/31',
        body: fixture('consumptions/consumption_response.json'),
      )
      ..on(
        'GET',
        '/medsys/consumption-projection',
        body: fixture('consumptions/projection_response.json'),
      )
      ..on(
        'GET',
        '/cost-centers',
        body: fixture('cost_centers/cost_centers_response.json'),
      )
      ..on(
        'GET',
        '/generic-products',
        body: fixture('catalog/products_list_response.json'),
      );
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Consumos').last);
    await AppHarness.settle(tester);
  }

  group('lista', () {
    testWidgets('muestra producto, lote, cantidad y estado de sincronización', (
      tester,
    ) async {
      await openConsumptions(tester);

      expect(find.text('Gasa estéril 10x10'), findsOneWidget);
      expect(find.text('Lote LOT-2026-A'), findsOneWidget);
      expect(find.text('FALLIDO'), findsOneWidget);
      expect(find.text('SINCRONIZADO'), findsOneWidget);
      expect(find.text('PENDIENTE'), findsOneWidget);
      expect(find.text('Insumo'), findsOneWidget, reason: 'sin nombre');
      expect(find.text('24/11/2026 09:15 a. m.'), findsOneWidget);
    });

    testWidgets('filtrar por estado pide solo ese estado', (tester) async {
      harness.adapter.on(
        'GET',
        '/consumptions',
        body: fixture('consumptions/failed_response.json'),
      );
      await openConsumptions(tester);

      await tester.tap(find.widgetWithText(ChoiceChip, 'Fallido'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/consumptions')
            .any((c) => c.queryParameters['sync_status'] == 'failed'),
        isTrue,
      );
    });

    testWidgets('sin consumos: mensaje', (tester) async {
      harness.adapter.on(
        'GET',
        '/consumptions',
        body: envelope({
          'items': <dynamic>[],
          'meta': {
            'current_page': 1,
            'per_page': 25,
            'total': 0,
            'last_page': 1,
          },
        }),
      );
      await openConsumptions(tester);

      expect(find.text('No hay consumos registrados.'), findsOneWidget);
    });

    testWidgets('sin crear no hay botón de nuevo consumo ni proyección', (
      tester,
    ) async {
      await openConsumptions(tester);

      expect(find.text('Nuevo consumo'), findsNothing);
      expect(find.text('Proyección'), findsNothing);
      expect(
        harness.adapter.callsTo('GET', '/medsys/consumption-projection'),
        isEmpty,
      );
    });
  });

  group('detalle', () {
    Future<void> openDetail(
      WidgetTester tester,
      List<String> permissions,
    ) async {
      await openConsumptions(tester, permissions: permissions);
      await tester.tap(find.text('Gasa estéril 10x10'));
      await AppHarness.settle(tester);
    }

    testWidgets('muestra datos de la cita y del paciente', (tester) async {
      await openDetail(tester, _view);

      expect(find.text('LOT-2026-A'), findsOneWidget);
      expect(find.text('C0001'), findsOneWidget);
      expect(find.text('1000000001'), findsOneWidget);
      expect(find.text('Curaciones'), findsOneWidget);
      expect(find.text('Reintentar sincronización'), findsNothing);
    });

    testWidgets('un consumo fallido se reintenta con confirmación', (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        '/consumptions/31/retry-sync',
        body: fixture('consumptions/retry_response.json'),
      );
      await openDetail(tester, ['consumos.ver', 'consumos.crear']);

      await tester.tap(find.text('Reintentar sincronización'));
      await AppHarness.settle(tester);
      expect(
        find.text('Se volverá a enviar el consumo a la historia clínica.'),
        findsOneWidget,
      );
      await tester.tap(find.text('Reintentar sincronización').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/consumptions/31/retry-sync'),
        hasLength(1),
      );
      expect(find.text('Sincronización reencolada.'), findsOneWidget);
    });

    testWidgets('sin respuesta al reintentar: avisa y no repite', (
      tester,
    ) async {
      harness.adapter.onError(
        'POST',
        '/consumptions/31/retry-sync',
        DioExceptionType.receiveTimeout,
      );
      await openDetail(tester, ['consumos.ver', 'consumos.crear']);

      await tester.tap(find.text('Reintentar sincronización'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Reintentar sincronización').last);
      await AppHarness.settle(tester);

      expect(
        find.textContaining('es posible que sí se haya reencolado'),
        findsOneWidget,
      );
      expect(
        harness.adapter.callsTo('POST', '/consumptions/31/retry-sync'),
        hasLength(1),
      );
    });
  });

  group('proyección', () {
    testWidgets('con integraciones.ver muestra la proyección por servicio', (
      tester,
    ) async {
      await openConsumptions(
        tester,
        permissions: [..._view, 'integraciones.ver'],
      );

      await tester.tap(find.text('Proyección'));
      await AppHarness.settle(tester);

      expect(find.text('Curaciones simples'), findsOneWidget);
      expect(find.text('12 citas · promedio 2,5 por cita'), findsOneWidget);
      expect(find.text('30 u.'), findsOneWidget);
      expect(
        harness.adapter
            .callsTo('GET', '/medsys/consumption-projection')
            .single
            .queryParameters,
        {'days': 30, 'historical_days': 90},
      );

      await tester.tap(find.widgetWithText(ChoiceChip, '7 días'));
      await AppHarness.settle(tester);
      expect(
        harness.adapter
            .callsTo('GET', '/medsys/consumption-projection')
            .last
            .queryParameters['days'],
        7,
      );
    });
  });

  group('nuevo consumo', () {
    Future<void> openForm(WidgetTester tester) async {
      await openConsumptions(tester, permissions: _creator);
      await tester.tap(find.text('Nuevo consumo'));
      await AppHarness.settle(tester);
    }

    Future<void> chooseWarehouseAndCenter(WidgetTester tester) async {
      await tester.tap(find.text('Almacén'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Farmacia').last);
      await AppHarness.settle(tester);
      await tester.tap(find.text('Centro de costo'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Farmacia').last);
      await AppHarness.settle(tester);
    }

    Future<void> addProduct(WidgetTester tester) async {
      await tester.tap(find.text('Agregar insumo'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Gasa estéril 10x10'));
      await AppHarness.settle(tester);
    }

    testWidgets('sin los permisos de apoyo no hay botón', (tester) async {
      await openConsumptions(
        tester,
        permissions: ['consumos.ver', 'consumos.crear'],
      );
      expect(find.text('Nuevo consumo'), findsNothing);
    });

    testWidgets('registra el consumo y vuelve a la lista', (tester) async {
      harness.adapter.on(
        'POST',
        '/consumptions',
        status: 201,
        body: fixture('consumptions/created_response.json'),
      );
      await openForm(tester);
      await chooseWarehouseAndCenter(tester);
      await addProduct(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Cantidad'),
        '3',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Código de la cita (opcional)'),
        'C0001',
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Registrar consumo'));
      await AppHarness.settle(tester);

      final data =
          harness.adapter.callsTo('POST', '/consumptions').single.data
              as Map<String, dynamic>;
      expect(data['warehouse_id'], 2);
      expect(data['cost_center_id'], 1);
      expect(data['appointment_id'], 'C0001');
      expect(data['items'], [
        {'generic_product_id': 5, 'quantity': 3},
      ]);
      expect(find.text('Consumo registrado.'), findsOneWidget);
    });

    testWidgets('faltan datos: pide completarlos y no envía', (tester) async {
      await openForm(tester);

      await tester.tap(find.widgetWithText(FilledButton, 'Registrar consumo'));
      await AppHarness.settle(tester);

      expect(find.text('Este campo es obligatorio.'), findsWidgets);
      expect(find.text('Agregue al menos un insumo.'), findsOneWidget);
      expect(harness.adapter.callsTo('POST', '/consumptions'), isEmpty);
    });

    testWidgets(
      'un 409 de stock insuficiente se muestra y se conserva lo escrito',
      (
        tester,
      ) async {
        harness.adapter.on(
          'POST',
          '/consumptions',
          status: 409,
          body: errorBody('Stock insuficiente para Gasa estéril 10x10.'),
        );
        await openForm(tester);
        await chooseWarehouseAndCenter(tester);
        await addProduct(tester);

        await tester.tap(
          find.widgetWithText(FilledButton, 'Registrar consumo'),
        );
        await AppHarness.settle(tester);

        expect(
          find.text('Stock insuficiente para Gasa estéril 10x10.'),
          findsOneWidget,
        );
        expect(find.text('Gasa estéril 10x10'), findsOneWidget);
      },
    );

    testWidgets('sin respuesta: bloquea hasta confirmar que no se registró', (
      tester,
    ) async {
      harness.adapter.onError(
        'POST',
        '/consumptions',
        DioExceptionType.receiveTimeout,
      );
      await openForm(tester);
      await chooseWarehouseAndCenter(tester);
      await addProduct(tester);

      await tester.tap(find.widgetWithText(FilledButton, 'Registrar consumo'));
      await AppHarness.settle(tester);

      expect(find.textContaining('pudo haberse registrado'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Registrar consumo'));
      await AppHarness.settle(tester);
      expect(harness.adapter.callsTo('POST', '/consumptions'), hasLength(1));
    });
  });
}
