// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumption_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConsumptionRecord {

 int get id; String? get appointmentId; String? get patientIdentifier; String? get serviceType; String? get productName; String? get productCode; String? get lotNumber;@DoubleConverter() double? get quantity; String? get consumedAt;@SyncStatusConverter() SyncStatus get syncStatus; String? get syncedToHcAt;
/// Create a copy of ConsumptionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsumptionRecordCopyWith<ConsumptionRecord> get copyWith => _$ConsumptionRecordCopyWithImpl<ConsumptionRecord>(this as ConsumptionRecord, _$identity);

  /// Serializes this ConsumptionRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumptionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.patientIdentifier, patientIdentifier) || other.patientIdentifier == patientIdentifier)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.consumedAt, consumedAt) || other.consumedAt == consumedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.syncedToHcAt, syncedToHcAt) || other.syncedToHcAt == syncedToHcAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,appointmentId,patientIdentifier,serviceType,productName,productCode,lotNumber,quantity,consumedAt,syncStatus,syncedToHcAt);

@override
String toString() {
  return 'ConsumptionRecord(id: $id, appointmentId: $appointmentId, patientIdentifier: $patientIdentifier, serviceType: $serviceType, productName: $productName, productCode: $productCode, lotNumber: $lotNumber, quantity: $quantity, consumedAt: $consumedAt, syncStatus: $syncStatus, syncedToHcAt: $syncedToHcAt)';
}


}

/// @nodoc
abstract mixin class $ConsumptionRecordCopyWith<$Res>  {
  factory $ConsumptionRecordCopyWith(ConsumptionRecord value, $Res Function(ConsumptionRecord) _then) = _$ConsumptionRecordCopyWithImpl;
@useResult
$Res call({
 int id, String? appointmentId, String? patientIdentifier, String? serviceType, String? productName, String? productCode, String? lotNumber,@DoubleConverter() double? quantity, String? consumedAt,@SyncStatusConverter() SyncStatus syncStatus, String? syncedToHcAt
});




}
/// @nodoc
class _$ConsumptionRecordCopyWithImpl<$Res>
    implements $ConsumptionRecordCopyWith<$Res> {
  _$ConsumptionRecordCopyWithImpl(this._self, this._then);

  final ConsumptionRecord _self;
  final $Res Function(ConsumptionRecord) _then;

/// Create a copy of ConsumptionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? appointmentId = freezed,Object? patientIdentifier = freezed,Object? serviceType = freezed,Object? productName = freezed,Object? productCode = freezed,Object? lotNumber = freezed,Object? quantity = freezed,Object? consumedAt = freezed,Object? syncStatus = null,Object? syncedToHcAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,appointmentId: freezed == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String?,patientIdentifier: freezed == patientIdentifier ? _self.patientIdentifier : patientIdentifier // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,lotNumber: freezed == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,consumedAt: freezed == consumedAt ? _self.consumedAt : consumedAt // ignore: cast_nullable_to_non_nullable
as String?,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,syncedToHcAt: freezed == syncedToHcAt ? _self.syncedToHcAt : syncedToHcAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConsumptionRecord].
extension ConsumptionRecordPatterns on ConsumptionRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsumptionRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsumptionRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsumptionRecord value)  $default,){
final _that = this;
switch (_that) {
case _ConsumptionRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsumptionRecord value)?  $default,){
final _that = this;
switch (_that) {
case _ConsumptionRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? appointmentId,  String? patientIdentifier,  String? serviceType,  String? productName,  String? productCode,  String? lotNumber, @DoubleConverter()  double? quantity,  String? consumedAt, @SyncStatusConverter()  SyncStatus syncStatus,  String? syncedToHcAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsumptionRecord() when $default != null:
return $default(_that.id,_that.appointmentId,_that.patientIdentifier,_that.serviceType,_that.productName,_that.productCode,_that.lotNumber,_that.quantity,_that.consumedAt,_that.syncStatus,_that.syncedToHcAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? appointmentId,  String? patientIdentifier,  String? serviceType,  String? productName,  String? productCode,  String? lotNumber, @DoubleConverter()  double? quantity,  String? consumedAt, @SyncStatusConverter()  SyncStatus syncStatus,  String? syncedToHcAt)  $default,) {final _that = this;
switch (_that) {
case _ConsumptionRecord():
return $default(_that.id,_that.appointmentId,_that.patientIdentifier,_that.serviceType,_that.productName,_that.productCode,_that.lotNumber,_that.quantity,_that.consumedAt,_that.syncStatus,_that.syncedToHcAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? appointmentId,  String? patientIdentifier,  String? serviceType,  String? productName,  String? productCode,  String? lotNumber, @DoubleConverter()  double? quantity,  String? consumedAt, @SyncStatusConverter()  SyncStatus syncStatus,  String? syncedToHcAt)?  $default,) {final _that = this;
switch (_that) {
case _ConsumptionRecord() when $default != null:
return $default(_that.id,_that.appointmentId,_that.patientIdentifier,_that.serviceType,_that.productName,_that.productCode,_that.lotNumber,_that.quantity,_that.consumedAt,_that.syncStatus,_that.syncedToHcAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsumptionRecord extends ConsumptionRecord {
  const _ConsumptionRecord({required this.id, this.appointmentId, this.patientIdentifier, this.serviceType, this.productName, this.productCode, this.lotNumber, @DoubleConverter() this.quantity, this.consumedAt, @SyncStatusConverter() this.syncStatus = SyncStatus.unknown, this.syncedToHcAt}): super._();
  factory _ConsumptionRecord.fromJson(Map<String, dynamic> json) => _$ConsumptionRecordFromJson(json);

@override final  int id;
@override final  String? appointmentId;
@override final  String? patientIdentifier;
@override final  String? serviceType;
@override final  String? productName;
@override final  String? productCode;
@override final  String? lotNumber;
@override@DoubleConverter() final  double? quantity;
@override final  String? consumedAt;
@override@JsonKey()@SyncStatusConverter() final  SyncStatus syncStatus;
@override final  String? syncedToHcAt;

/// Create a copy of ConsumptionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsumptionRecordCopyWith<_ConsumptionRecord> get copyWith => __$ConsumptionRecordCopyWithImpl<_ConsumptionRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsumptionRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsumptionRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.patientIdentifier, patientIdentifier) || other.patientIdentifier == patientIdentifier)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.consumedAt, consumedAt) || other.consumedAt == consumedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.syncedToHcAt, syncedToHcAt) || other.syncedToHcAt == syncedToHcAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,appointmentId,patientIdentifier,serviceType,productName,productCode,lotNumber,quantity,consumedAt,syncStatus,syncedToHcAt);

@override
String toString() {
  return 'ConsumptionRecord(id: $id, appointmentId: $appointmentId, patientIdentifier: $patientIdentifier, serviceType: $serviceType, productName: $productName, productCode: $productCode, lotNumber: $lotNumber, quantity: $quantity, consumedAt: $consumedAt, syncStatus: $syncStatus, syncedToHcAt: $syncedToHcAt)';
}


}

/// @nodoc
abstract mixin class _$ConsumptionRecordCopyWith<$Res> implements $ConsumptionRecordCopyWith<$Res> {
  factory _$ConsumptionRecordCopyWith(_ConsumptionRecord value, $Res Function(_ConsumptionRecord) _then) = __$ConsumptionRecordCopyWithImpl;
@override @useResult
$Res call({
 int id, String? appointmentId, String? patientIdentifier, String? serviceType, String? productName, String? productCode, String? lotNumber,@DoubleConverter() double? quantity, String? consumedAt,@SyncStatusConverter() SyncStatus syncStatus, String? syncedToHcAt
});




}
/// @nodoc
class __$ConsumptionRecordCopyWithImpl<$Res>
    implements _$ConsumptionRecordCopyWith<$Res> {
  __$ConsumptionRecordCopyWithImpl(this._self, this._then);

  final _ConsumptionRecord _self;
  final $Res Function(_ConsumptionRecord) _then;

/// Create a copy of ConsumptionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? appointmentId = freezed,Object? patientIdentifier = freezed,Object? serviceType = freezed,Object? productName = freezed,Object? productCode = freezed,Object? lotNumber = freezed,Object? quantity = freezed,Object? consumedAt = freezed,Object? syncStatus = null,Object? syncedToHcAt = freezed,}) {
  return _then(_ConsumptionRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,appointmentId: freezed == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String?,patientIdentifier: freezed == patientIdentifier ? _self.patientIdentifier : patientIdentifier // ignore: cast_nullable_to_non_nullable
as String?,serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,lotNumber: freezed == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,consumedAt: freezed == consumedAt ? _self.consumedAt : consumedAt // ignore: cast_nullable_to_non_nullable
as String?,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,syncedToHcAt: freezed == syncedToHcAt ? _self.syncedToHcAt : syncedToHcAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ServiceProjection {

 String get serviceName; int get futureAppointments;@DoubleConverter() double? get avgUnitsPerAppointment; int get projectedUnits;
/// Create a copy of ServiceProjection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceProjectionCopyWith<ServiceProjection> get copyWith => _$ServiceProjectionCopyWithImpl<ServiceProjection>(this as ServiceProjection, _$identity);

  /// Serializes this ServiceProjection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceProjection&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.futureAppointments, futureAppointments) || other.futureAppointments == futureAppointments)&&(identical(other.avgUnitsPerAppointment, avgUnitsPerAppointment) || other.avgUnitsPerAppointment == avgUnitsPerAppointment)&&(identical(other.projectedUnits, projectedUnits) || other.projectedUnits == projectedUnits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceName,futureAppointments,avgUnitsPerAppointment,projectedUnits);

@override
String toString() {
  return 'ServiceProjection(serviceName: $serviceName, futureAppointments: $futureAppointments, avgUnitsPerAppointment: $avgUnitsPerAppointment, projectedUnits: $projectedUnits)';
}


}

/// @nodoc
abstract mixin class $ServiceProjectionCopyWith<$Res>  {
  factory $ServiceProjectionCopyWith(ServiceProjection value, $Res Function(ServiceProjection) _then) = _$ServiceProjectionCopyWithImpl;
@useResult
$Res call({
 String serviceName, int futureAppointments,@DoubleConverter() double? avgUnitsPerAppointment, int projectedUnits
});




}
/// @nodoc
class _$ServiceProjectionCopyWithImpl<$Res>
    implements $ServiceProjectionCopyWith<$Res> {
  _$ServiceProjectionCopyWithImpl(this._self, this._then);

  final ServiceProjection _self;
  final $Res Function(ServiceProjection) _then;

/// Create a copy of ServiceProjection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceName = null,Object? futureAppointments = null,Object? avgUnitsPerAppointment = freezed,Object? projectedUnits = null,}) {
  return _then(_self.copyWith(
serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,futureAppointments: null == futureAppointments ? _self.futureAppointments : futureAppointments // ignore: cast_nullable_to_non_nullable
as int,avgUnitsPerAppointment: freezed == avgUnitsPerAppointment ? _self.avgUnitsPerAppointment : avgUnitsPerAppointment // ignore: cast_nullable_to_non_nullable
as double?,projectedUnits: null == projectedUnits ? _self.projectedUnits : projectedUnits // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceProjection].
extension ServiceProjectionPatterns on ServiceProjection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceProjection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceProjection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceProjection value)  $default,){
final _that = this;
switch (_that) {
case _ServiceProjection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceProjection value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceProjection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serviceName,  int futureAppointments, @DoubleConverter()  double? avgUnitsPerAppointment,  int projectedUnits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceProjection() when $default != null:
return $default(_that.serviceName,_that.futureAppointments,_that.avgUnitsPerAppointment,_that.projectedUnits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serviceName,  int futureAppointments, @DoubleConverter()  double? avgUnitsPerAppointment,  int projectedUnits)  $default,) {final _that = this;
switch (_that) {
case _ServiceProjection():
return $default(_that.serviceName,_that.futureAppointments,_that.avgUnitsPerAppointment,_that.projectedUnits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serviceName,  int futureAppointments, @DoubleConverter()  double? avgUnitsPerAppointment,  int projectedUnits)?  $default,) {final _that = this;
switch (_that) {
case _ServiceProjection() when $default != null:
return $default(_that.serviceName,_that.futureAppointments,_that.avgUnitsPerAppointment,_that.projectedUnits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceProjection implements ServiceProjection {
  const _ServiceProjection({required this.serviceName, this.futureAppointments = 0, @DoubleConverter() this.avgUnitsPerAppointment, this.projectedUnits = 0});
  factory _ServiceProjection.fromJson(Map<String, dynamic> json) => _$ServiceProjectionFromJson(json);

@override final  String serviceName;
@override@JsonKey() final  int futureAppointments;
@override@DoubleConverter() final  double? avgUnitsPerAppointment;
@override@JsonKey() final  int projectedUnits;

/// Create a copy of ServiceProjection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceProjectionCopyWith<_ServiceProjection> get copyWith => __$ServiceProjectionCopyWithImpl<_ServiceProjection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceProjectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceProjection&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.futureAppointments, futureAppointments) || other.futureAppointments == futureAppointments)&&(identical(other.avgUnitsPerAppointment, avgUnitsPerAppointment) || other.avgUnitsPerAppointment == avgUnitsPerAppointment)&&(identical(other.projectedUnits, projectedUnits) || other.projectedUnits == projectedUnits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceName,futureAppointments,avgUnitsPerAppointment,projectedUnits);

@override
String toString() {
  return 'ServiceProjection(serviceName: $serviceName, futureAppointments: $futureAppointments, avgUnitsPerAppointment: $avgUnitsPerAppointment, projectedUnits: $projectedUnits)';
}


}

/// @nodoc
abstract mixin class _$ServiceProjectionCopyWith<$Res> implements $ServiceProjectionCopyWith<$Res> {
  factory _$ServiceProjectionCopyWith(_ServiceProjection value, $Res Function(_ServiceProjection) _then) = __$ServiceProjectionCopyWithImpl;
@override @useResult
$Res call({
 String serviceName, int futureAppointments,@DoubleConverter() double? avgUnitsPerAppointment, int projectedUnits
});




}
/// @nodoc
class __$ServiceProjectionCopyWithImpl<$Res>
    implements _$ServiceProjectionCopyWith<$Res> {
  __$ServiceProjectionCopyWithImpl(this._self, this._then);

  final _ServiceProjection _self;
  final $Res Function(_ServiceProjection) _then;

/// Create a copy of ServiceProjection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceName = null,Object? futureAppointments = null,Object? avgUnitsPerAppointment = freezed,Object? projectedUnits = null,}) {
  return _then(_ServiceProjection(
serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,futureAppointments: null == futureAppointments ? _self.futureAppointments : futureAppointments // ignore: cast_nullable_to_non_nullable
as int,avgUnitsPerAppointment: freezed == avgUnitsPerAppointment ? _self.avgUnitsPerAppointment : avgUnitsPerAppointment // ignore: cast_nullable_to_non_nullable
as double?,projectedUnits: null == projectedUnits ? _self.projectedUnits : projectedUnits // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
