import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/catalog/cost_center.dart';
import 'package:sga_bojanini/core/catalog/cost_center_providers.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/cost_centers/data/cost_centers_repository.dart';
import 'package:sga_bojanini/features/cost_centers/data/medical_service_node.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

const _menu = 'auth/menu_cost_centers_response.json';

void main() {
  group('contrato', () {
    test('CostCenter: tipo, etiqueta y externo', () {
      final centers =
          (fixture('cost_centers/cost_centers_response.json')['data'] as List)
              .map((e) => CostCenter.fromJson(e as Json))
              .toList();
      expect(centers.first.name, 'Farmacia');
      expect(centers.first.isExternal, isFalse);
      expect(centers.last.typeLabel, 'Externo');
      expect(centers.last.isExternal, isTrue);
    });

    test('árbol: servicio con sus procedimientos', () {
      final nodes =
          (fixture('cost_centers/service_tree_response.json')['data'] as List)
              .map((e) => MedicalServiceNode.fromJson(e as Json))
              .toList();
      expect(nodes.single.children, hasLength(2));
      expect(nodes.single.children.first.isProcedure, isTrue);
      expect(nodes.single.isProcedure, isFalse);
    });

    test('tarifas: texto a decimal y vigencia', () {
      final prices =
          (fixture('cost_centers/procedure_prices_response.json')['data']
                  as List)
              .map((e) => ProcedurePrice.fromJson(e as Json))
              .toList();
      expect(prices.first.unitPrice, 50000);
      expect(prices.first.isCurrentlyValid, isTrue);
      expect(prices.last.isCurrentlyValid, isFalse);
      expect(prices.last.effectiveTo, '2025-12-31');
    });
  });

  group('repositorios', () {
    late FakeHttpAdapter adapter;
    late ProviderContainer container;

    setUp(() async {
      adapter = FakeHttpAdapter();
      container = ProviderContainer(
        retry: noAutoRetry,
        overrides: await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 26)),
        ),
      );
      addTearDown(container.dispose);
    });

    test('centros: solo activos y búsqueda solo si hay texto', () async {
      adapter.on(
        'GET',
        '/cost-centers',
        body: fixture('cost_centers/cost_centers_response.json'),
      );
      final repository = container.read(costCenterRepositoryProvider);
      await repository.list();
      await repository.list(search: 'far');

      final calls = adapter.callsTo('GET', '/cost-centers').toList();
      expect(calls.first.queryParameters, {'is_active': 1});
      expect(calls.last.queryParameters, {'is_active': 1, 'search': 'far'});
    });

    test('árbol de servicios activos y tarifas del procedimiento', () async {
      adapter
        ..on(
          'GET',
          '/medical-services/tree',
          body: fixture('cost_centers/service_tree_response.json'),
        )
        ..on(
          'GET',
          '/procedures/3/prices',
          body: fixture('cost_centers/procedure_prices_response.json'),
        );
      final repository = container.read(serviceCatalogRepositoryProvider);

      expect(await repository.tree(), hasLength(1));
      expect(await repository.prices(3), hasLength(2));
      expect(
        adapter.callsTo('GET', '/medical-services/tree').single.queryParameters,
        {'only_active': 1},
      );
    });
  });

  group('pantalla', () {
    late AppHarness harness;

    setUp(() => harness = AppHarness());

    Future<void> openSection(
      WidgetTester tester,
      List<String> permissions,
    ) async {
      tester.view
        ..physicalSize = const Size(800, 3000)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      harness
        ..stubSignedInUser(permissions: permissions, menu: _menu)
        ..storeSession();
      harness.adapter
        ..on(
          'GET',
          '/cost-centers',
          body: fixture('cost_centers/cost_centers_response.json'),
        )
        ..on(
          'GET',
          '/medical-services/tree',
          body: fixture('cost_centers/service_tree_response.json'),
        )
        ..on(
          'GET',
          '/procedures/3/prices',
          body: fixture('cost_centers/procedure_prices_response.json'),
        );
      await harness.pump(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Más'),
        ),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('Centros de costo').last);
      await AppHarness.settle(tester);
    }

    testWidgets('lista los centros con su tipo y sin pestaña de servicios', (
      tester,
    ) async {
      await openSection(tester, ['centros_costo.ver']);

      expect(find.text('Farmacia'), findsOneWidget);
      expect(find.text('INTERNO'), findsOneWidget);
      expect(find.text('EXTERNO'), findsOneWidget);
      expect(find.text('Servicios'), findsNothing);
      expect(harness.adapter.callsTo('GET', '/medical-services/tree'), isEmpty);
    });

    testWidgets(
      'con servicios_medicos.ver muestra el árbol de procedimientos',
      (
        tester,
      ) async {
        await openSection(tester, [
          'centros_costo.ver',
          'servicios_medicos.ver',
        ]);

        await tester.tap(find.text('Servicios'));
        await AppHarness.settle(tester);
        await tester.tap(find.text('Urgencias'));
        await AppHarness.settle(tester);

        expect(find.text('Curaciones simples'), findsOneWidget);
        expect(find.text('Sutura simple'), findsOneWidget);
      },
    );

    testWidgets(
      'con procedimientos.ver, tocar un procedimiento muestra tarifas',
      (
        tester,
      ) async {
        await openSection(tester, [
          'centros_costo.ver',
          'servicios_medicos.ver',
          'procedimientos.ver',
        ]);
        await tester.tap(find.text('Servicios'));
        await AppHarness.settle(tester);
        await tester.tap(find.text('Urgencias'));
        await AppHarness.settle(tester);

        await tester.tap(find.text('Curaciones simples'));
        await AppHarness.settle(tester);

        expect(find.text('Tarifas de Curaciones simples'), findsOneWidget);
        expect(find.text(r'$50.000'), findsOneWidget);
        expect(find.text(r'$45.000'), findsOneWidget);
        expect(find.text('VIGENTE'), findsOneWidget);
        expect(find.text('Desde 01/01/2026'), findsOneWidget);
        expect(find.text('Desde 01/01/2025 hasta 31/12/2025'), findsOneWidget);
      },
    );

    testWidgets('sin procedimientos.ver no se consultan las tarifas', (
      tester,
    ) async {
      await openSection(tester, ['centros_costo.ver', 'servicios_medicos.ver']);
      await tester.tap(find.text('Servicios'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Urgencias'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Curaciones simples'));
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('GET', '/procedures/3/prices'), isEmpty);
    });

    testWidgets('sin centros: mensaje', (tester) async {
      harness.adapter.on('GET', '/cost-centers', body: envelope(<dynamic>[]));
      await openSection(tester, ['centros_costo.ver']);

      expect(find.text('No se encontraron resultados.'), findsNothing);
      expect(find.text('No hay centros de costo.'), findsOneWidget);
    });
  });
}
