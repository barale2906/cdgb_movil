import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';
import 'package:sga_bojanini/features/purchasing/data/order_refs.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';

part 'expense_order.freezed.dart';
part 'expense_order.g.dart';

@freezed
abstract class ExpenseItem with _$ExpenseItem {
  const factory ExpenseItem({
    required int id,
    required String description,
    String? unit,
    @DoubleConverter() double? quantityRequested,
    @DoubleConverter() double? quantityReceived,
    @DoubleConverter() double? unitPrice,
    @DoubleConverter() double? taxRate,
    @DoubleConverter() double? taxAmount,
    @DoubleConverter() double? totalPrice,
    String? notes,
  }) = _ExpenseItem;

  const ExpenseItem._();

  factory ExpenseItem.fromJson(Map<String, dynamic> json) =>
      _$ExpenseItemFromJson(json);

  double get pendingQuantity {
    final pending = (quantityRequested ?? 0) - (quantityReceived ?? 0);
    return pending < 0 ? 0 : pending;
  }
}

@freezed
abstract class ExpensePayment with _$ExpensePayment {
  const factory ExpensePayment({
    required int id,
    @DoubleConverter() double? amount,
    String? paymentDate,
    String? paymentMethod,
    String? reference,
    String? notes,
    NamedRef? registeredBy,
    String? createdAt,
  }) = _ExpensePayment;

  factory ExpensePayment.fromJson(Map<String, dynamic> json) =>
      _$ExpensePaymentFromJson(json);
}

/// Orden de gasto (`ExpenseOrderResource`).
@freezed
abstract class ExpenseOrder with _$ExpenseOrder {
  const factory ExpenseOrder({
    required int id,
    required String code,
    @OrderStatusConverter() @Default(OrderStatus.unknown) OrderStatus status,
    @PaymentStatusConverter()
    @Default(PaymentStatus.unknown)
    PaymentStatus paymentStatus,
    int? supplierId,
    @DoubleConverter() double? subtotal,
    @DoubleConverter() double? taxAmount,
    @DoubleConverter() double? totalAmount,
    @DoubleConverter() double? amountPaid,
    String? invoiceNumber,
    String? invoiceDate,
    String? notes,
    String? expectedDeliveryDate,
    String? sentAt,
    String? receivedAt,
    String? accountingSentAt,
    String? createdAt,
    NamedRef? supplier,
    @Default([]) List<ExpenseItem> items,
    @Default([]) List<ExpensePayment> payments,
  }) = _ExpenseOrder;

  const ExpenseOrder._();

  factory ExpenseOrder.fromJson(Map<String, dynamic> json) =>
      _$ExpenseOrderFromJson(json);

  /// Saldo pendiente de pago (nunca negativo).
  double get balance {
    final value = (totalAmount ?? 0) - (amountPaid ?? 0);
    return value < 0 ? 0 : value;
  }

  bool get hasInvoice => (invoiceNumber ?? '').isNotEmpty;
}
