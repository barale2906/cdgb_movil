// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_signature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MySignature {

 String get signerName; String get documentType; String get documentNumber; String? get documentTypeLabel; String? get signatureData; bool get hasPin; String? get pinGeneratedAt; String? get registeredAt;
/// Create a copy of MySignature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MySignatureCopyWith<MySignature> get copyWith => _$MySignatureCopyWithImpl<MySignature>(this as MySignature, _$identity);

  /// Serializes this MySignature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MySignature&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.documentNumber, documentNumber) || other.documentNumber == documentNumber)&&(identical(other.documentTypeLabel, documentTypeLabel) || other.documentTypeLabel == documentTypeLabel)&&(identical(other.signatureData, signatureData) || other.signatureData == signatureData)&&(identical(other.hasPin, hasPin) || other.hasPin == hasPin)&&(identical(other.pinGeneratedAt, pinGeneratedAt) || other.pinGeneratedAt == pinGeneratedAt)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signerName,documentType,documentNumber,documentTypeLabel,signatureData,hasPin,pinGeneratedAt,registeredAt);

@override
String toString() {
  return 'MySignature(signerName: $signerName, documentType: $documentType, documentNumber: $documentNumber, documentTypeLabel: $documentTypeLabel, signatureData: $signatureData, hasPin: $hasPin, pinGeneratedAt: $pinGeneratedAt, registeredAt: $registeredAt)';
}


}

/// @nodoc
abstract mixin class $MySignatureCopyWith<$Res>  {
  factory $MySignatureCopyWith(MySignature value, $Res Function(MySignature) _then) = _$MySignatureCopyWithImpl;
@useResult
$Res call({
 String signerName, String documentType, String documentNumber, String? documentTypeLabel, String? signatureData, bool hasPin, String? pinGeneratedAt, String? registeredAt
});




}
/// @nodoc
class _$MySignatureCopyWithImpl<$Res>
    implements $MySignatureCopyWith<$Res> {
  _$MySignatureCopyWithImpl(this._self, this._then);

  final MySignature _self;
  final $Res Function(MySignature) _then;

/// Create a copy of MySignature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signerName = null,Object? documentType = null,Object? documentNumber = null,Object? documentTypeLabel = freezed,Object? signatureData = freezed,Object? hasPin = null,Object? pinGeneratedAt = freezed,Object? registeredAt = freezed,}) {
  return _then(_self.copyWith(
signerName: null == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,documentNumber: null == documentNumber ? _self.documentNumber : documentNumber // ignore: cast_nullable_to_non_nullable
as String,documentTypeLabel: freezed == documentTypeLabel ? _self.documentTypeLabel : documentTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,signatureData: freezed == signatureData ? _self.signatureData : signatureData // ignore: cast_nullable_to_non_nullable
as String?,hasPin: null == hasPin ? _self.hasPin : hasPin // ignore: cast_nullable_to_non_nullable
as bool,pinGeneratedAt: freezed == pinGeneratedAt ? _self.pinGeneratedAt : pinGeneratedAt // ignore: cast_nullable_to_non_nullable
as String?,registeredAt: freezed == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MySignature].
extension MySignaturePatterns on MySignature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MySignature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MySignature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MySignature value)  $default,){
final _that = this;
switch (_that) {
case _MySignature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MySignature value)?  $default,){
final _that = this;
switch (_that) {
case _MySignature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String signerName,  String documentType,  String documentNumber,  String? documentTypeLabel,  String? signatureData,  bool hasPin,  String? pinGeneratedAt,  String? registeredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MySignature() when $default != null:
return $default(_that.signerName,_that.documentType,_that.documentNumber,_that.documentTypeLabel,_that.signatureData,_that.hasPin,_that.pinGeneratedAt,_that.registeredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String signerName,  String documentType,  String documentNumber,  String? documentTypeLabel,  String? signatureData,  bool hasPin,  String? pinGeneratedAt,  String? registeredAt)  $default,) {final _that = this;
switch (_that) {
case _MySignature():
return $default(_that.signerName,_that.documentType,_that.documentNumber,_that.documentTypeLabel,_that.signatureData,_that.hasPin,_that.pinGeneratedAt,_that.registeredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String signerName,  String documentType,  String documentNumber,  String? documentTypeLabel,  String? signatureData,  bool hasPin,  String? pinGeneratedAt,  String? registeredAt)?  $default,) {final _that = this;
switch (_that) {
case _MySignature() when $default != null:
return $default(_that.signerName,_that.documentType,_that.documentNumber,_that.documentTypeLabel,_that.signatureData,_that.hasPin,_that.pinGeneratedAt,_that.registeredAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MySignature implements MySignature {
  const _MySignature({required this.signerName, required this.documentType, required this.documentNumber, this.documentTypeLabel, this.signatureData, this.hasPin = false, this.pinGeneratedAt, this.registeredAt});
  factory _MySignature.fromJson(Map<String, dynamic> json) => _$MySignatureFromJson(json);

@override final  String signerName;
@override final  String documentType;
@override final  String documentNumber;
@override final  String? documentTypeLabel;
@override final  String? signatureData;
@override@JsonKey() final  bool hasPin;
@override final  String? pinGeneratedAt;
@override final  String? registeredAt;

/// Create a copy of MySignature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MySignatureCopyWith<_MySignature> get copyWith => __$MySignatureCopyWithImpl<_MySignature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MySignatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MySignature&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.documentNumber, documentNumber) || other.documentNumber == documentNumber)&&(identical(other.documentTypeLabel, documentTypeLabel) || other.documentTypeLabel == documentTypeLabel)&&(identical(other.signatureData, signatureData) || other.signatureData == signatureData)&&(identical(other.hasPin, hasPin) || other.hasPin == hasPin)&&(identical(other.pinGeneratedAt, pinGeneratedAt) || other.pinGeneratedAt == pinGeneratedAt)&&(identical(other.registeredAt, registeredAt) || other.registeredAt == registeredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signerName,documentType,documentNumber,documentTypeLabel,signatureData,hasPin,pinGeneratedAt,registeredAt);

@override
String toString() {
  return 'MySignature(signerName: $signerName, documentType: $documentType, documentNumber: $documentNumber, documentTypeLabel: $documentTypeLabel, signatureData: $signatureData, hasPin: $hasPin, pinGeneratedAt: $pinGeneratedAt, registeredAt: $registeredAt)';
}


}

/// @nodoc
abstract mixin class _$MySignatureCopyWith<$Res> implements $MySignatureCopyWith<$Res> {
  factory _$MySignatureCopyWith(_MySignature value, $Res Function(_MySignature) _then) = __$MySignatureCopyWithImpl;
@override @useResult
$Res call({
 String signerName, String documentType, String documentNumber, String? documentTypeLabel, String? signatureData, bool hasPin, String? pinGeneratedAt, String? registeredAt
});




}
/// @nodoc
class __$MySignatureCopyWithImpl<$Res>
    implements _$MySignatureCopyWith<$Res> {
  __$MySignatureCopyWithImpl(this._self, this._then);

  final _MySignature _self;
  final $Res Function(_MySignature) _then;

/// Create a copy of MySignature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signerName = null,Object? documentType = null,Object? documentNumber = null,Object? documentTypeLabel = freezed,Object? signatureData = freezed,Object? hasPin = null,Object? pinGeneratedAt = freezed,Object? registeredAt = freezed,}) {
  return _then(_MySignature(
signerName: null == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,documentNumber: null == documentNumber ? _self.documentNumber : documentNumber // ignore: cast_nullable_to_non_nullable
as String,documentTypeLabel: freezed == documentTypeLabel ? _self.documentTypeLabel : documentTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,signatureData: freezed == signatureData ? _self.signatureData : signatureData // ignore: cast_nullable_to_non_nullable
as String?,hasPin: null == hasPin ? _self.hasPin : hasPin // ignore: cast_nullable_to_non_nullable
as bool,pinGeneratedAt: freezed == pinGeneratedAt ? _self.pinGeneratedAt : pinGeneratedAt // ignore: cast_nullable_to_non_nullable
as String?,registeredAt: freezed == registeredAt ? _self.registeredAt : registeredAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
