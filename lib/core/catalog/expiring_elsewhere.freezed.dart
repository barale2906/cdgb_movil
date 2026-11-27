// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expiring_elsewhere.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpiringBatch {

 int get batchId; String get lotNumber; String? get expirationDate; int get daysUntilExpiry; String? get labBrand; NamedRef? get warehouse;@DoubleConverter() double? get quantity;
/// Create a copy of ExpiringBatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpiringBatchCopyWith<ExpiringBatch> get copyWith => _$ExpiringBatchCopyWithImpl<ExpiringBatch>(this as ExpiringBatch, _$identity);

  /// Serializes this ExpiringBatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpiringBatch&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.daysUntilExpiry, daysUntilExpiry) || other.daysUntilExpiry == daysUntilExpiry)&&(identical(other.labBrand, labBrand) || other.labBrand == labBrand)&&(identical(other.warehouse, warehouse) || other.warehouse == warehouse)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,batchId,lotNumber,expirationDate,daysUntilExpiry,labBrand,warehouse,quantity);

@override
String toString() {
  return 'ExpiringBatch(batchId: $batchId, lotNumber: $lotNumber, expirationDate: $expirationDate, daysUntilExpiry: $daysUntilExpiry, labBrand: $labBrand, warehouse: $warehouse, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $ExpiringBatchCopyWith<$Res>  {
  factory $ExpiringBatchCopyWith(ExpiringBatch value, $Res Function(ExpiringBatch) _then) = _$ExpiringBatchCopyWithImpl;
@useResult
$Res call({
 int batchId, String lotNumber, String? expirationDate, int daysUntilExpiry, String? labBrand, NamedRef? warehouse,@DoubleConverter() double? quantity
});


$NamedRefCopyWith<$Res>? get warehouse;

}
/// @nodoc
class _$ExpiringBatchCopyWithImpl<$Res>
    implements $ExpiringBatchCopyWith<$Res> {
  _$ExpiringBatchCopyWithImpl(this._self, this._then);

  final ExpiringBatch _self;
  final $Res Function(ExpiringBatch) _then;

/// Create a copy of ExpiringBatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? batchId = null,Object? lotNumber = null,Object? expirationDate = freezed,Object? daysUntilExpiry = null,Object? labBrand = freezed,Object? warehouse = freezed,Object? quantity = freezed,}) {
  return _then(_self.copyWith(
batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as int,lotNumber: null == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String?,daysUntilExpiry: null == daysUntilExpiry ? _self.daysUntilExpiry : daysUntilExpiry // ignore: cast_nullable_to_non_nullable
as int,labBrand: freezed == labBrand ? _self.labBrand : labBrand // ignore: cast_nullable_to_non_nullable
as String?,warehouse: freezed == warehouse ? _self.warehouse : warehouse // ignore: cast_nullable_to_non_nullable
as NamedRef?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of ExpiringBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get warehouse {
    if (_self.warehouse == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.warehouse!, (value) {
    return _then(_self.copyWith(warehouse: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpiringBatch].
extension ExpiringBatchPatterns on ExpiringBatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpiringBatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpiringBatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpiringBatch value)  $default,){
final _that = this;
switch (_that) {
case _ExpiringBatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpiringBatch value)?  $default,){
final _that = this;
switch (_that) {
case _ExpiringBatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int batchId,  String lotNumber,  String? expirationDate,  int daysUntilExpiry,  String? labBrand,  NamedRef? warehouse, @DoubleConverter()  double? quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpiringBatch() when $default != null:
return $default(_that.batchId,_that.lotNumber,_that.expirationDate,_that.daysUntilExpiry,_that.labBrand,_that.warehouse,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int batchId,  String lotNumber,  String? expirationDate,  int daysUntilExpiry,  String? labBrand,  NamedRef? warehouse, @DoubleConverter()  double? quantity)  $default,) {final _that = this;
switch (_that) {
case _ExpiringBatch():
return $default(_that.batchId,_that.lotNumber,_that.expirationDate,_that.daysUntilExpiry,_that.labBrand,_that.warehouse,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int batchId,  String lotNumber,  String? expirationDate,  int daysUntilExpiry,  String? labBrand,  NamedRef? warehouse, @DoubleConverter()  double? quantity)?  $default,) {final _that = this;
switch (_that) {
case _ExpiringBatch() when $default != null:
return $default(_that.batchId,_that.lotNumber,_that.expirationDate,_that.daysUntilExpiry,_that.labBrand,_that.warehouse,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpiringBatch implements ExpiringBatch {
  const _ExpiringBatch({required this.batchId, required this.lotNumber, this.expirationDate, this.daysUntilExpiry = 0, this.labBrand, this.warehouse, @DoubleConverter() this.quantity});
  factory _ExpiringBatch.fromJson(Map<String, dynamic> json) => _$ExpiringBatchFromJson(json);

@override final  int batchId;
@override final  String lotNumber;
@override final  String? expirationDate;
@override@JsonKey() final  int daysUntilExpiry;
@override final  String? labBrand;
@override final  NamedRef? warehouse;
@override@DoubleConverter() final  double? quantity;

/// Create a copy of ExpiringBatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpiringBatchCopyWith<_ExpiringBatch> get copyWith => __$ExpiringBatchCopyWithImpl<_ExpiringBatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpiringBatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpiringBatch&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.daysUntilExpiry, daysUntilExpiry) || other.daysUntilExpiry == daysUntilExpiry)&&(identical(other.labBrand, labBrand) || other.labBrand == labBrand)&&(identical(other.warehouse, warehouse) || other.warehouse == warehouse)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,batchId,lotNumber,expirationDate,daysUntilExpiry,labBrand,warehouse,quantity);

@override
String toString() {
  return 'ExpiringBatch(batchId: $batchId, lotNumber: $lotNumber, expirationDate: $expirationDate, daysUntilExpiry: $daysUntilExpiry, labBrand: $labBrand, warehouse: $warehouse, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$ExpiringBatchCopyWith<$Res> implements $ExpiringBatchCopyWith<$Res> {
  factory _$ExpiringBatchCopyWith(_ExpiringBatch value, $Res Function(_ExpiringBatch) _then) = __$ExpiringBatchCopyWithImpl;
@override @useResult
$Res call({
 int batchId, String lotNumber, String? expirationDate, int daysUntilExpiry, String? labBrand, NamedRef? warehouse,@DoubleConverter() double? quantity
});


@override $NamedRefCopyWith<$Res>? get warehouse;

}
/// @nodoc
class __$ExpiringBatchCopyWithImpl<$Res>
    implements _$ExpiringBatchCopyWith<$Res> {
  __$ExpiringBatchCopyWithImpl(this._self, this._then);

  final _ExpiringBatch _self;
  final $Res Function(_ExpiringBatch) _then;

/// Create a copy of ExpiringBatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? batchId = null,Object? lotNumber = null,Object? expirationDate = freezed,Object? daysUntilExpiry = null,Object? labBrand = freezed,Object? warehouse = freezed,Object? quantity = freezed,}) {
  return _then(_ExpiringBatch(
batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as int,lotNumber: null == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String?,daysUntilExpiry: null == daysUntilExpiry ? _self.daysUntilExpiry : daysUntilExpiry // ignore: cast_nullable_to_non_nullable
as int,labBrand: freezed == labBrand ? _self.labBrand : labBrand // ignore: cast_nullable_to_non_nullable
as String?,warehouse: freezed == warehouse ? _self.warehouse : warehouse // ignore: cast_nullable_to_non_nullable
as NamedRef?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of ExpiringBatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get warehouse {
    if (_self.warehouse == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.warehouse!, (value) {
    return _then(_self.copyWith(warehouse: value));
  });
}
}


/// @nodoc
mixin _$ExpiringElsewhere {

 int get days; List<ExpiringBatch> get items;
/// Create a copy of ExpiringElsewhere
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpiringElsewhereCopyWith<ExpiringElsewhere> get copyWith => _$ExpiringElsewhereCopyWithImpl<ExpiringElsewhere>(this as ExpiringElsewhere, _$identity);

  /// Serializes this ExpiringElsewhere to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpiringElsewhere&&(identical(other.days, days) || other.days == days)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,days,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ExpiringElsewhere(days: $days, items: $items)';
}


}

/// @nodoc
abstract mixin class $ExpiringElsewhereCopyWith<$Res>  {
  factory $ExpiringElsewhereCopyWith(ExpiringElsewhere value, $Res Function(ExpiringElsewhere) _then) = _$ExpiringElsewhereCopyWithImpl;
@useResult
$Res call({
 int days, List<ExpiringBatch> items
});




}
/// @nodoc
class _$ExpiringElsewhereCopyWithImpl<$Res>
    implements $ExpiringElsewhereCopyWith<$Res> {
  _$ExpiringElsewhereCopyWithImpl(this._self, this._then);

  final ExpiringElsewhere _self;
  final $Res Function(ExpiringElsewhere) _then;

/// Create a copy of ExpiringElsewhere
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,Object? items = null,}) {
  return _then(_self.copyWith(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ExpiringBatch>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpiringElsewhere].
extension ExpiringElsewherePatterns on ExpiringElsewhere {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpiringElsewhere value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpiringElsewhere() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpiringElsewhere value)  $default,){
final _that = this;
switch (_that) {
case _ExpiringElsewhere():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpiringElsewhere value)?  $default,){
final _that = this;
switch (_that) {
case _ExpiringElsewhere() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int days,  List<ExpiringBatch> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpiringElsewhere() when $default != null:
return $default(_that.days,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int days,  List<ExpiringBatch> items)  $default,) {final _that = this;
switch (_that) {
case _ExpiringElsewhere():
return $default(_that.days,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int days,  List<ExpiringBatch> items)?  $default,) {final _that = this;
switch (_that) {
case _ExpiringElsewhere() when $default != null:
return $default(_that.days,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpiringElsewhere implements ExpiringElsewhere {
  const _ExpiringElsewhere({this.days = 0, final  List<ExpiringBatch> items = const []}): _items = items;
  factory _ExpiringElsewhere.fromJson(Map<String, dynamic> json) => _$ExpiringElsewhereFromJson(json);

@override@JsonKey() final  int days;
 final  List<ExpiringBatch> _items;
@override@JsonKey() List<ExpiringBatch> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ExpiringElsewhere
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpiringElsewhereCopyWith<_ExpiringElsewhere> get copyWith => __$ExpiringElsewhereCopyWithImpl<_ExpiringElsewhere>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpiringElsewhereToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpiringElsewhere&&(identical(other.days, days) || other.days == days)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,days,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ExpiringElsewhere(days: $days, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ExpiringElsewhereCopyWith<$Res> implements $ExpiringElsewhereCopyWith<$Res> {
  factory _$ExpiringElsewhereCopyWith(_ExpiringElsewhere value, $Res Function(_ExpiringElsewhere) _then) = __$ExpiringElsewhereCopyWithImpl;
@override @useResult
$Res call({
 int days, List<ExpiringBatch> items
});




}
/// @nodoc
class __$ExpiringElsewhereCopyWithImpl<$Res>
    implements _$ExpiringElsewhereCopyWith<$Res> {
  __$ExpiringElsewhereCopyWithImpl(this._self, this._then);

  final _ExpiringElsewhere _self;
  final $Res Function(_ExpiringElsewhere) _then;

/// Create a copy of ExpiringElsewhere
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,Object? items = null,}) {
  return _then(_ExpiringElsewhere(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ExpiringBatch>,
  ));
}


}

// dart format on
