import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/clinical/clinical_lookup.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  late FakeHttpAdapter adapter;
  late ProviderContainer container;
  late ClinicalLookupRepository repository;

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
    repository = container.read(clinicalLookupRepositoryProvider);
  });

  group('pacientes de MedSys', () {
    test('busca por texto y lee `data.patients`', () async {
      adapter.on(
        'GET',
        '/medsys/patients',
        body: fixture('clinical/patients_response.json'),
      );
      final patients = await repository.searchPatients('1000000001');
      expect(patients, hasLength(2));
      expect(
        adapter.callsTo('GET', '/medsys/patients').single.queryParameters,
        {'search': '1000000001'},
      );
    });

    test('paciente no encontrado (404) llega como NotFoundException', () async {
      adapter.on(
        'GET',
        '/medsys/patients',
        status: 404,
        body: errorBody('Paciente no encontrado'),
      );
      await expectLater(
        repository.searchPatients('9999999'),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('el proveedor no consulta con menos de 3 caracteres', () async {
      final result = await container.read(patientSearchProvider('an').future);
      expect(result, isEmpty);
      expect(adapter.callsTo('GET', '/medsys/patients'), isEmpty);
    });

    test('el proveedor consulta desde 3 caracteres', () async {
      adapter.on(
        'GET',
        '/medsys/patients',
        body: fixture('clinical/patients_response.json'),
      );
      final result = await container.read(patientSearchProvider('ana').future);
      expect(result, hasLength(2));
    });
  });

  group('procedimientos', () {
    test('busca con el texto en `q` y trae la tarifa vigente', () async {
      adapter.on(
        'GET',
        '/medical-services/search',
        body: fixture('clinical/procedures_response.json'),
      );
      final matches = await repository.searchProcedures('cur');
      expect(matches, hasLength(2));
      expect(matches.first.unitPrice, 50000);
      expect(
        adapter
            .callsTo('GET', '/medical-services/search')
            .single
            .queryParameters,
        {'q': 'cur'},
      );
    });

    test('el proveedor no consulta con menos de 2 caracteres', () async {
      final result = await container.read(procedureSearchProvider('c').future);
      expect(result, isEmpty);
      expect(adapter.callsTo('GET', '/medical-services/search'), isEmpty);
    });
  });
}
