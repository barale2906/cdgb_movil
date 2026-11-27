import 'package:flutter/foundation.dart';

/// Línea de una orden de gasto (concepto libre, sin producto de inventario).
@immutable
class ExpenseItemRequest {
  const ExpenseItemRequest({
    required this.description,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
    this.taxRate,
  });

  final String description;
  final String unit;
  final double quantity;
  final double unitPrice;

  /// Porcentaje de IVA (0–100); `null` = sin IVA.
  final double? taxRate;

  Map<String, Object> toJson() => {
    'description': description.trim(),
    'unit': unit.trim(),
    'quantity': quantity,
    'unit_price': unitPrice,
    'tax_rate': ?taxRate,
  };
}

/// Cuerpo de `POST/PUT /expense-orders` (borrador).
@immutable
class ExpenseDraftRequest {
  const ExpenseDraftRequest({
    required this.supplierId,
    required this.items,
    this.expectedDeliveryDate,
    this.notes,
  });

  final int supplierId;
  final List<ExpenseItemRequest> items;

  /// `AAAA-MM-DD`.
  final String? expectedDeliveryDate;
  final String? notes;

  Map<String, Object> toJson() => {
    'supplier_id': supplierId,
    'items': [for (final item in items) item.toJson()],
    'expected_delivery_date': ?expectedDeliveryDate,
    if ((notes ?? '').trim().isNotEmpty) 'notes': notes!.trim(),
  };
}

/// Línea de una orden de compra: variante y presentación de un producto.
@immutable
class PurchaseItemRequest {
  const PurchaseItemRequest({
    required this.productVariantId,
    required this.productPresentationId,
    required this.quantity,
    required this.unitPrice,
    this.taxRate,
  });

  final int productVariantId;
  final int productPresentationId;

  /// Unidades **de la presentación** (caja, blíster…), entero.
  final int quantity;
  final double unitPrice;
  final double? taxRate;

  Map<String, Object> toJson() => {
    'product_variant_id': productVariantId,
    'product_presentation_id': productPresentationId,
    'quantity': quantity,
    'unit_price': unitPrice,
    'tax_rate': ?taxRate,
  };
}

/// Cuerpo de `POST/PUT /purchase-orders` (borrador).
@immutable
class PurchaseDraftRequest {
  const PurchaseDraftRequest({
    required this.supplierId,
    required this.warehouseId,
    required this.items,
    this.costCenterId,
    this.expectedDeliveryDate,
    this.notes,
  });

  final int supplierId;
  final int warehouseId;
  final int? costCenterId;
  final List<PurchaseItemRequest> items;
  final String? expectedDeliveryDate;
  final String? notes;

  Map<String, Object> toJson() => {
    'supplier_id': supplierId,
    'warehouse_id': warehouseId,
    'cost_center_id': ?costCenterId,
    'items': [for (final item in items) item.toJson()],
    'expected_delivery_date': ?expectedDeliveryDate,
    if ((notes ?? '').trim().isNotEmpty) 'notes': notes!.trim(),
  };
}
