// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_presentation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductPresentation {

 int get id; String get name; String? get code;@DoubleConverter() double? get factorToBase; bool get isActive;
/// Create a copy of ProductPresentation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductPresentationCopyWith<ProductPresentation> get copyWith => _$ProductPresentationCopyWithImpl<ProductPresentation>(this as ProductPresentation, _$identity);

  /// Serializes this ProductPresentation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductPresentation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.factorToBase, factorToBase) || other.factorToBase == factorToBase)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,factorToBase,isActive);

@override
String toString() {
  return 'ProductPresentation(id: $id, name: $name, code: $code, factorToBase: $factorToBase, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ProductPresentationCopyWith<$Res>  {
  factory $ProductPresentationCopyWith(ProductPresentation value, $Res Function(ProductPresentation) _then) = _$ProductPresentationCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code,@DoubleConverter() double? factorToBase, bool isActive
});




}
/// @nodoc
class _$ProductPresentationCopyWithImpl<$Res>
    implements $ProductPresentationCopyWith<$Res> {
  _$ProductPresentationCopyWithImpl(this._self, this._then);

  final ProductPresentation _self;
  final $Res Function(ProductPresentation) _then;

/// Create a copy of ProductPresentation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? factorToBase = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,factorToBase: freezed == factorToBase ? _self.factorToBase : factorToBase // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductPresentation].
extension ProductPresentationPatterns on ProductPresentation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductPresentation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductPresentation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductPresentation value)  $default,){
final _that = this;
switch (_that) {
case _ProductPresentation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductPresentation value)?  $default,){
final _that = this;
switch (_that) {
case _ProductPresentation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? code, @DoubleConverter()  double? factorToBase,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductPresentation() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.factorToBase,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? code, @DoubleConverter()  double? factorToBase,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ProductPresentation():
return $default(_that.id,_that.name,_that.code,_that.factorToBase,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? code, @DoubleConverter()  double? factorToBase,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ProductPresentation() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.factorToBase,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductPresentation implements ProductPresentation {
  const _ProductPresentation({required this.id, required this.name, this.code, @DoubleConverter() this.factorToBase, this.isActive = true});
  factory _ProductPresentation.fromJson(Map<String, dynamic> json) => _$ProductPresentationFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;
@override@DoubleConverter() final  double? factorToBase;
@override@JsonKey() final  bool isActive;

/// Create a copy of ProductPresentation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductPresentationCopyWith<_ProductPresentation> get copyWith => __$ProductPresentationCopyWithImpl<_ProductPresentation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductPresentationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductPresentation&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.factorToBase, factorToBase) || other.factorToBase == factorToBase)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,factorToBase,isActive);

@override
String toString() {
  return 'ProductPresentation(id: $id, name: $name, code: $code, factorToBase: $factorToBase, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ProductPresentationCopyWith<$Res> implements $ProductPresentationCopyWith<$Res> {
  factory _$ProductPresentationCopyWith(_ProductPresentation value, $Res Function(_ProductPresentation) _then) = __$ProductPresentationCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code,@DoubleConverter() double? factorToBase, bool isActive
});




}
/// @nodoc
class __$ProductPresentationCopyWithImpl<$Res>
    implements _$ProductPresentationCopyWith<$Res> {
  __$ProductPresentationCopyWithImpl(this._self, this._then);

  final _ProductPresentation _self;
  final $Res Function(_ProductPresentation) _then;

/// Create a copy of ProductPresentation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? factorToBase = freezed,Object? isActive = null,}) {
  return _then(_ProductPresentation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,factorToBase: freezed == factorToBase ? _self.factorToBase : factorToBase // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
