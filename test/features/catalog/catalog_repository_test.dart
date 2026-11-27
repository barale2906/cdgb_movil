import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/catalog/product_repository.dart';
import 'package:sga_bojanini/core/catalog/supplier_repository.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_capacity_repository.dart';

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
      final repository = container.read(productRepositoryProvider);

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
          .read(productRepositoryProvider)
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
        container.read(productRepositoryProvider).product(99),
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
      final repository = container.read(supplierRepositoryProvider);

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

  group('ficha de producto: lotes por vencer y proveedores de variante', () {
    test(
      'otros almacenes: envía el almacén a excluir y lee los saldos',
      () async {
        adapter.on(
          'GET',
          '/generic-products/5/batches/other-warehouses-expiring',
          body: fixture('catalog/other_warehouses_expiring_response.json'),
        );
        final repository = container.read(productRepositoryProvider);

        final result = await repository.otherWarehousesExpiring(
          genericProductId: 5,
          excludeWarehouseId: 1,
        );
        await repository.otherWarehousesExpiring(genericProductId: 5);

        expect(result.days, 90);
        expect(result.items, hasLength(2));
        expect(result.items.first.lotNumber, 'L-2026-77');
        expect(result.items.first.warehouse?.name, 'Bodega Norte');
        expect(result.items.first.daysUntilExpiry, 49);
        expect(result.items.last.quantity, 12.5, reason: 'llega como texto');
        final calls = adapter
            .callsTo(
              'GET',
              '/generic-products/5/batches/other-warehouses-expiring',
            )
            .toList();
        expect(calls.first.queryParameters, {'exclude_warehouse_id': 1});
        expect(calls.last.queryParameters, isEmpty);
      },
    );

    test('sin saldos devuelve una lista vacía', () async {
      adapter.on(
        'GET',
        '/generic-products/5/batches/other-warehouses-expiring',
        body: envelope({'days': 90, 'items': <dynamic>[]}),
      );
      final result = await container
          .read(productRepositoryProvider)
          .otherWarehousesExpiring(genericProductId: 5);
      expect(result.items, isEmpty);
    });

    test('proveedores de una variante', () async {
      adapter.on(
        'GET',
        '/variants/50/suppliers',
        body: fixture('catalog/variant_suppliers_response.json'),
      );
      final suppliers = await container
          .read(productRepositoryProvider)
          .variantSuppliers(50);
      expect(suppliers, hasLength(2));
      expect(suppliers.first.name, isNotEmpty);
    });
  });
}
