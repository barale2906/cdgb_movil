import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _view = ['activos.ver'];
const _menu = 'auth/menu_assets_response.json';

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
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Activos'),
      ),
    );
    await AppHarness.settle(tester);
  }

  Future<void> openDetail(WidgetTester tester) async {
    await tester.tap(find.text('Monitor de signos vitales'));
    await AppHarness.settle(tester);
  }

  group('lista', () {
    testWidgets('muestra indicadores y activos con estado y ubicación', (
      tester,
    ) async {
      await openAssets(tester);

      expect(find.text('41'), findsOneWidget, reason: 'total');
      expect(find.text('Mantenimientos vencidos'), findsOneWidget);
      expect(find.text('Monitor de signos vitales'), findsOneWidget);
      expect(find.text('000007'), findsOneWidget);
      expect(find.text('Sede Principal · Urgencias · Sala 1'), findsOneWidget);
      expect(find.text('OPERATIVO'), findsWidgets);
      expect(find.text('Portátil administrativo'), findsOneWidget);
      expect(find.text('Taller externo'), findsOneWidget);
      expect(find.text('EN MANTENIMIENTO'), findsWidgets);
      expect(
        find.text('Mantenimiento vencido desde el 10/11/2026'),
        findsOneWidget,
      );
    });

    testWidgets('si fallan los indicadores la lista sigue funcionando', (
      tester,
    ) async {
      await openAssets(
        tester,
        before: () => harness.adapter.on(
          'GET',
          '/assets/statistics',
          status: 500,
          body: errorBody('Falla'),
        ),
      );
      expect(find.text('Monitor de signos vitales'), findsOneWidget);
      expect(find.text('Mantenimientos vencidos'), findsNothing);
    });

    testWidgets('filtrar por estado pide ese estado al servidor', (
      tester,
    ) async {
      await openAssets(tester);
      await tester.tap(find.widgetWithText(ChoiceChip, 'En mantenimiento'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/assets')
            .any((c) => c.queryParameters['status'] == 'maintenance'),
        isTrue,
      );
    });

    testWidgets('mantenimiento vencido se pide como filtro propio', (
      tester,
    ) async {
      await openAssets(tester);
      final chip = find.widgetWithText(ChoiceChip, 'Mantenimiento vencido');
      await tester.ensureVisible(chip);
      await tester.tap(chip);
      await AppHarness.settle(tester);

      expect(
        harness.adapter
            .callsTo('GET', '/assets')
            .any((c) => c.queryParameters['maintenance_overdue'] == true),
        isTrue,
      );
    });

    testWidgets('sin activos: mensaje', (tester) async {
      await openAssets(
        tester,
        before: () => harness.adapter.on(
          'GET',
          '/assets',
          body: pagedBody(<dynamic>[]),
        ),
      );
      expect(find.text('No hay activos para mostrar.'), findsOneWidget);
    });

    testWidgets('error del servidor: reintento', (tester) async {
      await openAssets(
        tester,
        before: () => harness.adapter.on(
          'GET',
          '/assets',
          status: 500,
          body: errorBody('Error interno'),
        ),
      );
      expect(find.text('Reintentar'), findsOneWidget);
    });
  });

  group('escáner', () {
    testWidgets('el código leído abre la ficha del activo', (tester) async {
      harness.scanCode = '000007';
      await openAssets(tester);

      await tester.tap(find.text('Escanear etiqueta'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Simular lectura'));
      await AppHarness.settle(tester);

      expect(find.text('Datos'), findsOneWidget);
      expect(find.text('Monitor de signos vitales'), findsOneWidget);
    });

    testWidgets('código desconocido: avisa y no cambia de pantalla', (
      tester,
    ) async {
      harness.scanCode = '999999';
      await openAssets(tester);

      await tester.tap(find.text('Escanear etiqueta'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Simular lectura'));
      await AppHarness.settle(tester);

      expect(
        find.text('No hay un activo con el código 999999.'),
        findsOneWidget,
      );
    });
  });

  group('detalle', () {
    testWidgets('ficha con datos, perfil técnico y avisos', (tester) async {
      await openAssets(tester);
      await openDetail(tester);

      expect(find.text('Equipos biomédicos'), findsOneWidget);
      expect(find.text('MarcaUno'), findsOneWidget);
      expect(find.text('SN-0001'), findsOneWidget);
      expect(find.text(r'$8.500.000'), findsOneWidget);
      expect(find.text('10/03/2024'), findsOneWidget);
      expect(
        find.text('Traslado pendiente de firma: Préstamo'),
        findsOneWidget,
      );
      expect(
        find.text('Mantenimiento vencido desde el 10/11/2026'),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.text('Fabricante Uno'),
        300,
        scrollable: find.byType(Scrollable).last,
      );
      expect(find.text('Fabricante Uno'), findsOneWidget);
      expect(find.text('INVIMA 2023EBC-0001'), findsOneWidget);
      expect(find.text('Sí'), findsOneWidget, reason: 'requiere calibración');
    });

    testWidgets('historial: ubicaciones y bitácora', (tester) async {
      await openAssets(tester);
      await openDetail(tester);
      await tester.tap(find.text('Historial'));
      await AppHarness.settle(tester);

      expect(find.text('Sede Principal · Urgencias · Sala 1'), findsOneWidget);
      expect(find.text('Actual'), findsOneWidget);
      expect(find.text('Taller externo'), findsOneWidget);
      expect(find.textContaining('Reparación externa'), findsOneWidget);
      expect(find.text('Cambio de estado'), findsOneWidget);
      expect(find.textContaining('Revisión de sensor'), findsOneWidget);
    });

    testWidgets('hoja de vida: abre el PDF', (tester) async {
      await openAssets(tester);
      harness.adapter.onBytes('GET', '/assets/7/life-sheet', [1, 2, 3, 4]);
      await openDetail(tester);

      await tester.scrollUntilVisible(
        find.text('Hoja de vida (PDF)'),
        300,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text('Hoja de vida (PDF)'));
      await AppHarness.settle(tester);

      expect(find.text('PDF 4 bytes'), findsOneWidget);
    });
  });

  group('comentarios', () {
    testWidgets('sin permiso de comentar no hay campo', (tester) async {
      await openAssets(tester);
      await openDetail(tester);
      await tester.tap(find.text('Comentarios'));
      await AppHarness.settle(tester);

      expect(find.text('Se limpió el sensor.'), findsOneWidget);
      expect(find.text('Agregar comentario'), findsNothing);
    });

    testWidgets('agrega un comentario y refresca la lista', (tester) async {
      await openAssets(tester, permissions: [..._view, 'activos.comentar']);
      harness.adapter.on(
        'POST',
        '/assets/7/comments',
        status: 201,
        body: fixture('assets/comment_saved_response.json'),
      );
      await openDetail(tester);
      await tester.tap(find.text('Comentarios'));
      await AppHarness.settle(tester);

      await tester.enterText(find.byType(TextField).last, 'Revisado hoy');
      await tester.tap(find.text('Agregar comentario'));
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('POST', '/assets/7/comments').single.data,
        {'comment': 'Revisado hoy'},
      );
      expect(find.text('Comentario agregado.'), findsOneWidget);
    });

    testWidgets('un comentario vacío no se envía', (tester) async {
      await openAssets(tester, permissions: [..._view, 'activos.comentar']);
      await openDetail(tester);
      await tester.tap(find.text('Comentarios'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Agregar comentario'));
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('POST', '/assets/7/comments'), isEmpty);
    });
  });
}
