import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// Usuario autenticado (`UserResource`). Los permisos mandan sobre los
/// roles: la app nunca decide por nombre de rol.
@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    required int id,
    required String name,
    required String email,
    String? phone,
    @Default(true) bool isActive,
    @Default([]) List<RoleRef> roles,
    @Default([]) List<String> permissions,
    @Default([]) List<NamedRef> warehouses,
    @Default([]) List<NamedRef> sensors,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

@freezed
abstract class RoleRef with _$RoleRef {
  const factory RoleRef({required int id, required String name}) = _RoleRef;

  factory RoleRef.fromJson(Map<String, dynamic> json) =>
      _$RoleRefFromJson(json);
}

/// Referencia con código (almacén o sensor asignado al usuario).
@freezed
abstract class NamedRef with _$NamedRef {
  const factory NamedRef({
    required int id,
    required String name,
    String? code,
  }) = _NamedRef;

  factory NamedRef.fromJson(Map<String, dynamic> json) =>
      _$NamedRefFromJson(json);
}
