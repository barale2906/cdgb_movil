// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  roles:
      (json['roles'] as List<dynamic>?)
          ?.map((e) => RoleRef.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  permissions:
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  warehouses:
      (json['warehouses'] as List<dynamic>?)
          ?.map((e) => NamedRef.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  sensors:
      (json['sensors'] as List<dynamic>?)
          ?.map((e) => NamedRef.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'is_active': instance.isActive,
  'roles': instance.roles.map((e) => e.toJson()).toList(),
  'permissions': instance.permissions,
  'warehouses': instance.warehouses.map((e) => e.toJson()).toList(),
  'sensors': instance.sensors.map((e) => e.toJson()).toList(),
};

_RoleRef _$RoleRefFromJson(Map<String, dynamic> json) =>
    _RoleRef(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$RoleRefToJson(_RoleRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

_NamedRef _$NamedRefFromJson(Map<String, dynamic> json) => _NamedRef(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  code: json['code'] as String?,
);

Map<String, dynamic> _$NamedRefToJson(_NamedRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
};
