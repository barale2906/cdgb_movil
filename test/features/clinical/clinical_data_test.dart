import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';
import 'package:sga_bojanini/features/clinical/data/medsys_patient.dart';
import 'package:sga_bojanini/features/clinical/data/procedure_record.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<ProcedureRecord> _records() =>
    (fixture('clinical/records_response.json')['data'] as List<dynamic>)
        .map((e) => ProcedureRecord.fromJson(e as Json))
        .toList();

void main() {
  group('MedsysPatient (contrato)', () {
    final patients =
        ((fixture('clinical/patients_response.json')['data']
                    as Json)['patients']
                as List<dynamic>)
            .map((e) => MedsysPatient.fromJson(e as Json))
            .toList();

    test('lee código, documento y nombre con las claves de MedSys', () {
      final patient = patients.first;
      expect(patient.code, 'P00001');
      expect(patient.document, '1000000001');
      expect(patient.documentType, 'CC');
    });

    test('el nombre se muestra sin espacios dobles ni sobrantes', () {
      expect(patients.first.displayName, 'ANA MARIA PEREZ GOMEZ');
    });

    test('lee las últimas citas; sin citas queda la lista vacía', () {
      final appointment = patients.first.recentAppointments.single;
      expect(appointment.controlCode, 'C0001');
      expect(appointment.serviceName, 'Dermatología');
      expect(appointment.status, 'Confirmada');
      expect(patients.last.recentAppointments, isEmpty);
    });

    test('no conserva datos de contacto (mínimo necesario)', () {
      expect(patients.first.toJson().keys, isNot(contains('email')));
    });
  });

  group('MedsysAppointment (contrato)', () {
    test('ignora el mapeo a servicios de SGA y lee fecha y hora', () {
      final items =
          (fixture('clinical/appointments_response.json')['data']
                  as List<dynamic>)
              .map((e) => MedsysAppointment.fromJson(e as Json))
              .toList();
      expect(items, hasLength(2));
      expect(items.first.date, '2026-11-27');
      expect(items.first.time, '09:00:00');
    });
  });

  group('ProcedureRecord (contrato)', () {
    test('importes en texto o número se leen como decimales', () {
      final records = _records();
      expect(records[0].quantity, 2);
      expect(records[0].total, 100000);
      expect(records[1].unitPrice, 150000, reason: 'llega como número');
      expect(records[1].netTotal, 135000, reason: 'llega como texto');
    });

    test('el nombre del paciente une nombres y apellidos', () {
      expect(_records().first.patientName, 'Ana María Pérez Gómez');
    });

    test('el descuento solo cuenta si el valor es mayor que cero', () {
      final records = _records();
      expect(records[0].hasDiscount, isFalse);
      expect(records[1].hasDiscount, isTrue);
    });

    test('estado de facturación y actividad', () {
      final records = _records();
      expect(records[0].billingStatus, isNull);
      expect(records[1].billingStatus, 'billed');
      expect(records[2].billingStatus, 'cancelled');
      expect(records[2].isActive, isFalse);
    });

    test('un registro mínimo no rompe el parseo', () {
      final record = ProcedureRecord.fromJson({
        'id': 1,
        'patient_external_id': 'P1',
        'patient_document': '1',
        'patient_first_name': 'A',
        'patient_last_name': 'B',
      });
      expect(record.total, isNull);
      expect(record.isActive, isTrue);
    });
  });

  group('PatientHistory (contrato)', () {
    final history = PatientHistory.fromJson(
      fixture('clinical/history_response.json')['data'] as Json,
    );

    test('lee el resumen', () {
      expect(history.summary.totalRecords, 2);
      expect(history.summary.totalAmount, 200000);
      expect(history.summary.firstServiceDate, '2026-11-20');
      expect(history.patientName, 'Luis Ramírez');
    });

    test('lee las líneas del historial', () {
      expect(history.records, hasLength(2));
      expect(history.records.first.procedureName, 'Consulta dermatología');
      expect(history.records.last.isActive, isFalse);
    });
  });

  group('ClinicalRepository', () {
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

    test('busca pacientes por texto y lee `data.patients`', () async {
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

    test('citas: el código del paciente va en la ruta y se codifica', () async {
      adapter.on(
        'GET',
        '/medsys/patients/P%2F1/appointments',
        body: fixture('clinical/appointments_response.json'),
      );
      expect(await repository.appointments('P/1'), hasLength(2));
    });

    test('registros: envía fechas y documento solo si hay', () async {
      adapter.on(
        'GET',
        '/patient-procedure-records',
        body: fixture('clinical/records_response.json'),
      );
      await repository.records(
        const RecordsQuery(dateFrom: '2026-10-27', dateTo: '2026-11-26'),
      );
      await repository.records(
        const RecordsQuery(
          dateFrom: '2026-10-27',
          dateTo: '2026-11-26',
          document: '1000000002',
        ),
      );
      final calls = adapter
          .callsTo('GET', '/patient-procedure-records')
          .toList();
      expect(calls.first.queryParameters, {
        'service_date_from': '2026-10-27',
        'service_date_to': '2026-11-26',
      });
      expect(
        calls.last.queryParameters,
        containsPair('patient_document', '1000000002'),
      );
    });

    test('detalle del registro e historial del paciente', () async {
      adapter
        ..on(
          'GET',
          '/patient-procedure-records/22',
          body: fixture('clinical/record_response.json'),
        )
        ..on(
          'GET',
          '/patients/P00002/procedure-records',
          body: fixture('clinical/history_response.json'),
        );
      expect((await repository.record(22)).orderNumber, 'OS-2026-0007');
      expect((await repository.history('P00002')).records, hasLength(2));
    });

    test('403 sin permiso llega como ForbiddenException', () async {
      adapter.on(
        'GET',
        '/medsys/patients/P1/appointments',
        status: 403,
        body: errorBody('No tiene permiso'),
      );
      await expectLater(
        repository.appointments('P1'),
        throwsA(isA<ForbiddenException>()),
      );
    });
  });

  group('RecordsQuery', () {
    test('igualdad por valor (clave de caché del proveedor)', () {
      const a = RecordsQuery(dateFrom: '2026-10-01', dateTo: '2026-10-31');
      const b = RecordsQuery(dateFrom: '2026-10-01', dateTo: '2026-10-31');
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(
        a,
        isNot(
          const RecordsQuery(
            dateFrom: '2026-10-01',
            dateTo: '2026-10-31',
            document: '1',
          ),
        ),
      );
    });
  });
}
