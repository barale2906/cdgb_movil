// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consolidation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReorderSuggestion _$ReorderSuggestionFromJson(
  Map<String, dynamic> json,
) => _ReorderSuggestion(
  genericProductId: (json['generic_product_id'] as num).toInt(),
  productName: json['product_name'] as String,
  productBarcode: json['product_barcode'] as String?,
  currentStock: const DoubleConverter().fromJson(json['current_stock']),
  reorderPoint: const DoubleConverter().fromJson(json['reorder_point']),
  dailyConsumption: const DoubleConverter().fromJson(json['daily_consumption']),
  leadTimeDays: (json['lead_time_days'] as num?)?.toInt(),
  safetyStock: const DoubleConverter().fromJson(json['safety_stock']),
  suggestedQuantity: const DoubleConverter().fromJson(
    json['suggested_quantity'],
  ),
  preferredSupplier: json['preferred_supplier'] == null
      ? null
      : NamedRef.fromJson(json['preferred_supplier'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ReorderSuggestionToJson(_ReorderSuggestion instance) =>
    <String, dynamic>{
      'generic_product_id': instance.genericProductId,
      'product_name': instance.productName,
      'product_barcode': instance.productBarcode,
      'current_stock': const DoubleConverter().toJson(instance.currentStock),
      'reorder_point': const DoubleConverter().toJson(instance.reorderPoint),
      'daily_consumption': const DoubleConverter().toJson(
        instance.dailyConsumption,
      ),
      'lead_time_days': instance.leadTimeDays,
      'safety_stock': const DoubleConverter().toJson(instance.safetyStock),
      'suggested_quantity': const DoubleConverter().toJson(
        instance.suggestedQuantity,
      ),
      'preferred_supplier': instance.preferredSupplier?.toJson(),
    };

_ConsolidableSupplier _$ConsolidableSupplierFromJson(
  Map<String, dynamic> json,
) => _ConsolidableSupplier(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  taxId: json['tax_id'] as String?,
);

Map<String, dynamic> _$ConsolidableSupplierToJson(
  _ConsolidableSupplier instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'tax_id': instance.taxId,
};

_ConsolidatedItem _$ConsolidatedItemFromJson(Map<String, dynamic> json) =>
    _ConsolidatedItem(
      quantity: const DoubleConverter().fromJson(json['quantity']),
      unitPrice: const DoubleConverter().fromJson(json['unit_price']),
      taxRate: const DoubleConverter().fromJson(json['tax_rate']),
      taxAmount: const DoubleConverter().fromJson(json['tax_amount']),
      totalPrice: const DoubleConverter().fromJson(json['total_price']),
      sourceOrderCodes:
          (json['source_order_codes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      variant: json['variant'] == null
          ? null
          : VariantRef.fromJson(json['variant'] as Map<String, dynamic>),
      presentation: json['presentation'] == null
          ? null
          : PresentationRef.fromJson(
              json['presentation'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ConsolidatedItemToJson(_ConsolidatedItem instance) =>
    <String, dynamic>{
      'quantity': const DoubleConverter().toJson(instance.quantity),
      'unit_price': const DoubleConverter().toJson(instance.unitPrice),
      'tax_rate': const DoubleConverter().toJson(instance.taxRate),
      'tax_amount': const DoubleConverter().toJson(instance.taxAmount),
      'total_price': const DoubleConverter().toJson(instance.totalPrice),
      'source_order_codes': instance.sourceOrderCodes,
      'variant': instance.variant?.toJson(),
      'presentation': instance.presentation?.toJson(),
    };

_ConsolidationSource _$ConsolidationSourceFromJson(Map<String, dynamic> json) =>
    _ConsolidationSource(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      totalAmount: const DoubleConverter().fromJson(json['total_amount']),
      warehouse: json['warehouse'] == null
          ? null
          : NamedRef.fromJson(json['warehouse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConsolidationSourceToJson(
  _ConsolidationSource instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'total_amount': const DoubleConverter().toJson(instance.totalAmount),
  'warehouse': instance.warehouse?.toJson(),
};

_ConsolidationPreview _$ConsolidationPreviewFromJson(
  Map<String, dynamic> json,
) => _ConsolidationPreview(
  supplier: json['supplier'] == null
      ? null
      : NamedRef.fromJson(json['supplier'] as Map<String, dynamic>),
  purchaseOrders:
      (json['purchase_orders'] as List<dynamic>?)
          ?.map((e) => ConsolidationSource.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => ConsolidatedItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  subtotal: const DoubleConverter().fromJson(json['subtotal']),
  taxAmount: const DoubleConverter().fromJson(json['tax_amount']),
  totalAmount: const DoubleConverter().fromJson(json['total_amount']),
);

Map<String, dynamic> _$ConsolidationPreviewToJson(
  _ConsolidationPreview instance,
) => <String, dynamic>{
  'supplier': instance.supplier?.toJson(),
  'purchase_orders': instance.purchaseOrders.map((e) => e.toJson()).toList(),
  'items': instance.items.map((e) => e.toJson()).toList(),
  'subtotal': const DoubleConverter().toJson(instance.subtotal),
  'tax_amount': const DoubleConverter().toJson(instance.taxAmount),
  'total_amount': const DoubleConverter().toJson(instance.totalAmount),
};

_ConsolidatedOrder _$ConsolidatedOrderFromJson(Map<String, dynamic> json) =>
    _ConsolidatedOrder(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      supplierId: (json['supplier_id'] as num?)?.toInt(),
      periodFrom: json['period_from'] as String?,
      periodTo: json['period_to'] as String?,
      subtotal: const DoubleConverter().fromJson(json['subtotal']),
      taxAmount: const DoubleConverter().fromJson(json['tax_amount']),
      totalAmount: const DoubleConverter().fromJson(json['total_amount']),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
      supplier: json['supplier'] == null
          ? null
          : NamedRef.fromJson(json['supplier'] as Map<String, dynamic>),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ConsolidatedItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      purchaseOrders:
          (json['purchase_orders'] as List<dynamic>?)
              ?.map((e) => PurchaseOrder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ConsolidatedOrderToJson(
  _ConsolidatedOrder instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'supplier_id': instance.supplierId,
  'period_from': instance.periodFrom,
  'period_to': instance.periodTo,
  'subtotal': const DoubleConverter().toJson(instance.subtotal),
  'tax_amount': const DoubleConverter().toJson(instance.taxAmount),
  'total_amount': const DoubleConverter().toJson(instance.totalAmount),
  'notes': instance.notes,
  'created_at': instance.createdAt,
  'supplier': instance.supplier?.toJson(),
  'items': instance.items.map((e) => e.toJson()).toList(),
  'purchase_orders': instance.purchaseOrders.map((e) => e.toJson()).toList(),
};
