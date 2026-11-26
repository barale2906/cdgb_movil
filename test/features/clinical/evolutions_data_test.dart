import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/clinical/clinical_lookup.dart';
import 'package:sga_bojanini/core/clinical/clinical_template.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/application/evolution_actions.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';
import 'package:sga_bojanini/features/clinical/data/evolution.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<Evolution> _evolutions() =>
    (fixture('clinical/evolutions_response.json')['data'] as List<dynamic>)
        .map((e) => Evolution.fromJson(e as Json))
        .toList();

void main() {
  group('Evolution (contrato)', () {
    test('lee autor y fecha; el HTML se ve como texto simple', () {
      final first = _evolutions().first;
      expect(first.id, 7);
      expect(first.userName, 'Usuario Prueba');
      expect(first.recordedAt, '2026-11-23 10:30:00');
      expect(first.text, 'Paciente estable.\nSe indica control en 8 días.');
    });

    test('una evolución que ya es texto simple se conserva', () {
      expect(_evolutions().last.text, 'Nota en texto simple');
    });
  });

  group('ProcedureMedication (contrato)', () {
    test('lee producto, lote, vencimiento y cantidad', () {
      final item = ProcedureMedication.fromJson(
        ((fixture('clinical/medications_response.json')['data']) as List).first
            as Json,
      );
      expect(item.productName, 'Lidocaína 2% ampolla');
      expect(item.lotNumber, 'LOT-2026-A');
      expect(item.expirationDate, '2027-03-31');
      expect(item.quantity, 2);
    });
  });

  group('ClinicalTemplate (contrato)', () {
    test('lee el contenido en HTML', () {
      final template = ClinicalTemplate.fromJson(
        fixture('clinical/template_response.json')['data'] as Json,
      );
      expect(template.medicalServiceId, 3);
      expect(template.content, contains('<strong>Motivo:</strong>'));
    });
  });

  group('repositorios', () {
    late FakeHttpAdapter adapter;
    late ProviderContainer container;
    late ClinicalRepository repository;

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
      container.listen(evolutionActionsProvider, (_, _) {});
      repository = container.read(clinicalRepositoryProvider);
    });

    test('lista las evoluciones y los medicamentos del registro', () async {
      adapter
        ..on(
          'GET',
          '/patient-procedure-records/22/evolutions',
          body: fixture('clinical/evolutions_response.json'),
        )
        ..on(
          'GET',
          '/patient-procedure-records/22/medications',
          body: fixture('clinical/medications_response.json'),
        );
      expect(await repository.evolutions(22), hasLength(2));
      expect(await repository.medications(22), hasLength(1));
    });

    test('crear envía el contenido y editar usa PUT con el id', () async {
      adapter
        ..on(
          'POST',
          '/patient-procedure-records/22/evolutions',
          status: 201,
          body: fixture('clinical/evolution_response.json'),
        )
        ..on(
          'PUT',
          '/patient-procedure-records/22/evolutions/7',
          body: fixture('clinical/evolution_response.json'),
        );
      await repository.createEvolution(22, '<p>Nueva nota</p>');
      await repository.updateEvolution(22, 7, '<p>Editada</p>');

      expect(
        adapter
            .callsTo('POST', '/patient-procedure-records/22/evolutions')
            .single
            .data,
        {'content': '<p>Nueva nota</p>'},
      );
      expect(
        adapter
            .callsTo('PUT', '/patient-procedure-records/22/evolutions/7')
            .single
            .data,
        {'content': '<p>Editada</p>'},
      );
    });

    test(
      'plantilla del servicio: existe o el servidor responde sin datos',
      () async {
        adapter
          ..on(
            'GET',
            '/clinical-templates/for-service/3',
            body: fixture('clinical/template_response.json'),
          )
          ..on(
            'GET',
            '/clinical-templates/for-service/9',
            body: fixture('clinical/template_none_response.json'),
          );
        final lookup = container.read(clinicalLookupRepositoryProvider);

        expect((await lookup.template(3))?.title, 'Curación simple');
        expect(await lookup.template(9), isNull);
      },
    );

    group('guardar con las acciones', () {
      EvolutionActions actions() =>
          container.read(evolutionActionsProvider.notifier);

      test('convierte el texto a párrafos y crea', () async {
        adapter.on(
          'POST',
          '/patient-procedure-records/22/evolutions',
          status: 201,
          body: fixture('clinical/evolution_response.json'),
        );

        final done = await actions().save(22, 'Línea 1\nLínea 2');

        expect(done, isTrue);
        expect(
          adapter
              .callsTo('POST', '/patient-procedure-records/22/evolutions')
              .single
              .data,
          {'content': '<p>Línea 1</p><p>Línea 2</p>'},
        );
      });

      test('con un id edita en vez de crear', () async {
        adapter.on(
          'PUT',
          '/patient-procedure-records/22/evolutions/7',
          body: fixture('clinical/evolution_response.json'),
        );
        expect(await actions().save(22, 'Editada', evolutionId: 7), isTrue);
        expect(
          adapter.callsTo('POST', '/patient-procedure-records/22/evolutions'),
          isEmpty,
        );
      });

      test('un texto vacío no envía nada', () async {
        expect(await actions().save(22, '  \n '), isFalse);
        expect(adapter.requests, isEmpty);
      });

      test('un rechazo deja el error y no reintenta', () async {
        adapter.on(
          'POST',
          '/patient-procedure-records/22/evolutions',
          status: 403,
          body: errorBody('No tiene permiso'),
        );
        expect(await actions().save(22, 'Texto'), isFalse);
        expect(
          container.read(evolutionActionsProvider).error,
          isA<ForbiddenException>(),
        );
        expect(
          adapter.callsTo('POST', '/patient-procedure-records/22/evolutions'),
          hasLength(1),
        );
      });

      test(
        'tras un timeout vuelve a consultar la lista por si sí se guardó',
        () async {
          adapter
            ..onError(
              'POST',
              '/patient-procedure-records/22/evolutions',
              DioExceptionType.receiveTimeout,
            )
            ..on(
              'GET',
              '/patient-procedure-records/22/evolutions',
              body: fixture('clinical/evolutions_response.json'),
            );
          final sub = container.listen(recordEvolutionsProvider(22), (_, _) {});
          addTearDown(sub.close);
          await container.read(recordEvolutionsProvider(22).future);

          expect(await actions().save(22, 'Texto'), isFalse);
          await container.read(recordEvolutionsProvider(22).future);

          expect(
            adapter.callsTo('POST', '/patient-procedure-records/22/evolutions'),
            hasLength(1),
          );
          expect(
            adapter.callsTo('GET', '/patient-procedure-records/22/evolutions'),
            hasLength(2),
            reason: 'la lista se recargó',
          );
        },
      );
    });
  });
}
