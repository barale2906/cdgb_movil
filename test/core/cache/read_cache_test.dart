import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/cache/read_cache.dart';
import 'package:sga_bojanini/core/catalog/cost_center_providers.dart';
import 'package:sga_bojanini/core/catalog/product_repository.dart';
import 'package:sga_bojanini/core/catalog/supplier_repository.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_repository.dart';
import 'package:sga_bojanini/features/cost_centers/data/cost_centers_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  group('ReadCache', () {
    late SharedPreferences prefs;
    late ReadCache cache;

    setUp(() async {
      SharedPreferences.setMockInitialValues({'otra_clave': 'no se toca'});
      prefs = await SharedPreferences.getInstance();
      cache = ReadCache(prefs);
    });

    test('guarda y lee la lista tal cual', () async {
      await cache.write('almacenes', [
        {'id': 1, 'name': 'Bodega'},
        {'id': 2, 'name': 'Farmacia', 'code': null},
      ]);
      expect(cache.read('almacenes'), [
        {'id': 1, 'name': 'Bodega'},
        {'id': 2, 'name': 'Farmacia', 'code': null},
      ]);
    });

    test('sin copia: null', () {
      expect(cache.read('nada'), isNull);
    });

    test('una copia dañada se ignora', () async {
      await prefs.setString('read_cache.rota', '{no es json');
      await prefs.setString('read_cache.objeto', '{"a":1}');
      expect(cache.read('rota'), isNull);
      expect(cache.read('objeto'), isNull);
    });

    test('clear borra solo las copias, no otras preferencias', () async {
      await cache.write('a', [<String, dynamic>{}]);
      await cache.write('b', [<String, dynamic>{}]);
      await cache.clear();
      expect(cache.read('a'), isNull);
      expect(cache.read('b'), isNull);
      expect(prefs.getString('otra_clave'), 'no se toca');
    });
  });

  group('cachedList', () {
    late ReadCache cache;
    var fetches = 0;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      cache = ReadCache(await SharedPreferences.getInstance());
      fetches = 0;
    });

    Future<List<String>> read(Future<List<Json>> Function() fetch) =>
        cachedList(
          cache: cache,
          key: 'k',
          fetch: () {
            fetches++;
            return fetch();
          },
          parse: (json) => json['name']! as String,
        );

    test('con red: devuelve lo del servidor y guarda la copia', () async {
      final result = await read(
        () async => [
          {'name': 'A'},
        ],
      );
      expect(result, ['A']);
      expect(cache.read('k'), [
        {'name': 'A'},
      ]);
    });

    test('sin conexión: usa la última copia', () async {
      await read(
        () async => [
          {'name': 'A'},
        ],
      );
      final offline = await read(
        () async =>
            throw const NetworkException(NetworkFailureKind.noConnection),
      );
      expect(offline, ['A']);
      expect(fetches, 2, reason: 'siempre se intenta primero en línea');
    });

    test('tiempo agotado: también usa la copia', () async {
      await read(
        () async => [
          {'name': 'A'},
        ],
      );
      expect(
        await read(
          () async => throw const NetworkException(NetworkFailureKind.timeout),
        ),
        ['A'],
      );
    });

    test('sin red y sin copia: el error de red se propaga', () async {
      await expectLater(
        read(
          () async =>
              throw const NetworkException(NetworkFailureKind.noConnection),
        ),
        throwsA(isA<NetworkException>()),
      );
    });

    test('un 403 o un 5xx no se esconden detrás de la copia', () async {
      await read(
        () async => [
          {'name': 'A'},
        ],
      );
      await expectLater(
        read(() async => throw const ForbiddenException('Sin permiso')),
        throwsA(isA<ForbiddenException>()),
      );
      await expectLater(
        read(() async => throw const ServerException('Error', statusCode: 500)),
        throwsA(isA<ServerException>()),
      );
    });

    test('con red de nuevo, la lista nueva reemplaza la copia', () async {
      await read(
        () async => [
          {'name': 'A'},
        ],
      );
      await read(
        () async => [
          {'name': 'B'},
        ],
      );
      expect(cache.read('k'), [
        {'name': 'B'},
      ]);
    });
  });

  group('repositorios con copia local', () {
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

    test(
      'almacenes: tras una consulta en línea, sin red salen los mismos',
      () async {
        adapter
          ..on(
            'GET',
            '/warehouses',
            body: fixture('auth/warehouses_response.json'),
          )
          ..onError('GET', '/warehouses', DioExceptionType.connectionError);
        final repository = container.read(warehouseRepositoryProvider);

        final online = await repository.list();
        final offline = await repository.list();

        expect(offline.map((w) => w.name), online.map((w) => w.name));
        expect(offline, hasLength(2));
      },
    );

    test(
      'productos: el listado completo se guarda; la búsqueda con texto no',
      () async {
        adapter
          ..on(
            'GET',
            '/generic-products',
            body: fixture('catalog/products_list_response.json'),
          )
          ..onSocketFailure('GET', '/generic-products');
        final repository = container.read(productRepositoryProvider);

        await repository.products();
        expect(
          await repository.products(),
          isNotEmpty,
          reason: 'sin red, copia',
        );
        await expectLater(
          repository.products(search: 'gasa'),
          throwsA(isA<NetworkException>()),
        );
      },
    );

    test('proveedores: listado completo con copia', () async {
      adapter
        ..on(
          'GET',
          '/suppliers',
          body: fixture('catalog/suppliers_list_response.json'),
        )
        ..onSocketFailure('GET', '/suppliers');
      final repository = container.read(supplierRepositoryProvider);

      final online = await repository.suppliers();
      expect(await repository.suppliers(), hasLength(online.length));
      await expectLater(
        repository.suppliers(search: 'x'),
        throwsA(isA<NetworkException>()),
      );
    });

    test('centros de costo y árbol de servicios con copia', () async {
      adapter
        ..on(
          'GET',
          '/cost-centers',
          body: fixture('cost_centers/cost_centers_response.json'),
        )
        ..onSocketFailure('GET', '/cost-centers')
        ..on(
          'GET',
          '/medical-services/tree',
          body: fixture('cost_centers/service_tree_response.json'),
        )
        ..onSocketFailure('GET', '/medical-services/tree');
      final centers = container.read(costCenterRepositoryProvider);
      final services = container.read(serviceCatalogRepositoryProvider);

      final first = (await centers.list()).first;
      expect((await centers.list()).first, first);
      expect(await services.tree(), hasLength(1));
      expect(await services.tree(), hasLength(1));
    });

    test('sin red y sin copia previa: error de red', () async {
      adapter.onSocketFailure('GET', '/warehouses');
      await expectLater(
        container.read(warehouseRepositoryProvider).list(),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
