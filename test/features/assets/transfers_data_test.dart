import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/signing/signoff.dart';
import 'package:sga_bojanini/features/assets/data/asset_transfer.dart';
import 'package:sga_bojanini/features/assets/data/transfers_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<AssetTransfer> _transfers() =>
    (fixture('assets/transfers_response.json')['data'] as List<dynamic>)
        .map((e) => AssetTransfer.fromJson(e as Json))
        .toList();

void main() {
  group('AssetTransfer (contrato)', () {
    test('traslado pendiente de firma', () {
      final transfer = _transfers().first;
      expect(transfer.status, TransferStatus.pendingSignature);
      expect(transfer.isPending, isTrue);
      expect(transfer.requiresSignature, isTrue);
      expect(transfer.asset?.name, 'Monitor de signos vitales');
      expect(transfer.externalDestination, 'Clínica Aliada');
      expect(transfer.expectedReturnDate, '2026-12-15');
      expect(transfer.signatures, isEmpty);
    });

    test('traslado confirmado con sus firmas', () {
      final transfer = _transfers().last;
      expect(transfer.status, TransferStatus.confirmed);
      expect(transfer.isPending, isFalse);
      expect(transfer.signatures.map((s) => s.role), [
        'delivered_by',
        'received_by',
      ]);
      expect(transfer.signatures.last.method, 'pin');
      expect(transfer.toResponsible?.name, 'Usuario Prueba');
    });

    test('estado desconocido y campos ausentes no rompen', () {
      final transfer = AssetTransfer.fromJson({'id': 1, 'status': 'otro'});
      expect(transfer.status, TransferStatus.unknown);
      expect(transfer.asset, isNull);
      expect(transfer.signatures, isEmpty);
    });
  });

  group('TransferType', () {
    test('en las instalaciones: no admite devolución', () {
      expect(TransferType.allowedFor(isOffPremises: false), [
        TransferType.relocation,
        TransferType.externalRepair,
        TransferType.loan,
        TransferType.retirement,
      ]);
    });

    test('fuera de las instalaciones: solo devolución o baja', () {
      expect(TransferType.allowedFor(isOffPremises: true), [
        TransferType.returnToSite,
        TransferType.retirement,
      ]);
    });
  });

  group('TransferRequest', () {
    test('solo envía los campos con valor', () {
      expect(
        const TransferRequest(
          type: TransferType.relocation,
          toPlaceId: 5,
          reason: '   ',
        ).toJson(),
        {'type': 'relocation', 'to_place_id': 5},
      );
      expect(
        const TransferRequest(
          type: TransferType.loan,
          externalDestination: ' Clínica Aliada ',
          expectedReturnDate: '2026-12-15',
          reason: 'Evento',
        ).toJson(),
        {
          'type': 'loan',
          'external_destination': 'Clínica Aliada',
          'expected_return_date': '2026-12-15',
          'reason': 'Evento',
        },
      );
    });
  });

  group('TransfersRepository', () {
    late FakeHttpAdapter adapter;
    late TransfersRepository repository;

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
      repository = container.read(transfersRepositoryProvider);
    });

    test('lista con filtro de estado', () async {
      adapter.on(
        'GET',
        '/assets/transfers',
        body: fixture('assets/transfers_response.json'),
      );
      final page = await repository.list(
        status: TransferStatus.pendingSignature,
      );
      expect(page.items, hasLength(2));
      expect(
        adapter.callsTo('GET', '/assets/transfers').single.queryParameters,
        {
          'status': 'pending_signature',
          'page': 1,
          'per_page': 25,
        },
      );
    });

    test('solicitar envía el tipo y devuelve el traslado', () async {
      adapter.on(
        'POST',
        '/assets/7/transfers',
        status: 201,
        body: fixture('assets/transfer_requested_pending_response.json'),
      );
      final transfer = await repository.request(
        7,
        const TransferRequest(
          type: TransferType.loan,
          externalDestination: 'Clínica Aliada',
        ),
      );
      expect(transfer.isPending, isTrue);
      expect(adapter.callsTo('POST', '/assets/7/transfers').single.data, {
        'type': 'loan',
        'external_destination': 'Clínica Aliada',
      });
    });

    test('confirmar usa el mismo formato de firmas que inventario', () async {
      adapter.on(
        'POST',
        '/assets/transfers/12/confirm',
        body: fixture('assets/transfer_confirmed_response.json'),
      );
      await repository.confirm(
        12,
        const ConfirmRequest(receivedBy: PinReceiver('123')),
      );
      await repository.confirm(
        12,
        const ConfirmRequest(
          receivedBy: ExternalReceiver(
            ExternalSigner(
              name: 'María',
              document: '123',
              signature: 'data:image/png;base64,AAA',
            ),
          ),
          deliveredBy: ExternalSigner(
            name: 'Pedro',
            document: '456',
            signature: 'data:image/png;base64,BBB',
          ),
        ),
      );
      final calls = adapter.callsTo('POST', '/assets/transfers/12/confirm');
      expect(calls.first.data, {
        'received_by': {'pin': '123'},
      });
      expect((calls.last.data as Map)['delivered_by'], {
        'name': 'Pedro',
        'document': '456',
        'signature': 'data:image/png;base64,BBB',
      });
    });

    test(
      'cancelar envía el motivo; 409 llega tipado y sin reintentos',
      () async {
        adapter
          ..on(
            'POST',
            '/assets/transfers/12/cancel',
            body: fixture('assets/transfer_confirmed_response.json'),
          )
          ..on(
            'POST',
            '/assets/transfers/99/cancel',
            status: 409,
            body: errorBody('El traslado ya no está pendiente.'),
          )
          ..onError(
            'POST',
            '/assets/transfers/98/cancel',
            DioExceptionType.receiveTimeout,
          );
        await repository.cancel(12, ' Ya no se necesita ');
        expect(
          adapter.callsTo('POST', '/assets/transfers/12/cancel').single.data,
          {
            'reason': 'Ya no se necesita',
          },
        );
        await expectLater(
          repository.cancel(99, 'x'),
          throwsA(isA<BusinessRuleException>()),
        );
        await expectLater(
          repository.cancel(98, 'x'),
          throwsA(isA<NetworkException>()),
        );
        expect(
          adapter.callsTo('POST', '/assets/transfers/98/cancel'),
          hasLength(1),
        );
      },
    );

    test('detalle y acta en PDF', () async {
      adapter
        ..on(
          'GET',
          '/assets/transfers/12',
          body: fixture('assets/transfer_pending_response.json'),
        )
        ..onBytes('GET', '/assets/transfers/12/act', [9, 8, 7]);
      expect((await repository.get(12)).isPending, isTrue);
      expect(await repository.act(12), [9, 8, 7]);
    });
  });
}
