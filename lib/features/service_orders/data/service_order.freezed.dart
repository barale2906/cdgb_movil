// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceOrder {

 String get orderNumber; String get patientExternalId; String get patientDocument; String get patientFirstName; String get patientLastName;@ServiceOrderStatusConverter() ServiceOrderStatus get orderStatus; String? get serviceDate; String? get billingStatus;@DoubleConverter() double? get totalAmount;@DoubleConverter() double? get totalDiscount;@DoubleConverter() double? get netTotal; List<ProcedureRecord> get procedures;
/// Create a copy of ServiceOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceOrderCopyWith<ServiceOrder> get copyWith => _$ServiceOrderCopyWithImpl<ServiceOrder>(this as ServiceOrder, _$identity);

  /// Serializes this ServiceOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceOrder&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.patientExternalId, patientExternalId) || other.patientExternalId == patientExternalId)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.patientFirstName, patientFirstName) || other.patientFirstName == patientFirstName)&&(identical(other.patientLastName, patientLastName) || other.patientLastName == patientLastName)&&(identical(other.orderStatus, orderStatus) || other.orderStatus == orderStatus)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&(identical(other.billingStatus, billingStatus) || other.billingStatus == billingStatus)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalDiscount, totalDiscount) || other.totalDiscount == totalDiscount)&&(identical(other.netTotal, netTotal) || other.netTotal == netTotal)&&const DeepCollectionEquality().equals(other.procedures, procedures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderNumber,patientExternalId,patientDocument,patientFirstName,patientLastName,orderStatus,serviceDate,billingStatus,totalAmount,totalDiscount,netTotal,const DeepCollectionEquality().hash(procedures));

@override
String toString() {
  return 'ServiceOrder(orderNumber: $orderNumber, patientExternalId: $patientExternalId, patientDocument: $patientDocument, patientFirstName: $patientFirstName, patientLastName: $patientLastName, orderStatus: $orderStatus, serviceDate: $serviceDate, billingStatus: $billingStatus, totalAmount: $totalAmount, totalDiscount: $totalDiscount, netTotal: $netTotal, procedures: $procedures)';
}


}

/// @nodoc
abstract mixin class $ServiceOrderCopyWith<$Res>  {
  factory $ServiceOrderCopyWith(ServiceOrder value, $Res Function(ServiceOrder) _then) = _$ServiceOrderCopyWithImpl;
@useResult
$Res call({
 String orderNumber, String patientExternalId, String patientDocument, String patientFirstName, String patientLastName,@ServiceOrderStatusConverter() ServiceOrderStatus orderStatus, String? serviceDate, String? billingStatus,@DoubleConverter() double? totalAmount,@DoubleConverter() double? totalDiscount,@DoubleConverter() double? netTotal, List<ProcedureRecord> procedures
});




}
/// @nodoc
class _$ServiceOrderCopyWithImpl<$Res>
    implements $ServiceOrderCopyWith<$Res> {
  _$ServiceOrderCopyWithImpl(this._self, this._then);

  final ServiceOrder _self;
  final $Res Function(ServiceOrder) _then;

/// Create a copy of ServiceOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderNumber = null,Object? patientExternalId = null,Object? patientDocument = null,Object? patientFirstName = null,Object? patientLastName = null,Object? orderStatus = null,Object? serviceDate = freezed,Object? billingStatus = freezed,Object? totalAmount = freezed,Object? totalDiscount = freezed,Object? netTotal = freezed,Object? procedures = null,}) {
  return _then(_self.copyWith(
orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,patientExternalId: null == patientExternalId ? _self.patientExternalId : patientExternalId // ignore: cast_nullable_to_non_nullable
as String,patientDocument: null == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String,patientFirstName: null == patientFirstName ? _self.patientFirstName : patientFirstName // ignore: cast_nullable_to_non_nullable
as String,patientLastName: null == patientLastName ? _self.patientLastName : patientLastName // ignore: cast_nullable_to_non_nullable
as String,orderStatus: null == orderStatus ? _self.orderStatus : orderStatus // ignore: cast_nullable_to_non_nullable
as ServiceOrderStatus,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,billingStatus: freezed == billingStatus ? _self.billingStatus : billingStatus // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,totalDiscount: freezed == totalDiscount ? _self.totalDiscount : totalDiscount // ignore: cast_nullable_to_non_nullable
as double?,netTotal: freezed == netTotal ? _self.netTotal : netTotal // ignore: cast_nullable_to_non_nullable
as double?,procedures: null == procedures ? _self.procedures : procedures // ignore: cast_nullable_to_non_nullable
as List<ProcedureRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceOrder].
extension ServiceOrderPatterns on ServiceOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceOrder value)  $default,){
final _that = this;
switch (_that) {
case _ServiceOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceOrder value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orderNumber,  String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName, @ServiceOrderStatusConverter()  ServiceOrderStatus orderStatus,  String? serviceDate,  String? billingStatus, @DoubleConverter()  double? totalAmount, @DoubleConverter()  double? totalDiscount, @DoubleConverter()  double? netTotal,  List<ProcedureRecord> procedures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceOrder() when $default != null:
return $default(_that.orderNumber,_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.orderStatus,_that.serviceDate,_that.billingStatus,_that.totalAmount,_that.totalDiscount,_that.netTotal,_that.procedures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orderNumber,  String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName, @ServiceOrderStatusConverter()  ServiceOrderStatus orderStatus,  String? serviceDate,  String? billingStatus, @DoubleConverter()  double? totalAmount, @DoubleConverter()  double? totalDiscount, @DoubleConverter()  double? netTotal,  List<ProcedureRecord> procedures)  $default,) {final _that = this;
switch (_that) {
case _ServiceOrder():
return $default(_that.orderNumber,_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.orderStatus,_that.serviceDate,_that.billingStatus,_that.totalAmount,_that.totalDiscount,_that.netTotal,_that.procedures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orderNumber,  String patientExternalId,  String patientDocument,  String patientFirstName,  String patientLastName, @ServiceOrderStatusConverter()  ServiceOrderStatus orderStatus,  String? serviceDate,  String? billingStatus, @DoubleConverter()  double? totalAmount, @DoubleConverter()  double? totalDiscount, @DoubleConverter()  double? netTotal,  List<ProcedureRecord> procedures)?  $default,) {final _that = this;
switch (_that) {
case _ServiceOrder() when $default != null:
return $default(_that.orderNumber,_that.patientExternalId,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.orderStatus,_that.serviceDate,_that.billingStatus,_that.totalAmount,_that.totalDiscount,_that.netTotal,_that.procedures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceOrder extends ServiceOrder {
  const _ServiceOrder({required this.orderNumber, required this.patientExternalId, required this.patientDocument, required this.patientFirstName, required this.patientLastName, @ServiceOrderStatusConverter() this.orderStatus = ServiceOrderStatus.unknown, this.serviceDate, this.billingStatus, @DoubleConverter() this.totalAmount, @DoubleConverter() this.totalDiscount, @DoubleConverter() this.netTotal, final  List<ProcedureRecord> procedures = const []}): _procedures = procedures,super._();
  factory _ServiceOrder.fromJson(Map<String, dynamic> json) => _$ServiceOrderFromJson(json);

@override final  String orderNumber;
@override final  String patientExternalId;
@override final  String patientDocument;
@override final  String patientFirstName;
@override final  String patientLastName;
@override@JsonKey()@ServiceOrderStatusConverter() final  ServiceOrderStatus orderStatus;
@override final  String? serviceDate;
@override final  String? billingStatus;
@override@DoubleConverter() final  double? totalAmount;
@override@DoubleConverter() final  double? totalDiscount;
@override@DoubleConverter() final  double? netTotal;
 final  List<ProcedureRecord> _procedures;
@override@JsonKey() List<ProcedureRecord> get procedures {
  if (_procedures is EqualUnmodifiableListView) return _procedures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_procedures);
}


/// Create a copy of ServiceOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceOrderCopyWith<_ServiceOrder> get copyWith => __$ServiceOrderCopyWithImpl<_ServiceOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceOrder&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.patientExternalId, patientExternalId) || other.patientExternalId == patientExternalId)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.patientFirstName, patientFirstName) || other.patientFirstName == patientFirstName)&&(identical(other.patientLastName, patientLastName) || other.patientLastName == patientLastName)&&(identical(other.orderStatus, orderStatus) || other.orderStatus == orderStatus)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&(identical(other.billingStatus, billingStatus) || other.billingStatus == billingStatus)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalDiscount, totalDiscount) || other.totalDiscount == totalDiscount)&&(identical(other.netTotal, netTotal) || other.netTotal == netTotal)&&const DeepCollectionEquality().equals(other._procedures, _procedures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderNumber,patientExternalId,patientDocument,patientFirstName,patientLastName,orderStatus,serviceDate,billingStatus,totalAmount,totalDiscount,netTotal,const DeepCollectionEquality().hash(_procedures));

@override
String toString() {
  return 'ServiceOrder(orderNumber: $orderNumber, patientExternalId: $patientExternalId, patientDocument: $patientDocument, patientFirstName: $patientFirstName, patientLastName: $patientLastName, orderStatus: $orderStatus, serviceDate: $serviceDate, billingStatus: $billingStatus, totalAmount: $totalAmount, totalDiscount: $totalDiscount, netTotal: $netTotal, procedures: $procedures)';
}


}

/// @nodoc
abstract mixin class _$ServiceOrderCopyWith<$Res> implements $ServiceOrderCopyWith<$Res> {
  factory _$ServiceOrderCopyWith(_ServiceOrder value, $Res Function(_ServiceOrder) _then) = __$ServiceOrderCopyWithImpl;
@override @useResult
$Res call({
 String orderNumber, String patientExternalId, String patientDocument, String patientFirstName, String patientLastName,@ServiceOrderStatusConverter() ServiceOrderStatus orderStatus, String? serviceDate, String? billingStatus,@DoubleConverter() double? totalAmount,@DoubleConverter() double? totalDiscount,@DoubleConverter() double? netTotal, List<ProcedureRecord> procedures
});




}
/// @nodoc
class __$ServiceOrderCopyWithImpl<$Res>
    implements _$ServiceOrderCopyWith<$Res> {
  __$ServiceOrderCopyWithImpl(this._self, this._then);

  final _ServiceOrder _self;
  final $Res Function(_ServiceOrder) _then;

/// Create a copy of ServiceOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderNumber = null,Object? patientExternalId = null,Object? patientDocument = null,Object? patientFirstName = null,Object? patientLastName = null,Object? orderStatus = null,Object? serviceDate = freezed,Object? billingStatus = freezed,Object? totalAmount = freezed,Object? totalDiscount = freezed,Object? netTotal = freezed,Object? procedures = null,}) {
  return _then(_ServiceOrder(
orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,patientExternalId: null == patientExternalId ? _self.patientExternalId : patientExternalId // ignore: cast_nullable_to_non_nullable
as String,patientDocument: null == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String,patientFirstName: null == patientFirstName ? _self.patientFirstName : patientFirstName // ignore: cast_nullable_to_non_nullable
as String,patientLastName: null == patientLastName ? _self.patientLastName : patientLastName // ignore: cast_nullable_to_non_nullable
as String,orderStatus: null == orderStatus ? _self.orderStatus : orderStatus // ignore: cast_nullable_to_non_nullable
as ServiceOrderStatus,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,billingStatus: freezed == billingStatus ? _self.billingStatus : billingStatus // ignore: cast_nullable_to_non_nullable
as String?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,totalDiscount: freezed == totalDiscount ? _self.totalDiscount : totalDiscount // ignore: cast_nullable_to_non_nullable
as double?,netTotal: freezed == netTotal ? _self.netTotal : netTotal // ignore: cast_nullable_to_non_nullable
as double?,procedures: null == procedures ? _self._procedures : procedures // ignore: cast_nullable_to_non_nullable
as List<ProcedureRecord>,
  ));
}


}


/// @nodoc
mixin _$DiscountOrder {

 String get orderNumber; String get patientDocument; String get patientFirstName; String get patientLastName; String? get serviceDate; List<ProcedureRecord> get records;
/// Create a copy of DiscountOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscountOrderCopyWith<DiscountOrder> get copyWith => _$DiscountOrderCopyWithImpl<DiscountOrder>(this as DiscountOrder, _$identity);

  /// Serializes this DiscountOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiscountOrder&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.patientFirstName, patientFirstName) || other.patientFirstName == patientFirstName)&&(identical(other.patientLastName, patientLastName) || other.patientLastName == patientLastName)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&const DeepCollectionEquality().equals(other.records, records));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderNumber,patientDocument,patientFirstName,patientLastName,serviceDate,const DeepCollectionEquality().hash(records));

@override
String toString() {
  return 'DiscountOrder(orderNumber: $orderNumber, patientDocument: $patientDocument, patientFirstName: $patientFirstName, patientLastName: $patientLastName, serviceDate: $serviceDate, records: $records)';
}


}

/// @nodoc
abstract mixin class $DiscountOrderCopyWith<$Res>  {
  factory $DiscountOrderCopyWith(DiscountOrder value, $Res Function(DiscountOrder) _then) = _$DiscountOrderCopyWithImpl;
@useResult
$Res call({
 String orderNumber, String patientDocument, String patientFirstName, String patientLastName, String? serviceDate, List<ProcedureRecord> records
});




}
/// @nodoc
class _$DiscountOrderCopyWithImpl<$Res>
    implements $DiscountOrderCopyWith<$Res> {
  _$DiscountOrderCopyWithImpl(this._self, this._then);

  final DiscountOrder _self;
  final $Res Function(DiscountOrder) _then;

/// Create a copy of DiscountOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderNumber = null,Object? patientDocument = null,Object? patientFirstName = null,Object? patientLastName = null,Object? serviceDate = freezed,Object? records = null,}) {
  return _then(_self.copyWith(
orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,patientDocument: null == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String,patientFirstName: null == patientFirstName ? _self.patientFirstName : patientFirstName // ignore: cast_nullable_to_non_nullable
as String,patientLastName: null == patientLastName ? _self.patientLastName : patientLastName // ignore: cast_nullable_to_non_nullable
as String,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<ProcedureRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [DiscountOrder].
extension DiscountOrderPatterns on DiscountOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiscountOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiscountOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiscountOrder value)  $default,){
final _that = this;
switch (_that) {
case _DiscountOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiscountOrder value)?  $default,){
final _that = this;
switch (_that) {
case _DiscountOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orderNumber,  String patientDocument,  String patientFirstName,  String patientLastName,  String? serviceDate,  List<ProcedureRecord> records)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiscountOrder() when $default != null:
return $default(_that.orderNumber,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.serviceDate,_that.records);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orderNumber,  String patientDocument,  String patientFirstName,  String patientLastName,  String? serviceDate,  List<ProcedureRecord> records)  $default,) {final _that = this;
switch (_that) {
case _DiscountOrder():
return $default(_that.orderNumber,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.serviceDate,_that.records);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orderNumber,  String patientDocument,  String patientFirstName,  String patientLastName,  String? serviceDate,  List<ProcedureRecord> records)?  $default,) {final _that = this;
switch (_that) {
case _DiscountOrder() when $default != null:
return $default(_that.orderNumber,_that.patientDocument,_that.patientFirstName,_that.patientLastName,_that.serviceDate,_that.records);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiscountOrder extends DiscountOrder {
  const _DiscountOrder({required this.orderNumber, required this.patientDocument, required this.patientFirstName, required this.patientLastName, this.serviceDate, final  List<ProcedureRecord> records = const []}): _records = records,super._();
  factory _DiscountOrder.fromJson(Map<String, dynamic> json) => _$DiscountOrderFromJson(json);

@override final  String orderNumber;
@override final  String patientDocument;
@override final  String patientFirstName;
@override final  String patientLastName;
@override final  String? serviceDate;
 final  List<ProcedureRecord> _records;
@override@JsonKey() List<ProcedureRecord> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}


/// Create a copy of DiscountOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiscountOrderCopyWith<_DiscountOrder> get copyWith => __$DiscountOrderCopyWithImpl<_DiscountOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiscountOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiscountOrder&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.patientFirstName, patientFirstName) || other.patientFirstName == patientFirstName)&&(identical(other.patientLastName, patientLastName) || other.patientLastName == patientLastName)&&(identical(other.serviceDate, serviceDate) || other.serviceDate == serviceDate)&&const DeepCollectionEquality().equals(other._records, _records));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderNumber,patientDocument,patientFirstName,patientLastName,serviceDate,const DeepCollectionEquality().hash(_records));

@override
String toString() {
  return 'DiscountOrder(orderNumber: $orderNumber, patientDocument: $patientDocument, patientFirstName: $patientFirstName, patientLastName: $patientLastName, serviceDate: $serviceDate, records: $records)';
}


}

/// @nodoc
abstract mixin class _$DiscountOrderCopyWith<$Res> implements $DiscountOrderCopyWith<$Res> {
  factory _$DiscountOrderCopyWith(_DiscountOrder value, $Res Function(_DiscountOrder) _then) = __$DiscountOrderCopyWithImpl;
@override @useResult
$Res call({
 String orderNumber, String patientDocument, String patientFirstName, String patientLastName, String? serviceDate, List<ProcedureRecord> records
});




}
/// @nodoc
class __$DiscountOrderCopyWithImpl<$Res>
    implements _$DiscountOrderCopyWith<$Res> {
  __$DiscountOrderCopyWithImpl(this._self, this._then);

  final _DiscountOrder _self;
  final $Res Function(_DiscountOrder) _then;

/// Create a copy of DiscountOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderNumber = null,Object? patientDocument = null,Object? patientFirstName = null,Object? patientLastName = null,Object? serviceDate = freezed,Object? records = null,}) {
  return _then(_DiscountOrder(
orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,patientDocument: null == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String,patientFirstName: null == patientFirstName ? _self.patientFirstName : patientFirstName // ignore: cast_nullable_to_non_nullable
as String,patientLastName: null == patientLastName ? _self.patientLastName : patientLastName // ignore: cast_nullable_to_non_nullable
as String,serviceDate: freezed == serviceDate ? _self.serviceDate : serviceDate // ignore: cast_nullable_to_non_nullable
as String?,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<ProcedureRecord>,
  ));
}


}

// dart format on
