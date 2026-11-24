// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'batch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BatchZone {

 int? get warehouseId; String? get warehouseName; String? get zoneName;
/// Create a copy of BatchZone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BatchZoneCopyWith<BatchZone> get copyWith => _$BatchZoneCopyWithImpl<BatchZone>(this as BatchZone, _$identity);

  /// Serializes this BatchZone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BatchZone&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.warehouseName, warehouseName) || other.warehouseName == warehouseName)&&(identical(other.zoneName, zoneName) || other.zoneName == zoneName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,warehouseId,warehouseName,zoneName);

@override
String toString() {
  return 'BatchZone(warehouseId: $warehouseId, warehouseName: $warehouseName, zoneName: $zoneName)';
}


}

/// @nodoc
abstract mixin class $BatchZoneCopyWith<$Res>  {
  factory $BatchZoneCopyWith(BatchZone value, $Res Function(BatchZone) _then) = _$BatchZoneCopyWithImpl;
@useResult
$Res call({
 int? warehouseId, String? warehouseName, String? zoneName
});




}
/// @nodoc
class _$BatchZoneCopyWithImpl<$Res>
    implements $BatchZoneCopyWith<$Res> {
  _$BatchZoneCopyWithImpl(this._self, this._then);

  final BatchZone _self;
  final $Res Function(BatchZone) _then;

/// Create a copy of BatchZone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? warehouseId = freezed,Object? warehouseName = freezed,Object? zoneName = freezed,}) {
  return _then(_self.copyWith(
warehouseId: freezed == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as int?,warehouseName: freezed == warehouseName ? _self.warehouseName : warehouseName // ignore: cast_nullable_to_non_nullable
as String?,zoneName: freezed == zoneName ? _self.zoneName : zoneName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BatchZone].
extension BatchZonePatterns on BatchZone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BatchZone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BatchZone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BatchZone value)  $default,){
final _that = this;
switch (_that) {
case _BatchZone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BatchZone value)?  $default,){
final _that = this;
switch (_that) {
case _BatchZone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? warehouseId,  String? warehouseName,  String? zoneName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BatchZone() when $default != null:
return $default(_that.warehouseId,_that.warehouseName,_that.zoneName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? warehouseId,  String? warehouseName,  String? zoneName)  $default,) {final _that = this;
switch (_that) {
case _BatchZone():
return $default(_that.warehouseId,_that.warehouseName,_that.zoneName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? warehouseId,  String? warehouseName,  String? zoneName)?  $default,) {final _that = this;
switch (_that) {
case _BatchZone() when $default != null:
return $default(_that.warehouseId,_that.warehouseName,_that.zoneName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BatchZone implements BatchZone {
  const _BatchZone({this.warehouseId, this.warehouseName, this.zoneName});
  factory _BatchZone.fromJson(Map<String, dynamic> json) => _$BatchZoneFromJson(json);

@override final  int? warehouseId;
@override final  String? warehouseName;
@override final  String? zoneName;

/// Create a copy of BatchZone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BatchZoneCopyWith<_BatchZone> get copyWith => __$BatchZoneCopyWithImpl<_BatchZone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BatchZoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BatchZone&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.warehouseName, warehouseName) || other.warehouseName == warehouseName)&&(identical(other.zoneName, zoneName) || other.zoneName == zoneName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,warehouseId,warehouseName,zoneName);

@override
String toString() {
  return 'BatchZone(warehouseId: $warehouseId, warehouseName: $warehouseName, zoneName: $zoneName)';
}


}

/// @nodoc
abstract mixin class _$BatchZoneCopyWith<$Res> implements $BatchZoneCopyWith<$Res> {
  factory _$BatchZoneCopyWith(_BatchZone value, $Res Function(_BatchZone) _then) = __$BatchZoneCopyWithImpl;
@override @useResult
$Res call({
 int? warehouseId, String? warehouseName, String? zoneName
});




}
/// @nodoc
class __$BatchZoneCopyWithImpl<$Res>
    implements _$BatchZoneCopyWith<$Res> {
  __$BatchZoneCopyWithImpl(this._self, this._then);

  final _BatchZone _self;
  final $Res Function(_BatchZone) _then;

/// Create a copy of BatchZone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? warehouseId = freezed,Object? warehouseName = freezed,Object? zoneName = freezed,}) {
  return _then(_BatchZone(
warehouseId: freezed == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as int?,warehouseName: freezed == warehouseName ? _self.warehouseName : warehouseName // ignore: cast_nullable_to_non_nullable
as String?,zoneName: freezed == zoneName ? _self.zoneName : zoneName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BatchLocation {

 int get locationId; String? get locationName; String? get locationCode;@DoubleConverter() double? get quantity; BatchZone? get zone;
/// Create a copy of BatchLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BatchLocationCopyWith<BatchLocation> get copyWith => _$BatchLocationCopyWithImpl<BatchLocation>(this as BatchLocation, _$identity);

  /// Serializes this BatchLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BatchLocation&&(identical(other.locationId, locationId) || other.locationId == locationId)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.locationCode, locationCode) || other.locationCode == locationCode)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.zone, zone) || other.zone == zone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locationId,locationName,locationCode,quantity,zone);

@override
String toString() {
  return 'BatchLocation(locationId: $locationId, locationName: $locationName, locationCode: $locationCode, quantity: $quantity, zone: $zone)';
}


}

/// @nodoc
abstract mixin class $BatchLocationCopyWith<$Res>  {
  factory $BatchLocationCopyWith(BatchLocation value, $Res Function(BatchLocation) _then) = _$BatchLocationCopyWithImpl;
@useResult
$Res call({
 int locationId, String? locationName, String? locationCode,@DoubleConverter() double? quantity, BatchZone? zone
});


$BatchZoneCopyWith<$Res>? get zone;

}
/// @nodoc
class _$BatchLocationCopyWithImpl<$Res>
    implements $BatchLocationCopyWith<$Res> {
  _$BatchLocationCopyWithImpl(this._self, this._then);

  final BatchLocation _self;
  final $Res Function(BatchLocation) _then;

/// Create a copy of BatchLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locationId = null,Object? locationName = freezed,Object? locationCode = freezed,Object? quantity = freezed,Object? zone = freezed,}) {
  return _then(_self.copyWith(
locationId: null == locationId ? _self.locationId : locationId // ignore: cast_nullable_to_non_nullable
as int,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,locationCode: freezed == locationCode ? _self.locationCode : locationCode // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as BatchZone?,
  ));
}
/// Create a copy of BatchLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BatchZoneCopyWith<$Res>? get zone {
    if (_self.zone == null) {
    return null;
  }

  return $BatchZoneCopyWith<$Res>(_self.zone!, (value) {
    return _then(_self.copyWith(zone: value));
  });
}
}


/// Adds pattern-matching-related methods to [BatchLocation].
extension BatchLocationPatterns on BatchLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BatchLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BatchLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BatchLocation value)  $default,){
final _that = this;
switch (_that) {
case _BatchLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BatchLocation value)?  $default,){
final _that = this;
switch (_that) {
case _BatchLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int locationId,  String? locationName,  String? locationCode, @DoubleConverter()  double? quantity,  BatchZone? zone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BatchLocation() when $default != null:
return $default(_that.locationId,_that.locationName,_that.locationCode,_that.quantity,_that.zone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int locationId,  String? locationName,  String? locationCode, @DoubleConverter()  double? quantity,  BatchZone? zone)  $default,) {final _that = this;
switch (_that) {
case _BatchLocation():
return $default(_that.locationId,_that.locationName,_that.locationCode,_that.quantity,_that.zone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int locationId,  String? locationName,  String? locationCode, @DoubleConverter()  double? quantity,  BatchZone? zone)?  $default,) {final _that = this;
switch (_that) {
case _BatchLocation() when $default != null:
return $default(_that.locationId,_that.locationName,_that.locationCode,_that.quantity,_that.zone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BatchLocation implements BatchLocation {
  const _BatchLocation({required this.locationId, this.locationName, this.locationCode, @DoubleConverter() this.quantity, this.zone});
  factory _BatchLocation.fromJson(Map<String, dynamic> json) => _$BatchLocationFromJson(json);

@override final  int locationId;
@override final  String? locationName;
@override final  String? locationCode;
@override@DoubleConverter() final  double? quantity;
@override final  BatchZone? zone;

/// Create a copy of BatchLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BatchLocationCopyWith<_BatchLocation> get copyWith => __$BatchLocationCopyWithImpl<_BatchLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BatchLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BatchLocation&&(identical(other.locationId, locationId) || other.locationId == locationId)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.locationCode, locationCode) || other.locationCode == locationCode)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.zone, zone) || other.zone == zone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locationId,locationName,locationCode,quantity,zone);

@override
String toString() {
  return 'BatchLocation(locationId: $locationId, locationName: $locationName, locationCode: $locationCode, quantity: $quantity, zone: $zone)';
}


}

/// @nodoc
abstract mixin class _$BatchLocationCopyWith<$Res> implements $BatchLocationCopyWith<$Res> {
  factory _$BatchLocationCopyWith(_BatchLocation value, $Res Function(_BatchLocation) _then) = __$BatchLocationCopyWithImpl;
@override @useResult
$Res call({
 int locationId, String? locationName, String? locationCode,@DoubleConverter() double? quantity, BatchZone? zone
});


@override $BatchZoneCopyWith<$Res>? get zone;

}
/// @nodoc
class __$BatchLocationCopyWithImpl<$Res>
    implements _$BatchLocationCopyWith<$Res> {
  __$BatchLocationCopyWithImpl(this._self, this._then);

  final _BatchLocation _self;
  final $Res Function(_BatchLocation) _then;

/// Create a copy of BatchLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locationId = null,Object? locationName = freezed,Object? locationCode = freezed,Object? quantity = freezed,Object? zone = freezed,}) {
  return _then(_BatchLocation(
locationId: null == locationId ? _self.locationId : locationId // ignore: cast_nullable_to_non_nullable
as int,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,locationCode: freezed == locationCode ? _self.locationCode : locationCode // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as BatchZone?,
  ));
}

/// Create a copy of BatchLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BatchZoneCopyWith<$Res>? get zone {
    if (_self.zone == null) {
    return null;
  }

  return $BatchZoneCopyWith<$Res>(_self.zone!, (value) {
    return _then(_self.copyWith(zone: value));
  });
}
}


/// @nodoc
mixin _$Batch {

 int get id; String get lotNumber; int? get productVariantId; String? get expirationDate; String? get manufacturingDate;@DoubleConverter() double? get quantityAvailable;@DoubleConverter() double? get totalQuantityAvailable;@BatchStatusConverter() BatchStatus get status; int? get daysUntilExpiry; String? get notes; StockVariant? get variant; List<BatchLocation> get locations;
/// Create a copy of Batch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BatchCopyWith<Batch> get copyWith => _$BatchCopyWithImpl<Batch>(this as Batch, _$identity);

  /// Serializes this Batch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Batch&&(identical(other.id, id) || other.id == id)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.productVariantId, productVariantId) || other.productVariantId == productVariantId)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.manufacturingDate, manufacturingDate) || other.manufacturingDate == manufacturingDate)&&(identical(other.quantityAvailable, quantityAvailable) || other.quantityAvailable == quantityAvailable)&&(identical(other.totalQuantityAvailable, totalQuantityAvailable) || other.totalQuantityAvailable == totalQuantityAvailable)&&(identical(other.status, status) || other.status == status)&&(identical(other.daysUntilExpiry, daysUntilExpiry) || other.daysUntilExpiry == daysUntilExpiry)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.variant, variant) || other.variant == variant)&&const DeepCollectionEquality().equals(other.locations, locations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lotNumber,productVariantId,expirationDate,manufacturingDate,quantityAvailable,totalQuantityAvailable,status,daysUntilExpiry,notes,variant,const DeepCollectionEquality().hash(locations));

@override
String toString() {
  return 'Batch(id: $id, lotNumber: $lotNumber, productVariantId: $productVariantId, expirationDate: $expirationDate, manufacturingDate: $manufacturingDate, quantityAvailable: $quantityAvailable, totalQuantityAvailable: $totalQuantityAvailable, status: $status, daysUntilExpiry: $daysUntilExpiry, notes: $notes, variant: $variant, locations: $locations)';
}


}

/// @nodoc
abstract mixin class $BatchCopyWith<$Res>  {
  factory $BatchCopyWith(Batch value, $Res Function(Batch) _then) = _$BatchCopyWithImpl;
@useResult
$Res call({
 int id, String lotNumber, int? productVariantId, String? expirationDate, String? manufacturingDate,@DoubleConverter() double? quantityAvailable,@DoubleConverter() double? totalQuantityAvailable,@BatchStatusConverter() BatchStatus status, int? daysUntilExpiry, String? notes, StockVariant? variant, List<BatchLocation> locations
});


$StockVariantCopyWith<$Res>? get variant;

}
/// @nodoc
class _$BatchCopyWithImpl<$Res>
    implements $BatchCopyWith<$Res> {
  _$BatchCopyWithImpl(this._self, this._then);

  final Batch _self;
  final $Res Function(Batch) _then;

/// Create a copy of Batch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lotNumber = null,Object? productVariantId = freezed,Object? expirationDate = freezed,Object? manufacturingDate = freezed,Object? quantityAvailable = freezed,Object? totalQuantityAvailable = freezed,Object? status = null,Object? daysUntilExpiry = freezed,Object? notes = freezed,Object? variant = freezed,Object? locations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,lotNumber: null == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String,productVariantId: freezed == productVariantId ? _self.productVariantId : productVariantId // ignore: cast_nullable_to_non_nullable
as int?,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String?,manufacturingDate: freezed == manufacturingDate ? _self.manufacturingDate : manufacturingDate // ignore: cast_nullable_to_non_nullable
as String?,quantityAvailable: freezed == quantityAvailable ? _self.quantityAvailable : quantityAvailable // ignore: cast_nullable_to_non_nullable
as double?,totalQuantityAvailable: freezed == totalQuantityAvailable ? _self.totalQuantityAvailable : totalQuantityAvailable // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BatchStatus,daysUntilExpiry: freezed == daysUntilExpiry ? _self.daysUntilExpiry : daysUntilExpiry // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as StockVariant?,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<BatchLocation>,
  ));
}
/// Create a copy of Batch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockVariantCopyWith<$Res>? get variant {
    if (_self.variant == null) {
    return null;
  }

  return $StockVariantCopyWith<$Res>(_self.variant!, (value) {
    return _then(_self.copyWith(variant: value));
  });
}
}


/// Adds pattern-matching-related methods to [Batch].
extension BatchPatterns on Batch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Batch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Batch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Batch value)  $default,){
final _that = this;
switch (_that) {
case _Batch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Batch value)?  $default,){
final _that = this;
switch (_that) {
case _Batch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String lotNumber,  int? productVariantId,  String? expirationDate,  String? manufacturingDate, @DoubleConverter()  double? quantityAvailable, @DoubleConverter()  double? totalQuantityAvailable, @BatchStatusConverter()  BatchStatus status,  int? daysUntilExpiry,  String? notes,  StockVariant? variant,  List<BatchLocation> locations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Batch() when $default != null:
return $default(_that.id,_that.lotNumber,_that.productVariantId,_that.expirationDate,_that.manufacturingDate,_that.quantityAvailable,_that.totalQuantityAvailable,_that.status,_that.daysUntilExpiry,_that.notes,_that.variant,_that.locations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String lotNumber,  int? productVariantId,  String? expirationDate,  String? manufacturingDate, @DoubleConverter()  double? quantityAvailable, @DoubleConverter()  double? totalQuantityAvailable, @BatchStatusConverter()  BatchStatus status,  int? daysUntilExpiry,  String? notes,  StockVariant? variant,  List<BatchLocation> locations)  $default,) {final _that = this;
switch (_that) {
case _Batch():
return $default(_that.id,_that.lotNumber,_that.productVariantId,_that.expirationDate,_that.manufacturingDate,_that.quantityAvailable,_that.totalQuantityAvailable,_that.status,_that.daysUntilExpiry,_that.notes,_that.variant,_that.locations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String lotNumber,  int? productVariantId,  String? expirationDate,  String? manufacturingDate, @DoubleConverter()  double? quantityAvailable, @DoubleConverter()  double? totalQuantityAvailable, @BatchStatusConverter()  BatchStatus status,  int? daysUntilExpiry,  String? notes,  StockVariant? variant,  List<BatchLocation> locations)?  $default,) {final _that = this;
switch (_that) {
case _Batch() when $default != null:
return $default(_that.id,_that.lotNumber,_that.productVariantId,_that.expirationDate,_that.manufacturingDate,_that.quantityAvailable,_that.totalQuantityAvailable,_that.status,_that.daysUntilExpiry,_that.notes,_that.variant,_that.locations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Batch extends Batch {
  const _Batch({required this.id, required this.lotNumber, this.productVariantId, this.expirationDate, this.manufacturingDate, @DoubleConverter() this.quantityAvailable, @DoubleConverter() this.totalQuantityAvailable, @BatchStatusConverter() this.status = BatchStatus.unknown, this.daysUntilExpiry, this.notes, this.variant, final  List<BatchLocation> locations = const []}): _locations = locations,super._();
  factory _Batch.fromJson(Map<String, dynamic> json) => _$BatchFromJson(json);

@override final  int id;
@override final  String lotNumber;
@override final  int? productVariantId;
@override final  String? expirationDate;
@override final  String? manufacturingDate;
@override@DoubleConverter() final  double? quantityAvailable;
@override@DoubleConverter() final  double? totalQuantityAvailable;
@override@JsonKey()@BatchStatusConverter() final  BatchStatus status;
@override final  int? daysUntilExpiry;
@override final  String? notes;
@override final  StockVariant? variant;
 final  List<BatchLocation> _locations;
@override@JsonKey() List<BatchLocation> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}


/// Create a copy of Batch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BatchCopyWith<_Batch> get copyWith => __$BatchCopyWithImpl<_Batch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Batch&&(identical(other.id, id) || other.id == id)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.productVariantId, productVariantId) || other.productVariantId == productVariantId)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.manufacturingDate, manufacturingDate) || other.manufacturingDate == manufacturingDate)&&(identical(other.quantityAvailable, quantityAvailable) || other.quantityAvailable == quantityAvailable)&&(identical(other.totalQuantityAvailable, totalQuantityAvailable) || other.totalQuantityAvailable == totalQuantityAvailable)&&(identical(other.status, status) || other.status == status)&&(identical(other.daysUntilExpiry, daysUntilExpiry) || other.daysUntilExpiry == daysUntilExpiry)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.variant, variant) || other.variant == variant)&&const DeepCollectionEquality().equals(other._locations, _locations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lotNumber,productVariantId,expirationDate,manufacturingDate,quantityAvailable,totalQuantityAvailable,status,daysUntilExpiry,notes,variant,const DeepCollectionEquality().hash(_locations));

@override
String toString() {
  return 'Batch(id: $id, lotNumber: $lotNumber, productVariantId: $productVariantId, expirationDate: $expirationDate, manufacturingDate: $manufacturingDate, quantityAvailable: $quantityAvailable, totalQuantityAvailable: $totalQuantityAvailable, status: $status, daysUntilExpiry: $daysUntilExpiry, notes: $notes, variant: $variant, locations: $locations)';
}


}

/// @nodoc
abstract mixin class _$BatchCopyWith<$Res> implements $BatchCopyWith<$Res> {
  factory _$BatchCopyWith(_Batch value, $Res Function(_Batch) _then) = __$BatchCopyWithImpl;
@override @useResult
$Res call({
 int id, String lotNumber, int? productVariantId, String? expirationDate, String? manufacturingDate,@DoubleConverter() double? quantityAvailable,@DoubleConverter() double? totalQuantityAvailable,@BatchStatusConverter() BatchStatus status, int? daysUntilExpiry, String? notes, StockVariant? variant, List<BatchLocation> locations
});


@override $StockVariantCopyWith<$Res>? get variant;

}
/// @nodoc
class __$BatchCopyWithImpl<$Res>
    implements _$BatchCopyWith<$Res> {
  __$BatchCopyWithImpl(this._self, this._then);

  final _Batch _self;
  final $Res Function(_Batch) _then;

/// Create a copy of Batch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lotNumber = null,Object? productVariantId = freezed,Object? expirationDate = freezed,Object? manufacturingDate = freezed,Object? quantityAvailable = freezed,Object? totalQuantityAvailable = freezed,Object? status = null,Object? daysUntilExpiry = freezed,Object? notes = freezed,Object? variant = freezed,Object? locations = null,}) {
  return _then(_Batch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,lotNumber: null == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String,productVariantId: freezed == productVariantId ? _self.productVariantId : productVariantId // ignore: cast_nullable_to_non_nullable
as int?,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String?,manufacturingDate: freezed == manufacturingDate ? _self.manufacturingDate : manufacturingDate // ignore: cast_nullable_to_non_nullable
as String?,quantityAvailable: freezed == quantityAvailable ? _self.quantityAvailable : quantityAvailable // ignore: cast_nullable_to_non_nullable
as double?,totalQuantityAvailable: freezed == totalQuantityAvailable ? _self.totalQuantityAvailable : totalQuantityAvailable // ignore: cast_nullable_to_non_nullable
as double?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BatchStatus,daysUntilExpiry: freezed == daysUntilExpiry ? _self.daysUntilExpiry : daysUntilExpiry // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as StockVariant?,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<BatchLocation>,
  ));
}

/// Create a copy of Batch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockVariantCopyWith<$Res>? get variant {
    if (_self.variant == null) {
    return null;
  }

  return $StockVariantCopyWith<$Res>(_self.variant!, (value) {
    return _then(_self.copyWith(variant: value));
  });
}
}

// dart format on
