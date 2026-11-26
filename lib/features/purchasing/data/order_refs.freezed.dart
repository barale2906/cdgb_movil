// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_refs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenericRef {

 int get id; String get name; String? get barcode;
/// Create a copy of GenericRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenericRefCopyWith<GenericRef> get copyWith => _$GenericRefCopyWithImpl<GenericRef>(this as GenericRef, _$identity);

  /// Serializes this GenericRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenericRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.barcode, barcode) || other.barcode == barcode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,barcode);

@override
String toString() {
  return 'GenericRef(id: $id, name: $name, barcode: $barcode)';
}


}

/// @nodoc
abstract mixin class $GenericRefCopyWith<$Res>  {
  factory $GenericRefCopyWith(GenericRef value, $Res Function(GenericRef) _then) = _$GenericRefCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? barcode
});




}
/// @nodoc
class _$GenericRefCopyWithImpl<$Res>
    implements $GenericRefCopyWith<$Res> {
  _$GenericRefCopyWithImpl(this._self, this._then);

  final GenericRef _self;
  final $Res Function(GenericRef) _then;

/// Create a copy of GenericRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? barcode = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenericRef].
extension GenericRefPatterns on GenericRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenericRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenericRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenericRef value)  $default,){
final _that = this;
switch (_that) {
case _GenericRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenericRef value)?  $default,){
final _that = this;
switch (_that) {
case _GenericRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? barcode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenericRef() when $default != null:
return $default(_that.id,_that.name,_that.barcode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? barcode)  $default,) {final _that = this;
switch (_that) {
case _GenericRef():
return $default(_that.id,_that.name,_that.barcode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? barcode)?  $default,) {final _that = this;
switch (_that) {
case _GenericRef() when $default != null:
return $default(_that.id,_that.name,_that.barcode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenericRef implements GenericRef {
  const _GenericRef({required this.id, required this.name, this.barcode});
  factory _GenericRef.fromJson(Map<String, dynamic> json) => _$GenericRefFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? barcode;

/// Create a copy of GenericRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenericRefCopyWith<_GenericRef> get copyWith => __$GenericRefCopyWithImpl<_GenericRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenericRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenericRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.barcode, barcode) || other.barcode == barcode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,barcode);

@override
String toString() {
  return 'GenericRef(id: $id, name: $name, barcode: $barcode)';
}


}

/// @nodoc
abstract mixin class _$GenericRefCopyWith<$Res> implements $GenericRefCopyWith<$Res> {
  factory _$GenericRefCopyWith(_GenericRef value, $Res Function(_GenericRef) _then) = __$GenericRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? barcode
});




}
/// @nodoc
class __$GenericRefCopyWithImpl<$Res>
    implements _$GenericRefCopyWith<$Res> {
  __$GenericRefCopyWithImpl(this._self, this._then);

  final _GenericRef _self;
  final $Res Function(_GenericRef) _then;

/// Create a copy of GenericRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? barcode = freezed,}) {
  return _then(_GenericRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VariantRef {

 int get id; String? get labBrand; String? get brandSku; GenericRef? get generic;
/// Create a copy of VariantRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantRefCopyWith<VariantRef> get copyWith => _$VariantRefCopyWithImpl<VariantRef>(this as VariantRef, _$identity);

  /// Serializes this VariantRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantRef&&(identical(other.id, id) || other.id == id)&&(identical(other.labBrand, labBrand) || other.labBrand == labBrand)&&(identical(other.brandSku, brandSku) || other.brandSku == brandSku)&&(identical(other.generic, generic) || other.generic == generic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,labBrand,brandSku,generic);

@override
String toString() {
  return 'VariantRef(id: $id, labBrand: $labBrand, brandSku: $brandSku, generic: $generic)';
}


}

/// @nodoc
abstract mixin class $VariantRefCopyWith<$Res>  {
  factory $VariantRefCopyWith(VariantRef value, $Res Function(VariantRef) _then) = _$VariantRefCopyWithImpl;
@useResult
$Res call({
 int id, String? labBrand, String? brandSku, GenericRef? generic
});


$GenericRefCopyWith<$Res>? get generic;

}
/// @nodoc
class _$VariantRefCopyWithImpl<$Res>
    implements $VariantRefCopyWith<$Res> {
  _$VariantRefCopyWithImpl(this._self, this._then);

  final VariantRef _self;
  final $Res Function(VariantRef) _then;

/// Create a copy of VariantRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? labBrand = freezed,Object? brandSku = freezed,Object? generic = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,labBrand: freezed == labBrand ? _self.labBrand : labBrand // ignore: cast_nullable_to_non_nullable
as String?,brandSku: freezed == brandSku ? _self.brandSku : brandSku // ignore: cast_nullable_to_non_nullable
as String?,generic: freezed == generic ? _self.generic : generic // ignore: cast_nullable_to_non_nullable
as GenericRef?,
  ));
}
/// Create a copy of VariantRef
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GenericRefCopyWith<$Res>? get generic {
    if (_self.generic == null) {
    return null;
  }

  return $GenericRefCopyWith<$Res>(_self.generic!, (value) {
    return _then(_self.copyWith(generic: value));
  });
}
}


/// Adds pattern-matching-related methods to [VariantRef].
extension VariantRefPatterns on VariantRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VariantRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VariantRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VariantRef value)  $default,){
final _that = this;
switch (_that) {
case _VariantRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VariantRef value)?  $default,){
final _that = this;
switch (_that) {
case _VariantRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? labBrand,  String? brandSku,  GenericRef? generic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VariantRef() when $default != null:
return $default(_that.id,_that.labBrand,_that.brandSku,_that.generic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? labBrand,  String? brandSku,  GenericRef? generic)  $default,) {final _that = this;
switch (_that) {
case _VariantRef():
return $default(_that.id,_that.labBrand,_that.brandSku,_that.generic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? labBrand,  String? brandSku,  GenericRef? generic)?  $default,) {final _that = this;
switch (_that) {
case _VariantRef() when $default != null:
return $default(_that.id,_that.labBrand,_that.brandSku,_that.generic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VariantRef implements VariantRef {
  const _VariantRef({required this.id, this.labBrand, this.brandSku, this.generic});
  factory _VariantRef.fromJson(Map<String, dynamic> json) => _$VariantRefFromJson(json);

@override final  int id;
@override final  String? labBrand;
@override final  String? brandSku;
@override final  GenericRef? generic;

/// Create a copy of VariantRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VariantRefCopyWith<_VariantRef> get copyWith => __$VariantRefCopyWithImpl<_VariantRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VariantRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VariantRef&&(identical(other.id, id) || other.id == id)&&(identical(other.labBrand, labBrand) || other.labBrand == labBrand)&&(identical(other.brandSku, brandSku) || other.brandSku == brandSku)&&(identical(other.generic, generic) || other.generic == generic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,labBrand,brandSku,generic);

@override
String toString() {
  return 'VariantRef(id: $id, labBrand: $labBrand, brandSku: $brandSku, generic: $generic)';
}


}

/// @nodoc
abstract mixin class _$VariantRefCopyWith<$Res> implements $VariantRefCopyWith<$Res> {
  factory _$VariantRefCopyWith(_VariantRef value, $Res Function(_VariantRef) _then) = __$VariantRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String? labBrand, String? brandSku, GenericRef? generic
});


@override $GenericRefCopyWith<$Res>? get generic;

}
/// @nodoc
class __$VariantRefCopyWithImpl<$Res>
    implements _$VariantRefCopyWith<$Res> {
  __$VariantRefCopyWithImpl(this._self, this._then);

  final _VariantRef _self;
  final $Res Function(_VariantRef) _then;

/// Create a copy of VariantRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? labBrand = freezed,Object? brandSku = freezed,Object? generic = freezed,}) {
  return _then(_VariantRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,labBrand: freezed == labBrand ? _self.labBrand : labBrand // ignore: cast_nullable_to_non_nullable
as String?,brandSku: freezed == brandSku ? _self.brandSku : brandSku // ignore: cast_nullable_to_non_nullable
as String?,generic: freezed == generic ? _self.generic : generic // ignore: cast_nullable_to_non_nullable
as GenericRef?,
  ));
}

/// Create a copy of VariantRef
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GenericRefCopyWith<$Res>? get generic {
    if (_self.generic == null) {
    return null;
  }

  return $GenericRefCopyWith<$Res>(_self.generic!, (value) {
    return _then(_self.copyWith(generic: value));
  });
}
}


/// @nodoc
mixin _$PresentationRef {

 int get id; String get name; String? get code;
/// Create a copy of PresentationRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresentationRefCopyWith<PresentationRef> get copyWith => _$PresentationRefCopyWithImpl<PresentationRef>(this as PresentationRef, _$identity);

  /// Serializes this PresentationRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresentationRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'PresentationRef(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class $PresentationRefCopyWith<$Res>  {
  factory $PresentationRefCopyWith(PresentationRef value, $Res Function(PresentationRef) _then) = _$PresentationRefCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code
});




}
/// @nodoc
class _$PresentationRefCopyWithImpl<$Res>
    implements $PresentationRefCopyWith<$Res> {
  _$PresentationRefCopyWithImpl(this._self, this._then);

  final PresentationRef _self;
  final $Res Function(PresentationRef) _then;

/// Create a copy of PresentationRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PresentationRef].
extension PresentationRefPatterns on PresentationRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PresentationRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PresentationRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PresentationRef value)  $default,){
final _that = this;
switch (_that) {
case _PresentationRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PresentationRef value)?  $default,){
final _that = this;
switch (_that) {
case _PresentationRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PresentationRef() when $default != null:
return $default(_that.id,_that.name,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? code)  $default,) {final _that = this;
switch (_that) {
case _PresentationRef():
return $default(_that.id,_that.name,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? code)?  $default,) {final _that = this;
switch (_that) {
case _PresentationRef() when $default != null:
return $default(_that.id,_that.name,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PresentationRef implements PresentationRef {
  const _PresentationRef({required this.id, required this.name, this.code});
  factory _PresentationRef.fromJson(Map<String, dynamic> json) => _$PresentationRefFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;

/// Create a copy of PresentationRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PresentationRefCopyWith<_PresentationRef> get copyWith => __$PresentationRefCopyWithImpl<_PresentationRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PresentationRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PresentationRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'PresentationRef(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class _$PresentationRefCopyWith<$Res> implements $PresentationRefCopyWith<$Res> {
  factory _$PresentationRefCopyWith(_PresentationRef value, $Res Function(_PresentationRef) _then) = __$PresentationRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code
});




}
/// @nodoc
class __$PresentationRefCopyWithImpl<$Res>
    implements _$PresentationRefCopyWith<$Res> {
  __$PresentationRefCopyWithImpl(this._self, this._then);

  final _PresentationRef _self;
  final $Res Function(_PresentationRef) _then;

/// Create a copy of PresentationRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,}) {
  return _then(_PresentationRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TaxLine {

@DoubleConverter() double? get taxRate;@DoubleConverter() double? get rate;@DoubleConverter() double? get taxableBase;@DoubleConverter() double? get taxAmount;
/// Create a copy of TaxLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxLineCopyWith<TaxLine> get copyWith => _$TaxLineCopyWithImpl<TaxLine>(this as TaxLine, _$identity);

  /// Serializes this TaxLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxLine&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.taxableBase, taxableBase) || other.taxableBase == taxableBase)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taxRate,rate,taxableBase,taxAmount);

@override
String toString() {
  return 'TaxLine(taxRate: $taxRate, rate: $rate, taxableBase: $taxableBase, taxAmount: $taxAmount)';
}


}

/// @nodoc
abstract mixin class $TaxLineCopyWith<$Res>  {
  factory $TaxLineCopyWith(TaxLine value, $Res Function(TaxLine) _then) = _$TaxLineCopyWithImpl;
@useResult
$Res call({
@DoubleConverter() double? taxRate,@DoubleConverter() double? rate,@DoubleConverter() double? taxableBase,@DoubleConverter() double? taxAmount
});




}
/// @nodoc
class _$TaxLineCopyWithImpl<$Res>
    implements $TaxLineCopyWith<$Res> {
  _$TaxLineCopyWithImpl(this._self, this._then);

  final TaxLine _self;
  final $Res Function(TaxLine) _then;

/// Create a copy of TaxLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taxRate = freezed,Object? rate = freezed,Object? taxableBase = freezed,Object? taxAmount = freezed,}) {
  return _then(_self.copyWith(
taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,taxableBase: freezed == taxableBase ? _self.taxableBase : taxableBase // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaxLine].
extension TaxLinePatterns on TaxLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxLine value)  $default,){
final _that = this;
switch (_that) {
case _TaxLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxLine value)?  $default,){
final _that = this;
switch (_that) {
case _TaxLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DoubleConverter()  double? taxRate, @DoubleConverter()  double? rate, @DoubleConverter()  double? taxableBase, @DoubleConverter()  double? taxAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxLine() when $default != null:
return $default(_that.taxRate,_that.rate,_that.taxableBase,_that.taxAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DoubleConverter()  double? taxRate, @DoubleConverter()  double? rate, @DoubleConverter()  double? taxableBase, @DoubleConverter()  double? taxAmount)  $default,) {final _that = this;
switch (_that) {
case _TaxLine():
return $default(_that.taxRate,_that.rate,_that.taxableBase,_that.taxAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DoubleConverter()  double? taxRate, @DoubleConverter()  double? rate, @DoubleConverter()  double? taxableBase, @DoubleConverter()  double? taxAmount)?  $default,) {final _that = this;
switch (_that) {
case _TaxLine() when $default != null:
return $default(_that.taxRate,_that.rate,_that.taxableBase,_that.taxAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaxLine implements TaxLine {
  const _TaxLine({@DoubleConverter() this.taxRate, @DoubleConverter() this.rate, @DoubleConverter() this.taxableBase, @DoubleConverter() this.taxAmount});
  factory _TaxLine.fromJson(Map<String, dynamic> json) => _$TaxLineFromJson(json);

@override@DoubleConverter() final  double? taxRate;
@override@DoubleConverter() final  double? rate;
@override@DoubleConverter() final  double? taxableBase;
@override@DoubleConverter() final  double? taxAmount;

/// Create a copy of TaxLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxLineCopyWith<_TaxLine> get copyWith => __$TaxLineCopyWithImpl<_TaxLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaxLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxLine&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.taxableBase, taxableBase) || other.taxableBase == taxableBase)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taxRate,rate,taxableBase,taxAmount);

@override
String toString() {
  return 'TaxLine(taxRate: $taxRate, rate: $rate, taxableBase: $taxableBase, taxAmount: $taxAmount)';
}


}

/// @nodoc
abstract mixin class _$TaxLineCopyWith<$Res> implements $TaxLineCopyWith<$Res> {
  factory _$TaxLineCopyWith(_TaxLine value, $Res Function(_TaxLine) _then) = __$TaxLineCopyWithImpl;
@override @useResult
$Res call({
@DoubleConverter() double? taxRate,@DoubleConverter() double? rate,@DoubleConverter() double? taxableBase,@DoubleConverter() double? taxAmount
});




}
/// @nodoc
class __$TaxLineCopyWithImpl<$Res>
    implements _$TaxLineCopyWith<$Res> {
  __$TaxLineCopyWithImpl(this._self, this._then);

  final _TaxLine _self;
  final $Res Function(_TaxLine) _then;

/// Create a copy of TaxLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taxRate = freezed,Object? rate = freezed,Object? taxableBase = freezed,Object? taxAmount = freezed,}) {
  return _then(_TaxLine(
taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,taxableBase: freezed == taxableBase ? _self.taxableBase : taxableBase // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
