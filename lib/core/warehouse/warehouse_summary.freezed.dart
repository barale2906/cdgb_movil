// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WarehouseSummary {

 int get id; String get name; String? get code; bool get isActive;
/// Create a copy of WarehouseSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WarehouseSummaryCopyWith<WarehouseSummary> get copyWith => _$WarehouseSummaryCopyWithImpl<WarehouseSummary>(this as WarehouseSummary, _$identity);

  /// Serializes this WarehouseSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WarehouseSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,isActive);

@override
String toString() {
  return 'WarehouseSummary(id: $id, name: $name, code: $code, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $WarehouseSummaryCopyWith<$Res>  {
  factory $WarehouseSummaryCopyWith(WarehouseSummary value, $Res Function(WarehouseSummary) _then) = _$WarehouseSummaryCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code, bool isActive
});




}
/// @nodoc
class _$WarehouseSummaryCopyWithImpl<$Res>
    implements $WarehouseSummaryCopyWith<$Res> {
  _$WarehouseSummaryCopyWithImpl(this._self, this._then);

  final WarehouseSummary _self;
  final $Res Function(WarehouseSummary) _then;

/// Create a copy of WarehouseSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WarehouseSummary].
extension WarehouseSummaryPatterns on WarehouseSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WarehouseSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WarehouseSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WarehouseSummary value)  $default,){
final _that = this;
switch (_that) {
case _WarehouseSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WarehouseSummary value)?  $default,){
final _that = this;
switch (_that) {
case _WarehouseSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? code,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WarehouseSummary() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? code,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _WarehouseSummary():
return $default(_that.id,_that.name,_that.code,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? code,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _WarehouseSummary() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WarehouseSummary implements WarehouseSummary {
  const _WarehouseSummary({required this.id, required this.name, this.code, this.isActive = true});
  factory _WarehouseSummary.fromJson(Map<String, dynamic> json) => _$WarehouseSummaryFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;
@override@JsonKey() final  bool isActive;

/// Create a copy of WarehouseSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WarehouseSummaryCopyWith<_WarehouseSummary> get copyWith => __$WarehouseSummaryCopyWithImpl<_WarehouseSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WarehouseSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WarehouseSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,isActive);

@override
String toString() {
  return 'WarehouseSummary(id: $id, name: $name, code: $code, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$WarehouseSummaryCopyWith<$Res> implements $WarehouseSummaryCopyWith<$Res> {
  factory _$WarehouseSummaryCopyWith(_WarehouseSummary value, $Res Function(_WarehouseSummary) _then) = __$WarehouseSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code, bool isActive
});




}
/// @nodoc
class __$WarehouseSummaryCopyWithImpl<$Res>
    implements _$WarehouseSummaryCopyWith<$Res> {
  __$WarehouseSummaryCopyWithImpl(this._self, this._then);

  final _WarehouseSummary _self;
  final $Res Function(_WarehouseSummary) _then;

/// Create a copy of WarehouseSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? isActive = null,}) {
  return _then(_WarehouseSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
