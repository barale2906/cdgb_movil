import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> openCatalog(
    WidgetTester tester, {
    List<String> permissions = const [
      'generic-products.ver',
      'proveedores.ver',
    ],
  }) async {
    harness
      ..stubSignedInUser(
        permissions: permissions,
        menu: 'auth/menu_catalog_response.json',
      )
      ..storeSession();
    harness.adapter
      ..on(
        'GET',
        '/generic-products',
        body: fixture('catalog/products_list_response.json'),
      )
      ..on(
        'GET',
        '/generic-products/5',
        body: fixture('catalog/product_detail_response.json'),
      )
      ..on(
        'GET',
        '/suppliers',
        body: fixture('catalog/suppliers_list_response.json'),
      )
      ..on(
        'GET',
        '/suppliers/1',
        body: envelope(
          (fixture('catalog/suppliers_list_response.json')['data'] as List)
              .first,
        ),
      );
    await harness.pump(tester);
    await tester.tap(find.text('Catálogo').last);
    await AppHarness.settle(tester);
  }

  testWidgets('lista productos con etiquetas de kit y cadena de frío', (
    tester,
  ) async {
    await openCatalog(tester);

    expect(find.text('Gasa estéril 10x10'), findsOneWidget);
    expect(find.text('Insulina NPH'), findsOneWidget);
    expect(find.text('CADENA DE FRÍO'), findsOneWidget);
  });

  testWidgets('buscar espera a que se deje de escribir y consulta una vez', (
    tester,
  ) async {
    await openCatalog(tester);

    await tester.enterText(find.byType(TextField).first, 'ga');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField).first, 'gasa');
    await tester.pump(const Duration(milliseconds: 500));
    await AppHarness.settle(tester, frames: 3);

    final searches = harness.adapter
        .callsTo('GET', '/generic-products')
        .where((r) => r.queryParameters['search'] != null)
        .toList();
    expect(searches, hasLength(1));
    expect(searches.single.queryParameters['search'], 'gasa');
  });

  testWidgets('sin resultados muestra el mensaje de búsqueda', (tester) async {
    await openCatalog(tester);
    harness.adapter.on(
      'GET',
      '/generic-products',
      body: envelope(<dynamic>[]),
    );

    await tester.enterText(find.byType(TextField).first, 'zzz');
    await tester.pump(const Duration(milliseconds: 500));
    await AppHarness.settle(tester);

    expect(find.text('No se encontraron resultados.'), findsOneWidget);
  });

  testWidgets('el detalle muestra variantes, registros sanitarios y kit', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(800, 2400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await openCatalog(tester);

    await tester.tap(find.text('Gasa estéril 10x10'));
    await AppHarness.settle(tester);

    expect(find.text('100005'), findsOneWidget);
    expect(find.text('Curación'), findsOneWidget);
    expect(find.text('Unidad (und)'), findsOneWidget);
    expect(find.textContaining('20 und'), findsOneWidget);
    expect(find.text('Esparadrapo'), findsOneWidget);
    expect(find.textContaining('INVIMA 2024DM-0001'), findsOneWidget);
    expect(find.text('VENCIDO'), findsOneWidget);
    expect(find.text('VENCE 01/05/2027'), findsOneWidget);
  });

  testWidgets('con proveedores.ver aparece la pestaña y su detalle', (
    tester,
  ) async {
    await openCatalog(tester);

    await tester.tap(find.text('Proveedores').last);
    await AppHarness.settle(tester);
    expect(find.text('Proveedor Uno S.A.S.'), findsOneWidget);

    await tester.tap(find.text('Proveedor Uno S.A.S.'));
    await AppHarness.settle(tester);

    expect(find.text('900000001-1'), findsOneWidget);
    expect(find.text('contacto@example.com'), findsOneWidget);
    expect(find.text('INVENTARIO'), findsOneWidget);
  });

  testWidgets('sin proveedores.ver no hay pestañas', (tester) async {
    await openCatalog(tester, permissions: ['generic-products.ver']);

    expect(find.byType(TabBar), findsNothing);
    expect(find.text('Gasa estéril 10x10'), findsOneWidget);
  });

  testWidgets('sin generic-products.ver el catálogo no aparece', (
    tester,
  ) async {
    harness
      ..stubSignedInUser(
        permissions: ['productos.ver'],
        menu: 'auth/menu_catalog_response.json',
      )
      ..storeSession();
    await harness.pump(tester);

    expect(find.text('Catálogo'), findsNothing);
  });

  testWidgets('error de red al listar: reintentar recarga', (tester) async {
    harness
      ..stubSignedInUser(
        permissions: ['generic-products.ver'],
        menu: 'auth/menu_catalog_response.json',
      )
      ..storeSession();
    harness.adapter
      ..onSocketFailure('GET', '/generic-products')
      ..on(
        'GET',
        '/generic-products',
        body: fixture('catalog/products_list_response.json'),
      );
    await harness.pump(tester);
    await tester.tap(find.text('Catálogo').last);
    await AppHarness.settle(tester);

    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    await tester.tap(find.text('Reintentar'));
    await AppHarness.settle(tester);

    expect(find.text('Insulina NPH'), findsOneWidget);
  });
}
