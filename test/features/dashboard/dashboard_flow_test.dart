import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';

const _all = [
  'tablero.ver',
  'stock.ver',
  'notificaciones.ver',
  'ordenes_compra.ver',
  'sensores.ver',
  'auditoria.ver',
];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openHome(WidgetTester tester, List<String> permissions) async {
    tester.view
      ..physicalSize = const Size(800, 4000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(permissions: permissions)
      ..stubDashboard()
      ..storeSession();
    await harness.pump(tester);
  }

  testWidgets('con todos los permisos muestra cada bloque con sus cifras', (
    tester,
  ) async {
    await openHome(tester, _all);

    expect(find.text('Inventario'), findsWidgets);
    expect(find.text('4.500'), findsOneWidget, reason: 'unidades en stock');
    expect(find.text('120'), findsOneWidget);
    expect(find.textContaining('Suficiente: 90'), findsOneWidget);
    expect(find.textContaining('Crítico: 10'), findsOneWidget);
    expect(find.text('HOY: 1'), findsOneWidget);
    expect(
      find.text('Gasa estéril 10x10'),
      findsOneWidget,
      reason: 'más consumidos',
    );
    expect(find.text(r'$1.250.001'), findsOneWidget);
    expect(find.text('Temperatura fuera de rango'), findsOneWidget);
    expect(find.text('144'), findsOneWidget, reason: 'lecturas hoy');
    expect(find.text('Creó Movement Document'), findsOneWidget);
  });

  testWidgets('cada bloque solo aparece con el permiso de su módulo', (
    tester,
  ) async {
    await openHome(tester, ['tablero.ver', 'stock.ver']);

    expect(find.text('4.500'), findsOneWidget);
    expect(find.text('Compras'), findsNothing);
    expect(find.text('Monitoreo'), findsNothing);
    expect(find.text('Alertas recientes'), findsNothing);
    expect(find.text('Actividad reciente'), findsNothing);
    expect(harness.adapter.callsTo('GET', '/dashboard/purchasing'), isEmpty);
    expect(harness.adapter.callsTo('GET', '/dashboard/activity'), isEmpty);
  });

  testWidgets('sin tablero.ver no se pide ningún bloque', (tester) async {
    await openHome(tester, ['stock.ver']);

    expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
    expect(find.text('4.500'), findsNothing);
    expect(harness.adapter.callsTo('GET', '/dashboard/inventory'), isEmpty);
  });

  testWidgets('un bloque que falla muestra reintento sin afectar a los demás', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(800, 4000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    // El primer pedido falla; el reintento (segundo) usa el stub normal.
    harness.adapter.onSocketFailure('GET', '/dashboard/purchasing');
    harness
      ..stubSignedInUser(permissions: _all)
      ..stubDashboard()
      ..storeSession();
    await harness.pump(tester);

    expect(find.text('4.500'), findsOneWidget, reason: 'inventario cargó');
    expect(find.text('Reintentar'), findsOneWidget);

    await tester.tap(find.text('Reintentar'));
    await AppHarness.settle(tester);

    expect(find.text('Reintentar'), findsNothing);
    expect(find.text(r'$1.250.001'), findsOneWidget);
  });

  testWidgets('accesos rápidos según permisos', (tester) async {
    await openHome(tester, [
      ..._all,
      'movimientos.entrada',
      'generic-products.barcode',
    ]);

    expect(find.text('Nuevo movimiento'), findsOneWidget);
    expect(find.text('Escanear'), findsOneWidget);
  });

  testWidgets('sin permisos de movimiento ni escáner no hay accesos rápidos', (
    tester,
  ) async {
    await openHome(tester, _all);
    expect(find.text('Accesos rápidos'), findsNothing);
  });

  testWidgets('tirar para recargar vuelve a pedir los bloques', (tester) async {
    await openHome(tester, ['tablero.ver', 'stock.ver']);
    expect(
      harness.adapter.callsTo('GET', '/dashboard/inventory'),
      hasLength(1),
    );

    // Equivale a tirar hacia abajo: dispara la acción de recarga.
    unawaited(
      tester.state<RefreshIndicatorState>(find.byType(RefreshIndicator)).show(),
    );
    await AppHarness.settle(tester, frames: 20);

    expect(
      harness.adapter.callsTo('GET', '/dashboard/inventory'),
      hasLength(2),
    );
  });

  testWidgets('un fallo de red en el bloque dice qué hacer', (tester) async {
    tester.view
      ..physicalSize = const Size(800, 4000)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness.adapter.onSocketFailure('GET', '/dashboard/inventory');
    harness
      ..stubSignedInUser(permissions: ['tablero.ver', 'stock.ver'])
      ..stubDashboard()
      ..storeSession();
    await harness.pump(tester);

    expect(find.textContaining('No se pudo conectar'), findsOneWidget);
  });
}
