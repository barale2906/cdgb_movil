// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procedure_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentPrice _$CurrentPriceFromJson(Map<String, dynamic> json) =>
    _CurrentPrice(
      unitPrice: const DoubleConverter().fromJson(json['unit_price']),
    );

Map<String, dynamic> _$CurrentPriceToJson(_CurrentPrice instance) =>
    <String, dynamic>{
      'unit_price': const DoubleConverter().toJson(instance.unitPrice),
    };

_ProcedureMatch _$ProcedureMatchFromJson(Map<String, dynamic> json) =>
    _ProcedureMatch(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
      currentPrice: json['current_price'] == null
          ? null
          : CurrentPrice.fromJson(
              json['current_price'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ProcedureMatchToJson(_ProcedureMatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'current_price': instance.currentPrice?.toJson(),
    };
