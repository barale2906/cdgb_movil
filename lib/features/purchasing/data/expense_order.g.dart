// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseItem _$ExpenseItemFromJson(Map<String, dynamic> json) => _ExpenseItem(
  id: (json['id'] as num).toInt(),
  description: json['description'] as String,
  unit: json['unit'] as String?,
  quantityRequested: const DoubleConverter().fromJson(
    json['quantity_requested'],
  ),
  quantityReceived: const DoubleConverter().fromJson(json['quantity_received']),
  unitPrice: const DoubleConverter().fromJson(json['unit_price']),
  taxRate: const DoubleConverter().fromJson(json['tax_rate']),
  taxAmount: const DoubleConverter().fromJson(json['tax_amount']),
  totalPrice: const DoubleConverter().fromJson(json['total_price']),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$ExpenseItemToJson(_ExpenseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'unit': instance.unit,
      'quantity_requested': const DoubleConverter().toJson(
        instance.quantityRequested,
      ),
      'quantity_received': const DoubleConverter().toJson(
        instance.quantityReceived,
      ),
      'unit_price': const DoubleConverter().toJson(instance.unitPrice),
      'tax_rate': const DoubleConverter().toJson(instance.taxRate),
      'tax_amount': const DoubleConverter().toJson(instance.taxAmount),
      'total_price': const DoubleConverter().toJson(instance.totalPrice),
      'notes': instance.notes,
    };

_ExpensePayment _$ExpensePaymentFromJson(Map<String, dynamic> json) =>
    _ExpensePayment(
      id: (json['id'] as num).toInt(),
      amount: const DoubleConverter().fromJson(json['amount']),
      paymentDate: json['payment_date'] as String?,
      paymentMethod: json['payment_method'] as String?,
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
      registeredBy: json['registered_by'] == null
          ? null
          : NamedRef.fromJson(json['registered_by'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ExpensePaymentToJson(_ExpensePayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': const DoubleConverter().toJson(instance.amount),
      'payment_date': instance.paymentDate,
      'payment_method': instance.paymentMethod,
      'reference': instance.reference,
      'notes': instance.notes,
      'registered_by': instance.registeredBy?.toJson(),
      'created_at': instance.createdAt,
    };

_ExpenseOrder _$ExpenseOrderFromJson(Map<String, dynamic> json) =>
    _ExpenseOrder(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      status: json['status'] == null
          ? OrderStatus.unknown
          : const OrderStatusConverter().fromJson(json['status']),
      paymentStatus: json['payment_status'] == null
          ? PaymentStatus.unknown
          : const PaymentStatusConverter().fromJson(json['payment_status']),
      supplierId: (json['supplier_id'] as num?)?.toInt(),
      subtotal: const DoubleConverter().fromJson(json['subtotal']),
      taxAmount: const DoubleConverter().fromJson(json['tax_amount']),
      totalAmount: const DoubleConverter().fromJson(json['total_amount']),
      amountPaid: const DoubleConverter().fromJson(json['amount_paid']),
      invoiceNumber: json['invoice_number'] as String?,
      invoiceDate: json['invoice_date'] as String?,
      notes: json['notes'] as String?,
      expectedDeliveryDate: json['expected_delivery_date'] as String?,
      sentAt: json['sent_at'] as String?,
      receivedAt: json['received_at'] as String?,
      accountingSentAt: json['accounting_sent_at'] as String?,
      createdAt: json['created_at'] as String?,
      supplier: json['supplier'] == null
          ? null
          : NamedRef.fromJson(json['supplier'] as Map<String, dynamic>),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ExpenseItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      payments:
          (json['payments'] as List<dynamic>?)
              ?.map((e) => ExpensePayment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExpenseOrderToJson(_ExpenseOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'status': const OrderStatusConverter().toJson(instance.status),
      'payment_status': const PaymentStatusConverter().toJson(
        instance.paymentStatus,
      ),
      'supplier_id': instance.supplierId,
      'subtotal': const DoubleConverter().toJson(instance.subtotal),
      'tax_amount': const DoubleConverter().toJson(instance.taxAmount),
      'total_amount': const DoubleConverter().toJson(instance.totalAmount),
      'amount_paid': const DoubleConverter().toJson(instance.amountPaid),
      'invoice_number': instance.invoiceNumber,
      'invoice_date': instance.invoiceDate,
      'notes': instance.notes,
      'expected_delivery_date': instance.expectedDeliveryDate,
      'sent_at': instance.sentAt,
      'received_at': instance.receivedAt,
      'accounting_sent_at': instance.accountingSentAt,
      'created_at': instance.createdAt,
      'supplier': instance.supplier?.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'payments': instance.payments.map((e) => e.toJson()).toList(),
    };
