// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockCategory _$StockCategoryFromJson(Map<String, dynamic> json) =>
    _StockCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$StockCategoryToJson(_StockCategory instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_StockGeneric _$StockGenericFromJson(Map<String, dynamic> json) =>
    _StockGeneric(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      barcode: json['barcode'] as String?,
      category: json['category'] == null
          ? null
          : StockCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockGenericToJson(_StockGeneric instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'barcode': instance.barcode,
      'category': instance.category?.toJson(),
    };

_StockVariant _$StockVariantFromJson(Map<String, dynamic> json) =>
    _StockVariant(
      id: (json['id'] as num?)?.toInt(),
      productVariantId: (json['product_variant_id'] as num?)?.toInt(),
      labBrand: json['lab_brand'] as String?,
      generic: json['generic'] == null
          ? null
          : StockGeneric.fromJson(json['generic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockVariantToJson(_StockVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_variant_id': instance.productVariantId,
      'lab_brand': instance.labBrand,
      'generic': instance.generic?.toJson(),
    };

_StockWarehouse _$StockWarehouseFromJson(Map<String, dynamic> json) =>
    _StockWarehouse(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StockWarehouseToJson(_StockWarehouse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

_StockItem _$StockItemFromJson(Map<String, dynamic> json) => _StockItem(
  variant: StockVariant.fromJson(json['variant'] as Map<String, dynamic>),
  warehouse: StockWarehouse.fromJson(json['warehouse'] as Map<String, dynamic>),
  totalQuantity: const DoubleConverter().fromJson(json['total_quantity']),
  reservedQuantity: const DoubleConverter().fromJson(json['reserved_quantity']),
  availableQuantity: const DoubleConverter().fromJson(
    json['available_quantity'],
  ),
  lastNote: json['last_note'] as String?,
  lastMovementAt: json['last_movement_at'] as String?,
);

Map<String, dynamic> _$StockItemToJson(_StockItem instance) =>
    <String, dynamic>{
      'variant': instance.variant.toJson(),
      'warehouse': instance.warehouse.toJson(),
      'total_quantity': const DoubleConverter().toJson(instance.totalQuantity),
      'reserved_quantity': const DoubleConverter().toJson(
        instance.reservedQuantity,
      ),
      'available_quantity': const DoubleConverter().toJson(
        instance.availableQuantity,
      ),
      'last_note': instance.lastNote,
      'last_movement_at': instance.lastMovementAt,
    };
