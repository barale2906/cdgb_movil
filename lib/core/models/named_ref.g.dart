// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'named_ref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NamedRef _$NamedRefFromJson(Map<String, dynamic> json) => _NamedRef(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  code: json['code'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$NamedRefToJson(_NamedRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'email': instance.email,
};
