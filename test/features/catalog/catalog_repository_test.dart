import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/catalog/data/catalog_repository.dart';
import 'package:sga_bojanini/features/warehouse/data/warehouse_capacity_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  late FakeHttpAdapter adapter;
  late ProviderContainer container;

  setUp(() async {
    adapter = FakeHttpAdapter();
    container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: InMemoryTokenStore(),
        clock: TestClock(DateTime(2026, 11, 24)),
      ),
    );
    addTearDown(container.dispose);
  });

  group('CatalogRepository', () {
    test('products pide solo activos y envía search si hay texto', () async {
      adapter.on(
        'GET',
        '/generic-products',
        body: fixture('catalog/products_list_response.json'),
      );
      final repository = container.read(catalogRepositoryProvider);

      await repository.products();
      await repository.products(search: 'gasa');

      final calls = adapter.callsTo('GET', '/generic-products').toList();
      expect(calls.first.queryParameters, {'is_active': true});
      expect(calls.last.queryParameters, {'is_active': true, 'search': 'gasa'});
    });

    test('product devuelve el detalle completo', () async {
      adapter.on(
        'GET',
        '/generic-products/5',
        body: fixture('catalog/product_detail_response.json'),
      );
      final product = await container
          .read(catalogRepositoryProvider)
          .product(5);
      expect(product.variants, hasLength(1));
    });

    test('un 404 llega como NotFoundException', () async {
      adapter.on(
        'GET',
        '/generic-products/99',
        status: 404,
        body: errorBody('Producto genérico no encontrado'),
      );
      await expectLater(
        container.read(catalogRepositoryProvider).product(99),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('suppliers y supplier', () async {
      adapter
        ..on(
          'GET',
          '/suppliers',
          body: fixture('catalog/suppliers_list_response.json'),
        )
        ..on(
          'GET',
          '/suppliers/1',
          body: envelope({'id': 1, 'name': 'Proveedor Uno S.A.S.'}),
        );
      final repository = container.read(catalogRepositoryProvider);

      expect(await repository.suppliers(search: 'uno'), hasLength(2));
      expect((await repository.supplier(1)).name, 'Proveedor Uno S.A.S.');
      expect(
        adapter.callsTo('GET', '/suppliers').single.queryParameters,
        {'is_active': true, 'search': 'uno'},
      );
    });
  });

  test('WarehouseCapacityRepository pide /warehouses/{id}/capacity', () async {
    adapter.on(
      'GET',
      '/warehouses/1/capacity',
      body: fixture('warehouse/capacity_response.json'),
    );
    final capacity = await container
        .read(warehouseCapacityRepositoryProvider)
        .capacity(1);
    expect(capacity.zones, hasLength(2));
  });
}
