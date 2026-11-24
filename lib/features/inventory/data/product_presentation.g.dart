// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_presentation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductPresentation _$ProductPresentationFromJson(Map<String, dynamic> json) =>
    _ProductPresentation(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
      factorToBase: const DoubleConverter().fromJson(json['factor_to_base']),
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$ProductPresentationToJson(
  _ProductPresentation instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'factor_to_base': const DoubleConverter().toJson(instance.factorToBase),
  'is_active': instance.isActive,
};
