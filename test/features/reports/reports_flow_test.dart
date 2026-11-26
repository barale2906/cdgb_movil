import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _base = ['reportes.ver', 'stock.ver', 'almacenes.ver'];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}));

  Future<void> openReports(
    WidgetTester tester, {
    List<String> permissions = _base,
    Map<String, dynamic>? exportsBody,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 2600)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(
        permissions: permissions,
        menu: 'auth/menu_monitoring_response.json',
      )
      ..stubInventoryReads()
      ..storeSession();
    harness.adapter
      ..on('GET', '/sensors', body: fixture('monitoring/sensors_response.json'))
      ..on('GET', '/reports/exports', body: exportsBody ?? pagedBody([]));
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Reportes').last);
    await AppHarness.settle(tester);
  }

  Future<void> openType(WidgetTester tester, String label) async {
    await tester.tap(find.widgetWithText(ListTile, label));
    await AppHarness.settle(tester);
  }

  testWidgets(
    'el catálogo lista los reportes; auditoría solo con auditoria.ver',
    (tester) async {
      await openReports(tester);

      expect(find.text('Inventario'), findsWidgets);
      expect(find.text('Condiciones de almacenamiento'), findsOneWidget);
      expect(find.text('Mis exportaciones'), findsOneWidget);
      expect(find.text('Auditoría'), findsNothing);
    },
  );

  testWidgets('con auditoria.ver aparece el reporte de auditoría', (
    tester,
  ) async {
    await openReports(tester, permissions: [..._base, 'auditoria.ver']);
    expect(find.text('Auditoría'), findsOneWidget);
  });

  testWidgets('la ruta de auditoría sin permiso vuelve al catálogo', (
    tester,
  ) async {
    await openReports(tester);
    final context = tester.element(find.byType(Scaffold).first);

    GoRouter.of(context).go('/reports/audit');
    await AppHarness.settle(tester);

    expect(find.text('Elija un reporte'), findsOneWidget);
  });

  group('generar', () {
    testWidgets('por vencer en PDF: valida los días y abre el visor', (
      tester,
    ) async {
      await openReports(tester);
      harness.adapter.onBytes('GET', '/reports/expiring', [
        37,
        80,
        68,
        70,
        45,
        49,
      ]);
      await openType(tester, 'Por vencer');

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Días a considerar'),
        '0',
      );
      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);
      expect(find.text('Ingrese una cantidad mayor que cero.'), findsOneWidget);
      expect(harness.adapter.callsTo('GET', '/reports/expiring'), isEmpty);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Días a considerar'),
        '15',
      );
      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);

      final query = harness.adapter
          .callsTo('GET', '/reports/expiring')
          .single
          .queryParameters;
      expect(query['format'], 'pdf');
      expect(query['days'], 15);
      expect(
        query['warehouse_id'],
        isNull,
        reason: 'sin almacén elegido explícitamente',
      );
      expect(find.text('PDF 6 bytes'), findsOneWidget);
    });

    testWidgets('el visor permite compartir el PDF', (tester) async {
      await openReports(tester);
      harness.adapter.onBytes('GET', '/reports/inventory', [1, 2, 3]);
      await openType(tester, 'Inventario');

      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);
      await tester.tap(find.byTooltip('Compartir PDF'));
      await AppHarness.settle(tester);

      expect(harness.sharedFiles.single.$2, 3);
      expect(
        harness.sharedFiles.single.$1,
        matches(RegExp(r'^inventory_\d{4}-\d\d-\d\d\.pdf$')),
      );
    });

    testWidgets('Excel se comparte directamente', (tester) async {
      await openReports(tester);
      harness.adapter.onBytes('GET', '/reports/consumption', [9, 9, 9, 9]);
      await openType(tester, 'Consumo');

      await tester.tap(find.text('Excel'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);

      expect(harness.sharedFiles.single.$1, endsWith('.xlsx'));
      expect(
        harness.adapter
            .callsTo('GET', '/reports/consumption')
            .single
            .queryParameters['format'],
        'excel',
      );
      expect(find.text('Reporte generado.'), findsOneWidget);
    });

    testWidgets('reporte grande (202): avisa y abre Mis exportaciones', (
      tester,
    ) async {
      await openReports(tester);
      harness.adapter.onBytes(
        'GET',
        '/reports/movements',
        utf8.encode(
          jsonEncode({
            'success': true,
            'data': {'mode': 'async', 'export_id': 13, 'status': 'queued'},
          }),
        ),
        status: 202,
      );
      await openType(tester, 'Movimientos');

      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);

      expect(
        find.text(
          'El reporte es grande y se está generando. '
          'Puede seguirlo en Mis exportaciones.',
        ),
        findsOneWidget,
      );
      expect(find.text('No hay exportaciones.'), findsOneWidget);
    });

    testWidgets('el rango de fechas no puede terminar antes de empezar', (
      tester,
    ) async {
      await openReports(tester);
      await openType(tester, 'Compras');

      await tester.tap(find.widgetWithText(DateField, 'Desde'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('ACEPTAR'));
      await AppHarness.settle(tester);
      await tester.tap(find.widgetWithText(DateField, 'Hasta'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('1').first);
      await tester.tap(find.text('ACEPTAR'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);

      expect(
        find.text('La fecha final no puede ser anterior a la inicial.'),
        findsOneWidget,
      );
      expect(harness.adapter.callsTo('GET', '/reports/purchases'), isEmpty);
    });

    testWidgets('error 422 del servidor se muestra y no se reintenta', (
      tester,
    ) async {
      await openReports(tester);
      harness.adapter.onBytes(
        'GET',
        '/reports/inventory',
        utf8.encode(
          jsonEncode({
            'message': 'Parámetros inválidos.',
            'errors': {
              'format': ['Formato no válido.'],
            },
          }),
        ),
        status: 422,
      );
      await openType(tester, 'Inventario');

      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);

      expect(find.text('Parámetros inválidos.'), findsOneWidget);
      expect(
        harness.adapter.callsTo('GET', '/reports/inventory'),
        hasLength(1),
      );
    });

    testWidgets('condiciones en PDF exige sensor', (tester) async {
      await openReports(tester);
      await openType(tester, 'Condiciones de almacenamiento');

      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);

      expect(
        find.text('Para el PDF de condiciones elija un sensor.'),
        findsOneWidget,
      );
      expect(harness.adapter.callsTo('GET', '/reports/conditions'), isEmpty);
    });

    testWidgets('condiciones con el sensor elegido envía sensor_id', (
      tester,
    ) async {
      await openReports(tester);
      harness.adapter.onBytes('GET', '/reports/conditions', [5, 5]);
      await openType(tester, 'Condiciones de almacenamiento');

      await tester.tap(
        find.byWidgetPredicate(
          (w) =>
              w is DropdownButtonFormField &&
              w.decoration.labelText == 'Sensor',
        ),
      );
      await AppHarness.settle(tester, frames: 4);
      await tester.tap(find.text('Nevera farmacia').last);
      await AppHarness.settle(tester, frames: 4);
      await tester.tap(find.text('Generar reporte'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/reports/conditions')
            .single
            .queryParameters['sensor_id'],
        1,
      );
    });
  });

  group('exportaciones', () {
    Future<void> openExports(
      WidgetTester tester, {
      Map<String, dynamic>? body,
    }) async {
      await openReports(
        tester,
        exportsBody: body ?? fixture('reports/exports_response.json'),
      );
      await openType(tester, 'Mis exportaciones');
    }

    testWidgets(
      'muestra cada estado y solo permite descargar lo listo y vigente',
      (tester) async {
        await openExports(tester);

        expect(find.text('LISTO'), findsOneWidget);
        expect(find.text('PROCESANDO'), findsOneWidget);
        expect(find.text('FALLÓ'), findsOneWidget);
        expect(find.text('VENCIDO'), findsOneWidget);
        expect(find.text('Falló la consulta.'), findsOneWidget);
        expect(find.text('Descargar'), findsOneWidget);
      },
    );

    testWidgets('descargar un Excel listo lo comparte', (tester) async {
      await openExports(tester);
      harness.adapter.onBytes('GET', '/reports/exports/12/download', [7, 7, 7]);

      await tester.tap(find.text('Descargar'));
      await AppHarness.settle(tester);

      expect(harness.sharedFiles, [('inventory_12.xlsx', 3)]);
    });

    testWidgets(
      'mientras algo se procesa, se consulta cada 5 s hasta que esté listo',
      (tester) async {
        await openExports(tester);
        final ready = fixture('reports/exports_response.json');
        ((ready['data'] as List)[1] as Map<String, dynamic>)
          ..['status'] = 'ready'
          ..['is_ready'] = true;
        harness.adapter.on('GET', '/reports/exports', body: ready);
        final before = harness.adapter
            .callsTo('GET', '/reports/exports')
            .length;

        await tester.pump(const Duration(seconds: 6));
        await AppHarness.settle(tester, frames: 3);

        expect(
          harness.adapter.callsTo('GET', '/reports/exports').length,
          greaterThan(before),
        );
        expect(find.text('PROCESANDO'), findsNothing);
        expect(find.text('Descargar'), findsNWidgets(2));
      },
    );

    testWidgets('si todo terminó no se sigue consultando', (tester) async {
      await openExports(
        tester,
        body: pagedBody([
          (fixture('reports/exports_response.json')['data'] as List).first,
        ]),
      );
      final before = harness.adapter.callsTo('GET', '/reports/exports').length;

      await tester.pump(const Duration(seconds: 16));
      await AppHarness.settle(tester, frames: 2);

      expect(harness.adapter.callsTo('GET', '/reports/exports').length, before);
    });

    testWidgets('descarga de un reporte vencido (410): avisa', (tester) async {
      final body = pagedBody([
        {
          ...((fixture('reports/exports_response.json')['data'] as List).first
              as Map<String, dynamic>),
          'id': 99,
        },
      ]);
      await openExports(tester, body: body);
      harness.adapter.onBytes(
        'GET',
        '/reports/exports/99/download',
        utf8.encode(jsonEncode({'message': 'El reporte expiró.'})),
        status: 410,
      );

      await tester.tap(find.text('Descargar'));
      await AppHarness.settle(tester);

      expect(
        find.text('El reporte venció. Genérelo de nuevo desde Reportes.'),
        findsOneWidget,
      );
    });
  });
}
