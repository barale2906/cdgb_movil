import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/auth_token_provider.dart';
import 'package:sga_bojanini/core/auth/my_signature.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/core/signing/signoff.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_repository.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  late FakeHttpAdapter adapter;
  late ProviderContainer container;
  late InventoryRepository repository;

  setUp(() async {
    adapter = FakeHttpAdapter();
    container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: InMemoryTokenStore(),
        clock: TestClock(DateTime(2026, 11, 24)),
      ),
    );
    addTearDown(container.dispose);
    repository = container.read(inventoryRepositoryProvider);
  });

  group('lecturas', () {
    test('stock pagina por almacén', () async {
      adapter.on(
        'GET',
        '/stock',
        body: fixture('inventory/stock_response.json'),
      );
      final page = await repository.stock(warehouseId: 1, page: 2);

      expect(page.items, hasLength(2));
      expect(page.meta.hasMore, isTrue);
      expect(adapter.callsTo('GET', '/stock').single.queryParameters, {
        'warehouse_id': 1,
        'page': 2,
        'per_page': 25,
      });
    });

    test('lotes: filtros opcionales solo si se indican', () async {
      adapter.on(
        'GET',
        '/batches',
        body: fixture('inventory/batches_response.json'),
      );
      await repository.batches(const BatchQuery());
      await repository.batches(
        const BatchQuery(warehouseId: 1, status: BatchStatus.expired),
      );

      final calls = adapter.callsTo('GET', '/batches').toList();
      expect(calls.first.queryParameters.containsKey('warehouse_id'), isFalse);
      expect(calls.first.queryParameters.containsKey('status'), isFalse);
      expect(calls.last.queryParameters['status'], 'expired');
      expect(calls.last.queryParameters['warehouse_id'], 1);
    });

    test('por vencer, vencidos y lotes de un producto', () async {
      adapter
        ..on(
          'GET',
          '/batches/expiring',
          body: fixture('inventory/batches_response.json'),
        )
        ..on(
          'GET',
          '/batches/expired',
          body: fixture('inventory/batches_response.json'),
        )
        ..on(
          'GET',
          '/generic-products/5/batches',
          body: fixture('inventory/batches_response.json'),
        );

      expect(await repository.expiringBatches(), hasLength(2));
      expect(await repository.expiredBatches(), hasLength(2));
      await repository.productBatches(
        5,
        warehouseId: 1,
        availableForExit: true,
      );
      expect(
        adapter
            .callsTo('GET', '/generic-products/5/batches')
            .single
            .queryParameters,
        {'warehouse_id': 1, 'available_for_exit': true},
      );
    });

    test('comprobantes: filtro de estado con el valor del backend', () async {
      adapter.on(
        'GET',
        '/movement-documents',
        body: envelope(<dynamic>[], message: 'x')
          ..['meta'] = {
            'current_page': 1,
            'last_page': 1,
            'per_page': 25,
            'total': 0,
          },
      );
      await repository.documents(
        const DocumentQuery(
          warehouseId: 1,
          status: DocumentStatus.pendingSignature,
        ),
      );
      expect(
        adapter
            .callsTo('GET', '/movement-documents')
            .single
            .queryParameters['status'],
        'pending_signature',
      );
    });

    test('centros de costo y presentaciones', () async {
      adapter.on(
        'GET',
        '/cost-centers',
        body: fixture('inventory/cost_centers_response.json'),
      );
      final centers = await repository.costCenters();
      expect(centers.last.isExternal, isTrue);
    });
  });

  group('escrituras', () {
    test('entrada: envía el cuerpo y devuelve el comprobante', () async {
      adapter.on(
        'POST',
        '/movements/entry',
        status: 201,
        body: fixture('inventory/document_response.json'),
      );
      final document = await repository.registerEntry(
        EntryRequest(
          warehouseId: 1,
          items: [
            EntryItem(
              productVariantId: 50,
              locationId: 100,
              lotNumber: 'L1',
              expirationDate: DateTime(2027),
              quantityBase: 4,
            ),
          ],
        ),
      );
      expect(document.documentNumber, 'SAL-2026-000123');
      final body =
          adapter.callsTo('POST', '/movements/entry').single.data as Map;
      expect(body['warehouse_id'], 1);
    });

    test('ajuste devuelve la línea suelta', () async {
      adapter.on(
        'POST',
        '/movements/adjustment',
        status: 201,
        body: fixture('inventory/line_response.json'),
      );
      final line = await repository.registerAdjustment(
        const AdjustmentRequest(
          productVariantId: 50,
          warehouseId: 1,
          locationId: 100,
          quantity: 5,
          reason: 'Conteo físico',
        ),
      );
      expect(line.movementType, 'adjustment');
      expect(line.quantity, 5);
    });

    test('lote vencido: 409 con error_code EXPIRED_STOCK', () async {
      adapter.on(
        'POST',
        '/movements/exit',
        status: 409,
        body: errorBody(
          'No se puede mover stock de un lote vencido.',
          extra: {'error_code': 'EXPIRED_STOCK'},
        ),
      );
      await expectLater(
        repository.registerExit(
          const ExitRequest(
            warehouseId: 1,
            costCenterId: 4,
            items: [ExitItem(genericProductId: 5, quantity: 1, batchId: 71)],
          ),
        ),
        throwsA(
          isA<BusinessRuleException>().having(
            (e) => e.errorCode,
            'errorCode',
            'EXPIRED_STOCK',
          ),
        ),
      );
    });

    test('un timeout en una escritura se informa, no se reintenta', () async {
      adapter.onError(
        'POST',
        '/movements/transfer',
        DioExceptionType.receiveTimeout,
      );
      await expectLater(
        repository.registerTransfer(
          const TransferRequest(
            warehouseFromId: 1,
            warehouseToId: 2,
            items: [
              TransferItem(
                productVariantId: 50,
                locationToId: 200,
                quantity: 1,
              ),
            ],
          ),
        ),
        throwsA(isA<NetworkException>()),
      );
      expect(adapter.callsTo('POST', '/movements/transfer'), hasLength(1));
    });

    test('confirmar: PIN inválido llega como 422 en received_by.pin', () async {
      adapter.on(
        'POST',
        '/movement-documents/900/confirm',
        status: 422,
        body: errorBody(
          'PIN inválido',
          extra: {
            'errors': {
              'received_by.pin': ['El PIN no es válido.'],
            },
          },
        ),
      );
      await expectLater(
        repository.confirm(
          900,
          const ConfirmRequest(receivedBy: PinReceiver('000')),
        ),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.firstErrorFor('received_by.pin'),
            'pin',
            'El PIN no es válido.',
          ),
        ),
      );
    });

    test('confirmar: 429 por PIN bloqueado y 409 por misma persona', () async {
      adapter
        ..on(
          'POST',
          '/movement-documents/1/confirm',
          status: 429,
          body: errorBody('Demasiados intentos.'),
        )
        ..on(
          'POST',
          '/movement-documents/2/confirm',
          status: 409,
          body: errorBody(
            'Quien entrega y quien recibe no pueden ser la misma persona.',
          ),
        );
      await expectLater(
        repository.confirm(
          1,
          const ConfirmRequest(receivedBy: PinReceiver('111')),
        ),
        throwsA(isA<RateLimitedException>()),
      );
      await expectLater(
        repository.confirm(
          2,
          const ConfirmRequest(receivedBy: PinReceiver('111')),
        ),
        throwsA(isA<BusinessRuleException>()),
      );
    });

    test('cancelar pendiente y enviar por correo', () async {
      adapter
        ..on('DELETE', '/movement-documents/900/pending', body: envelope(null))
        ..on(
          'POST',
          '/movement-documents/900/send-email',
          body: envelope(null),
        );
      await repository.cancelPending(900);
      await repository.sendEmail(900, ['a@example.com']);
      expect(
        (adapter
                .callsTo('POST', '/movement-documents/900/send-email')
                .single
                .data
            as Map)['recipients'],
        ['a@example.com'],
      );
    });
  });

  group('binarios y firma', () {
    test('pdf pide bytes con el Bearer', () async {
      container.read(authTokenProvider.notifier).replace('tok');
      adapter.onBytes('GET', '/movement-documents/900/pdf', [37, 80, 68, 70]);
      final bytes = await repository.pdf(900);
      expect(bytes, [37, 80, 68, 70]);
      expect(
        adapter
            .callsTo('GET', '/movement-documents/900/pdf')
            .single
            .headers['Authorization'],
        'Bearer tok',
      );
    });

    test('imagen de firma por rol', () async {
      adapter.on(
        'GET',
        '/movement-documents/900/signature/received_by',
        body: envelope({
          'role': 'received_by',
          'signature_data': 'data:image/png;base64,AA',
        }),
      );
      expect(
        await repository.signatureImage(900, 'received_by'),
        'data:image/png;base64,AA',
      );
    });
  });

  group('Mi firma', () {
    test('fetch: null si no hay firma; objeto si la hay', () async {
      final repo = container.read(mySignatureRepositoryProvider);
      adapter.on(
        'GET',
        '/auth/me/signature',
        body: fixture('inventory/signature_none_response.json'),
      );
      expect(await repo.fetch(), isNull);
      adapter.on(
        'GET',
        '/auth/me/signature',
        body: fixture('inventory/signature_response.json'),
      );
      expect((await repo.fetch())?.documentNumber, '1000000001');
    });

    test(
      'save: el primer registro devuelve el PIN; no se manda el id de usuario',
      () async {
        adapter.on(
          'PUT',
          '/auth/me/signature',
          status: 201,
          body: fixture('inventory/signature_saved_response.json'),
        );
        final result = await container
            .read(mySignatureRepositoryProvider)
            .save(
              currentPassword: 'secreto123',
              documentType: 'CC',
              documentNumber: '1000000001',
              signature: 'data:image/png;base64,AA',
            );
        expect(result.pin, '482');
        final body =
            adapter.callsTo('PUT', '/auth/me/signature').single.data as Map;
        expect(
          body.keys,
          containsAll([
            'current_password',
            'document_type',
            'document_number',
            'signature',
          ]),
        );
        expect(jsonEncode(body).contains('user_id'), isFalse);
      },
    );

    test('regeneratePin: 409 si aún no tiene firma', () async {
      adapter.on(
        'POST',
        '/auth/me/signature/pin',
        status: 409,
        body: errorBody('Primero registre su firma.'),
      );
      await expectLater(
        container.read(mySignatureRepositoryProvider).regeneratePin('x'),
        throwsA(isA<BusinessRuleException>()),
      );
    });
  });
}
