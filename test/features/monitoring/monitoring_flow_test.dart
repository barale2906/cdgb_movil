import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _menu = 'auth/menu_monitoring_response.json';
const _read = ['sensores.ver', 'lecturas.ver'];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openMonitoring(
    WidgetTester tester, {
    List<String> permissions = _read,
  }) async {
    tester.view
      ..physicalSize = const Size(800, 3000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: permissions, menu: _menu)
      ..storeSession();
    harness.adapter
      ..on('GET', '/sensors', body: fixture('monitoring/sensors_response.json'))
      ..on(
        'GET',
        '/sensors/1/readings',
        body: fixture('monitoring/readings_response.json'),
      )
      ..on(
        'GET',
        '/sensors/1/trend',
        body: fixture('monitoring/trend_response.json'),
      )
      ..on(
        'GET',
        '/sensors/1/calibrations',
        body: fixture('monitoring/calibrations_response.json'),
      )
      ..on(
        'GET',
        '/sensors/1/alert-rules',
        body: fixture('monitoring/alert_rules_response.json'),
      );
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Monitoreo').last);
    await AppHarness.settle(tester);
  }

  Future<void> openSensor(WidgetTester tester) async {
    await tester.tap(find.text('Nevera farmacia'));
    await AppHarness.settle(tester);
  }

  testWidgets('lista los sensores con última lectura, rango y calibración', (
    tester,
  ) async {
    await openMonitoring(tester);

    expect(find.text('Nevera farmacia'), findsOneWidget);
    expect(find.text('9,5 °C'), findsOneWidget);
    expect(find.text('FUERA DE RANGO'), findsOneWidget);
    expect(find.text('VENCE EN 16 DÍAS'), findsOneWidget);
    expect(find.text('Higrómetro bodega'), findsOneWidget);
    expect(find.text('EN RANGO'), findsOneWidget);
    expect(find.text('CALIBRACIÓN VIGENTE'), findsOneWidget);
    expect(
      find.text('Sin lecturas aún'),
      findsOneWidget,
      reason: 'sensor sin datos',
    );
    expect(find.text('SIN CERTIFICADO'), findsOneWidget);
    expect(find.textContaining('24/11/2026 09:00 a. m.'), findsOneWidget);
  });

  testWidgets('sin sensores asignados: mensaje', (tester) async {
    harness.adapter.on('GET', '/sensors', body: envelope(<dynamic>[]));
    await openMonitoring(tester);
    expect(find.text('No tiene sensores asignados.'), findsOneWidget);
  });

  testWidgets('el detalle muestra límites, resumen del periodo y tendencia', (
    tester,
  ) async {
    await openMonitoring(tester);
    await openSensor(tester);

    expect(find.textContaining('Rango permitido: 2–8 °C'), findsOneWidget);
    expect(find.text('Resumen del periodo'), findsOneWidget);
    expect(find.text('4,5 °C'), findsOneWidget, reason: 'mínimo');
    expect(
      find.text('9,5 °C'),
      findsWidgets,
      reason: 'máximo y última lectura',
    );
    expect(find.text('6,83 °C'), findsOneWidget, reason: 'promedio');
    expect(find.text('3'), findsOneWidget, reason: 'cantidad de lecturas');
    expect(find.text('TENDENCIA AL ALZA'), findsOneWidget);
    expect(find.text('CONFIANZA MEDIA'), findsOneWidget);
    expect(find.textContaining('Tendencia al alza detectada'), findsOneWidget);
  });

  testWidgets('cambiar de periodo pide lecturas de nuevo', (tester) async {
    await openMonitoring(tester);
    await openSensor(tester);
    expect(harness.adapter.callsTo('GET', '/sensors/1/readings'), hasLength(1));

    await tester.tap(find.text('30 días'));
    await AppHarness.settle(tester);

    final calls = harness.adapter
        .callsTo('GET', '/sensors/1/readings')
        .toList();
    expect(calls, hasLength(2));
    expect(
      calls.last.queryParameters['date_from'],
      isNot(calls.first.queryParameters['date_from']),
    );
  });

  testWidgets('sin lecturas.ver no se piden lecturas ni tendencia', (
    tester,
  ) async {
    await openMonitoring(tester, permissions: ['sensores.ver']);
    await openSensor(tester);

    expect(find.text('Resumen del periodo'), findsNothing);
    expect(harness.adapter.callsTo('GET', '/sensors/1/readings'), isEmpty);
    expect(harness.adapter.callsTo('GET', '/sensors/1/trend'), isEmpty);
  });

  testWidgets('exportar lecturas descarga el Excel y lo comparte', (
    tester,
  ) async {
    await openMonitoring(tester);
    harness.adapter.onBytes('GET', '/sensors/1/readings/export', [
      1,
      2,
      3,
      4,
      5,
    ]);
    await openSensor(tester);

    await tester.ensureVisible(find.text('Exportar lecturas (Excel)'));
    await tester.tap(find.text('Exportar lecturas (Excel)'));
    await AppHarness.settle(tester);

    final query = harness.adapter
        .callsTo('GET', '/sensors/1/readings/export')
        .single
        .queryParameters;
    expect(query.keys, containsAll(['date_from', 'date_to']));
    expect(
      harness.sharedFiles.single.$1,
      matches(RegExp(r'^lecturas-sensor-1-\d{4}-\d\d-\d\d\.xlsx$')),
    );
    expect(harness.sharedFiles.single.$2, 5);
  });

  group('lectura manual', () {
    testWidgets('sin lecturas.crear no hay botón', (tester) async {
      await openMonitoring(tester);
      await openSensor(tester);
      expect(find.text('Registrar lectura'), findsNothing);
    });

    testWidgets('registra la lectura en hora de Colombia y avisa alertas', (
      tester,
    ) async {
      await openMonitoring(tester, permissions: [..._read, 'lecturas.crear']);
      harness.adapter.on(
        'POST',
        '/sensors/1/readings',
        status: 201,
        body: fixture('monitoring/reading_saved_response.json'),
      );
      await openSensor(tester);

      await tester.tap(find.text('Registrar lectura'));
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Valor (°C)'),
        '7,5',
      );
      await tester.tap(
        find.widgetWithText(FilledButton, 'Registrar lectura').last,
      );
      await AppHarness.settle(tester);

      final body =
          harness.adapter.callsTo('POST', '/sensors/1/readings').single.data
              as Map;
      expect(body['value'], 7.5);
      expect(body['reading_source'], 'manual');
      // Reloj de pruebas 2026-11-24 08:00: según la zona del equipo cae el
      // día 23 o 24 (nunca depende de la zona del teléfono, solo de UTC-5).
      expect(
        body['recorded_at'],
        matches(RegExp(r'^2026-11-2[34] \d\d:\d\d:\d\d$')),
      );
      expect(
        find.textContaining('La lectura generó 1 alerta.'),
        findsOneWidget,
      );
    });

    testWidgets('exige un valor numérico', (tester) async {
      await openMonitoring(tester, permissions: [..._read, 'lecturas.crear']);
      await openSensor(tester);

      await tester.tap(find.text('Registrar lectura'));
      await AppHarness.settle(tester);
      await tester.tap(
        find.widgetWithText(FilledButton, 'Registrar lectura').last,
      );
      await AppHarness.settle(tester);

      expect(find.text('Ingrese un número válido.'), findsOneWidget);
      expect(harness.adapter.callsTo('POST', '/sensors/1/readings'), isEmpty);
    });

    testWidgets('403 al registrar: muestra el mensaje y no reintenta', (
      tester,
    ) async {
      await openMonitoring(tester, permissions: [..._read, 'lecturas.crear']);
      harness.adapter.on(
        'POST',
        '/sensors/1/readings',
        status: 403,
        body: errorBody('No tienes acceso a este sensor.'),
      );
      await openSensor(tester);

      await tester.tap(find.text('Registrar lectura'));
      await AppHarness.settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Valor (°C)'),
        '5',
      );
      await tester.tap(
        find.widgetWithText(FilledButton, 'Registrar lectura').last,
      );
      await AppHarness.settle(tester);

      expect(find.text('No tienes acceso a este sensor.'), findsOneWidget);
      expect(
        harness.adapter.callsTo('POST', '/sensors/1/readings'),
        hasLength(1),
      );
    });
  });

  group('calibraciones y reglas', () {
    testWidgets('lista certificados y descarga para compartir', (tester) async {
      await openMonitoring(tester);
      harness.adapter.onBytes('GET', '/calibrations/3/download', [1, 2, 3, 4]);
      await openSensor(tester);

      await tester.tap(find.text('Calibraciones'));
      await AppHarness.settle(tester);
      expect(find.text('CAL-2026-01'), findsOneWidget);
      expect(find.text('REEMPLAZADO'), findsOneWidget);

      await tester.tap(find.text('Descargar certificado').first);
      await AppHarness.settle(tester);

      expect(harness.sharedFiles, [('cert-cal-2026.pdf', 4)]);
    });

    testWidgets('las reglas de alerta solo con reglas_alerta.ver', (
      tester,
    ) async {
      await openMonitoring(tester);
      await openSensor(tester);
      expect(find.text('Reglas de alerta'), findsNothing);
    });

    testWidgets('con permiso muestra las reglas con su estado', (tester) async {
      await openMonitoring(
        tester,
        permissions: [..._read, 'reglas_alerta.ver'],
      );
      await openSensor(tester);

      await tester.tap(find.text('Reglas de alerta'));
      await AppHarness.settle(tester);

      expect(find.text('Por encima de 8'), findsOneWidget);
      expect(find.text('3 lecturas seguidas'), findsOneWidget);
      expect(find.text('Tendencia al alza'), findsOneWidget);
      expect(find.text('INACTIVO'), findsOneWidget);
    });
  });
}
