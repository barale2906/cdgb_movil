import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';
import 'package:sga_bojanini/features/purchasing/data/orders_repository.dart';

/// Línea de recepción de una orden de gasto (cantidad decimal, sin lote).
class ExpenseReceiveLine {
  const ExpenseReceiveLine({required this.itemId, required this.quantity});

  final int itemId;
  final double quantity;

  Map<String, Object?> toJson() => {
    'item_id': itemId,
    'quantity_received': quantity,
  };
}

/// Pago de una orden de gasto.
class PaymentRequest {
  const PaymentRequest({
    required this.amount,
    required this.paymentDate,
    required this.method,
    this.reference,
    this.notes,
  });

  final double amount;

  /// `AAAA-MM-DD`.
  final String paymentDate;
  final PaymentMethod method;
  final String? reference;
  final String? notes;

  Map<String, Object?> toJson() => {
    'amount': amount,
    'payment_date': paymentDate,
    'payment_method': method.value,
    if ((reference ?? '').trim().isNotEmpty) 'reference': reference!.trim(),
    if ((notes ?? '').trim().isNotEmpty) 'notes': notes!.trim(),
  };
}

/// Órdenes de gasto: flujo común más factura, contabilidad y pagos.
class ExpenseOrdersRepository extends OrdersRepository<ExpenseOrder> {
  ExpenseOrdersRepository(Dio dio)
    : super(dio, 'expense-orders', ExpenseOrder.fromJson);

  Future<ExpenseOrder> registerInvoice(
    int id, {
    required String invoiceNumber,
    required String invoiceDate,
  }) => apiCall(() async {
    final response = await dio.post<dynamic>(
      '/$path/$id/invoice',
      data: {'invoice_number': invoiceNumber, 'invoice_date': invoiceDate},
    );
    return ExpenseOrder.fromJson(ApiResponse.object(response));
  });

  /// Envía la orden a contabilidad por correo (multipart; sin adjuntos).
  Future<ExpenseOrder> sendToAccounting(int id, List<String> recipients) =>
      apiCall(() async {
        final response = await dio.post<dynamic>(
          '/$path/$id/send-accounting',
          data: FormData.fromMap({'recipients': recipients}),
        );
        return ExpenseOrder.fromJson(ApiResponse.object(response));
      });

  Future<List<ExpensePayment>> payments(int id) => apiCall(() async {
    final response = await dio.get<dynamic>('/$path/$id/payments');
    return ApiResponse.list(response, ExpensePayment.fromJson);
  });

  Future<ExpenseOrder> addPayment(int id, PaymentRequest request) =>
      apiCall(() async {
        final response = await dio.post<dynamic>(
          '/$path/$id/payments',
          data: request.toJson(),
        );
        return ExpenseOrder.fromJson(ApiResponse.object(response));
      });

  Future<void> deletePayment(int id, int paymentId) =>
      apiCall(() => dio.delete<dynamic>('/$path/$id/payments/$paymentId'));
}

final expenseOrdersRepositoryProvider = Provider<ExpenseOrdersRepository>(
  (ref) => ExpenseOrdersRepository(ref.watch(dioProvider)),
);
