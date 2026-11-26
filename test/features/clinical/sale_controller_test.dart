import 'dart:convert';

import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/clinical/application/sale_controller.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

const _path = '/patient-procedure-records';

List<ProcedureMatch> _procedures() =>
    (fixture('clinical/procedures_response.json')['data'] as List<dynamic>)
        .map((e) => ProcedureMatch.fromJson(e as Json))
        .toList();

const _patient = MedsysPatient(
  code: 'P00001',
  document: '1000000001',
  name: 'ANA  MARIA PEREZ GOMEZ ',
);

void main() {
  late FakeHttpAdapter adapter;
  late ProviderContainer container;
  late SaleNotifier sale;

  SaleState state() => container.read(saleProvider);

  setUp(() async {
    adapter = FakeHttpAdapter();
    container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: InMemoryTokenStore(),
        // 26/11/2026 02:00 a. m. en Colombia = 07:00 UTC.
        clock: TestClock(DateTime.utc(2026, 11, 26, 7)),
      ),
    );
    addTearDown(container.dispose);
    // Mientras haya envíos, el estado debe mantenerse vivo.
    container.listen(saleProvider, (_, _) {});
    sale = container.read(saleProvider.notifier);
  });

  void fill({int lines = 2}) {
    sale
      ..setPatient(_patient)
      ..setSeller('Vendedor Prueba')
      ..setReferrer('Remitente Prueba');
    final procedures = _procedures();
    for (var i = 0; i < lines; i++) {
      sale.addLine(procedures[i % procedures.length]);
    }
    // El servicio sin tarifa necesita un valor escrito.
    for (final line in state().lines.where((l) => l.unitPrice == null)) {
      sale.setUnitPrice(line.key, 150000);
    }
  }

  Map<String, dynamic> bodyOf(int call) =>
      adapter.callsTo('POST', _path).elementAt(call).data
          as Map<String, dynamic>;

  group('armado de la venta', () {
    test('la fecha de atención inicia en el día de hoy de Colombia', () {
      expect(state().serviceDate, DateTime(2026, 11, 26));
    });

    test('al agregar un servicio toma la tarifa vigente como valor', () {
      sale.addLine(_procedures().first);
      final line = state().lines.single;
      expect(line.quantity, 1);
      expect(line.unitPrice, 50000);
      expect(line.subtotal, 50000);
    });

    test('un servicio sin tarifa queda sin valor hasta escribirlo', () {
      sale.addLine(_procedures().last);
      expect(state().lines.single.unitPrice, isNull);
      expect(state().lines.single.isValid, isFalse);
    });

    test('el total suma cantidad por valor de cada línea', () {
      fill();
      sale.setQuantity(state().lines.first.key, 3);
      expect(state().total, 3 * 50000 + 150000);
    });

    test('quitar una línea no afecta a las demás', () {
      fill();
      final first = state().lines.first.key;
      sale.removeLine(first);
      expect(state().lines.map((l) => l.key), isNot(contains(first)));
      expect(state().lines, hasLength(1));
    });
  });

  group('cuándo se puede enviar', () {
    final today = DateTime(2026, 11, 26);

    test('con todo completo sí', () {
      fill();
      expect(state().canSubmit(today), isTrue);
    });

    test('sin paciente, vendedor, remitente o servicios no', () {
      expect(state().canSubmit(today), isFalse);
      fill();
      sale.setSeller('   ');
      expect(state().canSubmit(today), isFalse);
      sale
        ..setSeller('V')
        ..setReferrer('');
      expect(state().canSubmit(today), isFalse);
    });

    test('cantidad cero o valor vacío no', () {
      fill();
      sale.setQuantity(state().lines.first.key, 0);
      expect(state().canSubmit(today), isFalse);
      sale
        ..setQuantity(state().lines.first.key, 1)
        ..setUnitPrice(state().lines.first.key, null);
      expect(state().canSubmit(today), isFalse);
    });

    test('una fecha futura no', () {
      fill();
      sale.setServiceDate(DateTime(2026, 11, 27));
      expect(state().canSubmit(today), isFalse);
    });
  });

  group('envío', () {
    test(
      'un POST por servicio, con nombres separados y fecha de hoy',
      () async {
        adapter.on(
          'POST',
          _path,
          body: fixture('clinical/record_response.json'),
        );
        fill();

        final done = await sale.submit();

        expect(done, isTrue);
        expect(adapter.callsTo('POST', _path), hasLength(2));
        expect(bodyOf(0), {
          'medical_service_id': 3,
          'patient_external_id': 'P00001',
          'patient_document': '1000000001',
          'patient_first_name': 'ANA MARIA',
          'patient_last_name': 'PEREZ GOMEZ',
          'quantity': 1,
          'unit_price': 50000.0,
          'service_date': '2026-11-26',
          'seller': 'Vendedor Prueba',
          'referrer': 'Remitente Prueba',
        });
        expect(state().isComplete, isTrue);
        expect(state().isSubmitting, isFalse);
      },
    );

    test(
      'si una línea falla se detiene; lo registrado no se reenvía',
      () async {
        adapter
          ..on('POST', _path, body: fixture('clinical/record_response.json'))
          ..on(
            'POST',
            _path,
            status: 422,
            body: errorBody(
              'La fecha no puede ser futura.',
              extra: {
                'errors': {
                  'service_date': ['La fecha no puede ser futura.'],
                },
              },
            ),
          );
        fill(lines: 3);

        final done = await sale.submit();

        expect(done, isFalse);
        expect(
          state().lines.map((l) => l.status),
          [SaleLineStatus.saved, SaleLineStatus.failed, SaleLineStatus.draft],
        );
        expect(state().lines[1].error, isA<ValidationException>());
        expect(
          adapter.callsTo('POST', _path),
          hasLength(2),
          reason: 'la tercera ni se intentó',
        );

        // Corregido el problema, solo se envían la fallida y la pendiente.
        adapter.on(
          'POST',
          _path,
          body: fixture('clinical/record_response.json'),
        );
        final retried = await sale.submit();

        expect(retried, isTrue);
        expect(adapter.callsTo('POST', _path), hasLength(4));
        expect(state().isComplete, isTrue);
      },
    );

    test('lo ya registrado no se puede quitar ni editar', () async {
      adapter
        ..on('POST', _path, body: fixture('clinical/record_response.json'))
        ..on('POST', _path, status: 500, body: errorBody('Error interno'));
      fill();
      await sale.submit();
      final saved = state().lines.first;

      sale
        ..removeLine(saved.key)
        ..setQuantity(saved.key, 9);

      expect(state().lines.first.status, SaleLineStatus.saved);
      expect(state().lines.first.quantity, 1);
      expect(state().hasSaved, isTrue);
    });

    test(
      'sin respuesta (timeout): queda sin confirmar y no se reenvía sola',
      () async {
        adapter.onError('POST', _path, DioExceptionType.receiveTimeout);
        fill(lines: 1);

        await sale.submit();

        expect(state().lines.single.status, SaleLineStatus.unconfirmed);
        expect(state().canSubmit(DateTime(2026, 11, 26)), isFalse);
        expect(await sale.submit(), isFalse);
        expect(
          adapter.callsTo('POST', _path),
          hasLength(1),
          reason: 'jamás se reintenta automáticamente',
        );
      },
    );

    test(
      'tras revisar el historial, la línea sin confirmar se puede reenviar',
      () async {
        adapter
          ..onError('POST', _path, DioExceptionType.receiveTimeout)
          ..on('POST', _path, body: fixture('clinical/record_response.json'));
        fill(lines: 1);
        await sale.submit();

        sale.markAsNotRegistered(state().lines.single.key);

        expect(state().lines.single.status, SaleLineStatus.draft);
        expect(await sale.submit(), isTrue);
        expect(adapter.callsTo('POST', _path), hasLength(2));
      },
    );

    test('un envío en curso bloquea otro simultáneo', () async {
      adapter.on(
        'POST',
        _path,
        body: fixture('clinical/record_response.json'),
      );
      fill(lines: 1);

      final first = sale.submit();
      final second = await sale.submit();
      await first;

      expect(second, isFalse);
      expect(adapter.callsTo('POST', _path), hasLength(1));
    });

    test('sin conexión: la línea falla y puede reenviarse', () async {
      adapter
        ..onSocketFailure('POST', _path)
        ..on('POST', _path, body: fixture('clinical/record_response.json'));
      fill(lines: 1);

      await sale.submit();
      expect(state().lines.single.status, SaleLineStatus.failed);
      expect(
        (state().lines.single.error! as NetworkException).kind,
        NetworkFailureKind.noConnection,
      );

      expect(await sale.submit(), isTrue);
    });

    test('envía números, no texto (cantidad entera y valor decimal)', () async {
      adapter.on(
        'POST',
        _path,
        body: fixture('clinical/record_response.json'),
      );
      fill(lines: 1);
      await sale.submit();
      expect(jsonEncode(bodyOf(0)), contains('"quantity":1'));
      expect(jsonEncode(bodyOf(0)), contains('"unit_price":50000.0'));
    });
  });
}
