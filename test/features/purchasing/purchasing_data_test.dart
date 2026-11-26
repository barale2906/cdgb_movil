import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';
import 'package:sga_bojanini/features/purchasing/data/orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_orders_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<PurchaseOrder> _purchaseOrders() =>
    (fixture('purchasing/purchase_orders_response.json')['data']
            as List<dynamic>)
        .map((e) => PurchaseOrder.fromJson(e as Json))
        .toList();

List<ExpenseOrder> _expenseOrders() =>
    (fixture('purchasing/expense_orders_response.json')['data']
            as List<dynamic>)
        .map((e) => ExpenseOrder.fromJson(e as Json))
        .toList();

void main() {
  group('OrderStatus', () {
    test('lee los 8 estados y uno desconocido no rompe', () {
      expect(
        OrderStatus.parse('pending_approval'),
        OrderStatus.pendingApproval,
      );
      expect(
        OrderStatus.parse('partially_received'),
        OrderStatus.partiallyReceived,
      );
      expect(OrderStatus.parse('algo_nuevo'), OrderStatus.unknown);
      expect(OrderStatus.parse(null), OrderStatus.unknown);
    });

    test('recibir solo desde enviada o parcial', () {
      expect(OrderStatus.sent.canReceive, isTrue);
      expect(OrderStatus.partiallyReceived.canReceive, isTrue);
      expect(OrderStatus.approved.canReceive, isFalse);
      expect(OrderStatus.received.canReceive, isFalse);
    });

    test('no se cancela una orden recibida o ya cancelada', () {
      expect(OrderStatus.draft.canCancel, isTrue);
      expect(OrderStatus.sent.canCancel, isTrue);
      expect(OrderStatus.received.canCancel, isFalse);
      expect(OrderStatus.cancelled.canCancel, isFalse);
    });
  });

  group('PurchaseOrder (contrato)', () {
    test('parsea encabezado, importes en texto y relaciones', () {
      final order = _purchaseOrders().first;
      expect(order.code, 'OC-2026-0011');
      expect(order.status, OrderStatus.pendingApproval);
      expect(order.totalAmount, 1190000, reason: 'llega como "1190000.00"');
      expect(order.supplier?.name, 'Droguería Proveedor S.A.S.');
      expect(order.warehouse?.code, 'BC');
      expect(order.costCenter, isNull);
      expect(order.taxBreakdown.single.taxRate, 19);
    });

    test('parsea las líneas con producto y presentación', () {
      final item = _purchaseOrders().first.items.single;
      expect(item.productName, 'Gasa estéril');
      expect(item.presentation?.name, 'Caja x 10');
      expect(item.quantityRequested, 10);
      expect(item.pendingQuantity, 10);
    });

    test('lo ya recibido descuenta lo pendiente y nunca es negativo', () {
      final partial = _purchaseOrders().last.items.single;
      expect(partial.pendingQuantity, 15);
      expect(
        const PurchaseOrderItem(
          id: 1,
          quantityRequested: 2,
          quantityReceived: 3,
        ).pendingQuantity,
        0,
      );
    });

    test('sin relaciones ni líneas (listados): usa valores por defecto', () {
      final order = PurchaseOrder.fromJson({
        'id': 1,
        'code': 'X',
        'status': 'draft',
      });
      expect(order.items, isEmpty);
      expect(order.supplier, isNull);
      expect(order.totalAmount, isNull);
    });
  });

  group('ExpenseOrder (contrato)', () {
    test('parsea estados, importes, líneas y pagos', () {
      final order = _expenseOrders().first;
      expect(order.status, OrderStatus.received);
      expect(order.paymentStatus, PaymentStatus.partial);
      expect(order.amountPaid, 300000);
      expect(order.items.single.quantityRequested, 2);
      expect(order.payments.single.paymentMethod, 'transfer');
      expect(order.payments.single.registeredBy?.name, 'Usuario Prueba');
    });

    test('saldo = total - pagado, sin pasar de cero', () {
      expect(_expenseOrders().first.balance, 500000);
      expect(
        const ExpenseOrder(
          id: 1,
          code: 'X',
          totalAmount: 10,
          amountPaid: 50,
        ).balance,
        0,
      );
    });

    test('factura registrada', () {
      expect(_expenseOrders().first.hasInvoice, isFalse);
      expect(_expenseOrders().last.hasInvoice, isTrue);
    });
  });

  group('Consolidación (contrato)', () {
    test('sugerencias: proveedor preferido opcional', () {
      final list =
          (fixture('purchasing/suggestions_response.json')['data']
                  as List<dynamic>)
              .map((e) => ReorderSuggestion.fromJson(e as Json))
              .toList();
      expect(list.first.preferredSupplier?.name, 'Droguería Proveedor S.A.S.');
      expect(list.first.suggestedQuantity, 80);
      expect(list.last.preferredSupplier, isNull);
      expect(list.last.productBarcode, isNull);
    });

    test('vista previa: totales, líneas y órdenes de origen', () {
      final preview = ConsolidationPreview.fromJson(
        fixture('purchasing/consolidation_preview_response.json')['data']
            as Json,
      );
      expect(preview.supplier?.name, 'Droguería Proveedor S.A.S.');
      expect(preview.purchaseOrders, hasLength(2));
      expect(preview.items.single.sourceOrderCodes, ['OC-2026-0022']);
      expect(preview.totalAmount, 1690000);
    });

    test('órdenes consolidables: dentro y fuera del periodo', () {
      final orders = ConsolidableOrders.fromJson(
        fixture('purchasing/consolidable_response.json')['data'] as Json,
      );
      expect(orders.inRange, hasLength(2));
      expect(orders.pending, isEmpty);
    });

    test('orden consolidada con periodo', () {
      final order = ConsolidatedOrder.fromJson(
        fixture('purchasing/consolidated_order_response.json')['data'] as Json,
      );
      expect(order.code, 'CONS-2026-0005');
      expect(order.periodTo, '2026-11-24');
      expect(order.purchaseOrders, hasLength(2));
    });
  });

  group('Repositorios', () {
    late FakeHttpAdapter adapter;
    late PurchaseOrdersRepository purchases;
    late ExpenseOrdersRepository expenses;

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
      purchases = container.read(purchaseOrdersRepositoryProvider);
      expenses = container.read(expenseOrdersRepositoryProvider);
    });

    test('lista con filtro de estado y paginación', () async {
      adapter.on(
        'GET',
        '/purchase-orders',
        body: fixture('purchasing/purchase_orders_response.json'),
      );
      final page = await purchases.list(
        const OrderQuery(status: OrderStatus.pendingApproval),
      );
      expect(page.items, hasLength(2));
      expect(page.meta.hasMore, isFalse);
      expect(
        adapter.callsTo('GET', '/purchase-orders').single.queryParameters,
        {'status': 'pending_approval', 'page': 1, 'per_page': 25},
      );
    });

    test('órdenes de gasto filtran también por estado de pago', () async {
      adapter.on(
        'GET',
        '/expense-orders',
        body: fixture('purchasing/expense_orders_response.json'),
      );
      await expenses.list(
        const OrderQuery(paymentStatus: PaymentStatus.unpaid),
      );
      expect(
        adapter.callsTo('GET', '/expense-orders').single.queryParameters,
        containsPair('payment_status', 'unpaid'),
      );
    });

    test('aprobar envía los comentarios solo si hay', () async {
      adapter.on(
        'POST',
        '/purchase-orders/11/approve',
        body: fixture('purchasing/purchase_order_response.json'),
      );
      await purchases.approve(11, comments: '  Autorizado  ');
      await purchases.approve(11, comments: '   ');
      final calls = adapter
          .callsTo('POST', '/purchase-orders/11/approve')
          .toList();
      expect(calls.first.data, {'comments': 'Autorizado'});
      expect(calls.last.data, isNull);
    });

    test(
      'recepción de compra: ítem, cantidad, lote, vencimiento y ubicación',
      () async {
        adapter.on(
          'POST',
          '/purchase-orders/12/receive',
          body: fixture('purchasing/purchase_order_response.json'),
        );
        await purchases.receive(12, [
          const PurchaseReceiveLine(
            itemId: 102,
            quantityReceived: 15,
            lotNumber: 'L-77',
            expirationDate: '2027-05-01',
            locationId: 4,
          ).toJson(),
        ]);
        expect(
          adapter.callsTo('POST', '/purchase-orders/12/receive').single.data,
          {
            'items': [
              {
                'item_id': 102,
                'quantity_received': 15,
                'lot_number': 'L-77',
                'expiration_date': '2027-05-01',
                'location_id': 4,
              },
            ],
          },
        );
      },
    );

    test('un 409 o 422 de una acción llega tipado y sin reintentos', () async {
      adapter.on(
        'POST',
        '/purchase-orders/11/send',
        status: 409,
        body: errorBody('La orden no está aprobada.'),
      );
      await expectLater(
        purchases.send(11),
        throwsA(
          isA<BusinessRuleException>().having(
            (e) => e.message,
            'message',
            'La orden no está aprobada.',
          ),
        ),
      );
      expect(adapter.callsTo('POST', '/purchase-orders/11/send'), hasLength(1));
    });

    test('un timeout en una escritura no se reintenta', () async {
      adapter.onError(
        'POST',
        '/expense-orders/31/cancel',
        DioExceptionType.receiveTimeout,
      );
      await expectLater(
        expenses.cancel(31),
        throwsA(isA<NetworkException>()),
      );
      expect(
        adapter.callsTo('POST', '/expense-orders/31/cancel'),
        hasLength(1),
      );
    });

    test('recepción de gasto con cantidad decimal', () async {
      adapter.on(
        'POST',
        '/expense-orders/31/receive',
        body: fixture('purchasing/expense_order_response.json'),
      );
      await expenses.receive(31, [
        const ExpenseReceiveLine(itemId: 301, quantity: 1.5).toJson(),
      ]);
      expect(
        adapter.callsTo('POST', '/expense-orders/31/receive').single.data,
        {
          'items': [
            {'item_id': 301, 'quantity_received': 1.5},
          ],
        },
      );
    });

    test('factura, pago y borrado de pago', () async {
      adapter
        ..on(
          'POST',
          '/expense-orders/31/invoice',
          body: fixture('purchasing/expense_order_response.json'),
        )
        ..on(
          'POST',
          '/expense-orders/31/payments',
          body: fixture('purchasing/expense_order_response.json'),
        )
        ..on('DELETE', '/expense-orders/31/payments/51', body: envelope(null))
        ..on(
          'GET',
          '/expense-orders/31/payments',
          body: fixture('purchasing/payments_response.json'),
        );

      await expenses.registerInvoice(
        31,
        invoiceNumber: 'FV-9',
        invoiceDate: '2026-11-25',
      );
      await expenses.addPayment(
        31,
        const PaymentRequest(
          amount: 100000,
          paymentDate: '2026-11-25',
          method: PaymentMethod.cash,
          reference: ' ',
          notes: 'Abono',
        ),
      );
      await expenses.deletePayment(31, 51);

      expect(
        adapter.callsTo('POST', '/expense-orders/31/invoice').single.data,
        {
          'invoice_number': 'FV-9',
          'invoice_date': '2026-11-25',
        },
      );
      expect(
        adapter.callsTo('POST', '/expense-orders/31/payments').single.data,
        {
          'amount': 100000.0,
          'payment_date': '2026-11-25',
          'payment_method': 'cash',
          'notes': 'Abono',
        },
      );
      expect(await expenses.payments(31), hasLength(1));
    });

    test(
      'consolidación: proveedores, órdenes, vista previa y creación',
      () async {
        adapter
          ..on(
            'GET',
            '/purchase-orders/consolidable-suppliers',
            body: fixture('purchasing/consolidable_suppliers_response.json'),
          )
          ..on(
            'GET',
            '/purchase-orders/consolidable',
            body: fixture('purchasing/consolidable_response.json'),
          )
          ..on(
            'POST',
            '/purchase-orders/consolidation-preview',
            body: fixture('purchasing/consolidation_preview_response.json'),
          )
          ..on(
            'POST',
            '/consolidated-orders',
            status: 201,
            body: fixture('purchasing/consolidated_order_response.json'),
          )
          ..on(
            'GET',
            '/consolidated-orders',
            body: fixture('purchasing/consolidated_orders_response.json'),
          )
          ..on(
            'GET',
            '/consolidated-orders/5',
            body: fixture('purchasing/consolidated_order_response.json'),
          )
          ..on(
            'GET',
            '/purchase-orders/suggestions',
            body: fixture('purchasing/suggestions_response.json'),
          );

        expect(await purchases.consolidableSuppliers(), hasLength(1));
        final orders = await purchases.consolidable(4);
        expect(orders.inRange, hasLength(2));
        expect(
          adapter
              .callsTo('GET', '/purchase-orders/consolidable')
              .single
              .queryParameters,
          {'supplier_id': 4},
        );
        final preview = await purchases.preview([21, 22]);
        expect(preview.totalAmount, 1690000);
        final created = await purchases.consolidate([21, 22], notes: ' Mes ');
        expect(created.id, 5);
        expect(adapter.callsTo('POST', '/consolidated-orders').single.data, {
          'purchase_order_ids': [21, 22],
          'notes': 'Mes',
        });
        expect((await purchases.consolidatedOrders()).items, hasLength(1));
        expect((await purchases.consolidatedOrder(5)).code, 'CONS-2026-0005');
        expect(await purchases.suggestions(), hasLength(2));
      },
    );
  });
}
