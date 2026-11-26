import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/consumptions/application/consumption_actions.dart';
import 'package:sga_bojanini/features/consumptions/application/consumptions_providers.dart';
import 'package:sga_bojanini/features/consumptions/application/new_consumption_controller.dart';
import 'package:sga_bojanini/features/consumptions/data/consumption_record.dart';
import 'package:sga_bojanini/features/consumptions/data/consumptions_repository.dart';
import 'package:sga_bojanini/features/consumptions/data/new_consumption_request.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<ConsumptionRecord> _records() =>
    ((fixture('consumptions/consumptions_response.json')['data']
                as Json)['items']
            as List<dynamic>)
        .map((e) => ConsumptionRecord.fromJson(e as Json))
        .toList();

const _gauze = GenericProduct(id: 5, name: 'Gasa estéril 10x10');

void main() {
  group('ConsumptionRecord (contrato)', () {
    test('lee producto, lote, cantidad y estado', () {
      final first = _records().first;
      expect(first.productName, 'Gasa estéril 10x10');
      expect(first.lotNumber, 'LOT-2026-A');
      expect(first.quantity, 3);
      expect(first.syncStatus, SyncStatus.failed);
    });

    test('la cantidad puede llegar como texto y el producto puede faltar', () {
      final second = _records()[1];
      expect(second.quantity, 2);
      expect(second.productName, isNull);
      expect(second.syncStatus, SyncStatus.synced);
    });

    test('solo un consumo fallido se puede reenviar', () {
      expect(_records().first.canRetrySync, isTrue);
      expect(_records()[1].canRetrySync, isFalse);
      expect(_records().last.canRetrySync, isFalse);
    });

    test('un estado nuevo del servidor no rompe el parseo', () {
      expect(SyncStatus.parse('algo_nuevo'), SyncStatus.unknown);
      expect(SyncStatus.parse(null), SyncStatus.unknown);
    });
  });

  group('NewConsumptionRequest', () {
    test('arma el cuerpo y omite los textos vacíos', () {
      const request = NewConsumptionRequest(
        warehouseId: 2,
        costCenterId: 1,
        appointmentId: ' C0001 ',
        patientIdentifier: '  ',
        items: [ConsumptionItemRequest(genericProductId: 5, quantity: 3)],
      );
      expect(request.toJson(), {
        'warehouse_id': 2,
        'cost_center_id': 1,
        'items': [
          {'generic_product_id': 5, 'quantity': 3},
        ],
        'appointment_id': 'C0001',
      });
    });
  });

  group('repositorio y acciones', () {
    late FakeHttpAdapter adapter;
    late ProviderContainer container;
    late ConsumptionsRepository repository;

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
      container
        ..listen(consumptionActionsProvider, (_, _) {})
        ..listen(newConsumptionProvider, (_, _) {});
      repository = container.read(consumptionsRepositoryProvider);
    });

    test('lista: lee data.items y data.meta, con página y estado', () async {
      adapter.on(
        'GET',
        '/consumptions',
        body: fixture('consumptions/consumptions_response.json'),
      );
      final page = await repository.list(status: SyncStatus.failed, page: 2);
      expect(page.items, hasLength(3));
      expect(page.meta.total, 3);
      expect(page.meta.hasMore, isFalse);
      expect(
        adapter.callsTo('GET', '/consumptions').single.queryParameters,
        {'sync_status': 'failed', 'page': 2, 'per_page': 25},
      );
    });

    test('lista sin filtro no envía sync_status', () async {
      adapter.on(
        'GET',
        '/consumptions',
        body: fixture('consumptions/consumptions_response.json'),
      );
      await repository.list();
      expect(
        adapter.callsTo('GET', '/consumptions').single.queryParameters,
        {'page': 1, 'per_page': 25},
      );
    });

    test(
      'una lista sin items o sin meta es una respuesta inesperada',
      () async {
        adapter.on('GET', '/consumptions', body: envelope(<String, dynamic>{}));
        await expectLater(repository.list(), throwsA(isA<ServerException>()));
      },
    );

    test('detalle y proyección', () async {
      adapter
        ..on(
          'GET',
          '/consumptions/31',
          body: fixture('consumptions/consumption_response.json'),
        )
        ..on(
          'GET',
          '/medsys/consumption-projection',
          body: fixture('consumptions/projection_response.json'),
        );
      expect((await repository.detail(31)).lotNumber, 'LOT-2026-A');
      final projection = await repository.projection(days: 15);
      expect(projection.first.projectedUnits, 30);
      expect(projection.first.avgUnitsPerAppointment, 2.5);
      expect(
        adapter
            .callsTo('GET', '/medsys/consumption-projection')
            .single
            .queryParameters,
        {'days': 15, 'historical_days': 90},
      );
    });

    test('reintentar la sincronización: POST y recarga del detalle', () async {
      adapter
        ..on(
          'POST',
          '/consumptions/31/retry-sync',
          body: fixture('consumptions/retry_response.json'),
        )
        ..on(
          'GET',
          '/consumptions/31',
          body: fixture('consumptions/consumption_response.json'),
        );
      final sub = container.listen(consumptionDetailProvider(31), (_, _) {});
      addTearDown(sub.close);
      await container.read(consumptionDetailProvider(31).future);

      final done = await container
          .read(consumptionActionsProvider.notifier)
          .retrySync(31);
      await container.read(consumptionDetailProvider(31).future);

      expect(done, isTrue);
      expect(adapter.callsTo('GET', '/consumptions/31'), hasLength(2));
    });

    test('409 al reintentar llega con el mensaje y sin reintento', () async {
      adapter.on(
        'POST',
        '/consumptions/31/retry-sync',
        status: 409,
        body: errorBody(
          'Solo se puede reintentar sincronización de registros fallidos',
        ),
      );
      final done = await container
          .read(consumptionActionsProvider.notifier)
          .retrySync(31);
      expect(done, isFalse);
      expect(
        container.read(consumptionActionsProvider).error,
        isA<BusinessRuleException>(),
      );
      expect(
        adapter.callsTo('POST', '/consumptions/31/retry-sync'),
        hasLength(1),
      );
    });

    group('registrar un consumo', () {
      NewConsumptionNotifier form() =>
          container.read(newConsumptionProvider.notifier);
      NewConsumptionState state() => container.read(newConsumptionProvider);

      void fill() {
        form()
          ..setWarehouse(2)
          ..setCostCenter(1)
          ..addLine(_gauze);
      }

      test('exige almacén, centro de costo e insumos con cantidad ≥ 1', () {
        expect(state().canSubmit, isFalse);
        form().setWarehouse(2);
        expect(state().canSubmit, isFalse);
        form()
          ..setCostCenter(1)
          ..addLine(_gauze);
        expect(state().canSubmit, isTrue);
        form().setQuantity(state().lines.single.key, 0);
        expect(state().canSubmit, isFalse);
      });

      test('envía un solo POST con cita y paciente', () async {
        adapter.on(
          'POST',
          '/consumptions',
          status: 201,
          body: fixture('consumptions/created_response.json'),
        );
        fill();
        form()
          ..setAppointment('C0001')
          ..setPatient('1000000001')
          ..setQuantity(state().lines.single.key, 3);

        expect(await form().submit(), isTrue);

        expect(state().saved, isTrue);
        expect(adapter.callsTo('POST', '/consumptions').single.data, {
          'warehouse_id': 2,
          'cost_center_id': 1,
          'items': [
            {'generic_product_id': 5, 'quantity': 3},
          ],
          'appointment_id': 'C0001',
          'patient_identifier': '1000000001',
        });
        expect(await form().submit(), isFalse, reason: 'ya registrado');
        expect(adapter.callsTo('POST', '/consumptions'), hasLength(1));
      });

      test('un rechazo conserva lo escrito', () async {
        adapter.on(
          'POST',
          '/consumptions',
          status: 409,
          body: errorBody('Stock insuficiente'),
        );
        fill();
        expect(await form().submit(), isFalse);
        expect(state().error, isA<BusinessRuleException>());
        expect(state().lines, hasLength(1));
        expect(state().canSubmit, isTrue);
      });

      test('sin respuesta: bloquea hasta que el usuario confirme', () async {
        adapter
          ..onError('POST', '/consumptions', DioExceptionType.receiveTimeout)
          ..on(
            'POST',
            '/consumptions',
            body: fixture('consumptions/created_response.json'),
          );
        fill();
        await form().submit();

        expect(state().isUnconfirmed, isTrue);
        expect(await form().submit(), isFalse);
        expect(adapter.callsTo('POST', '/consumptions'), hasLength(1));

        form().acknowledgeNotSaved();
        expect(await form().submit(), isTrue);
        expect(adapter.callsTo('POST', '/consumptions'), hasLength(2));
      });

      test('quitar un insumo no afecta a los demás', () {
        fill();
        form().addLine(const GenericProduct(id: 6, name: 'Guantes'));
        form().removeLine(state().lines.first.key);
        expect(state().lines.single.product.name, 'Guantes');
      });
    });
  });
}
