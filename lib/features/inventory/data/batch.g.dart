// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BatchZone _$BatchZoneFromJson(Map<String, dynamic> json) => _BatchZone(
  warehouseId: (json['warehouse_id'] as num?)?.toInt(),
  warehouseName: json['warehouse_name'] as String?,
  zoneName: json['zone_name'] as String?,
);

Map<String, dynamic> _$BatchZoneToJson(_BatchZone instance) =>
    <String, dynamic>{
      'warehouse_id': instance.warehouseId,
      'warehouse_name': instance.warehouseName,
      'zone_name': instance.zoneName,
    };

_BatchLocation _$BatchLocationFromJson(Map<String, dynamic> json) =>
    _BatchLocation(
      locationId: (json['location_id'] as num).toInt(),
      locationName: json['location_name'] as String?,
      locationCode: json['location_code'] as String?,
      quantity: const DoubleConverter().fromJson(json['quantity']),
      zone: json['zone'] == null
          ? null
          : BatchZone.fromJson(json['zone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BatchLocationToJson(_BatchLocation instance) =>
    <String, dynamic>{
      'location_id': instance.locationId,
      'location_name': instance.locationName,
      'location_code': instance.locationCode,
      'quantity': const DoubleConverter().toJson(instance.quantity),
      'zone': instance.zone?.toJson(),
    };

_Batch _$BatchFromJson(Map<String, dynamic> json) => _Batch(
  id: (json['id'] as num).toInt(),
  lotNumber: json['lot_number'] as String,
  productVariantId: (json['product_variant_id'] as num?)?.toInt(),
  expirationDate: json['expiration_date'] as String?,
  manufacturingDate: json['manufacturing_date'] as String?,
  quantityAvailable: const DoubleConverter().fromJson(
    json['quantity_available'],
  ),
  totalQuantityAvailable: const DoubleConverter().fromJson(
    json['total_quantity_available'],
  ),
  status: json['status'] == null
      ? BatchStatus.unknown
      : const BatchStatusConverter().fromJson(json['status']),
  daysUntilExpiry: (json['days_until_expiry'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  variant: json['variant'] == null
      ? null
      : StockVariant.fromJson(json['variant'] as Map<String, dynamic>),
  locations:
      (json['locations'] as List<dynamic>?)
          ?.map((e) => BatchLocation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$BatchToJson(_Batch instance) => <String, dynamic>{
  'id': instance.id,
  'lot_number': instance.lotNumber,
  'product_variant_id': instance.productVariantId,
  'expiration_date': instance.expirationDate,
  'manufacturing_date': instance.manufacturingDate,
  'quantity_available': const DoubleConverter().toJson(
    instance.quantityAvailable,
  ),
  'total_quantity_available': const DoubleConverter().toJson(
    instance.totalQuantityAvailable,
  ),
  'status': const BatchStatusConverter().toJson(instance.status),
  'days_until_expiry': instance.daysUntilExpiry,
  'notes': instance.notes,
  'variant': instance.variant?.toJson(),
  'locations': instance.locations.map((e) => e.toJson()).toList(),
};
