// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_refs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenericRef _$GenericRefFromJson(Map<String, dynamic> json) => _GenericRef(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  barcode: json['barcode'] as String?,
);

Map<String, dynamic> _$GenericRefToJson(_GenericRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'barcode': instance.barcode,
    };

_VariantRef _$VariantRefFromJson(Map<String, dynamic> json) => _VariantRef(
  id: (json['id'] as num).toInt(),
  labBrand: json['lab_brand'] as String?,
  brandSku: json['brand_sku'] as String?,
  generic: json['generic'] == null
      ? null
      : GenericRef.fromJson(json['generic'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VariantRefToJson(_VariantRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lab_brand': instance.labBrand,
      'brand_sku': instance.brandSku,
      'generic': instance.generic?.toJson(),
    };

_PresentationRef _$PresentationRefFromJson(Map<String, dynamic> json) =>
    _PresentationRef(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$PresentationRefToJson(_PresentationRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };

_TaxLine _$TaxLineFromJson(Map<String, dynamic> json) => _TaxLine(
  taxRate: const DoubleConverter().fromJson(json['tax_rate']),
  rate: const DoubleConverter().fromJson(json['rate']),
  taxableBase: const DoubleConverter().fromJson(json['taxable_base']),
  taxAmount: const DoubleConverter().fromJson(json['tax_amount']),
);

Map<String, dynamic> _$TaxLineToJson(_TaxLine instance) => <String, dynamic>{
  'tax_rate': const DoubleConverter().toJson(instance.taxRate),
  'rate': const DoubleConverter().toJson(instance.rate),
  'taxable_base': const DoubleConverter().toJson(instance.taxableBase),
  'tax_amount': const DoubleConverter().toJson(instance.taxAmount),
};
