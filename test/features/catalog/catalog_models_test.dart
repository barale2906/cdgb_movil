import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_capacity.dart';
import 'package:sga_bojanini/features/catalog/data/supplier.dart';

import '../../helpers/fixtures.dart';

void main() {
  group('GenericProduct (contrato)', () {
    test('detalle: anidados, decimales como texto y componentes', () {
      final product = GenericProduct.fromJson(
        fixture('catalog/product_detail_response.json')['data'] as Json,
      );

      expect(product.productType, ProductType.kit);
      expect(product.category?.name, 'Curación');
      expect(product.baseUnit?.abbreviation, 'und');
      expect(product.reorderPoint, 20, reason: 'llega como "20.00"');
      expect(product.reorderQuantity, 100);
      expect(product.maxStock, isNull);
      expect(product.variants.single.sanitaryRegistrations, hasLength(2));
      expect(
        product.variants.single.sanitaryRegistrations.last.isExpired,
        isTrue,
      );
      expect(product.components.single.quantityPerKit, 2);
      expect(product.components.single.component?.name, 'Esparadrapo');
    });

    test('lista: campos planos y un tipo nuevo no rompe el parseo', () {
      final data =
          fixture('catalog/products_list_response.json')['data']
              as List<dynamic>;
      final products = [
        for (final item in data) GenericProduct.fromJson(item as Json),
      ];

      expect(products.first.category, isNull);
      expect(products.first.productType, ProductType.simple);
      expect(products.last.productType, ProductType.unknown);
      expect(products.last.requiresColdChain, isTrue);
    });
  });

  test('Supplier (contrato): tipo por defecto y campos nulos', () {
    final data =
        fixture('catalog/suppliers_list_response.json')['data']
            as List<dynamic>;
    final suppliers = [
      for (final item in data) Supplier.fromJson(item as Json),
    ];
    expect(suppliers.first.taxId, '900000001-1');
    expect(suppliers.last.supplierType, 'expense');
    expect(suppliers.last.phone, isNull);
    expect(
      Supplier.fromJson({'id': 3, 'name': 'X'}).supplierType,
      'inventory',
    );
  });

  test('WarehouseCapacity (contrato): árbol, enteros y límites nulos', () {
    final capacity = WarehouseCapacity.fromJson(
      fixture('warehouse/capacity_response.json')['data'] as Json,
    );

    expect(capacity.capacityVolume.usagePct, 25);
    expect(capacity.capacityWeight.usedKg, 950.5);
    expect(capacity.zones, hasLength(2));
    expect(capacity.zones.first.locations.single.code, 'A1');
    expect(capacity.zones.first.capacityWeight.maxKg, isNull);
    expect(capacity.zones.last.code, isNull);
    expect(capacity.zones.last.capacityVolume.usedCm3, 0);
    expect(capacity.zones.last.locations, isEmpty);
  });
}
