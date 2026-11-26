import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';
import 'package:sga_bojanini/features/purchasing/data/order_refs.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';

part 'consolidation.freezed.dart';
part 'consolidation.g.dart';

/// Sugerencia de reorden por stock bajo.
@freezed
abstract class ReorderSuggestion with _$ReorderSuggestion {
  const factory ReorderSuggestion({
    required int genericProductId,
    required String productName,
    String? productBarcode,
    @DoubleConverter() double? currentStock,
    @DoubleConverter() double? reorderPoint,
    @DoubleConverter() double? dailyConsumption,
    int? leadTimeDays,
    @DoubleConverter() double? safetyStock,
    @DoubleConverter() double? suggestedQuantity,
    NamedRef? preferredSupplier,
  }) = _ReorderSuggestion;

  factory ReorderSuggestion.fromJson(Map<String, dynamic> json) =>
      _$ReorderSuggestionFromJson(json);
}

/// Proveedor con órdenes recibidas aún sin consolidar.
@freezed
abstract class ConsolidableSupplier with _$ConsolidableSupplier {
  const factory ConsolidableSupplier({
    required int id,
    required String name,
    String? taxId,
  }) = _ConsolidableSupplier;

  factory ConsolidableSupplier.fromJson(Map<String, dynamic> json) =>
      _$ConsolidableSupplierFromJson(json);
}

/// Línea de la vista previa o de la orden consolidada.
@freezed
abstract class ConsolidatedItem with _$ConsolidatedItem {
  const factory ConsolidatedItem({
    @DoubleConverter() double? quantity,
    @DoubleConverter() double? unitPrice,
    @DoubleConverter() double? taxRate,
    @DoubleConverter() double? taxAmount,
    @DoubleConverter() double? totalPrice,
    @Default([]) List<String> sourceOrderCodes,
    VariantRef? variant,
    PresentationRef? presentation,
  }) = _ConsolidatedItem;

  factory ConsolidatedItem.fromJson(Map<String, dynamic> json) =>
      _$ConsolidatedItemFromJson(json);
}

/// Resumen de una orden incluida en una consolidación.
@freezed
abstract class ConsolidationSource with _$ConsolidationSource {
  const factory ConsolidationSource({
    required int id,
    required String code,
    @DoubleConverter() double? totalAmount,
    NamedRef? warehouse,
  }) = _ConsolidationSource;

  factory ConsolidationSource.fromJson(Map<String, dynamic> json) =>
      _$ConsolidationSourceFromJson(json);
}

/// `POST purchase-orders/consolidation-preview`: nada se guarda.
@freezed
abstract class ConsolidationPreview with _$ConsolidationPreview {
  const factory ConsolidationPreview({
    NamedRef? supplier,
    @Default([]) List<ConsolidationSource> purchaseOrders,
    @Default([]) List<ConsolidatedItem> items,
    @DoubleConverter() double? subtotal,
    @DoubleConverter() double? taxAmount,
    @DoubleConverter() double? totalAmount,
  }) = _ConsolidationPreview;

  factory ConsolidationPreview.fromJson(Map<String, dynamic> json) =>
      _$ConsolidationPreviewFromJson(json);
}

/// Órdenes consolidables: dentro del periodo pedido y fuera de él.
class ConsolidableOrders {
  const ConsolidableOrders({required this.inRange, required this.pending});

  factory ConsolidableOrders.fromJson(Map<String, dynamic> json) =>
      ConsolidableOrders(
        inRange: _orders(json['in_range']),
        pending: _orders(json['pending']),
      );

  final List<PurchaseOrder> inRange;
  final List<PurchaseOrder> pending;

  static List<PurchaseOrder> _orders(Object? raw) => [
    for (final item in raw as List<dynamic>? ?? const [])
      PurchaseOrder.fromJson(item as Map<String, dynamic>),
  ];
}

/// Orden consolidada (`ConsolidatedPurchaseOrderResource`).
@freezed
abstract class ConsolidatedOrder with _$ConsolidatedOrder {
  const factory ConsolidatedOrder({
    required int id,
    required String code,
    int? supplierId,
    String? periodFrom,
    String? periodTo,
    @DoubleConverter() double? subtotal,
    @DoubleConverter() double? taxAmount,
    @DoubleConverter() double? totalAmount,
    String? notes,
    String? createdAt,
    NamedRef? supplier,
    @Default([]) List<ConsolidatedItem> items,
    @Default([]) List<PurchaseOrder> purchaseOrders,
  }) = _ConsolidatedOrder;

  factory ConsolidatedOrder.fromJson(Map<String, dynamic> json) =>
      _$ConsolidatedOrderFromJson(json);
}
