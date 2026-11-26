import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';
import 'package:sga_bojanini/features/purchasing/data/order_refs.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';

part 'purchase_order.freezed.dart';
part 'purchase_order.g.dart';

@freezed
abstract class PurchaseOrderItem with _$PurchaseOrderItem {
  const factory PurchaseOrderItem({
    required int id,
    int? productVariantId,
    int? productPresentationId,
    @DoubleConverter() double? quantityRequested,
    @DoubleConverter() double? quantityReceived,
    @DoubleConverter() double? unitPrice,
    @DoubleConverter() double? taxRate,
    @DoubleConverter() double? taxAmount,
    @DoubleConverter() double? totalPrice,
    String? notes,
    VariantRef? variant,
    PresentationRef? presentation,
  }) = _PurchaseOrderItem;

  const PurchaseOrderItem._();

  factory PurchaseOrderItem.fromJson(Map<String, dynamic> json) =>
      _$PurchaseOrderItemFromJson(json);

  /// Nombre del producto genérico; cae al laboratorio si no viene.
  String? get productName => variant?.generic?.name ?? variant?.labBrand;

  /// Cantidad que aún falta por recibir (nunca negativa).
  double get pendingQuantity {
    final pending = (quantityRequested ?? 0) - (quantityReceived ?? 0);
    return pending < 0 ? 0 : pending;
  }
}

/// Orden de compra (`PurchaseOrderResource`). En la lista no siempre trae
/// `items`.
@freezed
abstract class PurchaseOrder with _$PurchaseOrder {
  const factory PurchaseOrder({
    required int id,
    required String code,
    @OrderStatusConverter() @Default(OrderStatus.unknown) OrderStatus status,
    int? supplierId,
    int? warehouseId,
    @DoubleConverter() double? subtotal,
    @DoubleConverter() double? taxAmount,
    @DoubleConverter() double? totalAmount,
    String? notes,
    String? expectedDeliveryDate,
    String? sentAt,
    String? receivedAt,
    String? createdAt,
    NamedRef? supplier,
    NamedRef? warehouse,
    NamedRef? costCenter,
    @Default([]) List<TaxLine> taxBreakdown,
    @Default([]) List<PurchaseOrderItem> items,
  }) = _PurchaseOrder;

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) =>
      _$PurchaseOrderFromJson(json);
}
