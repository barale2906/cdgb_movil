import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sga_bojanini/core/widgets/form_fields.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/form_helpers.dart';

const _menu = 'auth/menu_assets_response.json';
const _view = ['activos.ver', 'activos_mantenimientos.ver'];
final _isoDate = RegExp(r'^\d{4}-\d\d-\d\d$');

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openAssets(
    WidgetTester tester,
    List<String> permissions,
  ) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: permissions, menu: _menu)
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
  }

  Future<void> openDetail(
    WidgetTester tester,
    List<String> permissions,
  ) async {
    await openAssets(tester, permissions);
    await tester.tap(find.text('Monitor de signos vitales').first);
    await AppHarness.settle(tester);
  }

  Future<void> tapAction(WidgetTester tester, String label) async {
    await scrollTo(tester, find.text(label));
    await tester.tap(find.text(label));
    await AppHarness.settle(tester);
  }

  Future<void> save(WidgetTester tester, [String label = 'Guardar']) async {
    await tester.tap(find.widgetWithText(FilledButton, label));
    await AppHarness.settle(tester);
  }

  Future<void> pickToday(WidgetTester tester, String label) async {
    await tester.tap(find.widgetWithText(DateField, label));
    await AppHarness.settle(tester);
    await tester.tap(find.text('ACEPTAR'));
    await AppHarness.settle(tester);
  }

  group('registrar un activo', () {
    const create = [..._view, 'activos.crear'];

    testWidgets('sin permiso de crear no hay botón', (tester) async {
      await openAssets(tester, _view);
      expect(find.byTooltip('Nuevo activo'), findsNothing);
    });

    testWidgets('exige nombre, categoría y lugar y no envía nada', (
      tester,
    ) async {
      await openAssets(tester, create);
      await tester.tap(find.byTooltip('Nuevo activo'));
      await AppHarness.settle(tester);
      await save(tester);

      expect(find.text('Este campo es obligatorio.'), findsWidgets);
      expect(harness.adapter.callsTo('POST', '/assets'), isEmpty);
    });

    testWidgets('envía los datos y avisa que quedó registrado', (tester) async {
      await openAssets(tester, create);
      harness.adapter.on(
        'POST',
        '/assets',
        status: 201,
        body: fixture('assets/asset_created_response.json'),
      );
      await tester.tap(find.byTooltip('Nuevo activo'));
      await AppHarness.settle(tester);

      await enterField(tester, 'Nombre', '  Bomba de infusión ');
      await pickOption(tester, 'Categoría', 'Equipos biomédicos');
      await pickOption(tester, 'Sede', 'Sede Principal');
      await pickOption(tester, 'Lugar', 'Bodega');
      await pickOption(tester, 'Responsable', 'Técnico Dos');
      await enterField(tester, 'Marca', 'MarcaUno');
      await enterField(tester, 'Valor de adquisición', '1500000');
      await save(tester);

      final data =
          harness.adapter.callsTo('POST', '/assets').single.data
              as Map<String, dynamic>;
      expect(data['name'], 'Bomba de infusión');
      expect(data['category_id'], 2);
      expect(data['place_id'], 5);
      expect(data['responsible_id'], 4);
      expect(data['brand'], 'MarcaUno');
      expect(data['acquisition_value'], 1500000);
      expect(data.containsKey('model'), isFalse, reason: 'vacío no viaja');
      expect(find.text('Activo registrado.'), findsOneWidget);
      expect(
        find.text('Nuevo activo'),
        findsNothing,
        reason: 'volvió a la lista',
      );
    });

    testWidgets('tras un tiempo de espera agotado no se reenvía solo', (
      tester,
    ) async {
      await openAssets(tester, create);
      harness.adapter.onError(
        'POST',
        '/assets',
        DioExceptionType.receiveTimeout,
      );
      await tester.tap(find.byTooltip('Nuevo activo'));
      await AppHarness.settle(tester);
      await enterField(tester, 'Nombre', 'Bomba');
      await pickOption(tester, 'Categoría', 'Equipos biomédicos');
      await pickOption(tester, 'Sede', 'Sede Principal');
      await pickOption(tester, 'Lugar', 'Bodega');
      await save(tester);

      expect(harness.adapter.callsTo('POST', '/assets'), hasLength(1));
      expect(find.textContaining('Revise la lista de activos'), findsOneWidget);
      expect(
        find.text('Nuevo activo'),
        findsWidgets,
        reason: 'sigue en el formulario',
      );
    });

    testWidgets('un valor con letras se rechaza antes de enviar', (
      tester,
    ) async {
      await openAssets(tester, create);
      await tester.tap(find.byTooltip('Nuevo activo'));
      await AppHarness.settle(tester);
      await enterField(tester, 'Valor de adquisición', 'mucho');
      await save(tester);

      expect(find.text('Ingrese un valor válido, sin letras.'), findsOneWidget);
    });
  });

  group('editar y eliminar', () {
    const edit = [..._view, 'activos.editar'];

    testWidgets('sin permisos no aparecen las acciones de escritura', (
      tester,
    ) async {
      await openDetail(tester, _view);

      expect(find.text('Editar datos'), findsNothing);
      expect(find.text('Editar hoja de vida técnica'), findsNothing);
      expect(find.text('Programar mantenimiento'), findsNothing);
      expect(find.text('Eliminar activo'), findsNothing);
    });

    testWidgets('el formulario trae los datos y guarda solo la edición', (
      tester,
    ) async {
      await openDetail(tester, edit);
      harness.adapter.on(
        'PUT',
        '/assets/7',
        body: fixture('assets/asset_response.json'),
      );
      await tapAction(tester, 'Editar datos');

      expect(find.text('Editar activo'), findsOneWidget);
      expect(find.text('Monitor de signos vitales'), findsOneWidget);
      await enterField(tester, 'Marca', '');
      await enterField(tester, 'Modelo', 'MV-300');
      await save(tester);

      final data =
          harness.adapter.callsTo('PUT', '/assets/7').single.data
              as Map<String, dynamic>;
      expect(data['name'], 'Monitor de signos vitales');
      expect(data['brand'], isNull, reason: 'se pudo borrar');
      expect(data['model'], 'MV-300');
      expect(data['category_id'], 2);
      expect(data['supplier_id'], 4);
      expect(data['acquisition_date'], '2024-03-10');
      expect(data.containsKey('place_id'), isFalse);
      expect(data.containsKey('status'), isFalse);
      expect(find.text('Datos del activo guardados.'), findsOneWidget);
    });

    testWidgets('eliminar pide confirmar y vuelve a la lista', (tester) async {
      await openDetail(tester, [..._view, 'activos.eliminar']);
      harness.adapter.on(
        'DELETE',
        '/assets/7',
        body: {'success': true, 'message': 'Activo eliminado'},
      );
      await tapAction(tester, 'Eliminar activo');
      expect(
        find.textContaining('Se eliminará el activo Monitor de signos vitales'),
        findsOneWidget,
      );
      await tester.tap(find.text('Eliminar activo').last);
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('DELETE', '/assets/7'), hasLength(1));
      expect(find.text('Activo eliminado.'), findsOneWidget);
    });

    testWidgets('si el activo ya tiene historia se muestra el motivo', (
      tester,
    ) async {
      await openDetail(tester, [..._view, 'activos.eliminar']);
      harness.adapter.on(
        'DELETE',
        '/assets/7',
        status: 409,
        body: errorBody(
          'El activo tiene mantenimientos o traslados registrados; '
          'regístrelo como baja en lugar de eliminarlo.',
        ),
      );
      await tapAction(tester, 'Eliminar activo');
      await tester.tap(find.text('Eliminar activo').last);
      await AppHarness.settle(tester);

      expect(find.textContaining('regístrelo como baja'), findsOneWidget);
      expect(find.text('Monitor de signos vitales'), findsWidgets);
    });

    testWidgets('cancelar la confirmación no elimina', (tester) async {
      await openDetail(tester, [..._view, 'activos.eliminar']);
      await tapAction(tester, 'Eliminar activo');
      await tester.tap(find.text('Cancelar'));
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('DELETE', '/assets/7'), isEmpty);
    });
  });

  group('hoja de vida técnica', () {
    const edit = [..._view, 'activos.editar'];

    testWidgets('trae lo guardado y envía solo los campos del equipo', (
      tester,
    ) async {
      await openDetail(tester, edit);
      harness.adapter.on(
        'PUT',
        '/assets/7/technical-profile',
        body: {'success': true},
      );
      await tapAction(tester, 'Editar hoja de vida técnica');

      expect(find.text('Fabricante Uno'), findsOneWidget);
      await enterField(tester, 'Fabricante', 'Fabricante Dos');
      await pickOption(tester, 'Forma de adquisición', 'Donación');
      await pickOption(
        tester,
        'Clasificación de riesgo',
        'Clase IIb · riesgo alto',
      );
      await save(tester);

      final data =
          harness.adapter
                  .callsTo('PUT', '/assets/7/technical-profile')
                  .single
                  .data
              as Map<String, dynamic>;
      expect(data['manufacturer'], 'Fabricante Dos');
      expect(data['acquisition_mode'], 'donation');
      expect(data['risk_class'], 'IIb');
      expect(data['requires_calibration'], isTrue);
      expect(data['manufacture_year'], 2023);
      expect(data.containsKey('processor'), isFalse, reason: 'es de cómputo');
      expect(
        data.containsKey('technical_specs'),
        isFalse,
        reason: 'se conserva',
      );
      expect(find.text('Hoja de vida técnica guardada.'), findsOneWidget);
    });

    testWidgets('un año fuera de rango se rechaza antes de enviar', (
      tester,
    ) async {
      await openDetail(tester, edit);
      await tapAction(tester, 'Editar hoja de vida técnica');
      await enterField(tester, 'Año de fabricación', '1800');
      await save(tester);

      expect(find.textContaining('Ingrese un año entre 1900'), findsOneWidget);
      expect(
        harness.adapter.callsTo('PUT', '/assets/7/technical-profile'),
        isEmpty,
      );
    });

    testWidgets('la ficha muestra los valores fijos con su texto', (
      tester,
    ) async {
      await openDetail(tester, _view);
      await scrollTo(tester, find.text('Clase IIa · riesgo moderado'));

      expect(find.text('Clase IIa · riesgo moderado'), findsOneWidget);
    });
  });

  group('programar mantenimientos', () {
    const program = [..._view, 'activos_mantenimientos.programar'];

    testWidgets('programa un mantenimiento puntual', (tester) async {
      await openDetail(tester, program);
      harness.adapter.on(
        'POST',
        '/assets/7/maintenances',
        status: 201,
        body: fixture('assets/maintenance_scheduled_response.json'),
      );
      await tapAction(tester, 'Programar mantenimiento');

      await pickOption(tester, 'Tipo de mantenimiento', 'Inspección');
      await pickToday(tester, 'Fecha programada');
      await pickOption(tester, 'Quién lo realizará', 'Técnico interno');
      await pickOption(tester, 'Técnico', 'Usuario Prueba');
      await save(tester, 'Programar mantenimiento');

      final data =
          harness.adapter.callsTo('POST', '/assets/7/maintenances').single.data
              as Map<String, dynamic>;
      expect(data['maintenance_type'], 'inspection');
      expect(data['scheduled_date'], matches(_isoDate));
      expect(data['performed_by_type'], 'internal');
      expect(data['technician_id'], 3);
      expect(data.containsKey('supplier_id'), isFalse);
      expect(find.text('Mantenimiento programado.'), findsOneWidget);
    });

    testWidgets('un correctivo exige describir la falla', (tester) async {
      await openDetail(tester, program);
      await tapAction(tester, 'Programar mantenimiento');
      await pickOption(tester, 'Tipo de mantenimiento', 'Correctivo');
      await pickToday(tester, 'Fecha programada');
      await save(tester, 'Programar mantenimiento');

      expect(
        find.text(
          'Describa la falla reportada para el mantenimiento correctivo.',
        ),
        findsOneWidget,
      );
      expect(
        harness.adapter.callsTo('POST', '/assets/7/maintenances'),
        isEmpty,
      );
    });

    testWidgets('sin permiso de programar no hay botón ni agregar plan', (
      tester,
    ) async {
      await openDetail(tester, _view);
      await scrollTo(tester, find.text('Planes de mantenimiento'));

      expect(find.text('Programar mantenimiento'), findsNothing);
      expect(find.text('Agregar plan'), findsNothing);
      expect(find.byTooltip('Editar plan'), findsNothing);
    });
  });

  group('planes periódicos', () {
    const program = [..._view, 'activos_mantenimientos.programar'];

    testWidgets('crea un plan con proveedor externo', (tester) async {
      await openDetail(tester, program);
      harness.adapter.on(
        'POST',
        '/assets/7/maintenance-plans',
        status: 201,
        body: fixture('assets/plan_saved_response.json'),
      );
      await tapAction(tester, 'Agregar plan');

      await pickOption(tester, 'Tipo de mantenimiento', 'Calibración');
      await enterField(tester, 'Cada cuánto', '90');
      await pickToday(tester, 'Primera fecha');
      await pickOption(tester, 'Quién lo realizará', 'Proveedor externo');
      await pickOption(tester, 'Proveedor', 'Droguería Proveedor S.A.S.');
      await save(tester);

      final data =
          harness.adapter
                  .callsTo('POST', '/assets/7/maintenance-plans')
                  .single
                  .data
              as Map<String, dynamic>;
      expect(data['maintenance_type'], 'calibration');
      expect(data['frequency_value'], 90);
      expect(data['frequency_unit'], 'days');
      expect(data['performed_by_type'], 'external');
      expect(data['supplier_id'], 4);
      expect(data['technician_id'], isNull);
      expect(data['is_active'], isTrue);
      expect(find.text('Plan guardado.'), findsOneWidget);
    });

    testWidgets('una frecuencia fuera de rango no se envía', (tester) async {
      await openDetail(tester, program);
      await tapAction(tester, 'Agregar plan');
      await pickOption(tester, 'Tipo de mantenimiento', 'Preventivo');
      await enterField(tester, 'Cada cuánto', '0');
      await pickToday(tester, 'Primera fecha');
      await pickOption(tester, 'Quién lo realizará', 'Técnico interno');
      await save(tester);

      expect(
        find.text('Ingrese un número entero de 1 a 3650.'),
        findsOneWidget,
      );
      expect(
        harness.adapter.callsTo('POST', '/assets/7/maintenance-plans'),
        isEmpty,
      );
    });

    testWidgets('editar trae el plan y permite desactivarlo (no eliminarlo)', (
      tester,
    ) async {
      await openDetail(tester, program);
      harness.adapter.on(
        'PUT',
        '/assets/maintenance-plans/2',
        body: fixture('assets/plan_saved_response.json'),
      );
      await scrollTo(tester, find.byTooltip('Editar plan').first);
      await tester.tap(find.byTooltip('Editar plan').first);
      await AppHarness.settle(tester);

      expect(find.text('Editar plan de mantenimiento'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
      await scrollTo(tester, find.text('Plan activo'));
      await tester.tap(find.text('Plan activo'));
      await AppHarness.settle(tester);
      await save(tester);

      final data =
          harness.adapter
                  .callsTo('PUT', '/assets/maintenance-plans/2')
                  .single
                  .data
              as Map<String, dynamic>;
      expect(data['is_active'], isFalse);
      expect(data['frequency_value'], 6);
      expect(data['frequency_unit'], 'months');
      expect(find.text('Eliminar plan'), findsNothing);
    });

    testWidgets('reprogramar un mantenimiento programado', (tester) async {
      await openAssets(tester, [..._view, 'activos_mantenimientos.programar']);
      harness.adapter.on(
        'PUT',
        '/assets/maintenances/31',
        body: fixture('assets/maintenance_31_response.json'),
      );
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Más'),
        ),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('Mantenimientos').last);
      await AppHarness.settle(tester);
      await tester.tap(find.text('Monitor de signos vitales').first);
      await AppHarness.settle(tester);
      await tapAction(tester, 'Reprogramar');
      await pickToday(tester, 'Fecha programada');
      await save(tester);

      final data =
          harness.adapter.callsTo('PUT', '/assets/maintenances/31').single.data
              as Map<String, dynamic>;
      expect(data['scheduled_date'], matches(_isoDate));
      expect(find.text('Mantenimiento reprogramado.'), findsOneWidget);
    });
  });
}
