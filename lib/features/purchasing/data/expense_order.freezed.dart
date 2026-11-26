// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseItem {

 int get id; String get description; String? get unit;@DoubleConverter() double? get quantityRequested;@DoubleConverter() double? get quantityReceived;@DoubleConverter() double? get unitPrice;@DoubleConverter() double? get taxRate;@DoubleConverter() double? get taxAmount;@DoubleConverter() double? get totalPrice; String? get notes;
/// Create a copy of ExpenseItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseItemCopyWith<ExpenseItem> get copyWith => _$ExpenseItemCopyWithImpl<ExpenseItem>(this as ExpenseItem, _$identity);

  /// Serializes this ExpenseItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseItem&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.quantityRequested, quantityRequested) || other.quantityRequested == quantityRequested)&&(identical(other.quantityReceived, quantityReceived) || other.quantityReceived == quantityReceived)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,unit,quantityRequested,quantityReceived,unitPrice,taxRate,taxAmount,totalPrice,notes);

@override
String toString() {
  return 'ExpenseItem(id: $id, description: $description, unit: $unit, quantityRequested: $quantityRequested, quantityReceived: $quantityReceived, unitPrice: $unitPrice, taxRate: $taxRate, taxAmount: $taxAmount, totalPrice: $totalPrice, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ExpenseItemCopyWith<$Res>  {
  factory $ExpenseItemCopyWith(ExpenseItem value, $Res Function(ExpenseItem) _then) = _$ExpenseItemCopyWithImpl;
@useResult
$Res call({
 int id, String description, String? unit,@DoubleConverter() double? quantityRequested,@DoubleConverter() double? quantityReceived,@DoubleConverter() double? unitPrice,@DoubleConverter() double? taxRate,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalPrice, String? notes
});




}
/// @nodoc
class _$ExpenseItemCopyWithImpl<$Res>
    implements $ExpenseItemCopyWith<$Res> {
  _$ExpenseItemCopyWithImpl(this._self, this._then);

  final ExpenseItem _self;
  final $Res Function(ExpenseItem) _then;

/// Create a copy of ExpenseItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? unit = freezed,Object? quantityRequested = freezed,Object? quantityReceived = freezed,Object? unitPrice = freezed,Object? taxRate = freezed,Object? taxAmount = freezed,Object? totalPrice = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,quantityRequested: freezed == quantityRequested ? _self.quantityRequested : quantityRequested // ignore: cast_nullable_to_non_nullable
as double?,quantityReceived: freezed == quantityReceived ? _self.quantityReceived : quantityReceived // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseItem].
extension ExpenseItemPatterns on ExpenseItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseItem value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseItem value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String description,  String? unit, @DoubleConverter()  double? quantityRequested, @DoubleConverter()  double? quantityReceived, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseItem() when $default != null:
return $default(_that.id,_that.description,_that.unit,_that.quantityRequested,_that.quantityReceived,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String description,  String? unit, @DoubleConverter()  double? quantityRequested, @DoubleConverter()  double? quantityReceived, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _ExpenseItem():
return $default(_that.id,_that.description,_that.unit,_that.quantityRequested,_that.quantityReceived,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String description,  String? unit, @DoubleConverter()  double? quantityRequested, @DoubleConverter()  double? quantityReceived, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseItem() when $default != null:
return $default(_that.id,_that.description,_that.unit,_that.quantityRequested,_that.quantityReceived,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseItem extends ExpenseItem {
  const _ExpenseItem({required this.id, required this.description, this.unit, @DoubleConverter() this.quantityRequested, @DoubleConverter() this.quantityReceived, @DoubleConverter() this.unitPrice, @DoubleConverter() this.taxRate, @DoubleConverter() this.taxAmount, @DoubleConverter() this.totalPrice, this.notes}): super._();
  factory _ExpenseItem.fromJson(Map<String, dynamic> json) => _$ExpenseItemFromJson(json);

@override final  int id;
@override final  String description;
@override final  String? unit;
@override@DoubleConverter() final  double? quantityRequested;
@override@DoubleConverter() final  double? quantityReceived;
@override@DoubleConverter() final  double? unitPrice;
@override@DoubleConverter() final  double? taxRate;
@override@DoubleConverter() final  double? taxAmount;
@override@DoubleConverter() final  double? totalPrice;
@override final  String? notes;

/// Create a copy of ExpenseItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseItemCopyWith<_ExpenseItem> get copyWith => __$ExpenseItemCopyWithImpl<_ExpenseItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseItem&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.quantityRequested, quantityRequested) || other.quantityRequested == quantityRequested)&&(identical(other.quantityReceived, quantityReceived) || other.quantityReceived == quantityReceived)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,unit,quantityRequested,quantityReceived,unitPrice,taxRate,taxAmount,totalPrice,notes);

@override
String toString() {
  return 'ExpenseItem(id: $id, description: $description, unit: $unit, quantityRequested: $quantityRequested, quantityReceived: $quantityReceived, unitPrice: $unitPrice, taxRate: $taxRate, taxAmount: $taxAmount, totalPrice: $totalPrice, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ExpenseItemCopyWith<$Res> implements $ExpenseItemCopyWith<$Res> {
  factory _$ExpenseItemCopyWith(_ExpenseItem value, $Res Function(_ExpenseItem) _then) = __$ExpenseItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String description, String? unit,@DoubleConverter() double? quantityRequested,@DoubleConverter() double? quantityReceived,@DoubleConverter() double? unitPrice,@DoubleConverter() double? taxRate,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalPrice, String? notes
});




}
/// @nodoc
class __$ExpenseItemCopyWithImpl<$Res>
    implements _$ExpenseItemCopyWith<$Res> {
  __$ExpenseItemCopyWithImpl(this._self, this._then);

  final _ExpenseItem _self;
  final $Res Function(_ExpenseItem) _then;

/// Create a copy of ExpenseItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? unit = freezed,Object? quantityRequested = freezed,Object? quantityReceived = freezed,Object? unitPrice = freezed,Object? taxRate = freezed,Object? taxAmount = freezed,Object? totalPrice = freezed,Object? notes = freezed,}) {
  return _then(_ExpenseItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,quantityRequested: freezed == quantityRequested ? _self.quantityRequested : quantityRequested // ignore: cast_nullable_to_non_nullable
as double?,quantityReceived: freezed == quantityReceived ? _self.quantityReceived : quantityReceived // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ExpensePayment {

 int get id;@DoubleConverter() double? get amount; String? get paymentDate; String? get paymentMethod; String? get reference; String? get notes; NamedRef? get registeredBy; String? get createdAt;
/// Create a copy of ExpensePayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpensePaymentCopyWith<ExpensePayment> get copyWith => _$ExpensePaymentCopyWithImpl<ExpensePayment>(this as ExpensePayment, _$identity);

  /// Serializes this ExpensePayment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpensePayment&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.registeredBy, registeredBy) || other.registeredBy == registeredBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,paymentDate,paymentMethod,reference,notes,registeredBy,createdAt);

@override
String toString() {
  return 'ExpensePayment(id: $id, amount: $amount, paymentDate: $paymentDate, paymentMethod: $paymentMethod, reference: $reference, notes: $notes, registeredBy: $registeredBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ExpensePaymentCopyWith<$Res>  {
  factory $ExpensePaymentCopyWith(ExpensePayment value, $Res Function(ExpensePayment) _then) = _$ExpensePaymentCopyWithImpl;
@useResult
$Res call({
 int id,@DoubleConverter() double? amount, String? paymentDate, String? paymentMethod, String? reference, String? notes, NamedRef? registeredBy, String? createdAt
});


$NamedRefCopyWith<$Res>? get registeredBy;

}
/// @nodoc
class _$ExpensePaymentCopyWithImpl<$Res>
    implements $ExpensePaymentCopyWith<$Res> {
  _$ExpensePaymentCopyWithImpl(this._self, this._then);

  final ExpensePayment _self;
  final $Res Function(ExpensePayment) _then;

/// Create a copy of ExpensePayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = freezed,Object? paymentDate = freezed,Object? paymentMethod = freezed,Object? reference = freezed,Object? notes = freezed,Object? registeredBy = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,registeredBy: freezed == registeredBy ? _self.registeredBy : registeredBy // ignore: cast_nullable_to_non_nullable
as NamedRef?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ExpensePayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get registeredBy {
    if (_self.registeredBy == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.registeredBy!, (value) {
    return _then(_self.copyWith(registeredBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpensePayment].
extension ExpensePaymentPatterns on ExpensePayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpensePayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpensePayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpensePayment value)  $default,){
final _that = this;
switch (_that) {
case _ExpensePayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpensePayment value)?  $default,){
final _that = this;
switch (_that) {
case _ExpensePayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @DoubleConverter()  double? amount,  String? paymentDate,  String? paymentMethod,  String? reference,  String? notes,  NamedRef? registeredBy,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpensePayment() when $default != null:
return $default(_that.id,_that.amount,_that.paymentDate,_that.paymentMethod,_that.reference,_that.notes,_that.registeredBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @DoubleConverter()  double? amount,  String? paymentDate,  String? paymentMethod,  String? reference,  String? notes,  NamedRef? registeredBy,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ExpensePayment():
return $default(_that.id,_that.amount,_that.paymentDate,_that.paymentMethod,_that.reference,_that.notes,_that.registeredBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @DoubleConverter()  double? amount,  String? paymentDate,  String? paymentMethod,  String? reference,  String? notes,  NamedRef? registeredBy,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ExpensePayment() when $default != null:
return $default(_that.id,_that.amount,_that.paymentDate,_that.paymentMethod,_that.reference,_that.notes,_that.registeredBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpensePayment implements ExpensePayment {
  const _ExpensePayment({required this.id, @DoubleConverter() this.amount, this.paymentDate, this.paymentMethod, this.reference, this.notes, this.registeredBy, this.createdAt});
  factory _ExpensePayment.fromJson(Map<String, dynamic> json) => _$ExpensePaymentFromJson(json);

@override final  int id;
@override@DoubleConverter() final  double? amount;
@override final  String? paymentDate;
@override final  String? paymentMethod;
@override final  String? reference;
@override final  String? notes;
@override final  NamedRef? registeredBy;
@override final  String? createdAt;

/// Create a copy of ExpensePayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpensePaymentCopyWith<_ExpensePayment> get copyWith => __$ExpensePaymentCopyWithImpl<_ExpensePayment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpensePaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpensePayment&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.registeredBy, registeredBy) || other.registeredBy == registeredBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,paymentDate,paymentMethod,reference,notes,registeredBy,createdAt);

@override
String toString() {
  return 'ExpensePayment(id: $id, amount: $amount, paymentDate: $paymentDate, paymentMethod: $paymentMethod, reference: $reference, notes: $notes, registeredBy: $registeredBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ExpensePaymentCopyWith<$Res> implements $ExpensePaymentCopyWith<$Res> {
  factory _$ExpensePaymentCopyWith(_ExpensePayment value, $Res Function(_ExpensePayment) _then) = __$ExpensePaymentCopyWithImpl;
@override @useResult
$Res call({
 int id,@DoubleConverter() double? amount, String? paymentDate, String? paymentMethod, String? reference, String? notes, NamedRef? registeredBy, String? createdAt
});


@override $NamedRefCopyWith<$Res>? get registeredBy;

}
/// @nodoc
class __$ExpensePaymentCopyWithImpl<$Res>
    implements _$ExpensePaymentCopyWith<$Res> {
  __$ExpensePaymentCopyWithImpl(this._self, this._then);

  final _ExpensePayment _self;
  final $Res Function(_ExpensePayment) _then;

/// Create a copy of ExpensePayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = freezed,Object? paymentDate = freezed,Object? paymentMethod = freezed,Object? reference = freezed,Object? notes = freezed,Object? registeredBy = freezed,Object? createdAt = freezed,}) {
  return _then(_ExpensePayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,registeredBy: freezed == registeredBy ? _self.registeredBy : registeredBy // ignore: cast_nullable_to_non_nullable
as NamedRef?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ExpensePayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get registeredBy {
    if (_self.registeredBy == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.registeredBy!, (value) {
    return _then(_self.copyWith(registeredBy: value));
  });
}
}


/// @nodoc
mixin _$ExpenseOrder {

 int get id; String get code;@OrderStatusConverter() OrderStatus get status;@PaymentStatusConverter() PaymentStatus get paymentStatus; int? get supplierId;@DoubleConverter() double? get subtotal;@DoubleConverter() double? get taxAmount;@DoubleConverter() double? get totalAmount;@DoubleConverter() double? get amountPaid; String? get invoiceNumber; String? get invoiceDate; String? get notes; String? get expectedDeliveryDate; String? get sentAt; String? get receivedAt; String? get accountingSentAt; String? get createdAt; NamedRef? get supplier; List<ExpenseItem> get items; List<ExpensePayment> get payments;
/// Create a copy of ExpenseOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseOrderCopyWith<ExpenseOrder> get copyWith => _$ExpenseOrderCopyWithImpl<ExpenseOrder>(this as ExpenseOrder, _$identity);

  /// Serializes this ExpenseOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.supplierId, supplierId) || other.supplierId == supplierId)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.expectedDeliveryDate, expectedDeliveryDate) || other.expectedDeliveryDate == expectedDeliveryDate)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.accountingSentAt, accountingSentAt) || other.accountingSentAt == accountingSentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.payments, payments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,code,status,paymentStatus,supplierId,subtotal,taxAmount,totalAmount,amountPaid,invoiceNumber,invoiceDate,notes,expectedDeliveryDate,sentAt,receivedAt,accountingSentAt,createdAt,supplier,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(payments)]);

@override
String toString() {
  return 'ExpenseOrder(id: $id, code: $code, status: $status, paymentStatus: $paymentStatus, supplierId: $supplierId, subtotal: $subtotal, taxAmount: $taxAmount, totalAmount: $totalAmount, amountPaid: $amountPaid, invoiceNumber: $invoiceNumber, invoiceDate: $invoiceDate, notes: $notes, expectedDeliveryDate: $expectedDeliveryDate, sentAt: $sentAt, receivedAt: $receivedAt, accountingSentAt: $accountingSentAt, createdAt: $createdAt, supplier: $supplier, items: $items, payments: $payments)';
}


}

/// @nodoc
abstract mixin class $ExpenseOrderCopyWith<$Res>  {
  factory $ExpenseOrderCopyWith(ExpenseOrder value, $Res Function(ExpenseOrder) _then) = _$ExpenseOrderCopyWithImpl;
@useResult
$Res call({
 int id, String code,@OrderStatusConverter() OrderStatus status,@PaymentStatusConverter() PaymentStatus paymentStatus, int? supplierId,@DoubleConverter() double? subtotal,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalAmount,@DoubleConverter() double? amountPaid, String? invoiceNumber, String? invoiceDate, String? notes, String? expectedDeliveryDate, String? sentAt, String? receivedAt, String? accountingSentAt, String? createdAt, NamedRef? supplier, List<ExpenseItem> items, List<ExpensePayment> payments
});


$NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class _$ExpenseOrderCopyWithImpl<$Res>
    implements $ExpenseOrderCopyWith<$Res> {
  _$ExpenseOrderCopyWithImpl(this._self, this._then);

  final ExpenseOrder _self;
  final $Res Function(ExpenseOrder) _then;

/// Create a copy of ExpenseOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? status = null,Object? paymentStatus = null,Object? supplierId = freezed,Object? subtotal = freezed,Object? taxAmount = freezed,Object? totalAmount = freezed,Object? amountPaid = freezed,Object? invoiceNumber = freezed,Object? invoiceDate = freezed,Object? notes = freezed,Object? expectedDeliveryDate = freezed,Object? sentAt = freezed,Object? receivedAt = freezed,Object? accountingSentAt = freezed,Object? createdAt = freezed,Object? supplier = freezed,Object? items = null,Object? payments = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,supplierId: freezed == supplierId ? _self.supplierId : supplierId // ignore: cast_nullable_to_non_nullable
as int?,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,amountPaid: freezed == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double?,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,invoiceDate: freezed == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,expectedDeliveryDate: freezed == expectedDeliveryDate ? _self.expectedDeliveryDate : expectedDeliveryDate // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as String?,accountingSentAt: freezed == accountingSentAt ? _self.accountingSentAt : accountingSentAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ExpenseItem>,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<ExpensePayment>,
  ));
}
/// Create a copy of ExpenseOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get supplier {
    if (_self.supplier == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.supplier!, (value) {
    return _then(_self.copyWith(supplier: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpenseOrder].
extension ExpenseOrderPatterns on ExpenseOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseOrder value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseOrder value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code, @OrderStatusConverter()  OrderStatus status, @PaymentStatusConverter()  PaymentStatus paymentStatus,  int? supplierId, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount, @DoubleConverter()  double? amountPaid,  String? invoiceNumber,  String? invoiceDate,  String? notes,  String? expectedDeliveryDate,  String? sentAt,  String? receivedAt,  String? accountingSentAt,  String? createdAt,  NamedRef? supplier,  List<ExpenseItem> items,  List<ExpensePayment> payments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseOrder() when $default != null:
return $default(_that.id,_that.code,_that.status,_that.paymentStatus,_that.supplierId,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.amountPaid,_that.invoiceNumber,_that.invoiceDate,_that.notes,_that.expectedDeliveryDate,_that.sentAt,_that.receivedAt,_that.accountingSentAt,_that.createdAt,_that.supplier,_that.items,_that.payments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code, @OrderStatusConverter()  OrderStatus status, @PaymentStatusConverter()  PaymentStatus paymentStatus,  int? supplierId, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount, @DoubleConverter()  double? amountPaid,  String? invoiceNumber,  String? invoiceDate,  String? notes,  String? expectedDeliveryDate,  String? sentAt,  String? receivedAt,  String? accountingSentAt,  String? createdAt,  NamedRef? supplier,  List<ExpenseItem> items,  List<ExpensePayment> payments)  $default,) {final _that = this;
switch (_that) {
case _ExpenseOrder():
return $default(_that.id,_that.code,_that.status,_that.paymentStatus,_that.supplierId,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.amountPaid,_that.invoiceNumber,_that.invoiceDate,_that.notes,_that.expectedDeliveryDate,_that.sentAt,_that.receivedAt,_that.accountingSentAt,_that.createdAt,_that.supplier,_that.items,_that.payments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code, @OrderStatusConverter()  OrderStatus status, @PaymentStatusConverter()  PaymentStatus paymentStatus,  int? supplierId, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount, @DoubleConverter()  double? amountPaid,  String? invoiceNumber,  String? invoiceDate,  String? notes,  String? expectedDeliveryDate,  String? sentAt,  String? receivedAt,  String? accountingSentAt,  String? createdAt,  NamedRef? supplier,  List<ExpenseItem> items,  List<ExpensePayment> payments)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseOrder() when $default != null:
return $default(_that.id,_that.code,_that.status,_that.paymentStatus,_that.supplierId,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.amountPaid,_that.invoiceNumber,_that.invoiceDate,_that.notes,_that.expectedDeliveryDate,_that.sentAt,_that.receivedAt,_that.accountingSentAt,_that.createdAt,_that.supplier,_that.items,_that.payments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseOrder extends ExpenseOrder {
  const _ExpenseOrder({required this.id, required this.code, @OrderStatusConverter() this.status = OrderStatus.unknown, @PaymentStatusConverter() this.paymentStatus = PaymentStatus.unknown, this.supplierId, @DoubleConverter() this.subtotal, @DoubleConverter() this.taxAmount, @DoubleConverter() this.totalAmount, @DoubleConverter() this.amountPaid, this.invoiceNumber, this.invoiceDate, this.notes, this.expectedDeliveryDate, this.sentAt, this.receivedAt, this.accountingSentAt, this.createdAt, this.supplier, final  List<ExpenseItem> items = const [], final  List<ExpensePayment> payments = const []}): _items = items,_payments = payments,super._();
  factory _ExpenseOrder.fromJson(Map<String, dynamic> json) => _$ExpenseOrderFromJson(json);

@override final  int id;
@override final  String code;
@override@JsonKey()@OrderStatusConverter() final  OrderStatus status;
@override@JsonKey()@PaymentStatusConverter() final  PaymentStatus paymentStatus;
@override final  int? supplierId;
@override@DoubleConverter() final  double? subtotal;
@override@DoubleConverter() final  double? taxAmount;
@override@DoubleConverter() final  double? totalAmount;
@override@DoubleConverter() final  double? amountPaid;
@override final  String? invoiceNumber;
@override final  String? invoiceDate;
@override final  String? notes;
@override final  String? expectedDeliveryDate;
@override final  String? sentAt;
@override final  String? receivedAt;
@override final  String? accountingSentAt;
@override final  String? createdAt;
@override final  NamedRef? supplier;
 final  List<ExpenseItem> _items;
@override@JsonKey() List<ExpenseItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<ExpensePayment> _payments;
@override@JsonKey() List<ExpensePayment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}


/// Create a copy of ExpenseOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseOrderCopyWith<_ExpenseOrder> get copyWith => __$ExpenseOrderCopyWithImpl<_ExpenseOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.supplierId, supplierId) || other.supplierId == supplierId)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.expectedDeliveryDate, expectedDeliveryDate) || other.expectedDeliveryDate == expectedDeliveryDate)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.accountingSentAt, accountingSentAt) || other.accountingSentAt == accountingSentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._payments, _payments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,code,status,paymentStatus,supplierId,subtotal,taxAmount,totalAmount,amountPaid,invoiceNumber,invoiceDate,notes,expectedDeliveryDate,sentAt,receivedAt,accountingSentAt,createdAt,supplier,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_payments)]);

@override
String toString() {
  return 'ExpenseOrder(id: $id, code: $code, status: $status, paymentStatus: $paymentStatus, supplierId: $supplierId, subtotal: $subtotal, taxAmount: $taxAmount, totalAmount: $totalAmount, amountPaid: $amountPaid, invoiceNumber: $invoiceNumber, invoiceDate: $invoiceDate, notes: $notes, expectedDeliveryDate: $expectedDeliveryDate, sentAt: $sentAt, receivedAt: $receivedAt, accountingSentAt: $accountingSentAt, createdAt: $createdAt, supplier: $supplier, items: $items, payments: $payments)';
}


}

/// @nodoc
abstract mixin class _$ExpenseOrderCopyWith<$Res> implements $ExpenseOrderCopyWith<$Res> {
  factory _$ExpenseOrderCopyWith(_ExpenseOrder value, $Res Function(_ExpenseOrder) _then) = __$ExpenseOrderCopyWithImpl;
@override @useResult
$Res call({
 int id, String code,@OrderStatusConverter() OrderStatus status,@PaymentStatusConverter() PaymentStatus paymentStatus, int? supplierId,@DoubleConverter() double? subtotal,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalAmount,@DoubleConverter() double? amountPaid, String? invoiceNumber, String? invoiceDate, String? notes, String? expectedDeliveryDate, String? sentAt, String? receivedAt, String? accountingSentAt, String? createdAt, NamedRef? supplier, List<ExpenseItem> items, List<ExpensePayment> payments
});


@override $NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class __$ExpenseOrderCopyWithImpl<$Res>
    implements _$ExpenseOrderCopyWith<$Res> {
  __$ExpenseOrderCopyWithImpl(this._self, this._then);

  final _ExpenseOrder _self;
  final $Res Function(_ExpenseOrder) _then;

/// Create a copy of ExpenseOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? status = null,Object? paymentStatus = null,Object? supplierId = freezed,Object? subtotal = freezed,Object? taxAmount = freezed,Object? totalAmount = freezed,Object? amountPaid = freezed,Object? invoiceNumber = freezed,Object? invoiceDate = freezed,Object? notes = freezed,Object? expectedDeliveryDate = freezed,Object? sentAt = freezed,Object? receivedAt = freezed,Object? accountingSentAt = freezed,Object? createdAt = freezed,Object? supplier = freezed,Object? items = null,Object? payments = null,}) {
  return _then(_ExpenseOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,supplierId: freezed == supplierId ? _self.supplierId : supplierId // ignore: cast_nullable_to_non_nullable
as int?,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,amountPaid: freezed == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double?,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,invoiceDate: freezed == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,expectedDeliveryDate: freezed == expectedDeliveryDate ? _self.expectedDeliveryDate : expectedDeliveryDate // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as String?,accountingSentAt: freezed == accountingSentAt ? _self.accountingSentAt : accountingSentAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ExpenseItem>,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<ExpensePayment>,
  ));
}

/// Create a copy of ExpenseOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get supplier {
    if (_self.supplier == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.supplier!, (value) {
    return _then(_self.copyWith(supplier: value));
  });
}
}

// dart format on
