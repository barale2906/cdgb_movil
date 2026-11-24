import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/widgets/usage_bar.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openWarehouses(WidgetTester tester) async {
    harness
      ..stubSignedInUser(
        permissions: ['almacenes.ver'],
        menu: 'auth/menu_catalog_response.json',
      )
      ..storeSession();
    harness.adapter.on(
      'GET',
      '/warehouses/1/capacity',
      body: fixture('warehouse/capacity_response.json'),
    );
    await harness.pump(tester);
    await tester.tap(find.text('Almacenes').last);
    await AppHarness.settle(tester);
  }

  testWidgets('lista los almacenes y abre el detalle con capacidad', (
    tester,
  ) async {
    await openWarehouses(tester);

    expect(find.text('Farmacia'), findsWidgets);
    await tester.tap(find.text('Bodega Central').last);
    await AppHarness.settle(tester);

    expect(find.text('Capacidad'), findsOneWidget);
    expect(find.textContaining('Casi lleno'), findsWidgets);
    expect(find.textContaining('Casi lleno'), findsWidgets);
    expect(find.text('Zona fría'), findsOneWidget);
    expect(find.text('Zona seca'), findsOneWidget);
    expect(find.text('Sin ubicaciones'), findsOneWidget);
  });

  testWidgets('al expandir una zona muestra sus ubicaciones', (tester) async {
    await openWarehouses(tester);
    await tester.tap(find.text('Bodega Central').last);
    await AppHarness.settle(tester);

    await tester.ensureVisible(find.text('Zona fría'));
    await tester.tap(find.text('Zona fría'));
    await AppHarness.settle(tester);

    expect(find.textContaining('Estante A1'), findsOneWidget);
    expect(find.textContaining('sin límite definido'), findsWidgets);
  });

  testWidgets('un error de carga ofrece reintentar', (tester) async {
    harness
      ..stubSignedInUser(
        permissions: ['almacenes.ver'],
        menu: 'auth/menu_catalog_response.json',
      )
      ..storeSession();
    harness.adapter
      ..onSocketFailure('GET', '/warehouses/1/capacity')
      ..on(
        'GET',
        '/warehouses/1/capacity',
        body: fixture('warehouse/capacity_response.json'),
      );
    await harness.pump(tester);
    await tester.tap(find.text('Almacenes').last);
    await AppHarness.settle(tester);
    await tester.tap(find.text('Bodega Central').last);
    await AppHarness.settle(tester);

    expect(find.text('Reintentar'), findsOneWidget);
    await tester.tap(find.text('Reintentar'));
    await AppHarness.settle(tester);

    expect(find.text('Zona fría'), findsOneWidget);
  });

  testWidgets('403 en capacidad: muestra el mensaje del servidor', (
    tester,
  ) async {
    harness
      ..stubSignedInUser(
        permissions: ['almacenes.ver'],
        menu: 'auth/menu_catalog_response.json',
      )
      ..storeSession();
    harness.adapter.on(
      'GET',
      '/warehouses/1/capacity',
      status: 403,
      body: errorBody('No tienes acceso al almacén indicado.'),
    );
    await harness.pump(tester);
    await tester.tap(find.text('Almacenes').last);
    await AppHarness.settle(tester);
    await tester.tap(find.text('Bodega Central').last);
    await AppHarness.settle(tester);

    expect(find.text('No tienes acceso al almacén indicado.'), findsOneWidget);
  });

  group('UsageBar', () {
    testWidgets('el nivel se dice con texto, no solo con color', (
      tester,
    ) async {
      Future<void> pump(double? pct) => tester.pumpApp(
        UsageBar(label: 'Volumen', detail: '1 de 2 L', percent: pct),
      );

      await pump(10);
      expect(find.textContaining('Disponible'), findsOneWidget);
      await pump(75);
      expect(find.textContaining('Moderado'), findsOneWidget);
      await pump(95);
      expect(find.textContaining('Casi lleno'), findsOneWidget);
      await pump(null);
      expect(find.textContaining('%'), findsNothing);
    });
  });
}
