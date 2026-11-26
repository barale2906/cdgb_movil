import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';
import 'package:sga_bojanini/features/clinical/data/sale_request.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

MedsysPatient _named(String name) =>
    MedsysPatient(code: 'P1', document: '1', name: name);

void main() {
  group('ProcedureMatch (contrato)', () {
    final matches =
        (fixture('clinical/procedures_response.json')['data'] as List<dynamic>)
            .map((e) => ProcedureMatch.fromJson(e as Json))
            .toList();

    test('lee código, nombre y la tarifa vigente escrita como texto', () {
      expect(matches.first.code, 'CUR-001');
      expect(matches.first.name, 'Curaciones simples');
      expect(matches.first.unitPrice, 50000);
    });

    test('sin tarifa vigente no hay precio', () {
      expect(matches.last.currentPrice, isNull);
      expect(matches.last.unitPrice, isNull);
    });
  });

  group('MedsysPatient.splitName', () {
    test('4 palabras: dos nombres y dos apellidos', () {
      final names = _named('ANA MARIA PEREZ GOMEZ').splitName;
      expect(names.first, 'ANA MARIA');
      expect(names.last, 'PEREZ GOMEZ');
    });

    test('más de 4 palabras: los dos primeros son nombres', () {
      final names = _named('JUAN CARLOS DE LA CRUZ').splitName;
      expect(names.first, 'JUAN CARLOS');
      expect(names.last, 'DE LA CRUZ');
    });

    test('3 palabras: un nombre y dos apellidos', () {
      final names = _named('LUIS RAMIREZ SOTO').splitName;
      expect(names.first, 'LUIS');
      expect(names.last, 'RAMIREZ SOTO');
    });

    test('2 palabras: nombre y apellido', () {
      final names = _named('LUIS RAMIREZ').splitName;
      expect(names.first, 'LUIS');
      expect(names.last, 'RAMIREZ');
    });

    test('una sola palabra: todo es el nombre', () {
      final names = _named('LUIS').splitName;
      expect(names.first, 'LUIS');
      expect(names.last, isEmpty);
    });

    test('ignora espacios dobles y sobrantes de MedSys', () {
      final names = _named(' ANA  MARIA PEREZ  GOMEZ ').splitName;
      expect(names.first, 'ANA MARIA');
      expect(names.last, 'PEREZ GOMEZ');
    });
  });

  group('SaleRecordRequest', () {
    test('arma el cuerpo con las claves del servidor', () {
      const request = SaleRecordRequest(
        medicalServiceId: 3,
        patientExternalId: 'P1',
        patientDocument: '100',
        patientFirstName: 'Ana',
        patientLastName: 'Pérez',
        quantity: 2,
        unitPrice: 50000,
        serviceDate: '2026-11-26',
        seller: 'V',
        referrer: 'R',
      );
      expect(request.toJson(), {
        'medical_service_id': 3,
        'patient_external_id': 'P1',
        'patient_document': '100',
        'patient_first_name': 'Ana',
        'patient_last_name': 'Pérez',
        'quantity': 2,
        'unit_price': 50000.0,
        'service_date': '2026-11-26',
        'seller': 'V',
        'referrer': 'R',
      });
    });
  });

  group('ClinicalRepository (venta)', () {
    late FakeHttpAdapter adapter;
    late ClinicalRepository repository;

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
      repository = container.read(clinicalRepositoryProvider);
    });

    test('crear el registro devuelve lo guardado y envía el cuerpo', () async {
      adapter.on(
        'POST',
        '/patient-procedure-records',
        status: 201,
        body: fixture('clinical/record_response.json'),
      );
      const request = SaleRecordRequest(
        medicalServiceId: 4,
        patientExternalId: 'P00002',
        patientDocument: '1000000002',
        patientFirstName: 'Luis',
        patientLastName: 'Ramírez',
        quantity: 1,
        unitPrice: 150000,
        serviceDate: '2026-11-23',
        seller: 'V',
        referrer: 'R',
      );

      final record = await repository.createRecord(request);

      expect(record.id, 22);
      expect(
        adapter.callsTo('POST', '/patient-procedure-records').single.data,
        request.toJson(),
      );
    });

    test('422 llega con los errores por campo', () async {
      adapter.on(
        'POST',
        '/patient-procedure-records',
        status: 422,
        body: errorBody(
          'Datos inválidos',
          extra: {
            'errors': {
              'service_date': ['No puede ser una fecha futura.'],
            },
          },
        ),
      );
      const request = SaleRecordRequest(
        medicalServiceId: 4,
        patientExternalId: 'P',
        patientDocument: '1',
        patientFirstName: 'A',
        patientLastName: 'B',
        quantity: 1,
        unitPrice: 1,
        serviceDate: '2099-01-01',
        seller: 'V',
        referrer: 'R',
      );
      await expectLater(
        repository.createRecord(request),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.firstErrorFor('service_date'),
            'service_date',
            'No puede ser una fecha futura.',
          ),
        ),
      );
    });
  });
}
