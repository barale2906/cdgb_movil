// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssetDocument {

 int get id; String? get documentType; String? get documentTypeLabel; String? get title; String? get originalName; String? get mimeType; int? get size; int? get maintenanceId; String? get issuedAt; String? get expiresAt; NamedRef? get uploadedBy; String? get createdAt;
/// Create a copy of AssetDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetDocumentCopyWith<AssetDocument> get copyWith => _$AssetDocumentCopyWithImpl<AssetDocument>(this as AssetDocument, _$identity);

  /// Serializes this AssetDocument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.documentTypeLabel, documentTypeLabel) || other.documentTypeLabel == documentTypeLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalName, originalName) || other.originalName == originalName)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.size, size) || other.size == size)&&(identical(other.maintenanceId, maintenanceId) || other.maintenanceId == maintenanceId)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentType,documentTypeLabel,title,originalName,mimeType,size,maintenanceId,issuedAt,expiresAt,uploadedBy,createdAt);

@override
String toString() {
  return 'AssetDocument(id: $id, documentType: $documentType, documentTypeLabel: $documentTypeLabel, title: $title, originalName: $originalName, mimeType: $mimeType, size: $size, maintenanceId: $maintenanceId, issuedAt: $issuedAt, expiresAt: $expiresAt, uploadedBy: $uploadedBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AssetDocumentCopyWith<$Res>  {
  factory $AssetDocumentCopyWith(AssetDocument value, $Res Function(AssetDocument) _then) = _$AssetDocumentCopyWithImpl;
@useResult
$Res call({
 int id, String? documentType, String? documentTypeLabel, String? title, String? originalName, String? mimeType, int? size, int? maintenanceId, String? issuedAt, String? expiresAt, NamedRef? uploadedBy, String? createdAt
});


$NamedRefCopyWith<$Res>? get uploadedBy;

}
/// @nodoc
class _$AssetDocumentCopyWithImpl<$Res>
    implements $AssetDocumentCopyWith<$Res> {
  _$AssetDocumentCopyWithImpl(this._self, this._then);

  final AssetDocument _self;
  final $Res Function(AssetDocument) _then;

/// Create a copy of AssetDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? documentType = freezed,Object? documentTypeLabel = freezed,Object? title = freezed,Object? originalName = freezed,Object? mimeType = freezed,Object? size = freezed,Object? maintenanceId = freezed,Object? issuedAt = freezed,Object? expiresAt = freezed,Object? uploadedBy = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,documentType: freezed == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String?,documentTypeLabel: freezed == documentTypeLabel ? _self.documentTypeLabel : documentTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,originalName: freezed == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,maintenanceId: freezed == maintenanceId ? _self.maintenanceId : maintenanceId // ignore: cast_nullable_to_non_nullable
as int?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,uploadedBy: freezed == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as NamedRef?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AssetDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get uploadedBy {
    if (_self.uploadedBy == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.uploadedBy!, (value) {
    return _then(_self.copyWith(uploadedBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [AssetDocument].
extension AssetDocumentPatterns on AssetDocument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetDocument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetDocument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetDocument value)  $default,){
final _that = this;
switch (_that) {
case _AssetDocument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetDocument value)?  $default,){
final _that = this;
switch (_that) {
case _AssetDocument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? documentType,  String? documentTypeLabel,  String? title,  String? originalName,  String? mimeType,  int? size,  int? maintenanceId,  String? issuedAt,  String? expiresAt,  NamedRef? uploadedBy,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetDocument() when $default != null:
return $default(_that.id,_that.documentType,_that.documentTypeLabel,_that.title,_that.originalName,_that.mimeType,_that.size,_that.maintenanceId,_that.issuedAt,_that.expiresAt,_that.uploadedBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? documentType,  String? documentTypeLabel,  String? title,  String? originalName,  String? mimeType,  int? size,  int? maintenanceId,  String? issuedAt,  String? expiresAt,  NamedRef? uploadedBy,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AssetDocument():
return $default(_that.id,_that.documentType,_that.documentTypeLabel,_that.title,_that.originalName,_that.mimeType,_that.size,_that.maintenanceId,_that.issuedAt,_that.expiresAt,_that.uploadedBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? documentType,  String? documentTypeLabel,  String? title,  String? originalName,  String? mimeType,  int? size,  int? maintenanceId,  String? issuedAt,  String? expiresAt,  NamedRef? uploadedBy,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AssetDocument() when $default != null:
return $default(_that.id,_that.documentType,_that.documentTypeLabel,_that.title,_that.originalName,_that.mimeType,_that.size,_that.maintenanceId,_that.issuedAt,_that.expiresAt,_that.uploadedBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetDocument extends AssetDocument {
  const _AssetDocument({required this.id, this.documentType, this.documentTypeLabel, this.title, this.originalName, this.mimeType, this.size, this.maintenanceId, this.issuedAt, this.expiresAt, this.uploadedBy, this.createdAt}): super._();
  factory _AssetDocument.fromJson(Map<String, dynamic> json) => _$AssetDocumentFromJson(json);

@override final  int id;
@override final  String? documentType;
@override final  String? documentTypeLabel;
@override final  String? title;
@override final  String? originalName;
@override final  String? mimeType;
@override final  int? size;
@override final  int? maintenanceId;
@override final  String? issuedAt;
@override final  String? expiresAt;
@override final  NamedRef? uploadedBy;
@override final  String? createdAt;

/// Create a copy of AssetDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetDocumentCopyWith<_AssetDocument> get copyWith => __$AssetDocumentCopyWithImpl<_AssetDocument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetDocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.documentTypeLabel, documentTypeLabel) || other.documentTypeLabel == documentTypeLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalName, originalName) || other.originalName == originalName)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.size, size) || other.size == size)&&(identical(other.maintenanceId, maintenanceId) || other.maintenanceId == maintenanceId)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.uploadedBy, uploadedBy) || other.uploadedBy == uploadedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentType,documentTypeLabel,title,originalName,mimeType,size,maintenanceId,issuedAt,expiresAt,uploadedBy,createdAt);

@override
String toString() {
  return 'AssetDocument(id: $id, documentType: $documentType, documentTypeLabel: $documentTypeLabel, title: $title, originalName: $originalName, mimeType: $mimeType, size: $size, maintenanceId: $maintenanceId, issuedAt: $issuedAt, expiresAt: $expiresAt, uploadedBy: $uploadedBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AssetDocumentCopyWith<$Res> implements $AssetDocumentCopyWith<$Res> {
  factory _$AssetDocumentCopyWith(_AssetDocument value, $Res Function(_AssetDocument) _then) = __$AssetDocumentCopyWithImpl;
@override @useResult
$Res call({
 int id, String? documentType, String? documentTypeLabel, String? title, String? originalName, String? mimeType, int? size, int? maintenanceId, String? issuedAt, String? expiresAt, NamedRef? uploadedBy, String? createdAt
});


@override $NamedRefCopyWith<$Res>? get uploadedBy;

}
/// @nodoc
class __$AssetDocumentCopyWithImpl<$Res>
    implements _$AssetDocumentCopyWith<$Res> {
  __$AssetDocumentCopyWithImpl(this._self, this._then);

  final _AssetDocument _self;
  final $Res Function(_AssetDocument) _then;

/// Create a copy of AssetDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? documentType = freezed,Object? documentTypeLabel = freezed,Object? title = freezed,Object? originalName = freezed,Object? mimeType = freezed,Object? size = freezed,Object? maintenanceId = freezed,Object? issuedAt = freezed,Object? expiresAt = freezed,Object? uploadedBy = freezed,Object? createdAt = freezed,}) {
  return _then(_AssetDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,documentType: freezed == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String?,documentTypeLabel: freezed == documentTypeLabel ? _self.documentTypeLabel : documentTypeLabel // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,originalName: freezed == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String?,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,maintenanceId: freezed == maintenanceId ? _self.maintenanceId : maintenanceId // ignore: cast_nullable_to_non_nullable
as int?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,uploadedBy: freezed == uploadedBy ? _self.uploadedBy : uploadedBy // ignore: cast_nullable_to_non_nullable
as NamedRef?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AssetDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get uploadedBy {
    if (_self.uploadedBy == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.uploadedBy!, (value) {
    return _then(_self.copyWith(uploadedBy: value));
  });
}
}

// dart format on
