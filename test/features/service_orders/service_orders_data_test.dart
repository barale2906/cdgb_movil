import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/service_orders/data/new_order_request.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';
import 'package:sga_bojanini/features/service_orders/data/service_orders_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

ServiceOrder _order(String file) =>
    ServiceOrder.fromJson(fixture('service_orders/$file')['data'] as Json);

void main() {
  group('ServiceOrder (contrato)', () {
    test('lee encabezado, totales y procedimientos', () {
      final order = _order('order_pending_response.json');
      expect(order.orderNumber, 'OS-20261124-000001');
      expect(order.patientName, 'Ana María Pérez Gómez');
      expect(order.totalAmount, 250000);
      expect(order.totalDiscount, 15000);
      expect(order.netTotal, 235000);
      expect(order.procedures, hasLength(2));
      expect(order.procedures.last.discountType, 'percentage');
      expect(order.procedures.last.discountValue, 10);
      expect(order.procedures.first.movementDocumentId, 501);
    });

    test('estados: descuento pendiente y aprobada', () {
      expect(
        _order('order_pending_response.json').orderStatus,
        ServiceOrderStatus.discountPending,
      );
      expect(
        _order('order_approved_response.json').orderStatus,
        ServiceOrderStatus.approved,
      );
    });

    test('un estado nuevo del servidor no rompe el parseo', () {
      expect(
        ServiceOrderStatus.parse('algo_nuevo'),
        ServiceOrderStatus.unknown,
      );
      expect(ServiceOrderStatus.parse(null), ServiceOrderStatus.unknown);
    });

    test('facturar: solo sin facturar y sin descuento pendiente', () {
      expect(_order('order_pending_response.json').canBill, isFalse);
      expect(_order('order_approved_response.json').canBill, isTrue);
      expect(_order('order_billed_response.json').canBill, isFalse);
      expect(_order('order_cancelled_response.json').canBill, isFalse);
    });

    test('anular: salvo que ya esté anulada', () {
      expect(_order('order_approved_response.json').canCancel, isTrue);
      expect(_order('order_billed_response.json').canCancel, isTrue);
      expect(_order('order_cancelled_response.json').canCancel, isFalse);
      expect(_order('order_billed_response.json').isBilled, isTrue);
    });
  });

  group('DiscountOrder (contrato)', () {
    test('suma los descuentos pendientes de sus registros', () {
      final orders =
          (fixture('service_orders/discounts_response.json')['data']
                  as List<dynamic>)
              .map((e) => DiscountOrder.fromJson(e as Json))
              .toList();
      expect(orders.single.orderNumber, 'OS-20261124-000001');
      expect(orders.single.patientName, 'Ana María Pérez Gómez');
      expect(orders.single.totalDiscount, 15000);
    });
  });

  group('NewOrderRequest', () {
    const line = OrderLineRequest(
      medicalServiceId: 3,
      quantity: 2,
      unitPrice: 50000,
    );

    NewOrderRequest request({
      List<OrderLineRequest> lines = const [line],
      String? seller,
      String? email = 'p@example.com',
    }) => NewOrderRequest(
      patientExternalId: 'P1',
      patientDocument: '100',
      patientFirstName: 'Ana',
      patientLastName: 'Pérez',
      patientEmail: email,
      serviceDate: '2026-11-26',
      seller: seller,
      lines: lines,
    );

    test('arma el cuerpo con las claves del servidor', () {
      expect(request(seller: ' V ').toJson(), {
        'patient_external_id': 'P1',
        'patient_document': '100',
        'patient_first_name': 'Ana',
        'patient_last_name': 'Pérez',
        'patient_email': 'p@example.com',
        'service_date': '2026-11-26',
        'seller': 'V',
        'procedures': [
          {'medical_service_id': 3, 'quantity': 2.0, 'unit_price': 50000.0},
        ],
      });
    });

    test('omite los textos opcionales vacíos o en blanco', () {
      final json = request(seller: '   ', email: null).toJson();
      expect(json.keys, isNot(contains('seller')));
      expect(json.keys, isNot(contains('patient_email')));
      expect(json.keys, isNot(contains('referrer')));
    });

    test('descuento e insumos solo si existen', () {
      final json = request(
        lines: const [
          OrderLineRequest(
            medicalServiceId: 4,
            quantity: 1,
            unitPrice: 150000,
            discountType: 'percentage',
            discountValue: 10,
            notes: '<p>Estable</p>',
            supplies: [
              SupplyRequest(
                warehouseId: 2,
                genericProductId: 9,
                quantity: 1.5,
              ),
            ],
          ),
          line,
        ],
      ).toJson();
      final procedures = json['procedures']! as List<Object>;
      expect(procedures.first, {
        'medical_service_id': 4,
        'quantity': 1.0,
        'unit_price': 150000.0,
        'discount_type': 'percentage',
        'discount_value': 10.0,
        'notes': '<p>Estable</p>',
        'supplies': [
          {'warehouse_id': 2, 'generic_product_id': 9, 'quantity': 1.5},
        ],
      });
      final plain = (procedures.last as Map).keys;
      expect(plain, isNot(contains('discount_type')));
      expect(plain, isNot(contains('supplies')));
    });
  });

  group('ServiceOrdersRepository', () {
    late FakeHttpAdapter adapter;
    late ServiceOrdersRepository repository;

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
      repository = container.read(serviceOrdersRepositoryProvider);
    });

    test('consulta una orden por número (codificado en la ruta)', () async {
      adapter.on(
        'GET',
        '/service-orders/OS-20261124-000001',
        body: fixture('service_orders/order_pending_response.json'),
      );
      expect(
        (await repository.order('OS-20261124-000001')).procedures,
        hasLength(2),
      );
    });

    test('lista los descuentos pendientes', () async {
      adapter.on(
        'GET',
        '/service-orders/discounts',
        body: fixture('service_orders/discounts_response.json'),
      );
      expect(await repository.pendingDiscounts(), hasLength(1));
    });

    test('aprobar, facturar y anular hacen POST a su acción', () async {
      for (final action in ['approve', 'bill', 'cancel']) {
        adapter.on(
          'POST',
          '/service-orders/OS-1/$action',
          body: fixture('service_orders/order_approved_response.json'),
        );
      }
      await repository.approveDiscount('OS-1');
      await repository.bill('OS-1');
      await repository.cancel('OS-1');
      for (final action in ['approve', 'bill', 'cancel']) {
        expect(
          adapter.callsTo('POST', '/service-orders/OS-1/$action'),
          hasLength(1),
        );
      }
    });

    test('409 de una regla de negocio llega con su mensaje', () async {
      adapter.on(
        'POST',
        '/service-orders/OS-1/bill',
        status: 409,
        body: errorBody("La orden OS-1 ya se encuentra en estado 'billed'."),
      );
      await expectLater(
        repository.bill('OS-1'),
        throwsA(
          isA<BusinessRuleException>().having(
            (e) => e.message,
            'message',
            contains('ya se encuentra'),
          ),
        ),
      );
    });

    test('crear envía el cuerpo y devuelve la orden', () async {
      adapter.on(
        'POST',
        '/service-orders',
        status: 201,
        body: fixture('service_orders/order_pending_response.json'),
      );
      const request = NewOrderRequest(
        patientExternalId: 'P1',
        patientDocument: '100',
        patientFirstName: 'Ana',
        patientLastName: 'Pérez',
        serviceDate: '2026-11-26',
        lines: [
          OrderLineRequest(medicalServiceId: 3, quantity: 1, unitPrice: 10),
        ],
      );
      final order = await repository.create(request);
      expect(order.orderNumber, 'OS-20261124-000001');
      expect(
        adapter.callsTo('POST', '/service-orders').single.data,
        request.toJson(),
      );
    });
  });
}
