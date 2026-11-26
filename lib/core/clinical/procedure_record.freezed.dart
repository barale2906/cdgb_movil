// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'procedure_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProcedureRecord {

 int get id; String get patientExternalId; String get patientDocument; String get patientFirstName; String get patientLastName; int? get medicalServiceId; String? get medicalServiceName; int? get movementDocumentId;@DoubleConverter() double? get quantity;@DoubleConverter() double? get unitPrice;@DoubleConverter() double? get total; String? get discountType;@DoubleConverter() double? get discountValue;@DoubleConverter() double? get discountAmount;@DoubleConverter() double? get netTotal; String? get discountStatus; String? get orderNumber; String? get billingStatus; String? get serviceDate; String? get seller; String? get referrer; bool get isActive;
/// Create a copy of ProcedureRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcedureRecordCopyWith<ProcedureRecord> get copyWith => _$ProcedureRecordCopyWithImpl<ProcedureRecord>(this as ProcedureRecord, _$identity);

  /// Serializes this ProcedureRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcedureRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.patientExternalId, patientExternalId) || other.patientExternalId == patientExternalId)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.patientFirstName, patientFirstName) || other.patientFirstName == patientFirstName)&&(identical(other.patientLastName, patientLastName) || other.patientLastName == patientLastName)&&(identical(other.medicalServiceId, medicalServiceId) || other.medicalServiceId == medicalServiceId)&&(identical(other.medicalServiceName, medicalServiceName) || other.medicalServiceName == medicalServiceName)&&(identical(other.movementDocumentId, movementDocumentId) || other.movementDocumentId == movementDocumentId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.total, total) || other.total == total)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.netTotal, netTotal) || other.netTotal == netTotal)&&(identical(other.discountStatus, discountStatus) || other.discountStatus == discountStatus)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.billingStatus, billingStatus) || other.billingStatus == billingStatus)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&(identical(other.seller, seller) || other.seller == seller)&&(identical(other.referrer, referrer) || other.referrer == referrer)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,patientExternalId,patientDocument,patientFirstName,patientLastName,medicalServiceId,medicalServiceName,movementDocumentId,quantity,unitPrice,total,discountType,discountValue,discountAmount,netTotal,discountStatus,orderNumber,billingStatus,serviceDate,seller,referrer,isActive]);

@override
String toString() {
  return 'ProcedureRecord(id: $id, patientExternalId: $patientExternalId, patientDocument: $patientDocument, patientFirstName: $patientFirstName, patientLastName: $patientLastName, medicalServiceId: $medicalServiceId, medicalServiceName: $medicalServiceName, movementDocumentId: $movementDocumentId, quantity: $quantity, unitPrice: $unitPrice, total: $total, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, netTotal: $netTotal, discountStatus: $discountStatus, orderNumber: $orderNumber, billingStatus: $billingStatus, serviceDate: $serviceDate, seller: $seller, referrer: $referrer, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ProcedureRecordCopyWith<$Res>  {
  factory $ProcedureRecordCopyWith(ProcedureRecord value, $Res Function(ProcedureRecord) _then) = _$ProcedureRecordCopyWithImpl;
@useResult
$Res call({
 int id, String patientExternalId, String patientDocument, String patientFirstName, String patientLastName, int? medicalServiceId, String? medicalServiceName, int? movementDocumentId,@DoubleConverter() double? quantity,@DoubleConverter() double? unitPrice,@DoubleConverter() double? total, String? discountType,@DoubleConverter() double? discountValue,@DoubleConverter() double? discountAmount,@DoubleConverter() double? netTotal, String? discountStatus, String? orderNumber, String? billingStatus, String? serviceDate, String? seller, String? referrer, bool isActive
});




}
/// @nodoc
class _$ProcedureRecordCopyWithImpl<$Res>
    implements $ProcedureRecordCopyWith<$Res> {
  _$ProcedureRecordCopyWithImpl(this._self, this._then);

  final ProcedureRecord _self;
  final $Res Function(ProcedureRecord) _then;

/// Create a copy of ProcedureRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patientExternalId = null,Object? patientDocument = null,Object? patientFirstName = null,Object? patientLastName = null,Object? medicalServiceId = freezed,Object? medicalServiceName = freezed,Object? movementDocumentId = freezed,Object? quantity = freezed,Object? unitPrice = freezed,Object? total = freezed,Object? discountType = freezed,Object? discountValue = freezed,Object? discountAmount = freezed,Object? netTotal = freezed,Object? discountStatus = freezed,Object? orderNumber = freezed,Object? billingStatus = freezed,Object? serviceDate = freezed,Object? seller = freezed,Object? referrer = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,patientExternalId: null == patientExternalId ? _self.patientExternalId : patientExternalId // ignore: cast_nullable_to_non_nullable
as String,patientDocument: null == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String,patientFirstName: null == patientFirstName ? _self.patientFirstName : patientFirstName // ignore: cast_nullable_to_non_nullable
as String,patientLastName: null == patientLastName ? _self.patientLastName : patientLastName // ignore: cast_nullable_to_non_nullable
as String,medicalServiceId: freezed == medicalServiceId ? _self.medicalServiceId : medicalServiceId // ignore: cast_nullable_to_non_nullable
as int?,medicalServiceName: freezed == medicalServiceName ? _self.medicalServiceName : medicalServiceName // ignore: cast_nullable_to_non_nullable
as String?,movementDocumentId: freezed == movementDocumentId ? _self.movementDocumentId : movementDocumentId // ignore: cast_nullable_to_non_nullable
as int?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,discountType: freezed == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as String?,discountValue: freezed == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double?,netTotal: freezed == netTotal ? _self.netTotal : netTotal // ignore: cast_nullable_to_non_nullable
as double?,discountStatus: freezed == discountStatus ? _self.discountStatus : discountStatus // ignore: cast_nullable_to_non_nullable
as String?,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String?,billingStatus: freezed == billingStatus ? _self.billingStatus : billingStatus // ignore: cast_nullable_to_non_nullable
as String?,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,seller: freezed == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as String?,referrer: freezed == referrer ? _self.referrer : referrer // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProcedureRecord].
extension ProcedureRecordPatterns on ProcedureRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProcedureRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProcedureRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProcedureRecord value)  $default,){
final _that = this;
switch (_that) {
case _ProcedureRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProcedureRecord value)?  $default,){
final _that = this;
switch (_that) {
case _ProcedureRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName,  int? medicalServiceId,  String? medicalServiceName,  int? movementDocumentId, @DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? total,  String? discountType, @DoubleConverter()  double? discountValue, @DoubleConverter()  double? discountAmount, @DoubleConverter()  double? netTotal,  String? discountStatus,  String? orderNumber,  String? billingStatus,  String? serviceDate,  String? seller,  String? referrer,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProcedureRecord() when $default != null:
return $default(_that.id,_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.medicalServiceId,_that.medicalServiceName,_that.movementDocumentId,_that.quantity,_that.unitPrice,_that.total,_that.discountType,_that.discountValue,_that.discountAmount,_that.netTotal,_that.discountStatus,_that.orderNumber,_that.billingStatus,_that.serviceDate,_that.seller,_that.referrer,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName,  int? medicalServiceId,  String? medicalServiceName,  int? movementDocumentId, @DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? total,  String? discountType, @DoubleConverter()  double? discountValue, @DoubleConverter()  double? discountAmount, @DoubleConverter()  double? netTotal,  String? discountStatus,  String? orderNumber,  String? billingStatus,  String? serviceDate,  String? seller,  String? referrer,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ProcedureRecord():
return $default(_that.id,_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.medicalServiceId,_that.medicalServiceName,_that.movementDocumentId,_that.quantity,_that.unitPrice,_that.total,_that.discountType,_that.discountValue,_that.discountAmount,_that.netTotal,_that.discountStatus,_that.orderNumber,_that.billingStatus,_that.serviceDate,_that.seller,_that.referrer,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName,  int? medicalServiceId,  String? medicalServiceName,  int? movementDocumentId, @DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? total,  String? discountType, @DoubleConverter()  double? discountValue, @DoubleConverter()  double? discountAmount, @DoubleConverter()  double? netTotal,  String? discountStatus,  String? orderNumber,  String? billingStatus,  String? serviceDate,  String? seller,  String? referrer,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ProcedureRecord() when $default != null:
return $default(_that.id,_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.medicalServiceId,_that.medicalServiceName,_that.movementDocumentId,_that.quantity,_that.unitPrice,_that.total,_that.discountType,_that.discountValue,_that.discountAmount,_that.netTotal,_that.discountStatus,_that.orderNumber,_that.billingStatus,_that.serviceDate,_that.seller,_that.referrer,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProcedureRecord extends ProcedureRecord {
  const _ProcedureRecord({required this.id, required this.patientExternalId, required this.patientDocument, required this.patientFirstName, required this.patientLastName, this.medicalServiceId, this.medicalServiceName, this.movementDocumentId, @DoubleConverter() this.quantity, @DoubleConverter() this.unitPrice, @DoubleConverter() this.total, this.discountType, @DoubleConverter() this.discountValue, @DoubleConverter() this.discountAmount, @DoubleConverter() this.netTotal, this.discountStatus, this.orderNumber, this.billingStatus, this.serviceDate, this.seller, this.referrer, this.isActive = true}): super._();
  factory _ProcedureRecord.fromJson(Map<String, dynamic> json) => _$ProcedureRecordFromJson(json);

@override final  int id;
@override final  String patientExternalId;
@override final  String patientDocument;
@override final  String patientFirstName;
@override final  String patientLastName;
@override final  int? medicalServiceId;
@override final  String? medicalServiceName;
@override final  int? movementDocumentId;
@override@DoubleConverter() final  double? quantity;
@override@DoubleConverter() final  double? unitPrice;
@override@DoubleConverter() final  double? total;
@override final  String? discountType;
@override@DoubleConverter() final  double? discountValue;
@override@DoubleConverter() final  double? discountAmount;
@override@DoubleConverter() final  double? netTotal;
@override final  String? discountStatus;
@override final  String? orderNumber;
@override final  String? billingStatus;
@override final  String? serviceDate;
@override final  String? seller;
@override final  String? referrer;
@override@JsonKey() final  bool isActive;

/// Create a copy of ProcedureRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcedureRecordCopyWith<_ProcedureRecord> get copyWith => __$ProcedureRecordCopyWithImpl<_ProcedureRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProcedureRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcedureRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.patientExternalId, patientExternalId) || other.patientExternalId == patientExternalId)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.patientFirstName, patientFirstName) || other.patientFirstName == patientFirstName)&&(identical(other.patientLastName, patientLastName) || other.patientLastName == patientLastName)&&(identical(other.medicalServiceId, medicalServiceId) || other.medicalServiceId == medicalServiceId)&&(identical(other.medicalServiceName, medicalServiceName) || other.medicalServiceName == medicalServiceName)&&(identical(other.movementDocumentId, movementDocumentId) || other.movementDocumentId == movementDocumentId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.total, total) || other.total == total)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.netTotal, netTotal) || other.netTotal == netTotal)&&(identical(other.discountStatus, discountStatus) || other.discountStatus == discountStatus)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.billingStatus, billingStatus) || other.billingStatus == billingStatus)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&(identical(other.seller, seller) || other.seller == seller)&&(identical(other.referrer, referrer) || other.referrer == referrer)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,patientExternalId,patientDocument,patientFirstName,patientLastName,medicalServiceId,medicalServiceName,movementDocumentId,quantity,unitPrice,total,discountType,discountValue,discountAmount,netTotal,discountStatus,orderNumber,billingStatus,serviceDate,seller,referrer,isActive]);

@override
String toString() {
  return 'ProcedureRecord(id: $id, patientExternalId: $patientExternalId, patientDocument: $patientDocument, patientFirstName: $patientFirstName, patientLastName: $patientLastName, medicalServiceId: $medicalServiceId, medicalServiceName: $medicalServiceName, movementDocumentId: $movementDocumentId, quantity: $quantity, unitPrice: $unitPrice, total: $total, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, netTotal: $netTotal, discountStatus: $discountStatus, orderNumber: $orderNumber, billingStatus: $billingStatus, serviceDate: $serviceDate, seller: $seller, referrer: $referrer, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ProcedureRecordCopyWith<$Res> implements $ProcedureRecordCopyWith<$Res> {
  factory _$ProcedureRecordCopyWith(_ProcedureRecord value, $Res Function(_ProcedureRecord) _then) = __$ProcedureRecordCopyWithImpl;
@override @useResult
$Res call({
 int id, String patientExternalId, String patientDocument, String patientFirstName, String patientLastName, int? medicalServiceId, String? medicalServiceName, int? movementDocumentId,@DoubleConverter() double? quantity,@DoubleConverter() double? unitPrice,@DoubleConverter() double? total, String? discountType,@DoubleConverter() double? discountValue,@DoubleConverter() double? discountAmount,@DoubleConverter() double? netTotal, String? discountStatus, String? orderNumber, String? billingStatus, String? serviceDate, String? seller, String? referrer, bool isActive
});




}
/// @nodoc
class __$ProcedureRecordCopyWithImpl<$Res>
    implements _$ProcedureRecordCopyWith<$Res> {
  __$ProcedureRecordCopyWithImpl(this._self, this._then);

  final _ProcedureRecord _self;
  final $Res Function(_ProcedureRecord) _then;

/// Create a copy of ProcedureRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patientExternalId = null,Object? patientDocument = null,Object? patientFirstName = null,Object? patientLastName = null,Object? medicalServiceId = freezed,Object? medicalServiceName = freezed,Object? movementDocumentId = freezed,Object? quantity = freezed,Object? unitPrice = freezed,Object? total = freezed,Object? discountType = freezed,Object? discountValue = freezed,Object? discountAmount = freezed,Object? netTotal = freezed,Object? discountStatus = freezed,Object? orderNumber = freezed,Object? billingStatus = freezed,Object? serviceDate = freezed,Object? seller = freezed,Object? referrer = freezed,Object? isActive = null,}) {
  return _then(_ProcedureRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,patientExternalId: null == patientExternalId ? _self.patientExternalId : patientExternalId // ignore: cast_nullable_to_non_nullable
as String,patientDocument: null == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String,patientFirstName: null == patientFirstName ? _self.patientFirstName : patientFirstName // ignore: cast_nullable_to_non_nullable
as String,patientLastName: null == patientLastName ? _self.patientLastName : patientLastName // ignore: cast_nullable_to_non_nullable
as String,medicalServiceId: freezed == medicalServiceId ? _self.medicalServiceId : medicalServiceId // ignore: cast_nullable_to_non_nullable
as int?,medicalServiceName: freezed == medicalServiceName ? _self.medicalServiceName : medicalServiceName // ignore: cast_nullable_to_non_nullable
as String?,movementDocumentId: freezed == movementDocumentId ? _self.movementDocumentId : movementDocumentId // ignore: cast_nullable_to_non_nullable
as int?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,discountType: freezed == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as String?,discountValue: freezed == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double?,netTotal: freezed == netTotal ? _self.netTotal : netTotal // ignore: cast_nullable_to_non_nullable
as double?,discountStatus: freezed == discountStatus ? _self.discountStatus : discountStatus // ignore: cast_nullable_to_non_nullable
as String?,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String?,billingStatus: freezed == billingStatus ? _self.billingStatus : billingStatus // ignore: cast_nullable_to_non_nullable
as String?,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,seller: freezed == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as String?,referrer: freezed == referrer ? _self.referrer : referrer // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HistoryRecord {

 int get id; String? get serviceDate; String? get serviceName; String? get procedureCode; String? get procedureName;@DoubleConverter() double? get quantity;@DoubleConverter() double? get unitPrice;@DoubleConverter() double? get total; bool get isActive;
/// Create a copy of HistoryRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryRecordCopyWith<HistoryRecord> get copyWith => _$HistoryRecordCopyWithImpl<HistoryRecord>(this as HistoryRecord, _$identity);

  /// Serializes this HistoryRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.procedureCode, procedureCode) || other.procedureCode == procedureCode)&&(identical(other.procedureName, procedureName) || other.procedureName == procedureName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.total, total) || other.total == total)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serviceDate,serviceName,procedureCode,procedureName,quantity,unitPrice,total,isActive);

@override
String toString() {
  return 'HistoryRecord(id: $id, serviceDate: $serviceDate, serviceName: $serviceName, procedureCode: $procedureCode, procedureName: $procedureName, quantity: $quantity, unitPrice: $unitPrice, total: $total, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $HistoryRecordCopyWith<$Res>  {
  factory $HistoryRecordCopyWith(HistoryRecord value, $Res Function(HistoryRecord) _then) = _$HistoryRecordCopyWithImpl;
@useResult
$Res call({
 int id, String? serviceDate, String? serviceName, String? procedureCode, String? procedureName,@DoubleConverter() double? quantity,@DoubleConverter() double? unitPrice,@DoubleConverter() double? total, bool isActive
});




}
/// @nodoc
class _$HistoryRecordCopyWithImpl<$Res>
    implements $HistoryRecordCopyWith<$Res> {
  _$HistoryRecordCopyWithImpl(this._self, this._then);

  final HistoryRecord _self;
  final $Res Function(HistoryRecord) _then;

/// Create a copy of HistoryRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serviceDate = freezed,Object? serviceName = freezed,Object? procedureCode = freezed,Object? procedureName = freezed,Object? quantity = freezed,Object? unitPrice = freezed,Object? total = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,procedureCode: freezed == procedureCode ? _self.procedureCode : procedureCode // ignore: cast_nullable_to_non_nullable
as String?,procedureName: freezed == procedureName ? _self.procedureName : procedureName // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryRecord].
extension HistoryRecordPatterns on HistoryRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryRecord value)  $default,){
final _that = this;
switch (_that) {
case _HistoryRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryRecord value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? serviceDate,  String? serviceName,  String? procedureCode,  String? procedureName, @DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? total,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryRecord() when $default != null:
return $default(_that.id,_that.serviceDate,_that.serviceName,_that.procedureCode,_that.procedureName,_that.quantity,_that.unitPrice,_that.total,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? serviceDate,  String? serviceName,  String? procedureCode,  String? procedureName, @DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? total,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _HistoryRecord():
return $default(_that.id,_that.serviceDate,_that.serviceName,_that.procedureCode,_that.procedureName,_that.quantity,_that.unitPrice,_that.total,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? serviceDate,  String? serviceName,  String? procedureCode,  String? procedureName, @DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? total,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _HistoryRecord() when $default != null:
return $default(_that.id,_that.serviceDate,_that.serviceName,_that.procedureCode,_that.procedureName,_that.quantity,_that.unitPrice,_that.total,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryRecord implements HistoryRecord {
  const _HistoryRecord({required this.id, this.serviceDate, this.serviceName, this.procedureCode, this.procedureName, @DoubleConverter() this.quantity, @DoubleConverter() this.unitPrice, @DoubleConverter() this.total, this.isActive = true});
  factory _HistoryRecord.fromJson(Map<String, dynamic> json) => _$HistoryRecordFromJson(json);

@override final  int id;
@override final  String? serviceDate;
@override final  String? serviceName;
@override final  String? procedureCode;
@override final  String? procedureName;
@override@DoubleConverter() final  double? quantity;
@override@DoubleConverter() final  double? unitPrice;
@override@DoubleConverter() final  double? total;
@override@JsonKey() final  bool isActive;

/// Create a copy of HistoryRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryRecordCopyWith<_HistoryRecord> get copyWith => __$HistoryRecordCopyWithImpl<_HistoryRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.procedureCode, procedureCode) || other.procedureCode == procedureCode)&&(identical(other.procedureName, procedureName) || other.procedureName == procedureName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.total, total) || other.total == total)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serviceDate,serviceName,procedureCode,procedureName,quantity,unitPrice,total,isActive);

@override
String toString() {
  return 'HistoryRecord(id: $id, serviceDate: $serviceDate, serviceName: $serviceName, procedureCode: $procedureCode, procedureName: $procedureName, quantity: $quantity, unitPrice: $unitPrice, total: $total, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$HistoryRecordCopyWith<$Res> implements $HistoryRecordCopyWith<$Res> {
  factory _$HistoryRecordCopyWith(_HistoryRecord value, $Res Function(_HistoryRecord) _then) = __$HistoryRecordCopyWithImpl;
@override @useResult
$Res call({
 int id, String? serviceDate, String? serviceName, String? procedureCode, String? procedureName,@DoubleConverter() double? quantity,@DoubleConverter() double? unitPrice,@DoubleConverter() double? total, bool isActive
});




}
/// @nodoc
class __$HistoryRecordCopyWithImpl<$Res>
    implements _$HistoryRecordCopyWith<$Res> {
  __$HistoryRecordCopyWithImpl(this._self, this._then);

  final _HistoryRecord _self;
  final $Res Function(_HistoryRecord) _then;

/// Create a copy of HistoryRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serviceDate = freezed,Object? serviceName = freezed,Object? procedureCode = freezed,Object? procedureName = freezed,Object? quantity = freezed,Object? unitPrice = freezed,Object? total = freezed,Object? isActive = null,}) {
  return _then(_HistoryRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,serviceName: freezed == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String?,procedureCode: freezed == procedureCode ? _self.procedureCode : procedureCode // ignore: cast_nullable_to_non_nullable
as String?,procedureName: freezed == procedureName ? _self.procedureName : procedureName // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HistorySummary {

 int get totalRecords;@DoubleConverter() double? get totalAmount; String? get firstServiceDate; String? get lastServiceDate;
/// Create a copy of HistorySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistorySummaryCopyWith<HistorySummary> get copyWith => _$HistorySummaryCopyWithImpl<HistorySummary>(this as HistorySummary, _$identity);

  /// Serializes this HistorySummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistorySummary&&(identical(other.totalRecords, totalRecords) || other.totalRecords == totalRecords)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.firstServiceDate, firstServiceDate) || other.firstServiceDate == firstServiceDate)&&(identical(other.lastServiceDate, lastServiceDate) || other.lastServiceDate == lastServiceDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRecords,totalAmount,firstServiceDate,lastServiceDate);

@override
String toString() {
  return 'HistorySummary(totalRecords: $totalRecords, totalAmount: $totalAmount, firstServiceDate: $firstServiceDate, lastServiceDate: $lastServiceDate)';
}


}

/// @nodoc
abstract mixin class $HistorySummaryCopyWith<$Res>  {
  factory $HistorySummaryCopyWith(HistorySummary value, $Res Function(HistorySummary) _then) = _$HistorySummaryCopyWithImpl;
@useResult
$Res call({
 int totalRecords,@DoubleConverter() double? totalAmount, String? firstServiceDate, String? lastServiceDate
});




}
/// @nodoc
class _$HistorySummaryCopyWithImpl<$Res>
    implements $HistorySummaryCopyWith<$Res> {
  _$HistorySummaryCopyWithImpl(this._self, this._then);

  final HistorySummary _self;
  final $Res Function(HistorySummary) _then;

/// Create a copy of HistorySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRecords = null,Object? totalAmount = freezed,Object? firstServiceDate = freezed,Object? lastServiceDate = freezed,}) {
  return _then(_self.copyWith(
totalRecords: null == totalRecords ? _self.totalRecords : totalRecords // ignore: cast_nullable_to_non_nullable
as int,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,firstServiceDate: freezed == firstServiceDate ? _self.firstServiceDate : firstServiceDate // ignore: cast_nullable_to_non_nullable
as String?,lastServiceDate: freezed == lastServiceDate ? _self.lastServiceDate : lastServiceDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HistorySummary].
extension HistorySummaryPatterns on HistorySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistorySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistorySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistorySummary value)  $default,){
final _that = this;
switch (_that) {
case _HistorySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistorySummary value)?  $default,){
final _that = this;
switch (_that) {
case _HistorySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalRecords, @DoubleConverter()  double? totalAmount,  String? firstServiceDate,  String? lastServiceDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistorySummary() when $default != null:
return $default(_that.totalRecords,_that.totalAmount,_that.firstServiceDate,_that.lastServiceDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalRecords, @DoubleConverter()  double? totalAmount,  String? firstServiceDate,  String? lastServiceDate)  $default,) {final _that = this;
switch (_that) {
case _HistorySummary():
return $default(_that.totalRecords,_that.totalAmount,_that.firstServiceDate,_that.lastServiceDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalRecords, @DoubleConverter()  double? totalAmount,  String? firstServiceDate,  String? lastServiceDate)?  $default,) {final _that = this;
switch (_that) {
case _HistorySummary() when $default != null:
return $default(_that.totalRecords,_that.totalAmount,_that.firstServiceDate,_that.lastServiceDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistorySummary implements HistorySummary {
  const _HistorySummary({this.totalRecords = 0, @DoubleConverter() this.totalAmount, this.firstServiceDate, this.lastServiceDate});
  factory _HistorySummary.fromJson(Map<String, dynamic> json) => _$HistorySummaryFromJson(json);

@override@JsonKey() final  int totalRecords;
@override@DoubleConverter() final  double? totalAmount;
@override final  String? firstServiceDate;
@override final  String? lastServiceDate;

/// Create a copy of HistorySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistorySummaryCopyWith<_HistorySummary> get copyWith => __$HistorySummaryCopyWithImpl<_HistorySummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistorySummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistorySummary&&(identical(other.totalRecords, totalRecords) || other.totalRecords == totalRecords)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.firstServiceDate, firstServiceDate) || other.firstServiceDate == firstServiceDate)&&(identical(other.lastServiceDate, lastServiceDate) || other.lastServiceDate == lastServiceDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalRecords,totalAmount,firstServiceDate,lastServiceDate);

@override
String toString() {
  return 'HistorySummary(totalRecords: $totalRecords, totalAmount: $totalAmount, firstServiceDate: $firstServiceDate, lastServiceDate: $lastServiceDate)';
}


}

/// @nodoc
abstract mixin class _$HistorySummaryCopyWith<$Res> implements $HistorySummaryCopyWith<$Res> {
  factory _$HistorySummaryCopyWith(_HistorySummary value, $Res Function(_HistorySummary) _then) = __$HistorySummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalRecords,@DoubleConverter() double? totalAmount, String? firstServiceDate, String? lastServiceDate
});




}
/// @nodoc
class __$HistorySummaryCopyWithImpl<$Res>
    implements _$HistorySummaryCopyWith<$Res> {
  __$HistorySummaryCopyWithImpl(this._self, this._then);

  final _HistorySummary _self;
  final $Res Function(_HistorySummary) _then;

/// Create a copy of HistorySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRecords = null,Object? totalAmount = freezed,Object? firstServiceDate = freezed,Object? lastServiceDate = freezed,}) {
  return _then(_HistorySummary(
totalRecords: null == totalRecords ? _self.totalRecords : totalRecords // ignore: cast_nullable_to_non_nullable
as int,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,firstServiceDate: freezed == firstServiceDate ? _self.firstServiceDate : firstServiceDate // ignore: cast_nullable_to_non_nullable
as String?,lastServiceDate: freezed == lastServiceDate ? _self.lastServiceDate : lastServiceDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PatientHistory {

 String get patientExternalId; String get patientDocument; String get patientFirstName; String get patientLastName; HistorySummary get summary; List<HistoryRecord> get records;
/// Create a copy of PatientHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientHistoryCopyWith<PatientHistory> get copyWith => _$PatientHistoryCopyWithImpl<PatientHistory>(this as PatientHistory, _$identity);

  /// Serializes this PatientHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientHistory&&(identical(other.patientExternalId, patientExternalId) || other.patientExternalId == patientExternalId)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.patientFirstName, patientFirstName) || other.patientFirstName == patientFirstName)&&(identical(other.patientLastName, patientLastName) || other.patientLastName == patientLastName)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.records, records));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patientExternalId,patientDocument,patientFirstName,patientLastName,summary,const DeepCollectionEquality().hash(records));

@override
String toString() {
  return 'PatientHistory(patientExternalId: $patientExternalId, patientDocument: $patientDocument, patientFirstName: $patientFirstName, patientLastName: $patientLastName, summary: $summary, records: $records)';
}


}

/// @nodoc
abstract mixin class $PatientHistoryCopyWith<$Res>  {
  factory $PatientHistoryCopyWith(PatientHistory value, $Res Function(PatientHistory) _then) = _$PatientHistoryCopyWithImpl;
@useResult
$Res call({
 String patientExternalId, String patientDocument, String patientFirstName, String patientLastName, HistorySummary summary, List<HistoryRecord> records
});


$HistorySummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$PatientHistoryCopyWithImpl<$Res>
    implements $PatientHistoryCopyWith<$Res> {
  _$PatientHistoryCopyWithImpl(this._self, this._then);

  final PatientHistory _self;
  final $Res Function(PatientHistory) _then;

/// Create a copy of PatientHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? patientExternalId = null,Object? patientDocument = null,Object? patientFirstName = null,Object? patientLastName = null,Object? summary = null,Object? records = null,}) {
  return _then(_self.copyWith(
patientExternalId: null == patientExternalId ? _self.patientExternalId : patientExternalId // ignore: cast_nullable_to_non_nullable
as String,patientDocument: null == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String,patientFirstName: null == patientFirstName ? _self.patientFirstName : patientFirstName // ignore: cast_nullable_to_non_nullable
as String,patientLastName: null == patientLastName ? _self.patientLastName : patientLastName // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as HistorySummary,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<HistoryRecord>,
  ));
}
/// Create a copy of PatientHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistorySummaryCopyWith<$Res> get summary {
  
  return $HistorySummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [PatientHistory].
extension PatientHistoryPatterns on PatientHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientHistory value)  $default,){
final _that = this;
switch (_that) {
case _PatientHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientHistory value)?  $default,){
final _that = this;
switch (_that) {
case _PatientHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName,  HistorySummary summary,  List<HistoryRecord> records)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientHistory() when $default != null:
return $default(_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.summary,_that.records);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName,  HistorySummary summary,  List<HistoryRecord> records)  $default,) {final _that = this;
switch (_that) {
case _PatientHistory():
return $default(_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.summary,_that.records);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName,  HistorySummary summary,  List<HistoryRecord> records)?  $default,) {final _that = this;
switch (_that) {
case _PatientHistory() when $default != null:
return $default(_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.summary,_that.records);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatientHistory extends PatientHistory {
  const _PatientHistory({required this.patientExternalId, required this.patientDocument, required this.patientFirstName, required this.patientLastName, required this.summary, final  List<HistoryRecord> records = const []}): _records = records,super._();
  factory _PatientHistory.fromJson(Map<String, dynamic> json) => _$PatientHistoryFromJson(json);

@override final  String patientExternalId;
@override final  String patientDocument;
@override final  String patientFirstName;
@override final  String patientLastName;
@override final  HistorySummary summary;
 final  List<HistoryRecord> _records;
@override@JsonKey() List<HistoryRecord> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}


/// Create a copy of PatientHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientHistoryCopyWith<_PatientHistory> get copyWith => __$PatientHistoryCopyWithImpl<_PatientHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientHistory&&(identical(other.patientExternalId, patientExternalId) || other.patientExternalId == patientExternalId)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.patientFirstName, patientFirstName) || other.patientFirstName == patientFirstName)&&(identical(other.patientLastName, patientLastName) || other.patientLastName == patientLastName)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._records, _records));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patientExternalId,patientDocument,patientFirstName,patientLastName,summary,const DeepCollectionEquality().hash(_records));

@override
String toString() {
  return 'PatientHistory(patientExternalId: $patientExternalId, patientDocument: $patientDocument, patientFirstName: $patientFirstName, patientLastName: $patientLastName, summary: $summary, records: $records)';
}


}

/// @nodoc
abstract mixin class _$PatientHistoryCopyWith<$Res> implements $PatientHistoryCopyWith<$Res> {
  factory _$PatientHistoryCopyWith(_PatientHistory value, $Res Function(_PatientHistory) _then) = __$PatientHistoryCopyWithImpl;
@override @useResult
$Res call({
 String patientExternalId, String patientDocument, String patientFirstName, String patientLastName, HistorySummary summary, List<HistoryRecord> records
});


@override $HistorySummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$PatientHistoryCopyWithImpl<$Res>
    implements _$PatientHistoryCopyWith<$Res> {
  __$PatientHistoryCopyWithImpl(this._self, this._then);

  final _PatientHistory _self;
  final $Res Function(_PatientHistory) _then;

/// Create a copy of PatientHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? patientExternalId = null,Object? patientDocument = null,Object? patientFirstName = null,Object? patientLastName = null,Object? summary = null,Object? records = null,}) {
  return _then(_PatientHistory(
patientExternalId: null == patientExternalId ? _self.patientExternalId : patientExternalId // ignore: cast_nullable_to_non_nullable
as String,patientDocument: null == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String,patientFirstName: null == patientFirstName ? _self.patientFirstName : patientFirstName // ignore: cast_nullable_to_non_nullable
as String,patientLastName: null == patientLastName ? _self.patientLastName : patientLastName // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as HistorySummary,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<HistoryRecord>,
  ));
}

/// Create a copy of PatientHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistorySummaryCopyWith<$Res> get summary {
  
  return $HistorySummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
