import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<AssetMaintenance> _items() =>
    (fixture('assets/maintenances_response.json')['data'] as List<dynamic>)
        .map((e) => AssetMaintenance.fromJson(e as Json))
        .toList();

void main() {
  group('AssetMaintenance (contrato)', () {
    test('programado y vencido: se puede iniciar y cancelar, no completar', () {
      final item = _items().first;
      expect(item.status, MaintenanceStatus.scheduled);
      expect(item.isOverdue, isTrue);
      expect(item.type, MaintenanceType.preventive);
      expect(item.canStart, isTrue);
      expect(item.canComplete, isFalse);
      expect(item.canCancel, isTrue);
      expect(item.asset?.location, 'Sede Principal · Urgencias · Sala 1');
    });

    test('en curso: se puede completar y cancelar, con falla reportada', () {
      final item = _items()[1];
      expect(item.status, MaintenanceStatus.inProgress);
      expect(item.type, MaintenanceType.corrective);
      expect(item.reportedFailure, 'No enciende');
      expect(item.canStart, isFalse);
      expect(item.canComplete, isTrue);
      expect(item.canCancel, isTrue);
    });

    test('realizado: repuestos, costo en texto y resultado; sin acciones', () {
      final item = _items().last;
      expect(item.status, MaintenanceStatus.completed);
      expect(item.resultType, MaintenanceResult.operational);
      expect(item.technician?.name, 'Usuario Prueba');
      expect(item.partsReplaced.single.name, 'Filtro');
      expect(item.partsReplaced.single.cost, 15000);
      expect(item.cost, 30000);
      expect(item.canStart || item.canComplete || item.canCancel, isFalse);
    });

    test('valores desconocidos no rompen', () {
      final item = AssetMaintenance.fromJson({
        'id': 1,
        'status': 'otro',
        'maintenance_type': 'nuevo',
        'result': 'raro',
      });
      expect(item.status, MaintenanceStatus.unknown);
      expect(item.type, MaintenanceType.unknown);
      expect(item.resultType, MaintenanceResult.unknown);
      expect(item.canCancel, isFalse);
    });
  });

  group('CompleteMaintenanceRequest', () {
    test('interno: técnico, hora de Colombia y solo campos con valor', () {
      final json = CompleteMaintenanceRequest(
        performedAt: DateTime(2026, 11, 25, 14, 30),
        internal: true,
        activities: ' Limpieza ',
        result: MaintenanceResult.operationalWithRestrictions,
        technicianId: 3,
        supplierId: 9,
        externalTechnicianName: 'Ignorado',
        findings: '  ',
        parts: const [ReplacedPart(name: ' Filtro ', quantity: 2, cost: 5000)],
        cost: 12000,
      ).toJson();
      expect(json, {
        'performed_at': '2026-11-25 14:30:00',
        'performed_by_type': 'internal',
        'activities_performed': 'Limpieza',
        'result': 'operational_with_restrictions',
        'technician_id': 3,
        'parts_replaced': [
          {'name': 'Filtro', 'quantity': 2.0, 'cost': 5000.0},
        ],
        'cost': 12000.0,
      });
    });

    test('externo: proveedor y nombre; sin técnico interno', () {
      final json = CompleteMaintenanceRequest(
        performedAt: DateTime(2026, 11, 25, 9),
        internal: false,
        activities: 'Calibración',
        result: MaintenanceResult.operational,
        technicianId: 3,
        supplierId: 9,
        externalTechnicianName: ' Pedro ',
      ).toJson();
      expect(json['performed_by_type'], 'external');
      expect(json['supplier_id'], 9);
      expect(json['external_technician_name'], 'Pedro');
      expect(json.containsKey('technician_id'), isFalse);
    });
  });

  group('MaintenanceRepository', () {
    late FakeHttpAdapter adapter;
    late MaintenanceRepository repository;

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
      repository = container.read(maintenanceRepositoryProvider);
    });

    test('lista con estado, vencidos y búsqueda', () async {
      adapter.on(
        'GET',
        '/assets/maintenances',
        body: fixture('assets/maintenances_response.json'),
      );
      await repository.list(
        const MaintenanceQuery(
          status: MaintenanceStatus.scheduled,
          overdue: true,
          search: ' monitor ',
        ),
      );
      expect(
        adapter.callsTo('GET', '/assets/maintenances').single.queryParameters,
        {
          'status': 'scheduled',
          'overdue': true,
          'search': 'monitor',
          'page': 1,
          'per_page': 25,
        },
      );
    });

    test('iniciar, completar y cancelar usan su ruta', () async {
      for (final action in ['start', 'complete', 'cancel']) {
        adapter.on(
          'POST',
          '/assets/maintenances/32/$action',
          body: fixture('assets/maintenance_32_response.json'),
        );
      }
      await repository.start(32);
      await repository.complete(
        32,
        CompleteMaintenanceRequest(
          performedAt: DateTime(2026, 11, 25, 10),
          internal: true,
          activities: 'Reparación',
          result: MaintenanceResult.operational,
          technicianId: 3,
        ),
      );
      await repository.cancel(32, ' Equipo retirado ');

      expect(
        adapter.callsTo('POST', '/assets/maintenances/32/start').single.data,
        isNull,
      );
      expect(
        (adapter.callsTo('POST', '/assets/maintenances/32/complete').single.data
            as Map)['activities_performed'],
        'Reparación',
      );
      expect(
        adapter.callsTo('POST', '/assets/maintenances/32/cancel').single.data,
        {
          'reason': 'Equipo retirado',
        },
      );
    });

    test('un 422 llega tipado y un timeout no se reintenta', () async {
      adapter
        ..on(
          'POST',
          '/assets/maintenances/32/complete',
          status: 422,
          body: errorBody(
            'Datos inválidos',
            extra: {
              'errors': {
                'technician_id': ['Indique el técnico interno.'],
              },
            },
          ),
        )
        ..onError(
          'POST',
          '/assets/maintenances/33/start',
          DioExceptionType.receiveTimeout,
        );
      await expectLater(
        repository.complete(
          32,
          CompleteMaintenanceRequest(
            performedAt: DateTime(2026, 11, 25),
            internal: true,
            activities: 'x',
            result: MaintenanceResult.operational,
          ),
        ),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.firstErrorFor('technician_id'),
            'technician_id',
            'Indique el técnico interno.',
          ),
        ),
      );
      await expectLater(repository.start(33), throwsA(isA<NetworkException>()));
      expect(
        adapter.callsTo('POST', '/assets/maintenances/33/start'),
        hasLength(1),
      );
    });

    test('detalle y reporte en PDF', () async {
      adapter
        ..on(
          'GET',
          '/assets/maintenances/33',
          body: fixture('assets/maintenance_33_response.json'),
        )
        ..onBytes('GET', '/assets/maintenances/33/report', [5, 5]);
      expect((await repository.get(33)).status, MaintenanceStatus.completed);
      expect(await repository.report(33), [5, 5]);
    });
  });
}
