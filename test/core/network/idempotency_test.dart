import 'dart:math';

import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/idempotency.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/inventory/application/movement_controller.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  group('IdempotencyKey', () {
    test('son 32 caracteres hexadecimales y distintas entre sí', () {
      final keys = {for (var i = 0; i < 50; i++) IdempotencyKey.generate()};

      expect(keys, hasLength(50));
      expect(
        keys.every((key) => RegExp(r'^[0-9a-f]{32}$').hasMatch(key)),
        isTrue,
      );
    });

    test('con un generador fijo es repetible', () {
      expect(
        IdempotencyKey.generate(Random(1)),
        IdempotencyKey.generate(Random(1)),
      );
    });

    test('la cabecera solo existe si hay clave', () {
      expect(IdempotencyKey.headers('abc'), {'Idempotency-Key': 'abc'});
      expect(IdempotencyKey.headers(null), isEmpty);
    });
  });

  group('IdempotencyKeyHolder', () {
    late int counter;
    late IdempotencyKeyHolder holder;

    setUp(() {
      counter = 0;
      holder = IdempotencyKeyHolder(generator: () => 'k${++counter}');
    });

    test('mientras el contenido no cambia, la clave es la misma', () {
      expect(holder.keyFor({'a': 1}), 'k1');
      expect(holder.keyFor({'a': 1}), 'k1');
    });

    test('si el contenido cambia, usa una clave nueva', () {
      holder.keyFor({'a': 1});

      expect(holder.keyFor({'a': 2}), 'k2');
    });

    test('un tiempo de espera agotado conserva la clave', () {
      holder
        ..keyFor({'a': 1})
        ..settle(
          succeeded: false,
          error: const NetworkException(NetworkFailureKind.timeout),
        );

      expect(holder.keyFor({'a': 1}), 'k1');
    });

    test('el éxito y un error del servidor liberan la clave', () {
      holder
        ..keyFor({'a': 1})
        ..settle(succeeded: true);
      expect(holder.keyFor({'a': 1}), 'k2');

      holder.settle(
        succeeded: false,
        error: const BusinessRuleException('Sin stock'),
      );
      expect(holder.keyFor({'a': 1}), 'k3');
    });

    test('un envío ignorado (sin resultado ni error) no libera la clave', () {
      holder
        ..keyFor({'a': 1})
        ..settle(succeeded: false);

      expect(holder.keyFor({'a': 1}), 'k1');
    });
  });

  group('MovementController', () {
    late FakeHttpAdapter adapter;
    late ProviderContainer container;
    const request = LossRequest(
      productVariantId: 50,
      warehouseId: 1,
      locationId: 100,
      batchId: 7,
      quantity: 2,
      reason: 'Rotura',
    );

    String? sentKey(int index) =>
        adapter
                .callsTo('POST', '/movements/loss')
                .elementAt(index)
                .headers['Idempotency-Key']
            as String?;

    setUp(() async {
      adapter = FakeHttpAdapter();
      container = ProviderContainer(
        retry: noAutoRetry,
        overrides: await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 27)),
        ),
      );
      addTearDown(container.dispose);
      container.listen(movementControllerProvider, (_, _) {});
    });

    test('envía la clave y tras un timeout el reenvío usa la misma', () async {
      final controller = container.read(movementControllerProvider.notifier);
      adapter.onError(
        'POST',
        '/movements/loss',
        DioExceptionType.receiveTimeout,
      );
      expect(await controller.loss(request), isNull);

      adapter.on(
        'POST',
        '/movements/loss',
        status: 201,
        body: fixture('inventory/line_response.json'),
      );
      expect(await controller.loss(request), isNotNull);

      expect(sentKey(0), isNotNull);
      expect(sentKey(1), sentKey(0), reason: 'mismo envío, misma clave');
    });

    test('un movimiento nuevo después de guardar lleva otra clave', () async {
      final controller = container.read(movementControllerProvider.notifier);
      adapter.on(
        'POST',
        '/movements/loss',
        status: 201,
        body: fixture('inventory/line_response.json'),
      );
      await controller.loss(request);
      await controller.loss(request);

      expect(sentKey(1), isNot(sentKey(0)));
    });

    test('un error del servidor no conserva la clave', () async {
      final controller = container.read(movementControllerProvider.notifier);
      adapter.on(
        'POST',
        '/movements/loss',
        status: 409,
        body: errorBody('Sin stock suficiente.'),
      );
      await controller.loss(request);
      await controller.loss(request);

      expect(sentKey(1), isNot(sentKey(0)));
    });
  });
}
