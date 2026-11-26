import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/data/asset_events.dart';
import 'package:sga_bojanini/features/assets/data/assets_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<Asset> _assets() =>
    (fixture('assets/assets_response.json')['data'] as List<dynamic>)
        .map((e) => Asset.fromJson(e as Json))
        .toList();

void main() {
  group('Asset (contrato)', () {
    test('parsea ficha, ubicación, responsable y valores en texto', () {
      final asset = _assets().first;
      expect(asset.code, '000007');
      expect(asset.status, AssetStatus.operational);
      expect(asset.assetType, AssetType.biomedical);
      expect(asset.category?.name, 'Equipos biomédicos');
      expect(asset.responsible?.name, 'Usuario Prueba');
      expect(
        asset.acquisitionValue,
        8500000,
        reason: 'llega como "8500000.00"',
      );
      expect(asset.supplier?.name, 'Droguería Proveedor S.A.S.');
      expect(asset.counts?.comments, 2);
    });

    test('mantenimiento próximo y traslado pendiente', () {
      final asset = _assets().first;
      expect(asset.nextMaintenance?.isOverdue, isTrue);
      expect(asset.nextMaintenance?.scheduledDate, '2026-11-10');
      expect(asset.pendingTransfer?.typeLabel, 'Préstamo');
    });

    test('ubicación en una sede y fuera de las instalaciones', () {
      final assets = _assets();
      expect(assets.first.locationLabel, 'Sede Principal · Urgencias · Sala 1');
      expect(assets.first.isOffPremises, isFalse);
      expect(assets.last.locationLabel, 'Taller externo');
      expect(assets.last.isOffPremises, isTrue);
    });

    test('campos opcionales ausentes y estado desconocido: no rompe', () {
      final asset = _assets().last;
      expect(asset.technicalProfile, isEmpty);
      expect(asset.responsible, isNull);
      expect(asset.nextMaintenance, isNull);
      final unknown = Asset.fromJson({
        'id': 1,
        'code': 'X',
        'name': 'Y',
        'status': 'algo_nuevo',
      });
      expect(unknown.status, AssetStatus.unknown);
      expect(unknown.assetType, AssetType.unknown);
      expect(unknown.locationLabel, isNull);
      expect(unknown.isRetired, isFalse);
    });

    test('perfil técnico conserva los campos del servidor', () {
      final profile = _assets().first.technicalProfile;
      expect(profile['manufacturer'], 'Fabricante Uno');
      expect(profile['requires_calibration'], true);
    });
  });

  group('Catálogos y eventos (contrato)', () {
    test('filtros: sedes con lugares y tipos de traslado con firma', () {
      final filters = AssetFilters.fromJson(
        fixture('assets/filters_response.json')['data'] as Json,
      );
      expect(filters.sites.single.places, hasLength(2));
      expect(filters.transferTypes.last.requiresSignature, isTrue);
      expect(filters.transferTypes.first.requiresSignature, isFalse);
      expect(filters.documentTypes.map((o) => o.value), ['manual', 'photo']);
    });

    test('indicadores', () {
      final stats = AssetStatistics.fromJson(
        fixture('assets/statistics_response.json')['data'] as Json,
      );
      expect(stats.total, 41);
      expect(stats.byStatus['maintenance'], 3);
      expect(stats.maintenance.overdue, 5);
      expect(stats.pendingTransfers, 4);
      expect(stats.totalValue, 123456789.5);
    });

    test('historial de ubicaciones y bitácora', () {
      final history =
          (fixture('assets/location_history_response.json')['data']
                  as List<dynamic>)
              .map((e) => LocationRecord.fromJson(e as Json))
              .toList();
      expect(history.first.isCurrent, isTrue);
      expect(history.last.isOffPremises, isTrue);
      expect(history.last.transferLabel, 'Reparación externa');
      final events =
          (fixture('assets/movements_response.json')['data'] as List<dynamic>)
              .map((e) => AssetMovement.fromJson(e as Json))
              .toList();
      expect(events.single.typeLabel, 'Cambio de estado');
      expect(events.single.maintenanceId, 31);
    });
  });

  group('AssetsRepository', () {
    late FakeHttpAdapter adapter;
    late AssetsRepository repository;

    setUp(() async {
      adapter = FakeHttpAdapter();
      final container = ProviderContainer(
        retry: noAutoRetry,
        overrides: await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 25)),
        ),
      );
      addTearDown(container.dispose);
      repository = container.read(assetsRepositoryProvider);
    });

    test('lista con búsqueda y filtros como parámetros', () async {
      adapter.on(
        'GET',
        '/assets',
        body: fixture('assets/assets_response.json'),
      );

      final page = await repository.list(
        const AssetQuery(
          search: ' monitor ',
          status: AssetStatus.maintenance,
          maintenanceOverdue: true,
        ),
      );

      expect(page.items, hasLength(2));
      expect(adapter.callsTo('GET', '/assets').single.queryParameters, {
        'search': 'monitor',
        'status': 'maintenance',
        'maintenance_overdue': true,
        'page': 1,
        'per_page': 25,
      });
    });

    test('sin filtros solo se pide la página', () async {
      adapter.on(
        'GET',
        '/assets',
        body: fixture('assets/assets_response.json'),
      );
      await repository.list(const AssetQuery());
      expect(adapter.callsTo('GET', '/assets').single.queryParameters, {
        'page': 1,
        'per_page': 25,
      });
    });

    test(
      'por código exige coincidencia exacta (la búsqueda es parcial)',
      () async {
        adapter.on(
          'GET',
          '/assets',
          body: fixture('assets/assets_response.json'),
        );

        expect(
          (await repository.byCode('000008'))?.name,
          'Portátil administrativo',
        );
        expect(await repository.byCode('0000'), isNull, reason: 'solo parcial');
        expect((await repository.byCode(' 000007 '))?.id, 7);
      },
    );

    test('detalle, filtros, indicadores, historial y comentarios', () async {
      adapter
        ..on('GET', '/assets/7', body: fixture('assets/asset_response.json'))
        ..on(
          'GET',
          '/assets/filters',
          body: fixture('assets/filters_response.json'),
        )
        ..on(
          'GET',
          '/assets/statistics',
          body: fixture('assets/statistics_response.json'),
        )
        ..on(
          'GET',
          '/assets/7/movements',
          body: fixture('assets/movements_response.json'),
        )
        ..on(
          'GET',
          '/assets/7/location-history',
          body: fixture('assets/location_history_response.json'),
        )
        ..on(
          'GET',
          '/assets/7/comments',
          body: fixture('assets/comments_response.json'),
        );

      expect((await repository.get(7)).name, 'Monitor de signos vitales');
      expect((await repository.filters()).sites, hasLength(1));
      expect((await repository.statistics()).total, 41);
      expect((await repository.movements(7)).items, hasLength(1));
      expect(await repository.locationHistory(7), hasLength(2));
      expect(await repository.comments(7), hasLength(1));
    });

    test('hoja de vida: descarga binaria', () async {
      adapter.onBytes('GET', '/assets/7/life-sheet', [1, 2, 3]);
      expect(await repository.lifeSheet(7), [1, 2, 3]);
    });

    test('comentar envía el texto recortado y no se reintenta', () async {
      adapter.on(
        'POST',
        '/assets/7/comments',
        status: 201,
        body: fixture('assets/comment_saved_response.json'),
      );
      final saved = await repository.addComment(7, '  Revisado hoy ');
      expect(saved.id, 6);
      expect(adapter.callsTo('POST', '/assets/7/comments').single.data, {
        'comment': 'Revisado hoy',
      });

      adapter.onError(
        'POST',
        '/assets/9/comments',
        DioExceptionType.receiveTimeout,
      );
      await expectLater(
        repository.addComment(9, 'x'),
        throwsA(isA<NetworkException>()),
      );
      expect(adapter.callsTo('POST', '/assets/9/comments'), hasLength(1));
    });
  });
}
