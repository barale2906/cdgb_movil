import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_harness.dart';
import '../helpers/fixtures.dart';
import '../helpers/text_scale.dart';

/// Texto al 200 % en un teléfono de 360 dp (CLAUDE.md §6) en las pantallas
/// de escritura de activos, mantenimientos y órdenes. Un desborde hace fallar
/// la prueba.
void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> goBack(WidgetTester tester) async {
    // Botón «atrás» del sistema.
    await tester.binding.handlePopRoute();
    await AppHarness.settle(tester);
  }

  /// Toca [finder]; con [scroll] lo busca primero desplazando la ficha (al
  /// 200 % el contenido es más largo que la pantalla y la lista es perezosa).
  Future<void> tapAndCheck(
    WidgetTester tester,
    Finder finder, {
    bool scroll = false,
  }) async {
    if (scroll) {
      await tester.scrollUntilVisible(
        finder,
        300,
        scrollable: find.byType(Scrollable).last,
      );
    }
    await tester.tap(finder);
    await AppHarness.settle(tester);
    expect(tester.takeException(), isNull);
  }

  testWidgets('activos: formularios, programación y planes', (tester) async {
    phoneWithDoubleText(tester);
    harness
      ..stubSignedInUser(
        permissions: [
          'activos.ver',
          'activos.crear',
          'activos.editar',
          'activos.eliminar',
          'activos_mantenimientos.ver',
          'activos_mantenimientos.programar',
        ],
        menu: 'auth/menu_assets_response.json',
      )
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
    expect(tester.takeException(), isNull);

    // Nuevo activo.
    await tapAndCheck(tester, find.byTooltip('Nuevo activo'));
    expect(find.text('Nuevo activo'), findsWidgets);
    await goBack(tester);

    // Ficha del activo y sus acciones de escritura.
    await tapAndCheck(tester, find.text('Monitor de signos vitales').first);
    await tapAndCheck(tester, find.text('Editar datos'), scroll: true);
    expect(find.text('Editar activo'), findsOneWidget);
    await goBack(tester);

    await tapAndCheck(
      tester,
      find.text('Editar hoja de vida técnica'),
      scroll: true,
    );
    expect(find.text('Hoja de vida técnica'), findsWidgets);
    await goBack(tester);

    await tapAndCheck(
      tester,
      find.text('Programar mantenimiento'),
      scroll: true,
    );
    expect(find.text('Tipo de mantenimiento'), findsOneWidget);
    await goBack(tester);

    await tapAndCheck(tester, find.text('Agregar plan'), scroll: true);
    expect(find.text('Nuevo plan de mantenimiento'), findsOneWidget);
    await goBack(tester);

    await tapAndCheck(
      tester,
      find.byTooltip('Editar plan').first,
      scroll: true,
    );
    expect(find.text('Editar plan de mantenimiento'), findsOneWidget);
  });

  testWidgets('órdenes de servicio: lista con búsqueda y filtros', (
    tester,
  ) async {
    phoneWithDoubleText(tester);
    harness
      ..stubSignedInUser(
        permissions: ['ordenes_servicio.ver', 'ordenes_servicio.aprobar'],
        menu: 'auth/menu_service_orders_response.json',
      )
      ..storeSession();
    harness.adapter
      ..on(
        'GET',
        '/service-orders',
        body: fixture('service_orders/orders_list_response.json'),
      )
      ..on(
        'GET',
        '/service-orders/discounts',
        body: fixture('service_orders/discounts_response.json'),
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

    expect(find.text('Buscar por número de orden o documento'), findsOneWidget);
    expect(find.text('OS-20261125-000002'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
