// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'procedure_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentPrice {

@DoubleConverter() double? get unitPrice;
/// Create a copy of CurrentPrice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentPriceCopyWith<CurrentPrice> get copyWith => _$CurrentPriceCopyWithImpl<CurrentPrice>(this as CurrentPrice, _$identity);

  /// Serializes this CurrentPrice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentPrice&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unitPrice);

@override
String toString() {
  return 'CurrentPrice(unitPrice: $unitPrice)';
}


}

/// @nodoc
abstract mixin class $CurrentPriceCopyWith<$Res>  {
  factory $CurrentPriceCopyWith(CurrentPrice value, $Res Function(CurrentPrice) _then) = _$CurrentPriceCopyWithImpl;
@useResult
$Res call({
@DoubleConverter() double? unitPrice
});




}
/// @nodoc
class _$CurrentPriceCopyWithImpl<$Res>
    implements $CurrentPriceCopyWith<$Res> {
  _$CurrentPriceCopyWithImpl(this._self, this._then);

  final CurrentPrice _self;
  final $Res Function(CurrentPrice) _then;

/// Create a copy of CurrentPrice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unitPrice = freezed,}) {
  return _then(_self.copyWith(
unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentPrice].
extension CurrentPricePatterns on CurrentPrice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentPrice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentPrice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentPrice value)  $default,){
final _that = this;
switch (_that) {
case _CurrentPrice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentPrice value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentPrice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DoubleConverter()  double? unitPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentPrice() when $default != null:
return $default(_that.unitPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DoubleConverter()  double? unitPrice)  $default,) {final _that = this;
switch (_that) {
case _CurrentPrice():
return $default(_that.unitPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DoubleConverter()  double? unitPrice)?  $default,) {final _that = this;
switch (_that) {
case _CurrentPrice() when $default != null:
return $default(_that.unitPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentPrice implements CurrentPrice {
  const _CurrentPrice({@DoubleConverter() this.unitPrice});
  factory _CurrentPrice.fromJson(Map<String, dynamic> json) => _$CurrentPriceFromJson(json);

@override@DoubleConverter() final  double? unitPrice;

/// Create a copy of CurrentPrice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentPriceCopyWith<_CurrentPrice> get copyWith => __$CurrentPriceCopyWithImpl<_CurrentPrice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentPriceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentPrice&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unitPrice);

@override
String toString() {
  return 'CurrentPrice(unitPrice: $unitPrice)';
}


}

/// @nodoc
abstract mixin class _$CurrentPriceCopyWith<$Res> implements $CurrentPriceCopyWith<$Res> {
  factory _$CurrentPriceCopyWith(_CurrentPrice value, $Res Function(_CurrentPrice) _then) = __$CurrentPriceCopyWithImpl;
@override @useResult
$Res call({
@DoubleConverter() double? unitPrice
});




}
/// @nodoc
class __$CurrentPriceCopyWithImpl<$Res>
    implements _$CurrentPriceCopyWith<$Res> {
  __$CurrentPriceCopyWithImpl(this._self, this._then);

  final _CurrentPrice _self;
  final $Res Function(_CurrentPrice) _then;

/// Create a copy of CurrentPrice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unitPrice = freezed,}) {
  return _then(_CurrentPrice(
unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$ProcedureMatch {

 int get id; String get code; String get name; CurrentPrice? get currentPrice;
/// Create a copy of ProcedureMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcedureMatchCopyWith<ProcedureMatch> get copyWith => _$ProcedureMatchCopyWithImpl<ProcedureMatch>(this as ProcedureMatch, _$identity);

  /// Serializes this ProcedureMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcedureMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,currentPrice);

@override
String toString() {
  return 'ProcedureMatch(id: $id, code: $code, name: $name, currentPrice: $currentPrice)';
}


}

/// @nodoc
abstract mixin class $ProcedureMatchCopyWith<$Res>  {
  factory $ProcedureMatchCopyWith(ProcedureMatch value, $Res Function(ProcedureMatch) _then) = _$ProcedureMatchCopyWithImpl;
@useResult
$Res call({
 int id, String code, String name, CurrentPrice? currentPrice
});


$CurrentPriceCopyWith<$Res>? get currentPrice;

}
/// @nodoc
class _$ProcedureMatchCopyWithImpl<$Res>
    implements $ProcedureMatchCopyWith<$Res> {
  _$ProcedureMatchCopyWithImpl(this._self, this._then);

  final ProcedureMatch _self;
  final $Res Function(ProcedureMatch) _then;

/// Create a copy of ProcedureMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? currentPrice = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currentPrice: freezed == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as CurrentPrice?,
  ));
}
/// Create a copy of ProcedureMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPriceCopyWith<$Res>? get currentPrice {
    if (_self.currentPrice == null) {
    return null;
  }

  return $CurrentPriceCopyWith<$Res>(_self.currentPrice!, (value) {
    return _then(_self.copyWith(currentPrice: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProcedureMatch].
extension ProcedureMatchPatterns on ProcedureMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProcedureMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProcedureMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProcedureMatch value)  $default,){
final _that = this;
switch (_that) {
case _ProcedureMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProcedureMatch value)?  $default,){
final _that = this;
switch (_that) {
case _ProcedureMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String name,  CurrentPrice? currentPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProcedureMatch() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.currentPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String name,  CurrentPrice? currentPrice)  $default,) {final _that = this;
switch (_that) {
case _ProcedureMatch():
return $default(_that.id,_that.code,_that.name,_that.currentPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String name,  CurrentPrice? currentPrice)?  $default,) {final _that = this;
switch (_that) {
case _ProcedureMatch() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.currentPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProcedureMatch extends ProcedureMatch {
  const _ProcedureMatch({required this.id, required this.code, required this.name, this.currentPrice}): super._();
  factory _ProcedureMatch.fromJson(Map<String, dynamic> json) => _$ProcedureMatchFromJson(json);

@override final  int id;
@override final  String code;
@override final  String name;
@override final  CurrentPrice? currentPrice;

/// Create a copy of ProcedureMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcedureMatchCopyWith<_ProcedureMatch> get copyWith => __$ProcedureMatchCopyWithImpl<_ProcedureMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProcedureMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcedureMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,currentPrice);

@override
String toString() {
  return 'ProcedureMatch(id: $id, code: $code, name: $name, currentPrice: $currentPrice)';
}


}

/// @nodoc
abstract mixin class _$ProcedureMatchCopyWith<$Res> implements $ProcedureMatchCopyWith<$Res> {
  factory _$ProcedureMatchCopyWith(_ProcedureMatch value, $Res Function(_ProcedureMatch) _then) = __$ProcedureMatchCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String name, CurrentPrice? currentPrice
});


@override $CurrentPriceCopyWith<$Res>? get currentPrice;

}
/// @nodoc
class __$ProcedureMatchCopyWithImpl<$Res>
    implements _$ProcedureMatchCopyWith<$Res> {
  __$ProcedureMatchCopyWithImpl(this._self, this._then);

  final _ProcedureMatch _self;
  final $Res Function(_ProcedureMatch) _then;

/// Create a copy of ProcedureMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? currentPrice = freezed,}) {
  return _then(_ProcedureMatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currentPrice: freezed == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as CurrentPrice?,
  ));
}

/// Create a copy of ProcedureMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentPriceCopyWith<$Res>? get currentPrice {
    if (_self.currentPrice == null) {
    return null;
  }

  return $CurrentPriceCopyWith<$Res>(_self.currentPrice!, (value) {
    return _then(_self.copyWith(currentPrice: value));
  });
}
}

// dart format on
