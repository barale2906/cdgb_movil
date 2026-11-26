import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _view = ['activos.ver', 'activos_mantenimientos.ver'];
const _menu = 'auth/menu_assets_response.json';

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openMaintenance(
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
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Mantenimientos').last);
    await AppHarness.settle(tester);
  }

  /// La próxima lectura de la lista (al cambiar de filtro) trae solo [id].
  void nextListHas(int id) => harness.adapter.on(
    'GET',
    '/assets/maintenances',
    body: pagedBody([
      fixture('assets/maintenance_${id}_response.json')['data'],
    ]),
  );

  Future<void> openItem(WidgetTester tester, String assetName) async {
    await tester.tap(find.text(assetName).first);
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

  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(
        finder,
        200,
        scrollable: find.byType(Scrollable).last,
      );

  group('lista', () {
    testWidgets('por defecto pide los programados y marca los vencidos', (
      tester,
    ) async {
      await openMaintenance(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/assets/maintenances')
            .any((c) => c.queryParameters['status'] == 'scheduled'),
        isTrue,
      );
      expect(find.text('Monitor de signos vitales'), findsWidgets);
      expect(find.text('VENCIDO'), findsWidgets);
      expect(find.text('Programado para el 10/11/2026'), findsWidgets);
      expect(find.textContaining('Preventivo'), findsWidgets);
    });

    testWidgets('el filtro Vencido pide overdue al servidor', (tester) async {
      await openMaintenance(tester);
      await tester.tap(find.widgetWithText(ChoiceChip, 'Vencido'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/assets/maintenances')
            .any((c) => c.queryParameters['overdue'] == true),
        isTrue,
      );
    });

    testWidgets('sin mantenimientos: mensaje', (tester) async {
      await openMaintenance(
        tester,
        before: () => harness.adapter.on(
          'GET',
          '/assets/maintenances',
          body: pagedBody(<dynamic>[]),
        ),
      );
      expect(find.text('No hay mantenimientos para mostrar.'), findsOneWidget);
    });

    testWidgets('sin permiso la sección no existe', (tester) async {
      tester.view
        ..physicalSize = const Size(800, 3000)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      harness
        ..stubSignedInUser(permissions: ['activos.ver'], menu: _menu)
        ..stubAssetsReads()
        ..storeSession();
      await harness.pump(tester);
      expect(find.text('Mantenimientos'), findsNothing);
    });
  });

  group('detalle y acciones', () {
    testWidgets('sin permiso de ejecutar solo se ve el reporte', (
      tester,
    ) async {
      await openMaintenance(tester);
      await openItem(tester, 'Monitor de signos vitales');

      expect(find.text('Iniciar mantenimiento'), findsNothing);
      expect(find.text('Cancelar mantenimiento'), findsNothing);
      expect(find.text('Reporte del mantenimiento (PDF)'), findsOneWidget);
    });

    testWidgets('iniciar pide confirmación y avisa el resultado', (
      tester,
    ) async {
      await openMaintenance(
        tester,
        permissions: [..._view, 'activos_mantenimientos.ejecutar'],
      );
      harness.adapter.on(
        'POST',
        '/assets/maintenances/31/start',
        body: fixture('assets/maintenance_32_response.json'),
      );
      await openItem(tester, 'Monitor de signos vitales');

      await tester.tap(find.text('Iniciar mantenimiento'));
      await AppHarness.settle(tester);
      expect(
        find.textContaining('pasará a "En mantenimiento"'),
        findsOneWidget,
      );
      await tester.tap(find.text('Iniciar mantenimiento').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/assets/maintenances/31/start'),
        hasLength(1),
      );
      expect(find.text('Mantenimiento iniciado.'), findsOneWidget);
    });

    testWidgets('cancelar exige motivo', (tester) async {
      await openMaintenance(
        tester,
        permissions: [..._view, 'activos_mantenimientos.cancelar'],
      );
      harness.adapter.on(
        'POST',
        '/assets/maintenances/31/cancel',
        body: fixture('assets/maintenance_31_response.json'),
      );
      await openItem(tester, 'Monitor de signos vitales');
      await scrollTo(tester, find.text('Cancelar mantenimiento'));
      await tester.tap(find.text('Cancelar mantenimiento'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Cancelar mantenimiento').last);
      await AppHarness.settle(tester);
      expect(find.text('Este campo es obligatorio.'), findsOneWidget);

      await tester.enterText(
        find.byType(TextFormField).last,
        'Equipo retirado',
      );
      await tester.tap(find.text('Cancelar mantenimiento').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('POST', '/assets/maintenances/31/cancel')
            .single
            .data,
        {'reason': 'Equipo retirado'},
      );
      expect(find.text('Mantenimiento cancelado.'), findsOneWidget);
    });

    testWidgets('un mantenimiento realizado muestra su ejecución', (
      tester,
    ) async {
      await openMaintenance(
        tester,
        permissions: [..._view, 'activos_mantenimientos.ejecutar'],
      );
      nextListHas(33);
      await tester.tap(find.widgetWithText(ChoiceChip, 'Realizado'));
      await AppHarness.settle(tester);
      await openItem(tester, 'Monitor de signos vitales');

      expect(find.text('Limpieza y verificación'), findsOneWidget);
      expect(find.text('Operativo'), findsOneWidget);
      expect(find.text('Filtro'), findsOneWidget);
      expect(find.text(r'$30.000'), findsOneWidget);
      expect(find.text('Registrar ejecución'), findsNothing);
      expect(find.text('Iniciar mantenimiento'), findsNothing);
    });

    testWidgets('el reporte se abre como PDF', (tester) async {
      await openMaintenance(tester);
      harness.adapter.onBytes('GET', '/assets/maintenances/31/report', [1, 2]);
      await openItem(tester, 'Monitor de signos vitales');
      await scrollTo(tester, find.text('Reporte del mantenimiento (PDF)'));
      await tester.tap(find.text('Reporte del mantenimiento (PDF)'));
      await AppHarness.settle(tester);
      expect(find.text('PDF 2 bytes'), findsOneWidget);
    });
  });

  group('registrar ejecución', () {
    const execute = [..._view, 'activos_mantenimientos.ejecutar'];

    Future<void> openForm(WidgetTester tester) async {
      await openMaintenance(tester, permissions: execute);
      nextListHas(32);
      await tester.tap(find.widgetWithText(ChoiceChip, 'En curso'));
      await AppHarness.settle(tester);
      await openItem(tester, 'Portátil administrativo');
      await tester.tap(find.text('Registrar ejecución'));
      await AppHarness.settle(tester);
    }

    Future<void> submit(WidgetTester tester) async {
      await tester.tap(
        find.widgetWithText(FilledButton, 'Registrar ejecución'),
      );
      await AppHarness.settle(tester);
    }

    testWidgets('exige técnico, actividades y resultado', (tester) async {
      await openForm(tester);
      await submit(tester);

      expect(find.text('Este campo es obligatorio.'), findsWidgets);
      expect(
        harness.adapter.callsTo('POST', '/assets/maintenances/32/complete'),
        isEmpty,
      );
    });

    testWidgets('registra la ejecución interna con repuestos', (tester) async {
      await openForm(tester);
      harness.adapter.on(
        'POST',
        '/assets/maintenances/32/complete',
        body: fixture('assets/maintenance_33_response.json'),
      );

      await pickOption(tester, 'Técnico', 'Usuario Prueba');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Actividades realizadas'),
        'Cambio de batería',
      );
      await pickOption(tester, 'Resultado', 'Operativo con restricciones');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Costo (opcional)'),
        '45000',
      );
      await scrollTo(tester, find.text('Agregar repuesto'));
      await tester.tap(find.text('Agregar repuesto'));
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Repuesto'),
        'Batería',
      );
      await tester.tap(find.text('Guardar'));
      await AppHarness.settle(tester);
      expect(find.text('Batería'), findsOneWidget);
      await submit(tester);

      final data =
          harness.adapter
                  .callsTo('POST', '/assets/maintenances/32/complete')
                  .single
                  .data
              as Map<String, dynamic>;
      expect(data['performed_by_type'], 'internal');
      expect(data['technician_id'], 3);
      expect(data['activities_performed'], 'Cambio de batería');
      expect(data['result'], 'operational_with_restrictions');
      expect(data['cost'], 45000);
      expect((data['parts_replaced'] as List).single, {
        'name': 'Batería',
        'quantity': 1.0,
      });
      expect(
        data['performed_at'],
        matches(RegExp(r'^\d{4}-\d\d-\d\d \d\d:\d\d:\d\d$')),
      );
      expect(find.text('Ejecución registrada.'), findsOneWidget);
    });

    testWidgets('externo: pide proveedor y nombre del técnico', (tester) async {
      await openForm(tester);
      harness.adapter.on(
        'POST',
        '/assets/maintenances/32/complete',
        body: fixture('assets/maintenance_33_response.json'),
      );
      await tester.tap(find.text('Proveedor externo'));
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Actividades realizadas'),
        'Calibración',
      );
      await pickOption(tester, 'Resultado', 'Operativo');
      await submit(tester);
      expect(find.text('Este campo es obligatorio.'), findsWidgets);

      await pickOption(tester, 'Proveedor', 'Droguería Proveedor S.A.S.');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Nombre del técnico externo'),
        'Pedro Pérez',
      );
      await submit(tester);

      final data =
          harness.adapter
                  .callsTo('POST', '/assets/maintenances/32/complete')
                  .single
                  .data
              as Map<String, dynamic>;
      expect(data['performed_by_type'], 'external');
      expect(data['supplier_id'], 4);
      expect(data['external_technician_name'], 'Pedro Pérez');
      expect(data.containsKey('technician_id'), isFalse);
    });

    testWidgets('un error del servidor se muestra y no se repite', (
      tester,
    ) async {
      await openForm(tester);
      harness.adapter.on(
        'POST',
        '/assets/maintenances/32/complete',
        status: 409,
        body: errorBody('El mantenimiento ya fue completado.'),
      );
      await pickOption(tester, 'Técnico', 'Usuario Prueba');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Actividades realizadas'),
        'Algo',
      );
      await pickOption(tester, 'Resultado', 'Operativo');
      await submit(tester);

      expect(find.text('El mantenimiento ya fue completado.'), findsOneWidget);
      expect(
        harness.adapter.callsTo('POST', '/assets/maintenances/32/complete'),
        hasLength(1),
      );
    });
  });

  testWidgets('desde la ficha del activo se abre el mantenimiento vencido', (
    tester,
  ) async {
    await openMaintenance(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Activos'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Monitor de signos vitales').first);
    await AppHarness.settle(tester);
    await tester.tap(find.text('Ver mantenimiento'));
    await AppHarness.settle(tester);

    expect(find.text('Reporte del mantenimiento (PDF)'), findsOneWidget);
  });

  group('planes periódicos', () {
    Future<void> openAsset(
      WidgetTester tester, {
      List<String> permissions = _view,
    }) async {
      await openMaintenance(tester, permissions: permissions);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Activos'),
        ),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('Monitor de signos vitales').first);
      await AppHarness.settle(tester);
    }

    testWidgets('la ficha lista los planes con frecuencia y próxima fecha', (
      tester,
    ) async {
      await openAsset(tester);
      await tester.scrollUntilVisible(
        find.text('Planes de mantenimiento'),
        200,
        scrollable: find.byType(Scrollable).last,
      );

      expect(find.textContaining('Cada 6 meses'), findsOneWidget);
      expect(find.textContaining('Próximo: 10/11/2026'), findsOneWidget);
      expect(find.textContaining('Cada 365 días'), findsOneWidget);
      expect(find.textContaining('Inactivo'), findsOneWidget);
    });

    testWidgets('sin permiso de mantenimientos no se piden ni se muestran', (
      tester,
    ) async {
      tester.view
        ..physicalSize = const Size(800, 3000)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      harness
        ..stubSignedInUser(permissions: ['activos.ver'], menu: _menu)
        ..stubAssetsReads()
        ..storeSession();
      await harness.pump(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Activos'),
        ),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('Monitor de signos vitales').first);
      await AppHarness.settle(tester);

      expect(find.text('Planes de mantenimiento'), findsNothing);
      expect(
        harness.adapter.callsTo('GET', '/assets/7/maintenance-plans'),
        isEmpty,
      );
    });
  });
}
