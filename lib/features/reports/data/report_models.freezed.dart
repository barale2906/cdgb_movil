// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportExport {

@IdAsStringConverter() String get id; String get type; String get format;@ExportStatusConverter() ExportStatus get status; bool get isReady; bool get isExpired; int? get fileSize; String? get errorMessage; String? get expiresAt; String? get createdAt; String? get completedAt;
/// Create a copy of ReportExport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportExportCopyWith<ReportExport> get copyWith => _$ReportExportCopyWithImpl<ReportExport>(this as ReportExport, _$identity);

  /// Serializes this ReportExport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportExport&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&(identical(other.isReady, isReady) || other.isReady == isReady)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,format,status,isReady,isExpired,fileSize,errorMessage,expiresAt,createdAt,completedAt);

@override
String toString() {
  return 'ReportExport(id: $id, type: $type, format: $format, status: $status, isReady: $isReady, isExpired: $isExpired, fileSize: $fileSize, errorMessage: $errorMessage, expiresAt: $expiresAt, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $ReportExportCopyWith<$Res>  {
  factory $ReportExportCopyWith(ReportExport value, $Res Function(ReportExport) _then) = _$ReportExportCopyWithImpl;
@useResult
$Res call({
@IdAsStringConverter() String id, String type, String format,@ExportStatusConverter() ExportStatus status, bool isReady, bool isExpired, int? fileSize, String? errorMessage, String? expiresAt, String? createdAt, String? completedAt
});




}
/// @nodoc
class _$ReportExportCopyWithImpl<$Res>
    implements $ReportExportCopyWith<$Res> {
  _$ReportExportCopyWithImpl(this._self, this._then);

  final ReportExport _self;
  final $Res Function(ReportExport) _then;

/// Create a copy of ReportExport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? format = null,Object? status = null,Object? isReady = null,Object? isExpired = null,Object? fileSize = freezed,Object? errorMessage = freezed,Object? expiresAt = freezed,Object? createdAt = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExportStatus,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportExport].
extension ReportExportPatterns on ReportExport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportExport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportExport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportExport value)  $default,){
final _that = this;
switch (_that) {
case _ReportExport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportExport value)?  $default,){
final _that = this;
switch (_that) {
case _ReportExport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IdAsStringConverter()  String id,  String type,  String format, @ExportStatusConverter()  ExportStatus status,  bool isReady,  bool isExpired,  int? fileSize,  String? errorMessage,  String? expiresAt,  String? createdAt,  String? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportExport() when $default != null:
return $default(_that.id,_that.type,_that.format,_that.status,_that.isReady,_that.isExpired,_that.fileSize,_that.errorMessage,_that.expiresAt,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IdAsStringConverter()  String id,  String type,  String format, @ExportStatusConverter()  ExportStatus status,  bool isReady,  bool isExpired,  int? fileSize,  String? errorMessage,  String? expiresAt,  String? createdAt,  String? completedAt)  $default,) {final _that = this;
switch (_that) {
case _ReportExport():
return $default(_that.id,_that.type,_that.format,_that.status,_that.isReady,_that.isExpired,_that.fileSize,_that.errorMessage,_that.expiresAt,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IdAsStringConverter()  String id,  String type,  String format, @ExportStatusConverter()  ExportStatus status,  bool isReady,  bool isExpired,  int? fileSize,  String? errorMessage,  String? expiresAt,  String? createdAt,  String? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReportExport() when $default != null:
return $default(_that.id,_that.type,_that.format,_that.status,_that.isReady,_that.isExpired,_that.fileSize,_that.errorMessage,_that.expiresAt,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportExport extends ReportExport {
  const _ReportExport({@IdAsStringConverter() required this.id, this.type = '', this.format = '', @ExportStatusConverter() this.status = ExportStatus.unknown, this.isReady = false, this.isExpired = false, this.fileSize, this.errorMessage, this.expiresAt, this.createdAt, this.completedAt}): super._();
  factory _ReportExport.fromJson(Map<String, dynamic> json) => _$ReportExportFromJson(json);

@override@IdAsStringConverter() final  String id;
@override@JsonKey() final  String type;
@override@JsonKey() final  String format;
@override@JsonKey()@ExportStatusConverter() final  ExportStatus status;
@override@JsonKey() final  bool isReady;
@override@JsonKey() final  bool isExpired;
@override final  int? fileSize;
@override final  String? errorMessage;
@override final  String? expiresAt;
@override final  String? createdAt;
@override final  String? completedAt;

/// Create a copy of ReportExport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportExportCopyWith<_ReportExport> get copyWith => __$ReportExportCopyWithImpl<_ReportExport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportExportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportExport&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.format, format) || other.format == format)&&(identical(other.status, status) || other.status == status)&&(identical(other.isReady, isReady) || other.isReady == isReady)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,format,status,isReady,isExpired,fileSize,errorMessage,expiresAt,createdAt,completedAt);

@override
String toString() {
  return 'ReportExport(id: $id, type: $type, format: $format, status: $status, isReady: $isReady, isExpired: $isExpired, fileSize: $fileSize, errorMessage: $errorMessage, expiresAt: $expiresAt, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$ReportExportCopyWith<$Res> implements $ReportExportCopyWith<$Res> {
  factory _$ReportExportCopyWith(_ReportExport value, $Res Function(_ReportExport) _then) = __$ReportExportCopyWithImpl;
@override @useResult
$Res call({
@IdAsStringConverter() String id, String type, String format,@ExportStatusConverter() ExportStatus status, bool isReady, bool isExpired, int? fileSize, String? errorMessage, String? expiresAt, String? createdAt, String? completedAt
});




}
/// @nodoc
class __$ReportExportCopyWithImpl<$Res>
    implements _$ReportExportCopyWith<$Res> {
  __$ReportExportCopyWithImpl(this._self, this._then);

  final _ReportExport _self;
  final $Res Function(_ReportExport) _then;

/// Create a copy of ReportExport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? format = null,Object? status = null,Object? isReady = null,Object? isExpired = null,Object? fileSize = freezed,Object? errorMessage = freezed,Object? expiresAt = freezed,Object? createdAt = freezed,Object? completedAt = freezed,}) {
  return _then(_ReportExport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExportStatus,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
