// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost_center.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CostCenter {

 int get id; String get name; String? get code; String? get type; String? get typeLabel; bool get isExternal; String? get description; bool get isActive;
/// Create a copy of CostCenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CostCenterCopyWith<CostCenter> get copyWith => _$CostCenterCopyWithImpl<CostCenter>(this as CostCenter, _$identity);

  /// Serializes this CostCenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CostCenter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.isExternal, isExternal) || other.isExternal == isExternal)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,type,typeLabel,isExternal,description,isActive);

@override
String toString() {
  return 'CostCenter(id: $id, name: $name, code: $code, type: $type, typeLabel: $typeLabel, isExternal: $isExternal, description: $description, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CostCenterCopyWith<$Res>  {
  factory $CostCenterCopyWith(CostCenter value, $Res Function(CostCenter) _then) = _$CostCenterCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code, String? type, String? typeLabel, bool isExternal, String? description, bool isActive
});




}
/// @nodoc
class _$CostCenterCopyWithImpl<$Res>
    implements $CostCenterCopyWith<$Res> {
  _$CostCenterCopyWithImpl(this._self, this._then);

  final CostCenter _self;
  final $Res Function(CostCenter) _then;

/// Create a copy of CostCenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? type = freezed,Object? typeLabel = freezed,Object? isExternal = null,Object? description = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,isExternal: null == isExternal ? _self.isExternal : isExternal // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CostCenter].
extension CostCenterPatterns on CostCenter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CostCenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CostCenter() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CostCenter value)  $default,){
final _that = this;
switch (_that) {
case _CostCenter():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CostCenter value)?  $default,){
final _that = this;
switch (_that) {
case _CostCenter() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? code,  String? type,  String? typeLabel,  bool isExternal,  String? description,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CostCenter() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.type,_that.typeLabel,_that.isExternal,_that.description,_that.isActive);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? code,  String? type,  String? typeLabel,  bool isExternal,  String? description,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _CostCenter():
return $default(_that.id,_that.name,_that.code,_that.type,_that.typeLabel,_that.isExternal,_that.description,_that.isActive);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? code,  String? type,  String? typeLabel,  bool isExternal,  String? description,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _CostCenter() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.type,_that.typeLabel,_that.isExternal,_that.description,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CostCenter implements CostCenter {
  const _CostCenter({required this.id, required this.name, this.code, this.type, this.typeLabel, this.isExternal = false, this.description, this.isActive = true});
  factory _CostCenter.fromJson(Map<String, dynamic> json) => _$CostCenterFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;
@override final  String? type;
@override final  String? typeLabel;
@override@JsonKey() final  bool isExternal;
@override final  String? description;
@override@JsonKey() final  bool isActive;

/// Create a copy of CostCenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CostCenterCopyWith<_CostCenter> get copyWith => __$CostCenterCopyWithImpl<_CostCenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CostCenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CostCenter&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.isExternal, isExternal) || other.isExternal == isExternal)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,type,typeLabel,isExternal,description,isActive);

@override
String toString() {
  return 'CostCenter(id: $id, name: $name, code: $code, type: $type, typeLabel: $typeLabel, isExternal: $isExternal, description: $description, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CostCenterCopyWith<$Res> implements $CostCenterCopyWith<$Res> {
  factory _$CostCenterCopyWith(_CostCenter value, $Res Function(_CostCenter) _then) = __$CostCenterCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code, String? type, String? typeLabel, bool isExternal, String? description, bool isActive
});




}
/// @nodoc
class __$CostCenterCopyWithImpl<$Res>
    implements _$CostCenterCopyWith<$Res> {
  __$CostCenterCopyWithImpl(this._self, this._then);

  final _CostCenter _self;
  final $Res Function(_CostCenter) _then;

/// Create a copy of CostCenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? type = freezed,Object? typeLabel = freezed,Object? isExternal = null,Object? description = freezed,Object? isActive = null,}) {
  return _then(_CostCenter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,isExternal: null == isExternal ? _self.isExternal : isExternal // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
