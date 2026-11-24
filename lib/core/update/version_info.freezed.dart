// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'version_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VersionInfo {

 String get latest; int get build; int get minBuild; String get url; String? get sha256; String? get notes;
/// Create a copy of VersionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersionInfoCopyWith<VersionInfo> get copyWith => _$VersionInfoCopyWithImpl<VersionInfo>(this as VersionInfo, _$identity);

  /// Serializes this VersionInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VersionInfo&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.build, build) || other.build == build)&&(identical(other.minBuild, minBuild) || other.minBuild == minBuild)&&(identical(other.url, url) || other.url == url)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latest,build,minBuild,url,sha256,notes);

@override
String toString() {
  return 'VersionInfo(latest: $latest, build: $build, minBuild: $minBuild, url: $url, sha256: $sha256, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $VersionInfoCopyWith<$Res>  {
  factory $VersionInfoCopyWith(VersionInfo value, $Res Function(VersionInfo) _then) = _$VersionInfoCopyWithImpl;
@useResult
$Res call({
 String latest, int build, int minBuild, String url, String? sha256, String? notes
});




}
/// @nodoc
class _$VersionInfoCopyWithImpl<$Res>
    implements $VersionInfoCopyWith<$Res> {
  _$VersionInfoCopyWithImpl(this._self, this._then);

  final VersionInfo _self;
  final $Res Function(VersionInfo) _then;

/// Create a copy of VersionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latest = null,Object? build = null,Object? minBuild = null,Object? url = null,Object? sha256 = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as String,build: null == build ? _self.build : build // ignore: cast_nullable_to_non_nullable
as int,minBuild: null == minBuild ? _self.minBuild : minBuild // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sha256: freezed == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VersionInfo].
extension VersionInfoPatterns on VersionInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VersionInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VersionInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VersionInfo value)  $default,){
final _that = this;
switch (_that) {
case _VersionInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VersionInfo value)?  $default,){
final _that = this;
switch (_that) {
case _VersionInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String latest,  int build,  int minBuild,  String url,  String? sha256,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VersionInfo() when $default != null:
return $default(_that.latest,_that.build,_that.minBuild,_that.url,_that.sha256,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String latest,  int build,  int minBuild,  String url,  String? sha256,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _VersionInfo():
return $default(_that.latest,_that.build,_that.minBuild,_that.url,_that.sha256,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String latest,  int build,  int minBuild,  String url,  String? sha256,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _VersionInfo() when $default != null:
return $default(_that.latest,_that.build,_that.minBuild,_that.url,_that.sha256,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VersionInfo implements VersionInfo {
  const _VersionInfo({required this.latest, required this.build, required this.minBuild, required this.url, this.sha256, this.notes});
  factory _VersionInfo.fromJson(Map<String, dynamic> json) => _$VersionInfoFromJson(json);

@override final  String latest;
@override final  int build;
@override final  int minBuild;
@override final  String url;
@override final  String? sha256;
@override final  String? notes;

/// Create a copy of VersionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VersionInfoCopyWith<_VersionInfo> get copyWith => __$VersionInfoCopyWithImpl<_VersionInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VersionInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VersionInfo&&(identical(other.latest, latest) || other.latest == latest)&&(identical(other.build, build) || other.build == build)&&(identical(other.minBuild, minBuild) || other.minBuild == minBuild)&&(identical(other.url, url) || other.url == url)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latest,build,minBuild,url,sha256,notes);

@override
String toString() {
  return 'VersionInfo(latest: $latest, build: $build, minBuild: $minBuild, url: $url, sha256: $sha256, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$VersionInfoCopyWith<$Res> implements $VersionInfoCopyWith<$Res> {
  factory _$VersionInfoCopyWith(_VersionInfo value, $Res Function(_VersionInfo) _then) = __$VersionInfoCopyWithImpl;
@override @useResult
$Res call({
 String latest, int build, int minBuild, String url, String? sha256, String? notes
});




}
/// @nodoc
class __$VersionInfoCopyWithImpl<$Res>
    implements _$VersionInfoCopyWith<$Res> {
  __$VersionInfoCopyWithImpl(this._self, this._then);

  final _VersionInfo _self;
  final $Res Function(_VersionInfo) _then;

/// Create a copy of VersionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latest = null,Object? build = null,Object? minBuild = null,Object? url = null,Object? sha256 = freezed,Object? notes = freezed,}) {
  return _then(_VersionInfo(
latest: null == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as String,build: null == build ? _self.build : build // ignore: cast_nullable_to_non_nullable
as int,minBuild: null == minBuild ? _self.minBuild : minBuild // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sha256: freezed == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
