import 'package:freezed_annotation/freezed_annotation.dart';

/// Estado de una orden de compra o de gasto (`docs/app-movil/16-flujos.md` §3).
enum OrderStatus {
  draft('draft'),
  pendingApproval('pending_approval'),
  approved('approved'),
  rejected('rejected'),
  sent('sent'),
  partiallyReceived('partially_received'),
  received('received'),
  cancelled('cancelled'),
  unknown('unknown')
  ;

  const OrderStatus(this.value);

  final String value;

  static OrderStatus parse(Object? raw) => values.firstWhere(
    (status) => status.value == raw,
    orElse: () => unknown,
  );

  /// Se puede recibir mercancía (total o parcial).
  bool get canReceive => this == sent || this == partiallyReceived;

  /// El backend permite cancelar salvo en una orden ya recibida o cancelada.
  bool get canCancel =>
      this != received && this != cancelled && this != unknown;
}

class OrderStatusConverter implements JsonConverter<OrderStatus, Object?> {
  const OrderStatusConverter();

  @override
  OrderStatus fromJson(Object? json) => OrderStatus.parse(json);

  @override
  Object toJson(OrderStatus object) => object.value;
}

/// Estado de pago de una orden de gasto.
enum PaymentStatus {
  unpaid('unpaid'),
  partial('partial'),
  paid('paid'),
  unknown('unknown')
  ;

  const PaymentStatus(this.value);

  final String value;

  static PaymentStatus parse(Object? raw) => values.firstWhere(
    (status) => status.value == raw,
    orElse: () => unknown,
  );
}

class PaymentStatusConverter implements JsonConverter<PaymentStatus, Object?> {
  const PaymentStatusConverter();

  @override
  PaymentStatus fromJson(Object? json) => PaymentStatus.parse(json);

  @override
  Object toJson(PaymentStatus object) => object.value;
}

/// Forma de pago de una orden de gasto (`payment_method`).
enum PaymentMethod {
  cash('cash'),
  transfer('transfer'),
  check('check'),
  other('other')
  ;

  const PaymentMethod(this.value);

  final String value;

  static PaymentMethod parse(Object? raw) => values.firstWhere(
    (method) => method.value == raw,
    orElse: () => other,
  );
}
