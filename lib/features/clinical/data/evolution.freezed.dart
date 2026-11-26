// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evolution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Evolution {

 int get id; String get content; int? get patientProcedureRecordId; int? get userId; String? get userName; String? get recordedAt;
/// Create a copy of Evolution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvolutionCopyWith<Evolution> get copyWith => _$EvolutionCopyWithImpl<Evolution>(this as Evolution, _$identity);

  /// Serializes this Evolution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Evolution&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.patientProcedureRecordId, patientProcedureRecordId) || other.patientProcedureRecordId == patientProcedureRecordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,patientProcedureRecordId,userId,userName,recordedAt);

@override
String toString() {
  return 'Evolution(id: $id, content: $content, patientProcedureRecordId: $patientProcedureRecordId, userId: $userId, userName: $userName, recordedAt: $recordedAt)';
}


}

/// @nodoc
abstract mixin class $EvolutionCopyWith<$Res>  {
  factory $EvolutionCopyWith(Evolution value, $Res Function(Evolution) _then) = _$EvolutionCopyWithImpl;
@useResult
$Res call({
 int id, String content, int? patientProcedureRecordId, int? userId, String? userName, String? recordedAt
});




}
/// @nodoc
class _$EvolutionCopyWithImpl<$Res>
    implements $EvolutionCopyWith<$Res> {
  _$EvolutionCopyWithImpl(this._self, this._then);

  final Evolution _self;
  final $Res Function(Evolution) _then;

/// Create a copy of Evolution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? patientProcedureRecordId = freezed,Object? userId = freezed,Object? userName = freezed,Object? recordedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,patientProcedureRecordId: freezed == patientProcedureRecordId ? _self.patientProcedureRecordId : patientProcedureRecordId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Evolution].
extension EvolutionPatterns on Evolution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Evolution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Evolution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Evolution value)  $default,){
final _that = this;
switch (_that) {
case _Evolution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Evolution value)?  $default,){
final _that = this;
switch (_that) {
case _Evolution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String content,  int? patientProcedureRecordId,  int? userId,  String? userName,  String? recordedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Evolution() when $default != null:
return $default(_that.id,_that.content,_that.patientProcedureRecordId,_that.userId,_that.userName,_that.recordedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String content,  int? patientProcedureRecordId,  int? userId,  String? userName,  String? recordedAt)  $default,) {final _that = this;
switch (_that) {
case _Evolution():
return $default(_that.id,_that.content,_that.patientProcedureRecordId,_that.userId,_that.userName,_that.recordedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String content,  int? patientProcedureRecordId,  int? userId,  String? userName,  String? recordedAt)?  $default,) {final _that = this;
switch (_that) {
case _Evolution() when $default != null:
return $default(_that.id,_that.content,_that.patientProcedureRecordId,_that.userId,_that.userName,_that.recordedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Evolution extends Evolution {
  const _Evolution({required this.id, required this.content, this.patientProcedureRecordId, this.userId, this.userName, this.recordedAt}): super._();
  factory _Evolution.fromJson(Map<String, dynamic> json) => _$EvolutionFromJson(json);

@override final  int id;
@override final  String content;
@override final  int? patientProcedureRecordId;
@override final  int? userId;
@override final  String? userName;
@override final  String? recordedAt;

/// Create a copy of Evolution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvolutionCopyWith<_Evolution> get copyWith => __$EvolutionCopyWithImpl<_Evolution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvolutionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Evolution&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.patientProcedureRecordId, patientProcedureRecordId) || other.patientProcedureRecordId == patientProcedureRecordId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,patientProcedureRecordId,userId,userName,recordedAt);

@override
String toString() {
  return 'Evolution(id: $id, content: $content, patientProcedureRecordId: $patientProcedureRecordId, userId: $userId, userName: $userName, recordedAt: $recordedAt)';
}


}

/// @nodoc
abstract mixin class _$EvolutionCopyWith<$Res> implements $EvolutionCopyWith<$Res> {
  factory _$EvolutionCopyWith(_Evolution value, $Res Function(_Evolution) _then) = __$EvolutionCopyWithImpl;
@override @useResult
$Res call({
 int id, String content, int? patientProcedureRecordId, int? userId, String? userName, String? recordedAt
});




}
/// @nodoc
class __$EvolutionCopyWithImpl<$Res>
    implements _$EvolutionCopyWith<$Res> {
  __$EvolutionCopyWithImpl(this._self, this._then);

  final _Evolution _self;
  final $Res Function(_Evolution) _then;

/// Create a copy of Evolution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? patientProcedureRecordId = freezed,Object? userId = freezed,Object? userName = freezed,Object? recordedAt = freezed,}) {
  return _then(_Evolution(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,patientProcedureRecordId: freezed == patientProcedureRecordId ? _self.patientProcedureRecordId : patientProcedureRecordId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProcedureMedication {

 String get productName; String? get lotNumber; String? get expirationDate;@DoubleConverter() double? get quantity;
/// Create a copy of ProcedureMedication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcedureMedicationCopyWith<ProcedureMedication> get copyWith => _$ProcedureMedicationCopyWithImpl<ProcedureMedication>(this as ProcedureMedication, _$identity);

  /// Serializes this ProcedureMedication to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcedureMedication&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,lotNumber,expirationDate,quantity);

@override
String toString() {
  return 'ProcedureMedication(productName: $productName, lotNumber: $lotNumber, expirationDate: $expirationDate, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $ProcedureMedicationCopyWith<$Res>  {
  factory $ProcedureMedicationCopyWith(ProcedureMedication value, $Res Function(ProcedureMedication) _then) = _$ProcedureMedicationCopyWithImpl;
@useResult
$Res call({
 String productName, String? lotNumber, String? expirationDate,@DoubleConverter() double? quantity
});




}
/// @nodoc
class _$ProcedureMedicationCopyWithImpl<$Res>
    implements $ProcedureMedicationCopyWith<$Res> {
  _$ProcedureMedicationCopyWithImpl(this._self, this._then);

  final ProcedureMedication _self;
  final $Res Function(ProcedureMedication) _then;

/// Create a copy of ProcedureMedication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productName = null,Object? lotNumber = freezed,Object? expirationDate = freezed,Object? quantity = freezed,}) {
  return _then(_self.copyWith(
productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,lotNumber: freezed == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String?,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProcedureMedication].
extension ProcedureMedicationPatterns on ProcedureMedication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProcedureMedication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProcedureMedication() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProcedureMedication value)  $default,){
final _that = this;
switch (_that) {
case _ProcedureMedication():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProcedureMedication value)?  $default,){
final _that = this;
switch (_that) {
case _ProcedureMedication() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productName,  String? lotNumber,  String? expirationDate, @DoubleConverter()  double? quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProcedureMedication() when $default != null:
return $default(_that.productName,_that.lotNumber,_that.expirationDate,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productName,  String? lotNumber,  String? expirationDate, @DoubleConverter()  double? quantity)  $default,) {final _that = this;
switch (_that) {
case _ProcedureMedication():
return $default(_that.productName,_that.lotNumber,_that.expirationDate,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productName,  String? lotNumber,  String? expirationDate, @DoubleConverter()  double? quantity)?  $default,) {final _that = this;
switch (_that) {
case _ProcedureMedication() when $default != null:
return $default(_that.productName,_that.lotNumber,_that.expirationDate,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProcedureMedication implements ProcedureMedication {
  const _ProcedureMedication({required this.productName, this.lotNumber, this.expirationDate, @DoubleConverter() this.quantity});
  factory _ProcedureMedication.fromJson(Map<String, dynamic> json) => _$ProcedureMedicationFromJson(json);

@override final  String productName;
@override final  String? lotNumber;
@override final  String? expirationDate;
@override@DoubleConverter() final  double? quantity;

/// Create a copy of ProcedureMedication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcedureMedicationCopyWith<_ProcedureMedication> get copyWith => __$ProcedureMedicationCopyWithImpl<_ProcedureMedication>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProcedureMedicationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcedureMedication&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.lotNumber, lotNumber) || other.lotNumber == lotNumber)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,lotNumber,expirationDate,quantity);

@override
String toString() {
  return 'ProcedureMedication(productName: $productName, lotNumber: $lotNumber, expirationDate: $expirationDate, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$ProcedureMedicationCopyWith<$Res> implements $ProcedureMedicationCopyWith<$Res> {
  factory _$ProcedureMedicationCopyWith(_ProcedureMedication value, $Res Function(_ProcedureMedication) _then) = __$ProcedureMedicationCopyWithImpl;
@override @useResult
$Res call({
 String productName, String? lotNumber, String? expirationDate,@DoubleConverter() double? quantity
});




}
/// @nodoc
class __$ProcedureMedicationCopyWithImpl<$Res>
    implements _$ProcedureMedicationCopyWith<$Res> {
  __$ProcedureMedicationCopyWithImpl(this._self, this._then);

  final _ProcedureMedication _self;
  final $Res Function(_ProcedureMedication) _then;

/// Create a copy of ProcedureMedication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productName = null,Object? lotNumber = freezed,Object? expirationDate = freezed,Object? quantity = freezed,}) {
  return _then(_ProcedureMedication(
productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,lotNumber: freezed == lotNumber ? _self.lotNumber : lotNumber // ignore: cast_nullable_to_non_nullable
as String?,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
