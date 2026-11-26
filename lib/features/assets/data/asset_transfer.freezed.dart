// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransferAssetRef {

 int get id; String? get code; String? get name;
/// Create a copy of TransferAssetRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferAssetRefCopyWith<TransferAssetRef> get copyWith => _$TransferAssetRefCopyWithImpl<TransferAssetRef>(this as TransferAssetRef, _$identity);

  /// Serializes this TransferAssetRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferAssetRef&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name);

@override
String toString() {
  return 'TransferAssetRef(id: $id, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $TransferAssetRefCopyWith<$Res>  {
  factory $TransferAssetRefCopyWith(TransferAssetRef value, $Res Function(TransferAssetRef) _then) = _$TransferAssetRefCopyWithImpl;
@useResult
$Res call({
 int id, String? code, String? name
});




}
/// @nodoc
class _$TransferAssetRefCopyWithImpl<$Res>
    implements $TransferAssetRefCopyWith<$Res> {
  _$TransferAssetRefCopyWithImpl(this._self, this._then);

  final TransferAssetRef _self;
  final $Res Function(TransferAssetRef) _then;

/// Create a copy of TransferAssetRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferAssetRef].
extension TransferAssetRefPatterns on TransferAssetRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferAssetRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferAssetRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferAssetRef value)  $default,){
final _that = this;
switch (_that) {
case _TransferAssetRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferAssetRef value)?  $default,){
final _that = this;
switch (_that) {
case _TransferAssetRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? code,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferAssetRef() when $default != null:
return $default(_that.id,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? code,  String? name)  $default,) {final _that = this;
switch (_that) {
case _TransferAssetRef():
return $default(_that.id,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? code,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _TransferAssetRef() when $default != null:
return $default(_that.id,_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferAssetRef implements TransferAssetRef {
  const _TransferAssetRef({required this.id, this.code, this.name});
  factory _TransferAssetRef.fromJson(Map<String, dynamic> json) => _$TransferAssetRefFromJson(json);

@override final  int id;
@override final  String? code;
@override final  String? name;

/// Create a copy of TransferAssetRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferAssetRefCopyWith<_TransferAssetRef> get copyWith => __$TransferAssetRefCopyWithImpl<_TransferAssetRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferAssetRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferAssetRef&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name);

@override
String toString() {
  return 'TransferAssetRef(id: $id, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TransferAssetRefCopyWith<$Res> implements $TransferAssetRefCopyWith<$Res> {
  factory _$TransferAssetRefCopyWith(_TransferAssetRef value, $Res Function(_TransferAssetRef) _then) = __$TransferAssetRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String? code, String? name
});




}
/// @nodoc
class __$TransferAssetRefCopyWithImpl<$Res>
    implements _$TransferAssetRefCopyWith<$Res> {
  __$TransferAssetRefCopyWithImpl(this._self, this._then);

  final _TransferAssetRef _self;
  final $Res Function(_TransferAssetRef) _then;

/// Create a copy of TransferAssetRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = freezed,Object? name = freezed,}) {
  return _then(_TransferAssetRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TransferSignature {

 String get role; String? get method; String? get signerName; String? get signerDocument; String? get signedAt;
/// Create a copy of TransferSignature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferSignatureCopyWith<TransferSignature> get copyWith => _$TransferSignatureCopyWithImpl<TransferSignature>(this as TransferSignature, _$identity);

  /// Serializes this TransferSignature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferSignature&&(identical(other.role, role) || other.role == role)&&(identical(other.method, method) || other.method == method)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerDocument, signerDocument) || other.signerDocument == signerDocument)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,method,signerName,signerDocument,signedAt);

@override
String toString() {
  return 'TransferSignature(role: $role, method: $method, signerName: $signerName, signerDocument: $signerDocument, signedAt: $signedAt)';
}


}

/// @nodoc
abstract mixin class $TransferSignatureCopyWith<$Res>  {
  factory $TransferSignatureCopyWith(TransferSignature value, $Res Function(TransferSignature) _then) = _$TransferSignatureCopyWithImpl;
@useResult
$Res call({
 String role, String? method, String? signerName, String? signerDocument, String? signedAt
});




}
/// @nodoc
class _$TransferSignatureCopyWithImpl<$Res>
    implements $TransferSignatureCopyWith<$Res> {
  _$TransferSignatureCopyWithImpl(this._self, this._then);

  final TransferSignature _self;
  final $Res Function(TransferSignature) _then;

/// Create a copy of TransferSignature
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


/// Adds pattern-matching-related methods to [TransferSignature].
extension TransferSignaturePatterns on TransferSignature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferSignature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferSignature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferSignature value)  $default,){
final _that = this;
switch (_that) {
case _TransferSignature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferSignature value)?  $default,){
final _that = this;
switch (_that) {
case _TransferSignature() when $default != null:
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
case _TransferSignature() when $default != null:
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
case _TransferSignature():
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
case _TransferSignature() when $default != null:
return $default(_that.role,_that.method,_that.signerName,_that.signerDocument,_that.signedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferSignature implements TransferSignature {
  const _TransferSignature({required this.role, this.method, this.signerName, this.signerDocument, this.signedAt});
  factory _TransferSignature.fromJson(Map<String, dynamic> json) => _$TransferSignatureFromJson(json);

@override final  String role;
@override final  String? method;
@override final  String? signerName;
@override final  String? signerDocument;
@override final  String? signedAt;

/// Create a copy of TransferSignature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferSignatureCopyWith<_TransferSignature> get copyWith => __$TransferSignatureCopyWithImpl<_TransferSignature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferSignatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferSignature&&(identical(other.role, role) || other.role == role)&&(identical(other.method, method) || other.method == method)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerDocument, signerDocument) || other.signerDocument == signerDocument)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,method,signerName,signerDocument,signedAt);

@override
String toString() {
  return 'TransferSignature(role: $role, method: $method, signerName: $signerName, signerDocument: $signerDocument, signedAt: $signedAt)';
}


}

/// @nodoc
abstract mixin class _$TransferSignatureCopyWith<$Res> implements $TransferSignatureCopyWith<$Res> {
  factory _$TransferSignatureCopyWith(_TransferSignature value, $Res Function(_TransferSignature) _then) = __$TransferSignatureCopyWithImpl;
@override @useResult
$Res call({
 String role, String? method, String? signerName, String? signerDocument, String? signedAt
});




}
/// @nodoc
class __$TransferSignatureCopyWithImpl<$Res>
    implements _$TransferSignatureCopyWith<$Res> {
  __$TransferSignatureCopyWithImpl(this._self, this._then);

  final _TransferSignature _self;
  final $Res Function(_TransferSignature) _then;

/// Create a copy of TransferSignature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? method = freezed,Object? signerName = freezed,Object? signerDocument = freezed,Object? signedAt = freezed,}) {
  return _then(_TransferSignature(
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
mixin _$AssetTransfer {

 int get id; String? get type; String? get typeLabel;@TransferStatusConverter() TransferStatus get status; bool get requiresSignature; TransferAssetRef? get asset; String? get from; String? get to; String? get externalDestination; NamedRef? get supplier; NamedRef? get fromResponsible; NamedRef? get toResponsible; String? get expectedReturnDate; String? get resultingStatus; String? get reason; NamedRef? get requestedBy; String? get confirmedAt; String? get cancelReason; List<TransferSignature> get signatures; String? get createdAt;
/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetTransferCopyWith<AssetTransfer> get copyWith => _$AssetTransferCopyWithImpl<AssetTransfer>(this as AssetTransfer, _$identity);

  /// Serializes this AssetTransfer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetTransfer&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.status, status) || other.status == status)&&(identical(other.requiresSignature, requiresSignature) || other.requiresSignature == requiresSignature)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.externalDestination, externalDestination) || other.externalDestination == externalDestination)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.fromResponsible, fromResponsible) || other.fromResponsible == fromResponsible)&&(identical(other.toResponsible, toResponsible) || other.toResponsible == toResponsible)&&(identical(other.expectedReturnDate, expectedReturnDate) || other.expectedReturnDate == expectedReturnDate)&&(identical(other.resultingStatus, resultingStatus) || other.resultingStatus == resultingStatus)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&const DeepCollectionEquality().equals(other.signatures, signatures)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,typeLabel,status,requiresSignature,asset,from,to,externalDestination,supplier,fromResponsible,toResponsible,expectedReturnDate,resultingStatus,reason,requestedBy,confirmedAt,cancelReason,const DeepCollectionEquality().hash(signatures),createdAt]);

@override
String toString() {
  return 'AssetTransfer(id: $id, type: $type, typeLabel: $typeLabel, status: $status, requiresSignature: $requiresSignature, asset: $asset, from: $from, to: $to, externalDestination: $externalDestination, supplier: $supplier, fromResponsible: $fromResponsible, toResponsible: $toResponsible, expectedReturnDate: $expectedReturnDate, resultingStatus: $resultingStatus, reason: $reason, requestedBy: $requestedBy, confirmedAt: $confirmedAt, cancelReason: $cancelReason, signatures: $signatures, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AssetTransferCopyWith<$Res>  {
  factory $AssetTransferCopyWith(AssetTransfer value, $Res Function(AssetTransfer) _then) = _$AssetTransferCopyWithImpl;
@useResult
$Res call({
 int id, String? type, String? typeLabel,@TransferStatusConverter() TransferStatus status, bool requiresSignature, TransferAssetRef? asset, String? from, String? to, String? externalDestination, NamedRef? supplier, NamedRef? fromResponsible, NamedRef? toResponsible, String? expectedReturnDate, String? resultingStatus, String? reason, NamedRef? requestedBy, String? confirmedAt, String? cancelReason, List<TransferSignature> signatures, String? createdAt
});


$TransferAssetRefCopyWith<$Res>? get asset;$NamedRefCopyWith<$Res>? get supplier;$NamedRefCopyWith<$Res>? get fromResponsible;$NamedRefCopyWith<$Res>? get toResponsible;$NamedRefCopyWith<$Res>? get requestedBy;

}
/// @nodoc
class _$AssetTransferCopyWithImpl<$Res>
    implements $AssetTransferCopyWith<$Res> {
  _$AssetTransferCopyWithImpl(this._self, this._then);

  final AssetTransfer _self;
  final $Res Function(AssetTransfer) _then;

/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = freezed,Object? status = null,Object? requiresSignature = null,Object? asset = freezed,Object? from = freezed,Object? to = freezed,Object? externalDestination = freezed,Object? supplier = freezed,Object? fromResponsible = freezed,Object? toResponsible = freezed,Object? expectedReturnDate = freezed,Object? resultingStatus = freezed,Object? reason = freezed,Object? requestedBy = freezed,Object? confirmedAt = freezed,Object? cancelReason = freezed,Object? signatures = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransferStatus,requiresSignature: null == requiresSignature ? _self.requiresSignature : requiresSignature // ignore: cast_nullable_to_non_nullable
as bool,asset: freezed == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as TransferAssetRef?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,externalDestination: freezed == externalDestination ? _self.externalDestination : externalDestination // ignore: cast_nullable_to_non_nullable
as String?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,fromResponsible: freezed == fromResponsible ? _self.fromResponsible : fromResponsible // ignore: cast_nullable_to_non_nullable
as NamedRef?,toResponsible: freezed == toResponsible ? _self.toResponsible : toResponsible // ignore: cast_nullable_to_non_nullable
as NamedRef?,expectedReturnDate: freezed == expectedReturnDate ? _self.expectedReturnDate : expectedReturnDate // ignore: cast_nullable_to_non_nullable
as String?,resultingStatus: freezed == resultingStatus ? _self.resultingStatus : resultingStatus // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,requestedBy: freezed == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as NamedRef?,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as String?,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<TransferSignature>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransferAssetRefCopyWith<$Res>? get asset {
    if (_self.asset == null) {
    return null;
  }

  return $TransferAssetRefCopyWith<$Res>(_self.asset!, (value) {
    return _then(_self.copyWith(asset: value));
  });
}/// Create a copy of AssetTransfer
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
}/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get fromResponsible {
    if (_self.fromResponsible == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.fromResponsible!, (value) {
    return _then(_self.copyWith(fromResponsible: value));
  });
}/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get toResponsible {
    if (_self.toResponsible == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.toResponsible!, (value) {
    return _then(_self.copyWith(toResponsible: value));
  });
}/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get requestedBy {
    if (_self.requestedBy == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.requestedBy!, (value) {
    return _then(_self.copyWith(requestedBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [AssetTransfer].
extension AssetTransferPatterns on AssetTransfer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetTransfer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetTransfer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetTransfer value)  $default,){
final _that = this;
switch (_that) {
case _AssetTransfer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetTransfer value)?  $default,){
final _that = this;
switch (_that) {
case _AssetTransfer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? type,  String? typeLabel, @TransferStatusConverter()  TransferStatus status,  bool requiresSignature,  TransferAssetRef? asset,  String? from,  String? to,  String? externalDestination,  NamedRef? supplier,  NamedRef? fromResponsible,  NamedRef? toResponsible,  String? expectedReturnDate,  String? resultingStatus,  String? reason,  NamedRef? requestedBy,  String? confirmedAt,  String? cancelReason,  List<TransferSignature> signatures,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetTransfer() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel,_that.status,_that.requiresSignature,_that.asset,_that.from,_that.to,_that.externalDestination,_that.supplier,_that.fromResponsible,_that.toResponsible,_that.expectedReturnDate,_that.resultingStatus,_that.reason,_that.requestedBy,_that.confirmedAt,_that.cancelReason,_that.signatures,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? type,  String? typeLabel, @TransferStatusConverter()  TransferStatus status,  bool requiresSignature,  TransferAssetRef? asset,  String? from,  String? to,  String? externalDestination,  NamedRef? supplier,  NamedRef? fromResponsible,  NamedRef? toResponsible,  String? expectedReturnDate,  String? resultingStatus,  String? reason,  NamedRef? requestedBy,  String? confirmedAt,  String? cancelReason,  List<TransferSignature> signatures,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AssetTransfer():
return $default(_that.id,_that.type,_that.typeLabel,_that.status,_that.requiresSignature,_that.asset,_that.from,_that.to,_that.externalDestination,_that.supplier,_that.fromResponsible,_that.toResponsible,_that.expectedReturnDate,_that.resultingStatus,_that.reason,_that.requestedBy,_that.confirmedAt,_that.cancelReason,_that.signatures,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? type,  String? typeLabel, @TransferStatusConverter()  TransferStatus status,  bool requiresSignature,  TransferAssetRef? asset,  String? from,  String? to,  String? externalDestination,  NamedRef? supplier,  NamedRef? fromResponsible,  NamedRef? toResponsible,  String? expectedReturnDate,  String? resultingStatus,  String? reason,  NamedRef? requestedBy,  String? confirmedAt,  String? cancelReason,  List<TransferSignature> signatures,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AssetTransfer() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel,_that.status,_that.requiresSignature,_that.asset,_that.from,_that.to,_that.externalDestination,_that.supplier,_that.fromResponsible,_that.toResponsible,_that.expectedReturnDate,_that.resultingStatus,_that.reason,_that.requestedBy,_that.confirmedAt,_that.cancelReason,_that.signatures,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetTransfer extends AssetTransfer {
  const _AssetTransfer({required this.id, this.type, this.typeLabel, @TransferStatusConverter() this.status = TransferStatus.unknown, this.requiresSignature = false, this.asset, this.from, this.to, this.externalDestination, this.supplier, this.fromResponsible, this.toResponsible, this.expectedReturnDate, this.resultingStatus, this.reason, this.requestedBy, this.confirmedAt, this.cancelReason, final  List<TransferSignature> signatures = const [], this.createdAt}): _signatures = signatures,super._();
  factory _AssetTransfer.fromJson(Map<String, dynamic> json) => _$AssetTransferFromJson(json);

@override final  int id;
@override final  String? type;
@override final  String? typeLabel;
@override@JsonKey()@TransferStatusConverter() final  TransferStatus status;
@override@JsonKey() final  bool requiresSignature;
@override final  TransferAssetRef? asset;
@override final  String? from;
@override final  String? to;
@override final  String? externalDestination;
@override final  NamedRef? supplier;
@override final  NamedRef? fromResponsible;
@override final  NamedRef? toResponsible;
@override final  String? expectedReturnDate;
@override final  String? resultingStatus;
@override final  String? reason;
@override final  NamedRef? requestedBy;
@override final  String? confirmedAt;
@override final  String? cancelReason;
 final  List<TransferSignature> _signatures;
@override@JsonKey() List<TransferSignature> get signatures {
  if (_signatures is EqualUnmodifiableListView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signatures);
}

@override final  String? createdAt;

/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetTransferCopyWith<_AssetTransfer> get copyWith => __$AssetTransferCopyWithImpl<_AssetTransfer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetTransferToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetTransfer&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.status, status) || other.status == status)&&(identical(other.requiresSignature, requiresSignature) || other.requiresSignature == requiresSignature)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.externalDestination, externalDestination) || other.externalDestination == externalDestination)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.fromResponsible, fromResponsible) || other.fromResponsible == fromResponsible)&&(identical(other.toResponsible, toResponsible) || other.toResponsible == toResponsible)&&(identical(other.expectedReturnDate, expectedReturnDate) || other.expectedReturnDate == expectedReturnDate)&&(identical(other.resultingStatus, resultingStatus) || other.resultingStatus == resultingStatus)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&const DeepCollectionEquality().equals(other._signatures, _signatures)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,typeLabel,status,requiresSignature,asset,from,to,externalDestination,supplier,fromResponsible,toResponsible,expectedReturnDate,resultingStatus,reason,requestedBy,confirmedAt,cancelReason,const DeepCollectionEquality().hash(_signatures),createdAt]);

@override
String toString() {
  return 'AssetTransfer(id: $id, type: $type, typeLabel: $typeLabel, status: $status, requiresSignature: $requiresSignature, asset: $asset, from: $from, to: $to, externalDestination: $externalDestination, supplier: $supplier, fromResponsible: $fromResponsible, toResponsible: $toResponsible, expectedReturnDate: $expectedReturnDate, resultingStatus: $resultingStatus, reason: $reason, requestedBy: $requestedBy, confirmedAt: $confirmedAt, cancelReason: $cancelReason, signatures: $signatures, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AssetTransferCopyWith<$Res> implements $AssetTransferCopyWith<$Res> {
  factory _$AssetTransferCopyWith(_AssetTransfer value, $Res Function(_AssetTransfer) _then) = __$AssetTransferCopyWithImpl;
@override @useResult
$Res call({
 int id, String? type, String? typeLabel,@TransferStatusConverter() TransferStatus status, bool requiresSignature, TransferAssetRef? asset, String? from, String? to, String? externalDestination, NamedRef? supplier, NamedRef? fromResponsible, NamedRef? toResponsible, String? expectedReturnDate, String? resultingStatus, String? reason, NamedRef? requestedBy, String? confirmedAt, String? cancelReason, List<TransferSignature> signatures, String? createdAt
});


@override $TransferAssetRefCopyWith<$Res>? get asset;@override $NamedRefCopyWith<$Res>? get supplier;@override $NamedRefCopyWith<$Res>? get fromResponsible;@override $NamedRefCopyWith<$Res>? get toResponsible;@override $NamedRefCopyWith<$Res>? get requestedBy;

}
/// @nodoc
class __$AssetTransferCopyWithImpl<$Res>
    implements _$AssetTransferCopyWith<$Res> {
  __$AssetTransferCopyWithImpl(this._self, this._then);

  final _AssetTransfer _self;
  final $Res Function(_AssetTransfer) _then;

/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = freezed,Object? status = null,Object? requiresSignature = null,Object? asset = freezed,Object? from = freezed,Object? to = freezed,Object? externalDestination = freezed,Object? supplier = freezed,Object? fromResponsible = freezed,Object? toResponsible = freezed,Object? expectedReturnDate = freezed,Object? resultingStatus = freezed,Object? reason = freezed,Object? requestedBy = freezed,Object? confirmedAt = freezed,Object? cancelReason = freezed,Object? signatures = null,Object? createdAt = freezed,}) {
  return _then(_AssetTransfer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransferStatus,requiresSignature: null == requiresSignature ? _self.requiresSignature : requiresSignature // ignore: cast_nullable_to_non_nullable
as bool,asset: freezed == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as TransferAssetRef?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,externalDestination: freezed == externalDestination ? _self.externalDestination : externalDestination // ignore: cast_nullable_to_non_nullable
as String?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,fromResponsible: freezed == fromResponsible ? _self.fromResponsible : fromResponsible // ignore: cast_nullable_to_non_nullable
as NamedRef?,toResponsible: freezed == toResponsible ? _self.toResponsible : toResponsible // ignore: cast_nullable_to_non_nullable
as NamedRef?,expectedReturnDate: freezed == expectedReturnDate ? _self.expectedReturnDate : expectedReturnDate // ignore: cast_nullable_to_non_nullable
as String?,resultingStatus: freezed == resultingStatus ? _self.resultingStatus : resultingStatus // ignore: cast_nullable_to_non_nullable
as String?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,requestedBy: freezed == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as NamedRef?,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as String?,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<TransferSignature>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransferAssetRefCopyWith<$Res>? get asset {
    if (_self.asset == null) {
    return null;
  }

  return $TransferAssetRefCopyWith<$Res>(_self.asset!, (value) {
    return _then(_self.copyWith(asset: value));
  });
}/// Create a copy of AssetTransfer
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
}/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get fromResponsible {
    if (_self.fromResponsible == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.fromResponsible!, (value) {
    return _then(_self.copyWith(fromResponsible: value));
  });
}/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get toResponsible {
    if (_self.toResponsible == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.toResponsible!, (value) {
    return _then(_self.copyWith(toResponsible: value));
  });
}/// Create a copy of AssetTransfer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get requestedBy {
    if (_self.requestedBy == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.requestedBy!, (value) {
    return _then(_self.copyWith(requestedBy: value));
  });
}
}

// dart format on
