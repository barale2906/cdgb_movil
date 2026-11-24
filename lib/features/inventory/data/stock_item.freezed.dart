// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockCategory {

 int get id; String get name;
/// Create a copy of StockCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockCategoryCopyWith<StockCategory> get copyWith => _$StockCategoryCopyWithImpl<StockCategory>(this as StockCategory, _$identity);

  /// Serializes this StockCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'StockCategory(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $StockCategoryCopyWith<$Res>  {
  factory $StockCategoryCopyWith(StockCategory value, $Res Function(StockCategory) _then) = _$StockCategoryCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$StockCategoryCopyWithImpl<$Res>
    implements $StockCategoryCopyWith<$Res> {
  _$StockCategoryCopyWithImpl(this._self, this._then);

  final StockCategory _self;
  final $Res Function(StockCategory) _then;

/// Create a copy of StockCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StockCategory].
extension StockCategoryPatterns on StockCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockCategory value)  $default,){
final _that = this;
switch (_that) {
case _StockCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockCategory value)?  $default,){
final _that = this;
switch (_that) {
case _StockCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockCategory() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name)  $default,) {final _that = this;
switch (_that) {
case _StockCategory():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _StockCategory() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockCategory implements StockCategory {
  const _StockCategory({required this.id, required this.name});
  factory _StockCategory.fromJson(Map<String, dynamic> json) => _$StockCategoryFromJson(json);

@override final  int id;
@override final  String name;

/// Create a copy of StockCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockCategoryCopyWith<_StockCategory> get copyWith => __$StockCategoryCopyWithImpl<_StockCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'StockCategory(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$StockCategoryCopyWith<$Res> implements $StockCategoryCopyWith<$Res> {
  factory _$StockCategoryCopyWith(_StockCategory value, $Res Function(_StockCategory) _then) = __$StockCategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$StockCategoryCopyWithImpl<$Res>
    implements _$StockCategoryCopyWith<$Res> {
  __$StockCategoryCopyWithImpl(this._self, this._then);

  final _StockCategory _self;
  final $Res Function(_StockCategory) _then;

/// Create a copy of StockCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_StockCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StockGeneric {

 int get id; String get name; String? get barcode; StockCategory? get category;
/// Create a copy of StockGeneric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockGenericCopyWith<StockGeneric> get copyWith => _$StockGenericCopyWithImpl<StockGeneric>(this as StockGeneric, _$identity);

  /// Serializes this StockGeneric to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockGeneric&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,barcode,category);

@override
String toString() {
  return 'StockGeneric(id: $id, name: $name, barcode: $barcode, category: $category)';
}


}

/// @nodoc
abstract mixin class $StockGenericCopyWith<$Res>  {
  factory $StockGenericCopyWith(StockGeneric value, $Res Function(StockGeneric) _then) = _$StockGenericCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? barcode, StockCategory? category
});


$StockCategoryCopyWith<$Res>? get category;

}
/// @nodoc
class _$StockGenericCopyWithImpl<$Res>
    implements $StockGenericCopyWith<$Res> {
  _$StockGenericCopyWithImpl(this._self, this._then);

  final StockGeneric _self;
  final $Res Function(StockGeneric) _then;

/// Create a copy of StockGeneric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? barcode = freezed,Object? category = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as StockCategory?,
  ));
}
/// Create a copy of StockGeneric
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockCategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $StockCategoryCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [StockGeneric].
extension StockGenericPatterns on StockGeneric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockGeneric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockGeneric() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockGeneric value)  $default,){
final _that = this;
switch (_that) {
case _StockGeneric():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockGeneric value)?  $default,){
final _that = this;
switch (_that) {
case _StockGeneric() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? barcode,  StockCategory? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockGeneric() when $default != null:
return $default(_that.id,_that.name,_that.barcode,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? barcode,  StockCategory? category)  $default,) {final _that = this;
switch (_that) {
case _StockGeneric():
return $default(_that.id,_that.name,_that.barcode,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? barcode,  StockCategory? category)?  $default,) {final _that = this;
switch (_that) {
case _StockGeneric() when $default != null:
return $default(_that.id,_that.name,_that.barcode,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockGeneric implements StockGeneric {
  const _StockGeneric({required this.id, required this.name, this.barcode, this.category});
  factory _StockGeneric.fromJson(Map<String, dynamic> json) => _$StockGenericFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? barcode;
@override final  StockCategory? category;

/// Create a copy of StockGeneric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockGenericCopyWith<_StockGeneric> get copyWith => __$StockGenericCopyWithImpl<_StockGeneric>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockGenericToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockGeneric&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,barcode,category);

@override
String toString() {
  return 'StockGeneric(id: $id, name: $name, barcode: $barcode, category: $category)';
}


}

/// @nodoc
abstract mixin class _$StockGenericCopyWith<$Res> implements $StockGenericCopyWith<$Res> {
  factory _$StockGenericCopyWith(_StockGeneric value, $Res Function(_StockGeneric) _then) = __$StockGenericCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? barcode, StockCategory? category
});


@override $StockCategoryCopyWith<$Res>? get category;

}
/// @nodoc
class __$StockGenericCopyWithImpl<$Res>
    implements _$StockGenericCopyWith<$Res> {
  __$StockGenericCopyWithImpl(this._self, this._then);

  final _StockGeneric _self;
  final $Res Function(_StockGeneric) _then;

/// Create a copy of StockGeneric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? barcode = freezed,Object? category = freezed,}) {
  return _then(_StockGeneric(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as StockCategory?,
  ));
}

/// Create a copy of StockGeneric
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockCategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $StockCategoryCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// @nodoc
mixin _$StockVariant {

 int? get id; int? get productVariantId; String? get labBrand; StockGeneric? get generic;
/// Create a copy of StockVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockVariantCopyWith<StockVariant> get copyWith => _$StockVariantCopyWithImpl<StockVariant>(this as StockVariant, _$identity);

  /// Serializes this StockVariant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.productVariantId, productVariantId) || other.productVariantId == productVariantId)&&(identical(other.labBrand, labBrand) || other.labBrand == labBrand)&&(identical(other.generic, generic) || other.generic == generic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productVariantId,labBrand,generic);

@override
String toString() {
  return 'StockVariant(id: $id, productVariantId: $productVariantId, labBrand: $labBrand, generic: $generic)';
}


}

/// @nodoc
abstract mixin class $StockVariantCopyWith<$Res>  {
  factory $StockVariantCopyWith(StockVariant value, $Res Function(StockVariant) _then) = _$StockVariantCopyWithImpl;
@useResult
$Res call({
 int? id, int? productVariantId, String? labBrand, StockGeneric? generic
});


$StockGenericCopyWith<$Res>? get generic;

}
/// @nodoc
class _$StockVariantCopyWithImpl<$Res>
    implements $StockVariantCopyWith<$Res> {
  _$StockVariantCopyWithImpl(this._self, this._then);

  final StockVariant _self;
  final $Res Function(StockVariant) _then;

/// Create a copy of StockVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? productVariantId = freezed,Object? labBrand = freezed,Object? generic = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,productVariantId: freezed == productVariantId ? _self.productVariantId : productVariantId // ignore: cast_nullable_to_non_nullable
as int?,labBrand: freezed == labBrand ? _self.labBrand : labBrand // ignore: cast_nullable_to_non_nullable
as String?,generic: freezed == generic ? _self.generic : generic // ignore: cast_nullable_to_non_nullable
as StockGeneric?,
  ));
}
/// Create a copy of StockVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockGenericCopyWith<$Res>? get generic {
    if (_self.generic == null) {
    return null;
  }

  return $StockGenericCopyWith<$Res>(_self.generic!, (value) {
    return _then(_self.copyWith(generic: value));
  });
}
}


/// Adds pattern-matching-related methods to [StockVariant].
extension StockVariantPatterns on StockVariant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockVariant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockVariant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockVariant value)  $default,){
final _that = this;
switch (_that) {
case _StockVariant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockVariant value)?  $default,){
final _that = this;
switch (_that) {
case _StockVariant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? productVariantId,  String? labBrand,  StockGeneric? generic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockVariant() when $default != null:
return $default(_that.id,_that.productVariantId,_that.labBrand,_that.generic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? productVariantId,  String? labBrand,  StockGeneric? generic)  $default,) {final _that = this;
switch (_that) {
case _StockVariant():
return $default(_that.id,_that.productVariantId,_that.labBrand,_that.generic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? productVariantId,  String? labBrand,  StockGeneric? generic)?  $default,) {final _that = this;
switch (_that) {
case _StockVariant() when $default != null:
return $default(_that.id,_that.productVariantId,_that.labBrand,_that.generic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockVariant implements StockVariant {
  const _StockVariant({this.id, this.productVariantId, this.labBrand, this.generic});
  factory _StockVariant.fromJson(Map<String, dynamic> json) => _$StockVariantFromJson(json);

@override final  int? id;
@override final  int? productVariantId;
@override final  String? labBrand;
@override final  StockGeneric? generic;

/// Create a copy of StockVariant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockVariantCopyWith<_StockVariant> get copyWith => __$StockVariantCopyWithImpl<_StockVariant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockVariantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.productVariantId, productVariantId) || other.productVariantId == productVariantId)&&(identical(other.labBrand, labBrand) || other.labBrand == labBrand)&&(identical(other.generic, generic) || other.generic == generic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productVariantId,labBrand,generic);

@override
String toString() {
  return 'StockVariant(id: $id, productVariantId: $productVariantId, labBrand: $labBrand, generic: $generic)';
}


}

/// @nodoc
abstract mixin class _$StockVariantCopyWith<$Res> implements $StockVariantCopyWith<$Res> {
  factory _$StockVariantCopyWith(_StockVariant value, $Res Function(_StockVariant) _then) = __$StockVariantCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? productVariantId, String? labBrand, StockGeneric? generic
});


@override $StockGenericCopyWith<$Res>? get generic;

}
/// @nodoc
class __$StockVariantCopyWithImpl<$Res>
    implements _$StockVariantCopyWith<$Res> {
  __$StockVariantCopyWithImpl(this._self, this._then);

  final _StockVariant _self;
  final $Res Function(_StockVariant) _then;

/// Create a copy of StockVariant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? productVariantId = freezed,Object? labBrand = freezed,Object? generic = freezed,}) {
  return _then(_StockVariant(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,productVariantId: freezed == productVariantId ? _self.productVariantId : productVariantId // ignore: cast_nullable_to_non_nullable
as int?,labBrand: freezed == labBrand ? _self.labBrand : labBrand // ignore: cast_nullable_to_non_nullable
as String?,generic: freezed == generic ? _self.generic : generic // ignore: cast_nullable_to_non_nullable
as StockGeneric?,
  ));
}

/// Create a copy of StockVariant
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockGenericCopyWith<$Res>? get generic {
    if (_self.generic == null) {
    return null;
  }

  return $StockGenericCopyWith<$Res>(_self.generic!, (value) {
    return _then(_self.copyWith(generic: value));
  });
}
}


/// @nodoc
mixin _$StockWarehouse {

 int get id; String? get code; String? get name;
/// Create a copy of StockWarehouse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockWarehouseCopyWith<StockWarehouse> get copyWith => _$StockWarehouseCopyWithImpl<StockWarehouse>(this as StockWarehouse, _$identity);

  /// Serializes this StockWarehouse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockWarehouse&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name);

@override
String toString() {
  return 'StockWarehouse(id: $id, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $StockWarehouseCopyWith<$Res>  {
  factory $StockWarehouseCopyWith(StockWarehouse value, $Res Function(StockWarehouse) _then) = _$StockWarehouseCopyWithImpl;
@useResult
$Res call({
 int id, String? code, String? name
});




}
/// @nodoc
class _$StockWarehouseCopyWithImpl<$Res>
    implements $StockWarehouseCopyWith<$Res> {
  _$StockWarehouseCopyWithImpl(this._self, this._then);

  final StockWarehouse _self;
  final $Res Function(StockWarehouse) _then;

/// Create a copy of StockWarehouse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockWarehouse].
extension StockWarehousePatterns on StockWarehouse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockWarehouse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockWarehouse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockWarehouse value)  $default,){
final _that = this;
switch (_that) {
case _StockWarehouse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockWarehouse value)?  $default,){
final _that = this;
switch (_that) {
case _StockWarehouse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? code,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockWarehouse() when $default != null:
return $default(_that.id,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? code,  String? name)  $default,) {final _that = this;
switch (_that) {
case _StockWarehouse():
return $default(_that.id,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? code,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _StockWarehouse() when $default != null:
return $default(_that.id,_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockWarehouse implements StockWarehouse {
  const _StockWarehouse({required this.id, this.code, this.name});
  factory _StockWarehouse.fromJson(Map<String, dynamic> json) => _$StockWarehouseFromJson(json);

@override final  int id;
@override final  String? code;
@override final  String? name;

/// Create a copy of StockWarehouse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockWarehouseCopyWith<_StockWarehouse> get copyWith => __$StockWarehouseCopyWithImpl<_StockWarehouse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockWarehouseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockWarehouse&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name);

@override
String toString() {
  return 'StockWarehouse(id: $id, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$StockWarehouseCopyWith<$Res> implements $StockWarehouseCopyWith<$Res> {
  factory _$StockWarehouseCopyWith(_StockWarehouse value, $Res Function(_StockWarehouse) _then) = __$StockWarehouseCopyWithImpl;
@override @useResult
$Res call({
 int id, String? code, String? name
});




}
/// @nodoc
class __$StockWarehouseCopyWithImpl<$Res>
    implements _$StockWarehouseCopyWith<$Res> {
  __$StockWarehouseCopyWithImpl(this._self, this._then);

  final _StockWarehouse _self;
  final $Res Function(_StockWarehouse) _then;

/// Create a copy of StockWarehouse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = freezed,Object? name = freezed,}) {
  return _then(_StockWarehouse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StockItem {

 StockVariant get variant; StockWarehouse get warehouse;@DoubleConverter() double? get totalQuantity;@DoubleConverter() double? get reservedQuantity;@DoubleConverter() double? get availableQuantity; String? get lastNote; String? get lastMovementAt;
/// Create a copy of StockItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockItemCopyWith<StockItem> get copyWith => _$StockItemCopyWithImpl<StockItem>(this as StockItem, _$identity);

  /// Serializes this StockItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockItem&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.warehouse, warehouse) || other.warehouse == warehouse)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.reservedQuantity, reservedQuantity) || other.reservedQuantity == reservedQuantity)&&(identical(other.availableQuantity, availableQuantity) || other.availableQuantity == availableQuantity)&&(identical(other.lastNote, lastNote) || other.lastNote == lastNote)&&(identical(other.lastMovementAt, lastMovementAt) || other.lastMovementAt == lastMovementAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,variant,warehouse,totalQuantity,reservedQuantity,availableQuantity,lastNote,lastMovementAt);

@override
String toString() {
  return 'StockItem(variant: $variant, warehouse: $warehouse, totalQuantity: $totalQuantity, reservedQuantity: $reservedQuantity, availableQuantity: $availableQuantity, lastNote: $lastNote, lastMovementAt: $lastMovementAt)';
}


}

/// @nodoc
abstract mixin class $StockItemCopyWith<$Res>  {
  factory $StockItemCopyWith(StockItem value, $Res Function(StockItem) _then) = _$StockItemCopyWithImpl;
@useResult
$Res call({
 StockVariant variant, StockWarehouse warehouse,@DoubleConverter() double? totalQuantity,@DoubleConverter() double? reservedQuantity,@DoubleConverter() double? availableQuantity, String? lastNote, String? lastMovementAt
});


$StockVariantCopyWith<$Res> get variant;$StockWarehouseCopyWith<$Res> get warehouse;

}
/// @nodoc
class _$StockItemCopyWithImpl<$Res>
    implements $StockItemCopyWith<$Res> {
  _$StockItemCopyWithImpl(this._self, this._then);

  final StockItem _self;
  final $Res Function(StockItem) _then;

/// Create a copy of StockItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? variant = null,Object? warehouse = null,Object? totalQuantity = freezed,Object? reservedQuantity = freezed,Object? availableQuantity = freezed,Object? lastNote = freezed,Object? lastMovementAt = freezed,}) {
  return _then(_self.copyWith(
variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as StockVariant,warehouse: null == warehouse ? _self.warehouse : warehouse // ignore: cast_nullable_to_non_nullable
as StockWarehouse,totalQuantity: freezed == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as double?,reservedQuantity: freezed == reservedQuantity ? _self.reservedQuantity : reservedQuantity // ignore: cast_nullable_to_non_nullable
as double?,availableQuantity: freezed == availableQuantity ? _self.availableQuantity : availableQuantity // ignore: cast_nullable_to_non_nullable
as double?,lastNote: freezed == lastNote ? _self.lastNote : lastNote // ignore: cast_nullable_to_non_nullable
as String?,lastMovementAt: freezed == lastMovementAt ? _self.lastMovementAt : lastMovementAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of StockItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockVariantCopyWith<$Res> get variant {
  
  return $StockVariantCopyWith<$Res>(_self.variant, (value) {
    return _then(_self.copyWith(variant: value));
  });
}/// Create a copy of StockItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockWarehouseCopyWith<$Res> get warehouse {
  
  return $StockWarehouseCopyWith<$Res>(_self.warehouse, (value) {
    return _then(_self.copyWith(warehouse: value));
  });
}
}


/// Adds pattern-matching-related methods to [StockItem].
extension StockItemPatterns on StockItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockItem value)  $default,){
final _that = this;
switch (_that) {
case _StockItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockItem value)?  $default,){
final _that = this;
switch (_that) {
case _StockItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StockVariant variant,  StockWarehouse warehouse, @DoubleConverter()  double? totalQuantity, @DoubleConverter()  double? reservedQuantity, @DoubleConverter()  double? availableQuantity,  String? lastNote,  String? lastMovementAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockItem() when $default != null:
return $default(_that.variant,_that.warehouse,_that.totalQuantity,_that.reservedQuantity,_that.availableQuantity,_that.lastNote,_that.lastMovementAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StockVariant variant,  StockWarehouse warehouse, @DoubleConverter()  double? totalQuantity, @DoubleConverter()  double? reservedQuantity, @DoubleConverter()  double? availableQuantity,  String? lastNote,  String? lastMovementAt)  $default,) {final _that = this;
switch (_that) {
case _StockItem():
return $default(_that.variant,_that.warehouse,_that.totalQuantity,_that.reservedQuantity,_that.availableQuantity,_that.lastNote,_that.lastMovementAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StockVariant variant,  StockWarehouse warehouse, @DoubleConverter()  double? totalQuantity, @DoubleConverter()  double? reservedQuantity, @DoubleConverter()  double? availableQuantity,  String? lastNote,  String? lastMovementAt)?  $default,) {final _that = this;
switch (_that) {
case _StockItem() when $default != null:
return $default(_that.variant,_that.warehouse,_that.totalQuantity,_that.reservedQuantity,_that.availableQuantity,_that.lastNote,_that.lastMovementAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockItem extends StockItem {
  const _StockItem({required this.variant, required this.warehouse, @DoubleConverter() this.totalQuantity, @DoubleConverter() this.reservedQuantity, @DoubleConverter() this.availableQuantity, this.lastNote, this.lastMovementAt}): super._();
  factory _StockItem.fromJson(Map<String, dynamic> json) => _$StockItemFromJson(json);

@override final  StockVariant variant;
@override final  StockWarehouse warehouse;
@override@DoubleConverter() final  double? totalQuantity;
@override@DoubleConverter() final  double? reservedQuantity;
@override@DoubleConverter() final  double? availableQuantity;
@override final  String? lastNote;
@override final  String? lastMovementAt;

/// Create a copy of StockItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockItemCopyWith<_StockItem> get copyWith => __$StockItemCopyWithImpl<_StockItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockItem&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.warehouse, warehouse) || other.warehouse == warehouse)&&(identical(other.totalQuantity, totalQuantity) || other.totalQuantity == totalQuantity)&&(identical(other.reservedQuantity, reservedQuantity) || other.reservedQuantity == reservedQuantity)&&(identical(other.availableQuantity, availableQuantity) || other.availableQuantity == availableQuantity)&&(identical(other.lastNote, lastNote) || other.lastNote == lastNote)&&(identical(other.lastMovementAt, lastMovementAt) || other.lastMovementAt == lastMovementAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,variant,warehouse,totalQuantity,reservedQuantity,availableQuantity,lastNote,lastMovementAt);

@override
String toString() {
  return 'StockItem(variant: $variant, warehouse: $warehouse, totalQuantity: $totalQuantity, reservedQuantity: $reservedQuantity, availableQuantity: $availableQuantity, lastNote: $lastNote, lastMovementAt: $lastMovementAt)';
}


}

/// @nodoc
abstract mixin class _$StockItemCopyWith<$Res> implements $StockItemCopyWith<$Res> {
  factory _$StockItemCopyWith(_StockItem value, $Res Function(_StockItem) _then) = __$StockItemCopyWithImpl;
@override @useResult
$Res call({
 StockVariant variant, StockWarehouse warehouse,@DoubleConverter() double? totalQuantity,@DoubleConverter() double? reservedQuantity,@DoubleConverter() double? availableQuantity, String? lastNote, String? lastMovementAt
});


@override $StockVariantCopyWith<$Res> get variant;@override $StockWarehouseCopyWith<$Res> get warehouse;

}
/// @nodoc
class __$StockItemCopyWithImpl<$Res>
    implements _$StockItemCopyWith<$Res> {
  __$StockItemCopyWithImpl(this._self, this._then);

  final _StockItem _self;
  final $Res Function(_StockItem) _then;

/// Create a copy of StockItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? variant = null,Object? warehouse = null,Object? totalQuantity = freezed,Object? reservedQuantity = freezed,Object? availableQuantity = freezed,Object? lastNote = freezed,Object? lastMovementAt = freezed,}) {
  return _then(_StockItem(
variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as StockVariant,warehouse: null == warehouse ? _self.warehouse : warehouse // ignore: cast_nullable_to_non_nullable
as StockWarehouse,totalQuantity: freezed == totalQuantity ? _self.totalQuantity : totalQuantity // ignore: cast_nullable_to_non_nullable
as double?,reservedQuantity: freezed == reservedQuantity ? _self.reservedQuantity : reservedQuantity // ignore: cast_nullable_to_non_nullable
as double?,availableQuantity: freezed == availableQuantity ? _self.availableQuantity : availableQuantity // ignore: cast_nullable_to_non_nullable
as double?,lastNote: freezed == lastNote ? _self.lastNote : lastNote // ignore: cast_nullable_to_non_nullable
as String?,lastMovementAt: freezed == lastMovementAt ? _self.lastMovementAt : lastMovementAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of StockItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockVariantCopyWith<$Res> get variant {
  
  return $StockVariantCopyWith<$Res>(_self.variant, (value) {
    return _then(_self.copyWith(variant: value));
  });
}/// Create a copy of StockItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockWarehouseCopyWith<$Res> get warehouse {
  
  return $StockWarehouseCopyWith<$Res>(_self.warehouse, (value) {
    return _then(_self.copyWith(warehouse: value));
  });
}
}

// dart format on
