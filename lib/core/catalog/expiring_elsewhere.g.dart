// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expiring_elsewhere.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpiringBatch _$ExpiringBatchFromJson(Map<String, dynamic> json) =>
    _ExpiringBatch(
      batchId: (json['batch_id'] as num).toInt(),
      lotNumber: json['lot_number'] as String,
      expirationDate: json['expiration_date'] as String?,
      daysUntilExpiry: (json['days_until_expiry'] as num?)?.toInt() ?? 0,
      labBrand: json['lab_brand'] as String?,
      warehouse: json['warehouse'] == null
          ? null
          : NamedRef.fromJson(json['warehouse'] as Map<String, dynamic>),
      quantity: const DoubleConverter().fromJson(json['quantity']),
    );

Map<String, dynamic> _$ExpiringBatchToJson(_ExpiringBatch instance) =>
    <String, dynamic>{
      'batch_id': instance.batchId,
      'lot_number': instance.lotNumber,
      'expiration_date': instance.expirationDate,
      'days_until_expiry': instance.daysUntilExpiry,
      'lab_brand': instance.labBrand,
      'warehouse': instance.warehouse?.toJson(),
      'quantity': const DoubleConverter().toJson(instance.quantity),
    };

_ExpiringElsewhere _$ExpiringElsewhereFromJson(Map<String, dynamic> json) =>
    _ExpiringElsewhere(
      days: (json['days'] as num?)?.toInt() ?? 0,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ExpiringBatch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExpiringElsewhereToJson(_ExpiringElsewhere instance) =>
    <String, dynamic>{
      'days': instance.days,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
