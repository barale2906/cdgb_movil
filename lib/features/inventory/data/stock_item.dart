import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'stock_item.freezed.dart';
part 'stock_item.g.dart';

@freezed
abstract class StockCategory with _$StockCategory {
  const factory StockCategory({required int id, required String name}) =
      _StockCategory;

  factory StockCategory.fromJson(Map<String, dynamic> json) =>
      _$StockCategoryFromJson(json);
}

@freezed
abstract class StockGeneric with _$StockGeneric {
  const factory StockGeneric({
    required int id,
    required String name,
    String? barcode,
    StockCategory? category,
  }) = _StockGeneric;

  factory StockGeneric.fromJson(Map<String, dynamic> json) =>
      _$StockGenericFromJson(json);
}

/// Variante tal como la expone `StockResource`: con producto genérico, o
/// solo `product_variant_id` si el servidor no la cargó.
@freezed
abstract class StockVariant with _$StockVariant {
  const factory StockVariant({
    int? id,
    int? productVariantId,
    String? labBrand,
    StockGeneric? generic,
  }) = _StockVariant;

  factory StockVariant.fromJson(Map<String, dynamic> json) =>
      _$StockVariantFromJson(json);
}

@freezed
abstract class StockWarehouse with _$StockWarehouse {
  const factory StockWarehouse({
    required int id,
    String? code,
    String? name,
  }) = _StockWarehouse;

  factory StockWarehouse.fromJson(Map<String, dynamic> json) =>
      _$StockWarehouseFromJson(json);
}

/// Existencia de una variante en un almacén (`GET /stock`).
@freezed
abstract class StockItem with _$StockItem {
  const factory StockItem({
    required StockVariant variant,
    required StockWarehouse warehouse,
    @DoubleConverter() double? totalQuantity,
    @DoubleConverter() double? reservedQuantity,
    @DoubleConverter() double? availableQuantity,
    String? lastNote,
    String? lastMovementAt,
  }) = _StockItem;

  const StockItem._();

  factory StockItem.fromJson(Map<String, dynamic> json) =>
      _$StockItemFromJson(json);

  int? get variantId => variant.id ?? variant.productVariantId;
  int? get genericProductId => variant.generic?.id;
  String get productName => variant.generic?.name ?? '';
}
