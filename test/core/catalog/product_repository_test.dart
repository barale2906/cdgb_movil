import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/catalog/product_repository.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  late FakeHttpAdapter adapter;
  late ProductRepository repository;

  setUp(() async {
    adapter = FakeHttpAdapter();
    final container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: InMemoryTokenStore(),
        clock: TestClock(DateTime(2026, 11, 26)),
      ),
    );
    addTearDown(container.dispose);
    repository = container.read(productRepositoryProvider);
  });

  test('kitAvailability devuelve las unidades armables del almacén', () async {
    adapter.on(
      'GET',
      '/generic-products/5/kit-availability',
      body: envelope({
        'generic_product_id': 5,
        'warehouse_id': 1,
        'available_kits': 12,
      }),
    );
    expect(
      await repository.kitAvailability(genericProductId: 5, warehouseId: 1),
      12,
    );
  });

  test('kitAvailability sin cantidad en la respuesta es cero', () async {
    adapter.on(
      'GET',
      '/generic-products/5/kit-availability',
      body: envelope(<String, dynamic>{}),
    );
    expect(
      await repository.kitAvailability(genericProductId: 5, warehouseId: 1),
      0,
    );
  });

  test('presentaciones del producto con su factor a unidad base', () async {
    adapter.on(
      'GET',
      '/generic-products/5/presentations',
      body: fixture('inventory/presentations_response.json'),
    );
    final presentations = await repository.presentations(5);
    expect(presentations.single.name, 'Caja x 100');
  });
}
