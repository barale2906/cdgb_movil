// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movement_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentSignature {

 String get role; String? get method; String? get signerName; String? get signerDocument; String? get signedAt;
/// Create a copy of DocumentSignature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentSignatureCopyWith<DocumentSignature> get copyWith => _$DocumentSignatureCopyWithImpl<DocumentSignature>(this as DocumentSignature, _$identity);

  /// Serializes this DocumentSignature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentSignature&&(identical(other.role, role) || other.role == role)&&(identical(other.method, method) || other.method == method)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerDocument, signerDocument) || other.signerDocument == signerDocument)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,method,signerName,signerDocument,signedAt);

@override
String toString() {
  return 'DocumentSignature(role: $role, method: $method, signerName: $signerName, signerDocument: $signerDocument, signedAt: $signedAt)';
}


}

/// @nodoc
abstract mixin class $DocumentSignatureCopyWith<$Res>  {
  factory $DocumentSignatureCopyWith(DocumentSignature value, $Res Function(DocumentSignature) _then) = _$DocumentSignatureCopyWithImpl;
@useResult
$Res call({
 String role, String? method, String? signerName, String? signerDocument, String? signedAt
});




}
/// @nodoc
class _$DocumentSignatureCopyWithImpl<$Res>
    implements $DocumentSignatureCopyWith<$Res> {
  _$DocumentSignatureCopyWithImpl(this._self, this._then);

  final DocumentSignature _self;
  final $Res Function(DocumentSignature) _then;

/// Create a copy of DocumentSignature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? method = freezed,Object? signerName = freezed,Object? signerDocument = freezed,Object? signedAt = freezed,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,signerName: freezed == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String?,signerDocument: freezed == signerDocument ? _self.signerDocument : signerDocument // ignore: cast_nullable_to_non_nullable
as String?,signedAt: freezed == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentSignature].
extension DocumentSignaturePatterns on DocumentSignature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentSignature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentSignature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentSignature value)  $default,){
final _that = this;
switch (_that) {
case _DocumentSignature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentSignature value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentSignature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String? method,  String? signerName,  String? signerDocument,  String? signedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentSignature() when $default != null:
return $default(_that.role,_that.method,_that.signerName,_that.signerDocument,_that.signedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String? method,  String? signerName,  String? signerDocument,  String? signedAt)  $default,) {final _that = this;
switch (_that) {
case _DocumentSignature():
return $default(_that.role,_that.method,_that.signerName,_that.signerDocument,_that.signedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String? method,  String? signerName,  String? signerDocument,  String? signedAt)?  $default,) {final _that = this;
switch (_that) {
case _DocumentSignature() when $default != null:
return $default(_that.role,_that.method,_that.signerName,_that.signerDocument,_that.signedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentSignature implements DocumentSignature {
  const _DocumentSignature({required this.role, this.method, this.signerName, this.signerDocument, this.signedAt});
  factory _DocumentSignature.fromJson(Map<String, dynamic> json) => _$DocumentSignatureFromJson(json);

@override final  String role;
@override final  String? method;
@override final  String? signerName;
@override final  String? signerDocument;
@override final  String? signedAt;

/// Create a copy of DocumentSignature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentSignatureCopyWith<_DocumentSignature> get copyWith => __$DocumentSignatureCopyWithImpl<_DocumentSignature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentSignatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentSignature&&(identical(other.role, role) || other.role == role)&&(identical(other.method, method) || other.method == method)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerDocument, signerDocument) || other.signerDocument == signerDocument)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,method,signerName,signerDocument,signedAt);

@override
String toString() {
  return 'DocumentSignature(role: $role, method: $method, signerName: $signerName, signerDocument: $signerDocument, signedAt: $signedAt)';
}


}

/// @nodoc
abstract mixin class _$DocumentSignatureCopyWith<$Res> implements $DocumentSignatureCopyWith<$Res> {
  factory _$DocumentSignatureCopyWith(_DocumentSignature value, $Res Function(_DocumentSignature) _then) = __$DocumentSignatureCopyWithImpl;
@override @useResult
$Res call({
 String role, String? method, String? signerName, String? signerDocument, String? signedAt
});




}
/// @nodoc
class __$DocumentSignatureCopyWithImpl<$Res>
    implements _$DocumentSignatureCopyWith<$Res> {
  __$DocumentSignatureCopyWithImpl(this._self, this._then);

  final _DocumentSignature _self;
  final $Res Function(_DocumentSignature) _then;

/// Create a copy of DocumentSignature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? method = freezed,Object? signerName = freezed,Object? signerDocument = freezed,Object? signedAt = freezed,}) {
  return _then(_DocumentSignature(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,signerName: freezed == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String?,signerDocument: freezed == signerDocument ? _self.signerDocument : signerDocument // ignore: cast_nullable_to_non_nullable
as String?,signedAt: freezed == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MovementLine {

 int get id; String get movementType;@DoubleConverter() double? get quantity; int? get warehouseId; int? get productVariantId; int? get batchId; int? get locationFromId; int? get locationToId; String? get reason; String? get notes; String? get movementDate; String? get status; String? get productName; String? get variantLabBrand; String? get batchLotNumber; String? get batchExpirationDate; String? get userName; String? get createdAt;
/// Create a copy of MovementLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovementLineCopyWith<MovementLine> get copyWith => _$MovementLineCopyWithImpl<MovementLine>(this as MovementLine, _$identity);

  /// Serializes this MovementLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovementLine&&(identical(other.id, id) || other.id == id)&&(identical(other.movementType, movementType) || other.movementType == movementType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.productVariantId, productVariantId) || other.productVariantId == productVariantId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.locationFromId, locationFromId) || other.locationFromId == locationFromId)&&(identical(other.locationToId, locationToId) || other.locationToId == locationToId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.movementDate, movementDate) || other.movementDate == movementDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.variantLabBrand, variantLabBrand) || other.variantLabBrand == variantLabBrand)&&(identical(other.batchLotNumber, batchLotNumber) || other.batchLotNumber == batchLotNumber)&&(identical(other.batchExpirationDate, batchExpirationDate) || other.batchExpirationDate == batchExpirationDate)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,movementType,quantity,warehouseId,productVariantId,batchId,locationFromId,locationToId,reason,notes,movementDate,status,productName,variantLabBrand,batchLotNumber,batchExpirationDate,userName,createdAt);

@override
String toString() {
  return 'MovementLine(id: $id, movementType: $movementType, quantity: $quantity, warehouseId: $warehouseId, productVariantId: $productVariantId, batchId: $batchId, locationFromId: $locationFromId, locationToId: $locationToId, reason: $reason, notes: $notes, movementDate: $movementDate, status: $status, productName: $productName, variantLabBrand: $variantLabBrand, batchLotNumber: $batchLotNumber, batchExpirationDate: $batchExpirationDate, userName: $userName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MovementLineCopyWith<$Res>  {
  factory $MovementLineCopyWith(MovementLine value, $Res Function(MovementLine) _then) = _$MovementLineCopyWithImpl;
@useResult
$Res call({
 int id, String movementType,@DoubleConverter() double? quantity, int? warehouseId, int? productVariantId, int? batchId, int? locationFromId, int? locationToId, String? reason, String? notes, String? movementDate, String? status, String? productName, String? variantLabBrand, String? batchLotNumber, String? batchExpirationDate, String? userName, String? createdAt
});




}
/// @nodoc
class _$MovementLineCopyWithImpl<$Res>
    implements $MovementLineCopyWith<$Res> {
  _$MovementLineCopyWithImpl(this._self, this._then);

  final MovementLine _self;
  final $Res Function(MovementLine) _then;

/// Create a copy of MovementLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? movementType = null,Object? quantity = freezed,Object? warehouseId = freezed,Object? productVariantId = freezed,Object? batchId = freezed,Object? locationFromId = freezed,Object? locationToId = freezed,Object? reason = freezed,Object? notes = freezed,Object? movementDate = freezed,Object? status = freezed,Object? productName = freezed,Object? variantLabBrand = freezed,Object? batchLotNumber = freezed,Object? batchExpirationDate = freezed,Object? userName = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,movementType: null == movementType ? _self.movementType : movementType // ignore: cast_nullable_to_non_nullable
as String,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,warehouseId: freezed == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as int?,productVariantId: freezed == productVariantId ? _self.productVariantId : productVariantId // ignore: cast_nullable_to_non_nullable
as int?,batchId: freezed == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as int?,locationFromId: freezed == locationFromId ? _self.locationFromId : locationFromId // ignore: cast_nullable_to_non_nullable
as int?,locationToId: freezed == locationToId ? _self.locationToId : locationToId // ignore: cast_nullable_to_non_nullable
as int?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,movementDate: freezed == movementDate ? _self.movementDate : movementDate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,variantLabBrand: freezed == variantLabBrand ? _self.variantLabBrand : variantLabBrand // ignore: cast_nullable_to_non_nullable
as String?,batchLotNumber: freezed == batchLotNumber ? _self.batchLotNumber : batchLotNumber // ignore: cast_nullable_to_non_nullable
as String?,batchExpirationDate: freezed == batchExpirationDate ? _self.batchExpirationDate : batchExpirationDate // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MovementLine].
extension MovementLinePatterns on MovementLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovementLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovementLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovementLine value)  $default,){
final _that = this;
switch (_that) {
case _MovementLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovementLine value)?  $default,){
final _that = this;
switch (_that) {
case _MovementLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String movementType, @DoubleConverter()  double? quantity,  int? warehouseId,  int? productVariantId,  int? batchId,  int? locationFromId,  int? locationToId,  String? reason,  String? notes,  String? movementDate,  String? status,  String? productName,  String? variantLabBrand,  String? batchLotNumber,  String? batchExpirationDate,  String? userName,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovementLine() when $default != null:
return $default(_that.id,_that.movementType,_that.quantity,_that.warehouseId,_that.productVariantId,_that.batchId,_that.locationFromId,_that.locationToId,_that.reason,_that.notes,_that.movementDate,_that.status,_that.productName,_that.variantLabBrand,_that.batchLotNumber,_that.batchExpirationDate,_that.userName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String movementType, @DoubleConverter()  double? quantity,  int? warehouseId,  int? productVariantId,  int? batchId,  int? locationFromId,  int? locationToId,  String? reason,  String? notes,  String? movementDate,  String? status,  String? productName,  String? variantLabBrand,  String? batchLotNumber,  String? batchExpirationDate,  String? userName,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MovementLine():
return $default(_that.id,_that.movementType,_that.quantity,_that.warehouseId,_that.productVariantId,_that.batchId,_that.locationFromId,_that.locationToId,_that.reason,_that.notes,_that.movementDate,_that.status,_that.productName,_that.variantLabBrand,_that.batchLotNumber,_that.batchExpirationDate,_that.userName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String movementType, @DoubleConverter()  double? quantity,  int? warehouseId,  int? productVariantId,  int? batchId,  int? locationFromId,  int? locationToId,  String? reason,  String? notes,  String? movementDate,  String? status,  String? productName,  String? variantLabBrand,  String? batchLotNumber,  String? batchExpirationDate,  String? userName,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MovementLine() when $default != null:
return $default(_that.id,_that.movementType,_that.quantity,_that.warehouseId,_that.productVariantId,_that.batchId,_that.locationFromId,_that.locationToId,_that.reason,_that.notes,_that.movementDate,_that.status,_that.productName,_that.variantLabBrand,_that.batchLotNumber,_that.batchExpirationDate,_that.userName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MovementLine implements MovementLine {
  const _MovementLine({required this.id, required this.movementType, @DoubleConverter() this.quantity, this.warehouseId, this.productVariantId, this.batchId, this.locationFromId, this.locationToId, this.reason, this.notes, this.movementDate, this.status, this.productName, this.variantLabBrand, this.batchLotNumber, this.batchExpirationDate, this.userName, this.createdAt});
  factory _MovementLine.fromJson(Map<String, dynamic> json) => _$MovementLineFromJson(json);

@override final  int id;
@override final  String movementType;
@override@DoubleConverter() final  double? quantity;
@override final  int? warehouseId;
@override final  int? productVariantId;
@override final  int? batchId;
@override final  int? locationFromId;
@override final  int? locationToId;
@override final  String? reason;
@override final  String? notes;
@override final  String? movementDate;
@override final  String? status;
@override final  String? productName;
@override final  String? variantLabBrand;
@override final  String? batchLotNumber;
@override final  String? batchExpirationDate;
@override final  String? userName;
@override final  String? createdAt;

/// Create a copy of MovementLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovementLineCopyWith<_MovementLine> get copyWith => __$MovementLineCopyWithImpl<_MovementLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MovementLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovementLine&&(identical(other.id, id) || other.id == id)&&(identical(other.movementType, movementType) || other.movementType == movementType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.productVariantId, productVariantId) || other.productVariantId == productVariantId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.locationFromId, locationFromId) || other.locationFromId == locationFromId)&&(identical(other.locationToId, locationToId) || other.locationToId == locationToId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.movementDate, movementDate) || other.movementDate == movementDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.variantLabBrand, variantLabBrand) || other.variantLabBrand == variantLabBrand)&&(identical(other.batchLotNumber, batchLotNumber) || other.batchLotNumber == batchLotNumber)&&(identical(other.batchExpirationDate, batchExpirationDate) || other.batchExpirationDate == batchExpirationDate)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,movementType,quantity,warehouseId,productVariantId,batchId,locationFromId,locationToId,reason,notes,movementDate,status,productName,variantLabBrand,batchLotNumber,batchExpirationDate,userName,createdAt);

@override
String toString() {
  return 'MovementLine(id: $id, movementType: $movementType, quantity: $quantity, warehouseId: $warehouseId, productVariantId: $productVariantId, batchId: $batchId, locationFromId: $locationFromId, locationToId: $locationToId, reason: $reason, notes: $notes, movementDate: $movementDate, status: $status, productName: $productName, variantLabBrand: $variantLabBrand, batchLotNumber: $batchLotNumber, batchExpirationDate: $batchExpirationDate, userName: $userName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MovementLineCopyWith<$Res> implements $MovementLineCopyWith<$Res> {
  factory _$MovementLineCopyWith(_MovementLine value, $Res Function(_MovementLine) _then) = __$MovementLineCopyWithImpl;
@override @useResult
$Res call({
 int id, String movementType,@DoubleConverter() double? quantity, int? warehouseId, int? productVariantId, int? batchId, int? locationFromId, int? locationToId, String? reason, String? notes, String? movementDate, String? status, String? productName, String? variantLabBrand, String? batchLotNumber, String? batchExpirationDate, String? userName, String? createdAt
});




}
/// @nodoc
class __$MovementLineCopyWithImpl<$Res>
    implements _$MovementLineCopyWith<$Res> {
  __$MovementLineCopyWithImpl(this._self, this._then);

  final _MovementLine _self;
  final $Res Function(_MovementLine) _then;

/// Create a copy of MovementLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? movementType = null,Object? quantity = freezed,Object? warehouseId = freezed,Object? productVariantId = freezed,Object? batchId = freezed,Object? locationFromId = freezed,Object? locationToId = freezed,Object? reason = freezed,Object? notes = freezed,Object? movementDate = freezed,Object? status = freezed,Object? productName = freezed,Object? variantLabBrand = freezed,Object? batchLotNumber = freezed,Object? batchExpirationDate = freezed,Object? userName = freezed,Object? createdAt = freezed,}) {
  return _then(_MovementLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,movementType: null == movementType ? _self.movementType : movementType // ignore: cast_nullable_to_non_nullable
as String,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,warehouseId: freezed == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as int?,productVariantId: freezed == productVariantId ? _self.productVariantId : productVariantId // ignore: cast_nullable_to_non_nullable
as int?,batchId: freezed == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as int?,locationFromId: freezed == locationFromId ? _self.locationFromId : locationFromId // ignore: cast_nullable_to_non_nullable
as int?,locationToId: freezed == locationToId ? _self.locationToId : locationToId // ignore: cast_nullable_to_non_nullable
as int?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,movementDate: freezed == movementDate ? _self.movementDate : movementDate // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,variantLabBrand: freezed == variantLabBrand ? _self.variantLabBrand : variantLabBrand // ignore: cast_nullable_to_non_nullable
as String?,batchLotNumber: freezed == batchLotNumber ? _self.batchLotNumber : batchLotNumber // ignore: cast_nullable_to_non_nullable
as String?,batchExpirationDate: freezed == batchExpirationDate ? _self.batchExpirationDate : batchExpirationDate // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CostCenterRef {

 int get id; String get name; String? get code; String? get type; bool get isExternal;
/// Create a copy of CostCenterRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CostCenterRefCopyWith<CostCenterRef> get copyWith => _$CostCenterRefCopyWithImpl<CostCenterRef>(this as CostCenterRef, _$identity);

  /// Serializes this CostCenterRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CostCenterRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.type, type) || other.type == type)&&(identical(other.isExternal, isExternal) || other.isExternal == isExternal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,type,isExternal);

@override
String toString() {
  return 'CostCenterRef(id: $id, name: $name, code: $code, type: $type, isExternal: $isExternal)';
}


}

/// @nodoc
abstract mixin class $CostCenterRefCopyWith<$Res>  {
  factory $CostCenterRefCopyWith(CostCenterRef value, $Res Function(CostCenterRef) _then) = _$CostCenterRefCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code, String? type, bool isExternal
});




}
/// @nodoc
class _$CostCenterRefCopyWithImpl<$Res>
    implements $CostCenterRefCopyWith<$Res> {
  _$CostCenterRefCopyWithImpl(this._self, this._then);

  final CostCenterRef _self;
  final $Res Function(CostCenterRef) _then;

/// Create a copy of CostCenterRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? type = freezed,Object? isExternal = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,isExternal: null == isExternal ? _self.isExternal : isExternal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CostCenterRef].
extension CostCenterRefPatterns on CostCenterRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CostCenterRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CostCenterRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CostCenterRef value)  $default,){
final _that = this;
switch (_that) {
case _CostCenterRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CostCenterRef value)?  $default,){
final _that = this;
switch (_that) {
case _CostCenterRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? code,  String? type,  bool isExternal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CostCenterRef() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.type,_that.isExternal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? code,  String? type,  bool isExternal)  $default,) {final _that = this;
switch (_that) {
case _CostCenterRef():
return $default(_that.id,_that.name,_that.code,_that.type,_that.isExternal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? code,  String? type,  bool isExternal)?  $default,) {final _that = this;
switch (_that) {
case _CostCenterRef() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.type,_that.isExternal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CostCenterRef implements CostCenterRef {
  const _CostCenterRef({required this.id, required this.name, this.code, this.type, this.isExternal = false});
  factory _CostCenterRef.fromJson(Map<String, dynamic> json) => _$CostCenterRefFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;
@override final  String? type;
@override@JsonKey() final  bool isExternal;

/// Create a copy of CostCenterRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CostCenterRefCopyWith<_CostCenterRef> get copyWith => __$CostCenterRefCopyWithImpl<_CostCenterRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CostCenterRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CostCenterRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.type, type) || other.type == type)&&(identical(other.isExternal, isExternal) || other.isExternal == isExternal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,type,isExternal);

@override
String toString() {
  return 'CostCenterRef(id: $id, name: $name, code: $code, type: $type, isExternal: $isExternal)';
}


}

/// @nodoc
abstract mixin class _$CostCenterRefCopyWith<$Res> implements $CostCenterRefCopyWith<$Res> {
  factory _$CostCenterRefCopyWith(_CostCenterRef value, $Res Function(_CostCenterRef) _then) = __$CostCenterRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code, String? type, bool isExternal
});




}
/// @nodoc
class __$CostCenterRefCopyWithImpl<$Res>
    implements _$CostCenterRefCopyWith<$Res> {
  __$CostCenterRefCopyWithImpl(this._self, this._then);

  final _CostCenterRef _self;
  final $Res Function(_CostCenterRef) _then;

/// Create a copy of CostCenterRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? type = freezed,Object? isExternal = null,}) {
  return _then(_CostCenterRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,isExternal: null == isExternal ? _self.isExternal : isExternal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MovementDocument {

 int get id; String get documentNumber; String get documentType;@DocumentStatusConverter() DocumentStatus get status; int? get warehouseId; int? get warehouseToId; String? get warehouseName; String? get warehouseToName; String? get patientDocument; String? get invoiceNumber; String? get reason; String? get movementDate; String? get userName; String? get createdAt; CostCenterRef? get costCenter; List<DocumentSignature> get signatures; List<MovementLine> get movements;
/// Create a copy of MovementDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovementDocumentCopyWith<MovementDocument> get copyWith => _$MovementDocumentCopyWithImpl<MovementDocument>(this as MovementDocument, _$identity);

  /// Serializes this MovementDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovementDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.documentNumber, documentNumber) || other.documentNumber == documentNumber)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.status, status) || other.status == status)&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.warehouseToId, warehouseToId) || other.warehouseToId == warehouseToId)&&(identical(other.warehouseName, warehouseName) || other.warehouseName == warehouseName)&&(identical(other.warehouseToName, warehouseToName) || other.warehouseToName == warehouseToName)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.movementDate, movementDate) || other.movementDate == movementDate)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.costCenter, costCenter) || other.costCenter == costCenter)&&const DeepCollectionEquality().equals(other.signatures, signatures)&&const DeepCollectionEquality().equals(other.movements, movements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentNumber,documentType,status,warehouseId,warehouseToId,warehouseName,warehouseToName,patientDocument,invoiceNumber,reason,movementDate,userName,createdAt,costCenter,const DeepCollectionEquality().hash(signatures),const DeepCollectionEquality().hash(movements));

@override
String toString() {
  return 'MovementDocument(id: $id, documentNumber: $documentNumber, documentType: $documentType, status: $status, warehouseId: $warehouseId, warehouseToId: $warehouseToId, warehouseName: $warehouseName, warehouseToName: $warehouseToName, patientDocument: $patientDocument, invoiceNumber: $invoiceNumber, reason: $reason, movementDate: $movementDate, userName: $userName, createdAt: $createdAt, costCenter: $costCenter, signatures: $signatures, movements: $movements)';
}


}

/// @nodoc
abstract mixin class $MovementDocumentCopyWith<$Res>  {
  factory $MovementDocumentCopyWith(MovementDocument value, $Res Function(MovementDocument) _then) = _$MovementDocumentCopyWithImpl;
@useResult
$Res call({
 int id, String documentNumber, String documentType,@DocumentStatusConverter() DocumentStatus status, int? warehouseId, int? warehouseToId, String? warehouseName, String? warehouseToName, String? patientDocument, String? invoiceNumber, String? reason, String? movementDate, String? userName, String? createdAt, CostCenterRef? costCenter, List<DocumentSignature> signatures, List<MovementLine> movements
});


$CostCenterRefCopyWith<$Res>? get costCenter;

}
/// @nodoc
class _$MovementDocumentCopyWithImpl<$Res>
    implements $MovementDocumentCopyWith<$Res> {
  _$MovementDocumentCopyWithImpl(this._self, this._then);

  final MovementDocument _self;
  final $Res Function(MovementDocument) _then;

/// Create a copy of MovementDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? documentNumber = null,Object? documentType = null,Object? status = null,Object? warehouseId = freezed,Object? warehouseToId = freezed,Object? warehouseName = freezed,Object? warehouseToName = freezed,Object? patientDocument = freezed,Object? invoiceNumber = freezed,Object? reason = freezed,Object? movementDate = freezed,Object? userName = freezed,Object? createdAt = freezed,Object? costCenter = freezed,Object? signatures = null,Object? movements = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,documentNumber: null == documentNumber ? _self.documentNumber : documentNumber // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,warehouseId: freezed == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as int?,warehouseToId: freezed == warehouseToId ? _self.warehouseToId : warehouseToId // ignore: cast_nullable_to_non_nullable
as int?,warehouseName: freezed == warehouseName ? _self.warehouseName : warehouseName // ignore: cast_nullable_to_non_nullable
as String?,warehouseToName: freezed == warehouseToName ? _self.warehouseToName : warehouseToName // ignore: cast_nullable_to_non_nullable
as String?,patientDocument: freezed == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String?,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,movementDate: freezed == movementDate ? _self.movementDate : movementDate // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,costCenter: freezed == costCenter ? _self.costCenter : costCenter // ignore: cast_nullable_to_non_nullable
as CostCenterRef?,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<DocumentSignature>,movements: null == movements ? _self.movements : movements // ignore: cast_nullable_to_non_nullable
as List<MovementLine>,
  ));
}
/// Create a copy of MovementDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCenterRefCopyWith<$Res>? get costCenter {
    if (_self.costCenter == null) {
    return null;
  }

  return $CostCenterRefCopyWith<$Res>(_self.costCenter!, (value) {
    return _then(_self.copyWith(costCenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [MovementDocument].
extension MovementDocumentPatterns on MovementDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovementDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovementDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovementDocument value)  $default,){
final _that = this;
switch (_that) {
case _MovementDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovementDocument value)?  $default,){
final _that = this;
switch (_that) {
case _MovementDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String documentNumber,  String documentType, @DocumentStatusConverter()  DocumentStatus status,  int? warehouseId,  int? warehouseToId,  String? warehouseName,  String? warehouseToName,  String? patientDocument,  String? invoiceNumber,  String? reason,  String? movementDate,  String? userName,  String? createdAt,  CostCenterRef? costCenter,  List<DocumentSignature> signatures,  List<MovementLine> movements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovementDocument() when $default != null:
return $default(_that.id,_that.documentNumber,_that.documentType,_that.status,_that.warehouseId,_that.warehouseToId,_that.warehouseName,_that.warehouseToName,_that.patientDocument,_that.invoiceNumber,_that.reason,_that.movementDate,_that.userName,_that.createdAt,_that.costCenter,_that.signatures,_that.movements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String documentNumber,  String documentType, @DocumentStatusConverter()  DocumentStatus status,  int? warehouseId,  int? warehouseToId,  String? warehouseName,  String? warehouseToName,  String? patientDocument,  String? invoiceNumber,  String? reason,  String? movementDate,  String? userName,  String? createdAt,  CostCenterRef? costCenter,  List<DocumentSignature> signatures,  List<MovementLine> movements)  $default,) {final _that = this;
switch (_that) {
case _MovementDocument():
return $default(_that.id,_that.documentNumber,_that.documentType,_that.status,_that.warehouseId,_that.warehouseToId,_that.warehouseName,_that.warehouseToName,_that.patientDocument,_that.invoiceNumber,_that.reason,_that.movementDate,_that.userName,_that.createdAt,_that.costCenter,_that.signatures,_that.movements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String documentNumber,  String documentType, @DocumentStatusConverter()  DocumentStatus status,  int? warehouseId,  int? warehouseToId,  String? warehouseName,  String? warehouseToName,  String? patientDocument,  String? invoiceNumber,  String? reason,  String? movementDate,  String? userName,  String? createdAt,  CostCenterRef? costCenter,  List<DocumentSignature> signatures,  List<MovementLine> movements)?  $default,) {final _that = this;
switch (_that) {
case _MovementDocument() when $default != null:
return $default(_that.id,_that.documentNumber,_that.documentType,_that.status,_that.warehouseId,_that.warehouseToId,_that.warehouseName,_that.warehouseToName,_that.patientDocument,_that.invoiceNumber,_that.reason,_that.movementDate,_that.userName,_that.createdAt,_that.costCenter,_that.signatures,_that.movements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MovementDocument extends MovementDocument {
  const _MovementDocument({required this.id, required this.documentNumber, required this.documentType, @DocumentStatusConverter() this.status = DocumentStatus.unknown, this.warehouseId, this.warehouseToId, this.warehouseName, this.warehouseToName, this.patientDocument, this.invoiceNumber, this.reason, this.movementDate, this.userName, this.createdAt, this.costCenter, final  List<DocumentSignature> signatures = const [], final  List<MovementLine> movements = const []}): _signatures = signatures,_movements = movements,super._();
  factory _MovementDocument.fromJson(Map<String, dynamic> json) => _$MovementDocumentFromJson(json);

@override final  int id;
@override final  String documentNumber;
@override final  String documentType;
@override@JsonKey()@DocumentStatusConverter() final  DocumentStatus status;
@override final  int? warehouseId;
@override final  int? warehouseToId;
@override final  String? warehouseName;
@override final  String? warehouseToName;
@override final  String? patientDocument;
@override final  String? invoiceNumber;
@override final  String? reason;
@override final  String? movementDate;
@override final  String? userName;
@override final  String? createdAt;
@override final  CostCenterRef? costCenter;
 final  List<DocumentSignature> _signatures;
@override@JsonKey() List<DocumentSignature> get signatures {
  if (_signatures is EqualUnmodifiableListView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signatures);
}

 final  List<MovementLine> _movements;
@override@JsonKey() List<MovementLine> get movements {
  if (_movements is EqualUnmodifiableListView) return _movements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movements);
}


/// Create a copy of MovementDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovementDocumentCopyWith<_MovementDocument> get copyWith => __$MovementDocumentCopyWithImpl<_MovementDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MovementDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovementDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.documentNumber, documentNumber) || other.documentNumber == documentNumber)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.status, status) || other.status == status)&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.warehouseToId, warehouseToId) || other.warehouseToId == warehouseToId)&&(identical(other.warehouseName, warehouseName) || other.warehouseName == warehouseName)&&(identical(other.warehouseToName, warehouseToName) || other.warehouseToName == warehouseToName)&&(identical(other.patientDocument, patientDocument) || other.patientDocument == patientDocument)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.movementDate, movementDate) || other.movementDate == movementDate)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.costCenter, costCenter) || other.costCenter == costCenter)&&const DeepCollectionEquality().equals(other._signatures, _signatures)&&const DeepCollectionEquality().equals(other._movements, _movements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentNumber,documentType,status,warehouseId,warehouseToId,warehouseName,warehouseToName,patientDocument,invoiceNumber,reason,movementDate,userName,createdAt,costCenter,const DeepCollectionEquality().hash(_signatures),const DeepCollectionEquality().hash(_movements));

@override
String toString() {
  return 'MovementDocument(id: $id, documentNumber: $documentNumber, documentType: $documentType, status: $status, warehouseId: $warehouseId, warehouseToId: $warehouseToId, warehouseName: $warehouseName, warehouseToName: $warehouseToName, patientDocument: $patientDocument, invoiceNumber: $invoiceNumber, reason: $reason, movementDate: $movementDate, userName: $userName, createdAt: $createdAt, costCenter: $costCenter, signatures: $signatures, movements: $movements)';
}


}

/// @nodoc
abstract mixin class _$MovementDocumentCopyWith<$Res> implements $MovementDocumentCopyWith<$Res> {
  factory _$MovementDocumentCopyWith(_MovementDocument value, $Res Function(_MovementDocument) _then) = __$MovementDocumentCopyWithImpl;
@override @useResult
$Res call({
 int id, String documentNumber, String documentType,@DocumentStatusConverter() DocumentStatus status, int? warehouseId, int? warehouseToId, String? warehouseName, String? warehouseToName, String? patientDocument, String? invoiceNumber, String? reason, String? movementDate, String? userName, String? createdAt, CostCenterRef? costCenter, List<DocumentSignature> signatures, List<MovementLine> movements
});


@override $CostCenterRefCopyWith<$Res>? get costCenter;

}
/// @nodoc
class __$MovementDocumentCopyWithImpl<$Res>
    implements _$MovementDocumentCopyWith<$Res> {
  __$MovementDocumentCopyWithImpl(this._self, this._then);

  final _MovementDocument _self;
  final $Res Function(_MovementDocument) _then;

/// Create a copy of MovementDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? documentNumber = null,Object? documentType = null,Object? status = null,Object? warehouseId = freezed,Object? warehouseToId = freezed,Object? warehouseName = freezed,Object? warehouseToName = freezed,Object? patientDocument = freezed,Object? invoiceNumber = freezed,Object? reason = freezed,Object? movementDate = freezed,Object? userName = freezed,Object? createdAt = freezed,Object? costCenter = freezed,Object? signatures = null,Object? movements = null,}) {
  return _then(_MovementDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,documentNumber: null == documentNumber ? _self.documentNumber : documentNumber // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,warehouseId: freezed == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as int?,warehouseToId: freezed == warehouseToId ? _self.warehouseToId : warehouseToId // ignore: cast_nullable_to_non_nullable
as int?,warehouseName: freezed == warehouseName ? _self.warehouseName : warehouseName // ignore: cast_nullable_to_non_nullable
as String?,warehouseToName: freezed == warehouseToName ? _self.warehouseToName : warehouseToName // ignore: cast_nullable_to_non_nullable
as String?,patientDocument: freezed == patientDocument ? _self.patientDocument : patientDocument // ignore: cast_nullable_to_non_nullable
as String?,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,movementDate: freezed == movementDate ? _self.movementDate : movementDate // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,costCenter: freezed == costCenter ? _self.costCenter : costCenter // ignore: cast_nullable_to_non_nullable
as CostCenterRef?,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<DocumentSignature>,movements: null == movements ? _self._movements : movements // ignore: cast_nullable_to_non_nullable
as List<MovementLine>,
  ));
}

/// Create a copy of MovementDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CostCenterRefCopyWith<$Res>? get costCenter {
    if (_self.costCenter == null) {
    return null;
  }

  return $CostCenterRefCopyWith<$Res>(_self.costCenter!, (value) {
    return _then(_self.copyWith(costCenter: value));
  });
}
}

// dart format on
