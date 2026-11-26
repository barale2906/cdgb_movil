// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PurchaseOrderItem _$PurchaseOrderItemFromJson(
  Map<String, dynamic> json,
) => _PurchaseOrderItem(
  id: (json['id'] as num).toInt(),
  productVariantId: (json['product_variant_id'] as num?)?.toInt(),
  productPresentationId: (json['product_presentation_id'] as num?)?.toInt(),
  quantityRequested: const DoubleConverter().fromJson(
    json['quantity_requested'],
  ),
  quantityReceived: const DoubleConverter().fromJson(json['quantity_received']),
  unitPrice: const DoubleConverter().fromJson(json['unit_price']),
  taxRate: const DoubleConverter().fromJson(json['tax_rate']),
  taxAmount: const DoubleConverter().fromJson(json['tax_amount']),
  totalPrice: const DoubleConverter().fromJson(json['total_price']),
  notes: json['notes'] as String?,
  variant: json['variant'] == null
      ? null
      : VariantRef.fromJson(json['variant'] as Map<String, dynamic>),
  presentation: json['presentation'] == null
      ? null
      : PresentationRef.fromJson(json['presentation'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PurchaseOrderItemToJson(_PurchaseOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_variant_id': instance.productVariantId,
      'product_presentation_id': instance.productPresentationId,
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
      'variant': instance.variant?.toJson(),
      'presentation': instance.presentation?.toJson(),
    };

_PurchaseOrder _$PurchaseOrderFromJson(Map<String, dynamic> json) =>
    _PurchaseOrder(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      status: json['status'] == null
          ? OrderStatus.unknown
          : const OrderStatusConverter().fromJson(json['status']),
      supplierId: (json['supplier_id'] as num?)?.toInt(),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      subtotal: const DoubleConverter().fromJson(json['subtotal']),
      taxAmount: const DoubleConverter().fromJson(json['tax_amount']),
      totalAmount: const DoubleConverter().fromJson(json['total_amount']),
      notes: json['notes'] as String?,
      expectedDeliveryDate: json['expected_delivery_date'] as String?,
      sentAt: json['sent_at'] as String?,
      receivedAt: json['received_at'] as String?,
      createdAt: json['created_at'] as String?,
      supplier: json['supplier'] == null
          ? null
          : NamedRef.fromJson(json['supplier'] as Map<String, dynamic>),
      warehouse: json['warehouse'] == null
          ? null
          : NamedRef.fromJson(json['warehouse'] as Map<String, dynamic>),
      costCenter: json['cost_center'] == null
          ? null
          : NamedRef.fromJson(json['cost_center'] as Map<String, dynamic>),
      taxBreakdown:
          (json['tax_breakdown'] as List<dynamic>?)
              ?.map((e) => TaxLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => PurchaseOrderItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PurchaseOrderToJson(_PurchaseOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'status': const OrderStatusConverter().toJson(instance.status),
      'supplier_id': instance.supplierId,
      'warehouse_id': instance.warehouseId,
      'subtotal': const DoubleConverter().toJson(instance.subtotal),
      'tax_amount': const DoubleConverter().toJson(instance.taxAmount),
      'total_amount': const DoubleConverter().toJson(instance.totalAmount),
      'notes': instance.notes,
      'expected_delivery_date': instance.expectedDeliveryDate,
      'sent_at': instance.sentAt,
      'received_at': instance.receivedAt,
      'created_at': instance.createdAt,
      'supplier': instance.supplier?.toJson(),
      'warehouse': instance.warehouse?.toJson(),
      'cost_center': instance.costCenter?.toJson(),
      'tax_breakdown': instance.taxBreakdown.map((e) => e.toJson()).toList(),
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
