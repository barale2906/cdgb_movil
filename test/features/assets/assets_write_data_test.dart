import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_draft.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/data/assets_repository.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_repository.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_requests.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

Asset _asset(String file) =>
    Asset.fromJson(fixture('assets/$file')['data'] as Json);

void main() {
  group('AssetDraft', () {
    final draft = AssetDraft(
      name: '  Bomba de infusión ',
      categoryId: 2,
      placeId: 4,
      responsibleId: 3,
      status: AssetStatus.available,
      brand: ' MarcaUno ',
      model: '',
      acquisitionDate: DateTime(2026, 3, 10),
      acquisitionValue: 8500000,
      supplierId: 4,
      warrantyUntil: DateTime(2027, 3, 10),
      comment: 'Ingreso por compra',
    );

    test('crear: solo viaja lo que tiene valor, con fechas AAAA-MM-DD', () {
      expect(draft.toCreateJson(), {
        'name': 'Bomba de infusión',
        'category_id': 2,
        'brand': 'MarcaUno',
        'acquisition_date': '2026-03-10',
        'acquisition_value': 8500000.0,
        'supplier_id': 4,
        'warranty_until': '2027-03-10',
        'place_id': 4,
        'responsible_id': 3,
        'status': 'available',
        'comment': 'Ingreso por compra',
      });
    });

    test('editar: no envía ubicación ni estado y manda null en lo vacío', () {
      final json = draft.toUpdateJson();
      expect(json['name'], 'Bomba de infusión');
      expect(json['model'], isNull, reason: 'permite borrar el campo');
      expect(json['serial'], isNull);
      expect(json['brand'], 'MarcaUno');
      expect(json.keys, isNot(contains('place_id')));
      expect(json.keys, isNot(contains('status')));
      expect(json.keys, isNot(contains('responsible_id')));
    });
  });

  group('contrato', () {
    test('los catálogos traen las categorías para el formulario', () {
      final filters = AssetFilters.fromJson(
        fixture('assets/filters_response.json')['data'] as Json,
      );
      expect(filters.categories.map((c) => c.name), [
        'Equipos biomédicos',
        'Mobiliario',
      ]);
    });

    test('la hoja de vida técnica solo aplica a equipos que la admiten', () {
      expect(_asset('asset_response.json').supportsTechnicalProfile, isTrue);
      final general = Asset.fromJson({
        'id': 9,
        'code': '000009',
        'name': 'Escritorio',
        'asset_type': 'general',
        'requires_maintenance': false,
      });
      expect(general.supportsTechnicalProfile, isFalse);
    });

    test('programar un correctivo exige enviar la falla y quién lo hará', () {
      final request = ScheduleMaintenanceRequest(
        type: MaintenanceType.corrective,
        scheduledDate: DateTime(2026, 12, 15),
        reportedFailure: ' No enciende ',
        performer: Performer.external,
        technicianId: 3,
        supplierId: 4,
      );
      expect(request.toJson(), {
        'maintenance_type': 'corrective',
        'scheduled_date': '2026-12-15',
        'reported_failure': 'No enciende',
        'performed_by_type': 'external',
        'supplier_id': 4,
      });
    });

    test('un plan interno manda null en el proveedor para borrarlo', () {
      final plan = MaintenancePlanRequest(
        type: MaintenanceType.preventive,
        frequencyValue: 6,
        frequencyUnit: FrequencyUnit.months,
        startDate: DateTime(2026),
        performer: Performer.internal,
        technicianId: 3,
        supplierId: 4,
        notes: '  ',
        isActive: false,
      );
      expect(plan.toJson(), {
        'maintenance_type': 'preventive',
        'frequency_value': 6,
        'frequency_unit': 'months',
        'start_date': '2026-01-01',
        'performed_by_type': 'internal',
        'technician_id': 3,
        'supplier_id': null,
        'notes': null,
        'is_active': false,
      });
    });

    test('sin correctivo en los tipos de plan', () {
      expect(
        plannableMaintenanceTypes,
        isNot(contains(MaintenanceType.corrective)),
      );
    });
  });

  group('repositorios', () {
    late FakeHttpAdapter adapter;
    late AssetsRepository assets;
    late MaintenanceRepository maintenance;

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
      assets = container.read(assetsRepositoryProvider);
      maintenance = container.read(maintenanceRepositoryProvider);
    });

    const draft = AssetDraft(name: 'Bomba de infusión', categoryId: 2);

    test(
      'crear hace POST /assets y devuelve el activo con su código',
      () async {
        adapter.on(
          'POST',
          '/assets',
          status: 201,
          body: fixture('assets/asset_created_response.json'),
        );
        final created = await assets.create(draft);

        expect(created.code, '000042');
        expect(adapter.callsTo('POST', '/assets').single.data, {
          'name': 'Bomba de infusión',
          'category_id': 2,
        });
      },
    );

    test('editar hace PUT y eliminar hace DELETE', () async {
      adapter
        ..on(
          'PUT',
          '/assets/7',
          body: fixture('assets/asset_response.json'),
        )
        ..on('DELETE', '/assets/7', body: {'success': true, 'message': 'ok'});

      await assets.update(7, draft);
      await assets.delete(7);

      expect(
        adapter.callsTo('PUT', '/assets/7').single.data,
        containsPair(
          'category_id',
          2,
        ),
      );
      expect(adapter.callsTo('DELETE', '/assets/7'), hasLength(1));
    });

    test('un 409 al eliminar llega con el mensaje del servidor', () async {
      adapter.on(
        'DELETE',
        '/assets/7',
        status: 409,
        body: errorBody('El activo tiene mantenimientos registrados.'),
      );
      await expectLater(
        assets.delete(7),
        throwsA(
          isA<BusinessRuleException>().having(
            (e) => e.message,
            'message',
            'El activo tiene mantenimientos registrados.',
          ),
        ),
      );
    });

    test('hoja de vida: PUT con los campos enviados', () async {
      adapter.on('PUT', '/assets/7/technical-profile', body: {'success': true});
      await assets.updateTechnicalProfile(7, {'manufacturer': 'Fabricante'});
      expect(
        adapter.callsTo('PUT', '/assets/7/technical-profile').single.data,
        {'manufacturer': 'Fabricante'},
      );
    });

    test(
      'las escrituras de activos no se reintentan tras un timeout',
      () async {
        adapter.onError('POST', '/assets', DioExceptionType.receiveTimeout);
        await expectLater(
          assets.create(draft),
          throwsA(isA<NetworkException>()),
        );
        expect(adapter.callsTo('POST', '/assets'), hasLength(1));
      },
    );

    test('programar, reprogramar y planes usan sus rutas', () async {
      adapter
        ..on(
          'POST',
          '/assets/7/maintenances',
          status: 201,
          body: fixture('assets/maintenance_scheduled_response.json'),
        )
        ..on(
          'PUT',
          '/assets/maintenances/34',
          body: fixture('assets/maintenance_scheduled_response.json'),
        )
        ..on(
          'POST',
          '/assets/7/maintenance-plans',
          status: 201,
          body: fixture('assets/plan_saved_response.json'),
        )
        ..on(
          'PUT',
          '/assets/maintenance-plans/4',
          body: fixture('assets/plan_saved_response.json'),
        );
      final plan = MaintenancePlanRequest(
        type: MaintenanceType.inspection,
        frequencyValue: 30,
        frequencyUnit: FrequencyUnit.days,
        startDate: DateTime(2026, 12),
        performer: Performer.internal,
      );

      final scheduled = await maintenance.schedule(
        7,
        ScheduleMaintenanceRequest(
          type: MaintenanceType.inspection,
          scheduledDate: DateTime(2026, 12, 15),
        ),
      );
      await maintenance.reschedule(34, DateTime(2026, 12, 20));
      await maintenance.createPlan(7, plan);
      await maintenance.updatePlan(4, plan);

      expect(scheduled.id, 34);
      expect(
        adapter.callsTo('PUT', '/assets/maintenances/34').single.data,
        {'scheduled_date': '2026-12-20'},
      );
      expect(
        adapter.callsTo('POST', '/assets/7/maintenance-plans'),
        hasLength(1),
      );
      expect(
        adapter.callsTo('PUT', '/assets/maintenance-plans/4'),
        hasLength(1),
      );
    });
  });
}
