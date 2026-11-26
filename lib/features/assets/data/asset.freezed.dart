// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssetCategory {

 int get id; String get name; String? get code;
/// Create a copy of AssetCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetCategoryCopyWith<AssetCategory> get copyWith => _$AssetCategoryCopyWithImpl<AssetCategory>(this as AssetCategory, _$identity);

  /// Serializes this AssetCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'AssetCategory(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class $AssetCategoryCopyWith<$Res>  {
  factory $AssetCategoryCopyWith(AssetCategory value, $Res Function(AssetCategory) _then) = _$AssetCategoryCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code
});




}
/// @nodoc
class _$AssetCategoryCopyWithImpl<$Res>
    implements $AssetCategoryCopyWith<$Res> {
  _$AssetCategoryCopyWithImpl(this._self, this._then);

  final AssetCategory _self;
  final $Res Function(AssetCategory) _then;

/// Create a copy of AssetCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetCategory].
extension AssetCategoryPatterns on AssetCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetCategory value)  $default,){
final _that = this;
switch (_that) {
case _AssetCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetCategory value)?  $default,){
final _that = this;
switch (_that) {
case _AssetCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetCategory() when $default != null:
return $default(_that.id,_that.name,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? code)  $default,) {final _that = this;
switch (_that) {
case _AssetCategory():
return $default(_that.id,_that.name,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? code)?  $default,) {final _that = this;
switch (_that) {
case _AssetCategory() when $default != null:
return $default(_that.id,_that.name,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetCategory implements AssetCategory {
  const _AssetCategory({required this.id, required this.name, this.code});
  factory _AssetCategory.fromJson(Map<String, dynamic> json) => _$AssetCategoryFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;

/// Create a copy of AssetCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetCategoryCopyWith<_AssetCategory> get copyWith => __$AssetCategoryCopyWithImpl<_AssetCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'AssetCategory(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class _$AssetCategoryCopyWith<$Res> implements $AssetCategoryCopyWith<$Res> {
  factory _$AssetCategoryCopyWith(_AssetCategory value, $Res Function(_AssetCategory) _then) = __$AssetCategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code
});




}
/// @nodoc
class __$AssetCategoryCopyWithImpl<$Res>
    implements _$AssetCategoryCopyWith<$Res> {
  __$AssetCategoryCopyWithImpl(this._self, this._then);

  final _AssetCategory _self;
  final $Res Function(_AssetCategory) _then;

/// Create a copy of AssetCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,}) {
  return _then(_AssetCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AssetLocation {

 bool get isOffPremises; String? get offPremisesLocation; int? get placeId; String? get placeName; int? get siteId; String? get siteName;
/// Create a copy of AssetLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetLocationCopyWith<AssetLocation> get copyWith => _$AssetLocationCopyWithImpl<AssetLocation>(this as AssetLocation, _$identity);

  /// Serializes this AssetLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetLocation&&(identical(other.isOffPremises, isOffPremises) || other.isOffPremises == isOffPremises)&&(identical(other.offPremisesLocation, offPremisesLocation) || other.offPremisesLocation == offPremisesLocation)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.siteId, siteId) || other.siteId == siteId)&&(identical(other.siteName, siteName) || other.siteName == siteName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOffPremises,offPremisesLocation,placeId,placeName,siteId,siteName);

@override
String toString() {
  return 'AssetLocation(isOffPremises: $isOffPremises, offPremisesLocation: $offPremisesLocation, placeId: $placeId, placeName: $placeName, siteId: $siteId, siteName: $siteName)';
}


}

/// @nodoc
abstract mixin class $AssetLocationCopyWith<$Res>  {
  factory $AssetLocationCopyWith(AssetLocation value, $Res Function(AssetLocation) _then) = _$AssetLocationCopyWithImpl;
@useResult
$Res call({
 bool isOffPremises, String? offPremisesLocation, int? placeId, String? placeName, int? siteId, String? siteName
});




}
/// @nodoc
class _$AssetLocationCopyWithImpl<$Res>
    implements $AssetLocationCopyWith<$Res> {
  _$AssetLocationCopyWithImpl(this._self, this._then);

  final AssetLocation _self;
  final $Res Function(AssetLocation) _then;

/// Create a copy of AssetLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOffPremises = null,Object? offPremisesLocation = freezed,Object? placeId = freezed,Object? placeName = freezed,Object? siteId = freezed,Object? siteName = freezed,}) {
  return _then(_self.copyWith(
isOffPremises: null == isOffPremises ? _self.isOffPremises : isOffPremises // ignore: cast_nullable_to_non_nullable
as bool,offPremisesLocation: freezed == offPremisesLocation ? _self.offPremisesLocation : offPremisesLocation // ignore: cast_nullable_to_non_nullable
as String?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as int?,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,siteId: freezed == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as int?,siteName: freezed == siteName ? _self.siteName : siteName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetLocation].
extension AssetLocationPatterns on AssetLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetLocation value)  $default,){
final _that = this;
switch (_that) {
case _AssetLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetLocation value)?  $default,){
final _that = this;
switch (_that) {
case _AssetLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOffPremises,  String? offPremisesLocation,  int? placeId,  String? placeName,  int? siteId,  String? siteName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetLocation() when $default != null:
return $default(_that.isOffPremises,_that.offPremisesLocation,_that.placeId,_that.placeName,_that.siteId,_that.siteName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOffPremises,  String? offPremisesLocation,  int? placeId,  String? placeName,  int? siteId,  String? siteName)  $default,) {final _that = this;
switch (_that) {
case _AssetLocation():
return $default(_that.isOffPremises,_that.offPremisesLocation,_that.placeId,_that.placeName,_that.siteId,_that.siteName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOffPremises,  String? offPremisesLocation,  int? placeId,  String? placeName,  int? siteId,  String? siteName)?  $default,) {final _that = this;
switch (_that) {
case _AssetLocation() when $default != null:
return $default(_that.isOffPremises,_that.offPremisesLocation,_that.placeId,_that.placeName,_that.siteId,_that.siteName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetLocation implements AssetLocation {
  const _AssetLocation({this.isOffPremises = false, this.offPremisesLocation, this.placeId, this.placeName, this.siteId, this.siteName});
  factory _AssetLocation.fromJson(Map<String, dynamic> json) => _$AssetLocationFromJson(json);

@override@JsonKey() final  bool isOffPremises;
@override final  String? offPremisesLocation;
@override final  int? placeId;
@override final  String? placeName;
@override final  int? siteId;
@override final  String? siteName;

/// Create a copy of AssetLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetLocationCopyWith<_AssetLocation> get copyWith => __$AssetLocationCopyWithImpl<_AssetLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetLocation&&(identical(other.isOffPremises, isOffPremises) || other.isOffPremises == isOffPremises)&&(identical(other.offPremisesLocation, offPremisesLocation) || other.offPremisesLocation == offPremisesLocation)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.siteId, siteId) || other.siteId == siteId)&&(identical(other.siteName, siteName) || other.siteName == siteName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOffPremises,offPremisesLocation,placeId,placeName,siteId,siteName);

@override
String toString() {
  return 'AssetLocation(isOffPremises: $isOffPremises, offPremisesLocation: $offPremisesLocation, placeId: $placeId, placeName: $placeName, siteId: $siteId, siteName: $siteName)';
}


}

/// @nodoc
abstract mixin class _$AssetLocationCopyWith<$Res> implements $AssetLocationCopyWith<$Res> {
  factory _$AssetLocationCopyWith(_AssetLocation value, $Res Function(_AssetLocation) _then) = __$AssetLocationCopyWithImpl;
@override @useResult
$Res call({
 bool isOffPremises, String? offPremisesLocation, int? placeId, String? placeName, int? siteId, String? siteName
});




}
/// @nodoc
class __$AssetLocationCopyWithImpl<$Res>
    implements _$AssetLocationCopyWith<$Res> {
  __$AssetLocationCopyWithImpl(this._self, this._then);

  final _AssetLocation _self;
  final $Res Function(_AssetLocation) _then;

/// Create a copy of AssetLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOffPremises = null,Object? offPremisesLocation = freezed,Object? placeId = freezed,Object? placeName = freezed,Object? siteId = freezed,Object? siteName = freezed,}) {
  return _then(_AssetLocation(
isOffPremises: null == isOffPremises ? _self.isOffPremises : isOffPremises // ignore: cast_nullable_to_non_nullable
as bool,offPremisesLocation: freezed == offPremisesLocation ? _self.offPremisesLocation : offPremisesLocation // ignore: cast_nullable_to_non_nullable
as String?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as int?,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,siteId: freezed == siteId ? _self.siteId : siteId // ignore: cast_nullable_to_non_nullable
as int?,siteName: freezed == siteName ? _self.siteName : siteName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NextMaintenance {

 int get id; String? get type; String? get typeLabel; String? get status; String? get scheduledDate; bool get isOverdue;
/// Create a copy of NextMaintenance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NextMaintenanceCopyWith<NextMaintenance> get copyWith => _$NextMaintenanceCopyWithImpl<NextMaintenance>(this as NextMaintenance, _$identity);

  /// Serializes this NextMaintenance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NextMaintenance&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.status, status) || other.status == status)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,typeLabel,status,scheduledDate,isOverdue);

@override
String toString() {
  return 'NextMaintenance(id: $id, type: $type, typeLabel: $typeLabel, status: $status, scheduledDate: $scheduledDate, isOverdue: $isOverdue)';
}


}

/// @nodoc
abstract mixin class $NextMaintenanceCopyWith<$Res>  {
  factory $NextMaintenanceCopyWith(NextMaintenance value, $Res Function(NextMaintenance) _then) = _$NextMaintenanceCopyWithImpl;
@useResult
$Res call({
 int id, String? type, String? typeLabel, String? status, String? scheduledDate, bool isOverdue
});




}
/// @nodoc
class _$NextMaintenanceCopyWithImpl<$Res>
    implements $NextMaintenanceCopyWith<$Res> {
  _$NextMaintenanceCopyWithImpl(this._self, this._then);

  final NextMaintenance _self;
  final $Res Function(NextMaintenance) _then;

/// Create a copy of NextMaintenance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = freezed,Object? status = freezed,Object? scheduledDate = freezed,Object? isOverdue = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,scheduledDate: freezed == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as String?,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NextMaintenance].
extension NextMaintenancePatterns on NextMaintenance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NextMaintenance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NextMaintenance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NextMaintenance value)  $default,){
final _that = this;
switch (_that) {
case _NextMaintenance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NextMaintenance value)?  $default,){
final _that = this;
switch (_that) {
case _NextMaintenance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? type,  String? typeLabel,  String? status,  String? scheduledDate,  bool isOverdue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NextMaintenance() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel,_that.status,_that.scheduledDate,_that.isOverdue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? type,  String? typeLabel,  String? status,  String? scheduledDate,  bool isOverdue)  $default,) {final _that = this;
switch (_that) {
case _NextMaintenance():
return $default(_that.id,_that.type,_that.typeLabel,_that.status,_that.scheduledDate,_that.isOverdue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? type,  String? typeLabel,  String? status,  String? scheduledDate,  bool isOverdue)?  $default,) {final _that = this;
switch (_that) {
case _NextMaintenance() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel,_that.status,_that.scheduledDate,_that.isOverdue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NextMaintenance implements NextMaintenance {
  const _NextMaintenance({required this.id, this.type, this.typeLabel, this.status, this.scheduledDate, this.isOverdue = false});
  factory _NextMaintenance.fromJson(Map<String, dynamic> json) => _$NextMaintenanceFromJson(json);

@override final  int id;
@override final  String? type;
@override final  String? typeLabel;
@override final  String? status;
@override final  String? scheduledDate;
@override@JsonKey() final  bool isOverdue;

/// Create a copy of NextMaintenance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NextMaintenanceCopyWith<_NextMaintenance> get copyWith => __$NextMaintenanceCopyWithImpl<_NextMaintenance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NextMaintenanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextMaintenance&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.status, status) || other.status == status)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,typeLabel,status,scheduledDate,isOverdue);

@override
String toString() {
  return 'NextMaintenance(id: $id, type: $type, typeLabel: $typeLabel, status: $status, scheduledDate: $scheduledDate, isOverdue: $isOverdue)';
}


}

/// @nodoc
abstract mixin class _$NextMaintenanceCopyWith<$Res> implements $NextMaintenanceCopyWith<$Res> {
  factory _$NextMaintenanceCopyWith(_NextMaintenance value, $Res Function(_NextMaintenance) _then) = __$NextMaintenanceCopyWithImpl;
@override @useResult
$Res call({
 int id, String? type, String? typeLabel, String? status, String? scheduledDate, bool isOverdue
});




}
/// @nodoc
class __$NextMaintenanceCopyWithImpl<$Res>
    implements _$NextMaintenanceCopyWith<$Res> {
  __$NextMaintenanceCopyWithImpl(this._self, this._then);

  final _NextMaintenance _self;
  final $Res Function(_NextMaintenance) _then;

/// Create a copy of NextMaintenance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = freezed,Object? status = freezed,Object? scheduledDate = freezed,Object? isOverdue = null,}) {
  return _then(_NextMaintenance(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,scheduledDate: freezed == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as String?,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PendingTransfer {

 int get id; String? get type; String? get typeLabel;
/// Create a copy of PendingTransfer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingTransferCopyWith<PendingTransfer> get copyWith => _$PendingTransferCopyWithImpl<PendingTransfer>(this as PendingTransfer, _$identity);

  /// Serializes this PendingTransfer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingTransfer&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,typeLabel);

@override
String toString() {
  return 'PendingTransfer(id: $id, type: $type, typeLabel: $typeLabel)';
}


}

/// @nodoc
abstract mixin class $PendingTransferCopyWith<$Res>  {
  factory $PendingTransferCopyWith(PendingTransfer value, $Res Function(PendingTransfer) _then) = _$PendingTransferCopyWithImpl;
@useResult
$Res call({
 int id, String? type, String? typeLabel
});




}
/// @nodoc
class _$PendingTransferCopyWithImpl<$Res>
    implements $PendingTransferCopyWith<$Res> {
  _$PendingTransferCopyWithImpl(this._self, this._then);

  final PendingTransfer _self;
  final $Res Function(PendingTransfer) _then;

/// Create a copy of PendingTransfer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingTransfer].
extension PendingTransferPatterns on PendingTransfer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingTransfer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingTransfer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingTransfer value)  $default,){
final _that = this;
switch (_that) {
case _PendingTransfer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingTransfer value)?  $default,){
final _that = this;
switch (_that) {
case _PendingTransfer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? type,  String? typeLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingTransfer() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? type,  String? typeLabel)  $default,) {final _that = this;
switch (_that) {
case _PendingTransfer():
return $default(_that.id,_that.type,_that.typeLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? type,  String? typeLabel)?  $default,) {final _that = this;
switch (_that) {
case _PendingTransfer() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingTransfer implements PendingTransfer {
  const _PendingTransfer({required this.id, this.type, this.typeLabel});
  factory _PendingTransfer.fromJson(Map<String, dynamic> json) => _$PendingTransferFromJson(json);

@override final  int id;
@override final  String? type;
@override final  String? typeLabel;

/// Create a copy of PendingTransfer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingTransferCopyWith<_PendingTransfer> get copyWith => __$PendingTransferCopyWithImpl<_PendingTransfer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingTransferToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingTransfer&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,typeLabel);

@override
String toString() {
  return 'PendingTransfer(id: $id, type: $type, typeLabel: $typeLabel)';
}


}

/// @nodoc
abstract mixin class _$PendingTransferCopyWith<$Res> implements $PendingTransferCopyWith<$Res> {
  factory _$PendingTransferCopyWith(_PendingTransfer value, $Res Function(_PendingTransfer) _then) = __$PendingTransferCopyWithImpl;
@override @useResult
$Res call({
 int id, String? type, String? typeLabel
});




}
/// @nodoc
class __$PendingTransferCopyWithImpl<$Res>
    implements _$PendingTransferCopyWith<$Res> {
  __$PendingTransferCopyWithImpl(this._self, this._then);

  final _PendingTransfer _self;
  final $Res Function(_PendingTransfer) _then;

/// Create a copy of PendingTransfer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = freezed,}) {
  return _then(_PendingTransfer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AssetCounts {

 int get comments; int get documents; int get maintenancePlans;
/// Create a copy of AssetCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetCountsCopyWith<AssetCounts> get copyWith => _$AssetCountsCopyWithImpl<AssetCounts>(this as AssetCounts, _$identity);

  /// Serializes this AssetCounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetCounts&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.documents, documents) || other.documents == documents)&&(identical(other.maintenancePlans, maintenancePlans) || other.maintenancePlans == maintenancePlans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,comments,documents,maintenancePlans);

@override
String toString() {
  return 'AssetCounts(comments: $comments, documents: $documents, maintenancePlans: $maintenancePlans)';
}


}

/// @nodoc
abstract mixin class $AssetCountsCopyWith<$Res>  {
  factory $AssetCountsCopyWith(AssetCounts value, $Res Function(AssetCounts) _then) = _$AssetCountsCopyWithImpl;
@useResult
$Res call({
 int comments, int documents, int maintenancePlans
});




}
/// @nodoc
class _$AssetCountsCopyWithImpl<$Res>
    implements $AssetCountsCopyWith<$Res> {
  _$AssetCountsCopyWithImpl(this._self, this._then);

  final AssetCounts _self;
  final $Res Function(AssetCounts) _then;

/// Create a copy of AssetCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? comments = null,Object? documents = null,Object? maintenancePlans = null,}) {
  return _then(_self.copyWith(
comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as int,maintenancePlans: null == maintenancePlans ? _self.maintenancePlans : maintenancePlans // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetCounts].
extension AssetCountsPatterns on AssetCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetCounts value)  $default,){
final _that = this;
switch (_that) {
case _AssetCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetCounts value)?  $default,){
final _that = this;
switch (_that) {
case _AssetCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int comments,  int documents,  int maintenancePlans)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetCounts() when $default != null:
return $default(_that.comments,_that.documents,_that.maintenancePlans);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int comments,  int documents,  int maintenancePlans)  $default,) {final _that = this;
switch (_that) {
case _AssetCounts():
return $default(_that.comments,_that.documents,_that.maintenancePlans);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int comments,  int documents,  int maintenancePlans)?  $default,) {final _that = this;
switch (_that) {
case _AssetCounts() when $default != null:
return $default(_that.comments,_that.documents,_that.maintenancePlans);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetCounts implements AssetCounts {
  const _AssetCounts({this.comments = 0, this.documents = 0, this.maintenancePlans = 0});
  factory _AssetCounts.fromJson(Map<String, dynamic> json) => _$AssetCountsFromJson(json);

@override@JsonKey() final  int comments;
@override@JsonKey() final  int documents;
@override@JsonKey() final  int maintenancePlans;

/// Create a copy of AssetCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetCountsCopyWith<_AssetCounts> get copyWith => __$AssetCountsCopyWithImpl<_AssetCounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetCountsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetCounts&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.documents, documents) || other.documents == documents)&&(identical(other.maintenancePlans, maintenancePlans) || other.maintenancePlans == maintenancePlans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,comments,documents,maintenancePlans);

@override
String toString() {
  return 'AssetCounts(comments: $comments, documents: $documents, maintenancePlans: $maintenancePlans)';
}


}

/// @nodoc
abstract mixin class _$AssetCountsCopyWith<$Res> implements $AssetCountsCopyWith<$Res> {
  factory _$AssetCountsCopyWith(_AssetCounts value, $Res Function(_AssetCounts) _then) = __$AssetCountsCopyWithImpl;
@override @useResult
$Res call({
 int comments, int documents, int maintenancePlans
});




}
/// @nodoc
class __$AssetCountsCopyWithImpl<$Res>
    implements _$AssetCountsCopyWith<$Res> {
  __$AssetCountsCopyWithImpl(this._self, this._then);

  final _AssetCounts _self;
  final $Res Function(_AssetCounts) _then;

/// Create a copy of AssetCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? comments = null,Object? documents = null,Object? maintenancePlans = null,}) {
  return _then(_AssetCounts(
comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as int,maintenancePlans: null == maintenancePlans ? _self.maintenancePlans : maintenancePlans // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Asset {

 int get id; String get code; String get name;@AssetStatusConverter() AssetStatus get status;@AssetTypeConverter() AssetType get assetType; String? get description; AssetCategory? get category; bool get requiresMaintenance; AssetLocation get location; NamedRef? get responsible; String? get brand; String? get model; String? get serial; String? get acquisitionDate;@DoubleConverter() double? get acquisitionValue; NamedRef? get supplier; String? get invoiceNumber; String? get warrantyUntil; String? get retiredAt; String? get retirementReason; String? get notes; NextMaintenance? get nextMaintenance; PendingTransfer? get pendingTransfer; Map<String, dynamic> get technicalProfile; AssetCounts? get counts; String? get createdAt;
/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetCopyWith<Asset> get copyWith => _$AssetCopyWithImpl<Asset>(this as Asset, _$identity);

  /// Serializes this Asset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Asset&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.requiresMaintenance, requiresMaintenance) || other.requiresMaintenance == requiresMaintenance)&&(identical(other.location, location) || other.location == location)&&(identical(other.responsible, responsible) || other.responsible == responsible)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.serial, serial) || other.serial == serial)&&(identical(other.acquisitionDate, acquisitionDate) || other.acquisitionDate == acquisitionDate)&&(identical(other.acquisitionValue, acquisitionValue) || other.acquisitionValue == acquisitionValue)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.warrantyUntil, warrantyUntil) || other.warrantyUntil == warrantyUntil)&&(identical(other.retiredAt, retiredAt) || other.retiredAt == retiredAt)&&(identical(other.retirementReason, retirementReason) || other.retirementReason == retirementReason)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.nextMaintenance, nextMaintenance) || other.nextMaintenance == nextMaintenance)&&(identical(other.pendingTransfer, pendingTransfer) || other.pendingTransfer == pendingTransfer)&&const DeepCollectionEquality().equals(other.technicalProfile, technicalProfile)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,code,name,status,assetType,description,category,requiresMaintenance,location,responsible,brand,model,serial,acquisitionDate,acquisitionValue,supplier,invoiceNumber,warrantyUntil,retiredAt,retirementReason,notes,nextMaintenance,pendingTransfer,const DeepCollectionEquality().hash(technicalProfile),counts,createdAt]);

@override
String toString() {
  return 'Asset(id: $id, code: $code, name: $name, status: $status, assetType: $assetType, description: $description, category: $category, requiresMaintenance: $requiresMaintenance, location: $location, responsible: $responsible, brand: $brand, model: $model, serial: $serial, acquisitionDate: $acquisitionDate, acquisitionValue: $acquisitionValue, supplier: $supplier, invoiceNumber: $invoiceNumber, warrantyUntil: $warrantyUntil, retiredAt: $retiredAt, retirementReason: $retirementReason, notes: $notes, nextMaintenance: $nextMaintenance, pendingTransfer: $pendingTransfer, technicalProfile: $technicalProfile, counts: $counts, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AssetCopyWith<$Res>  {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) _then) = _$AssetCopyWithImpl;
@useResult
$Res call({
 int id, String code, String name,@AssetStatusConverter() AssetStatus status,@AssetTypeConverter() AssetType assetType, String? description, AssetCategory? category, bool requiresMaintenance, AssetLocation location, NamedRef? responsible, String? brand, String? model, String? serial, String? acquisitionDate,@DoubleConverter() double? acquisitionValue, NamedRef? supplier, String? invoiceNumber, String? warrantyUntil, String? retiredAt, String? retirementReason, String? notes, NextMaintenance? nextMaintenance, PendingTransfer? pendingTransfer, Map<String, dynamic> technicalProfile, AssetCounts? counts, String? createdAt
});


$AssetCategoryCopyWith<$Res>? get category;$AssetLocationCopyWith<$Res> get location;$NamedRefCopyWith<$Res>? get responsible;$NamedRefCopyWith<$Res>? get supplier;$NextMaintenanceCopyWith<$Res>? get nextMaintenance;$PendingTransferCopyWith<$Res>? get pendingTransfer;$AssetCountsCopyWith<$Res>? get counts;

}
/// @nodoc
class _$AssetCopyWithImpl<$Res>
    implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._self, this._then);

  final Asset _self;
  final $Res Function(Asset) _then;

/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? status = null,Object? assetType = null,Object? description = freezed,Object? category = freezed,Object? requiresMaintenance = null,Object? location = null,Object? responsible = freezed,Object? brand = freezed,Object? model = freezed,Object? serial = freezed,Object? acquisitionDate = freezed,Object? acquisitionValue = freezed,Object? supplier = freezed,Object? invoiceNumber = freezed,Object? warrantyUntil = freezed,Object? retiredAt = freezed,Object? retirementReason = freezed,Object? notes = freezed,Object? nextMaintenance = freezed,Object? pendingTransfer = freezed,Object? technicalProfile = null,Object? counts = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AssetStatus,assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as AssetType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AssetCategory?,requiresMaintenance: null == requiresMaintenance ? _self.requiresMaintenance : requiresMaintenance // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as AssetLocation,responsible: freezed == responsible ? _self.responsible : responsible // ignore: cast_nullable_to_non_nullable
as NamedRef?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,serial: freezed == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as String?,acquisitionDate: freezed == acquisitionDate ? _self.acquisitionDate : acquisitionDate // ignore: cast_nullable_to_non_nullable
as String?,acquisitionValue: freezed == acquisitionValue ? _self.acquisitionValue : acquisitionValue // ignore: cast_nullable_to_non_nullable
as double?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,warrantyUntil: freezed == warrantyUntil ? _self.warrantyUntil : warrantyUntil // ignore: cast_nullable_to_non_nullable
as String?,retiredAt: freezed == retiredAt ? _self.retiredAt : retiredAt // ignore: cast_nullable_to_non_nullable
as String?,retirementReason: freezed == retirementReason ? _self.retirementReason : retirementReason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,nextMaintenance: freezed == nextMaintenance ? _self.nextMaintenance : nextMaintenance // ignore: cast_nullable_to_non_nullable
as NextMaintenance?,pendingTransfer: freezed == pendingTransfer ? _self.pendingTransfer : pendingTransfer // ignore: cast_nullable_to_non_nullable
as PendingTransfer?,technicalProfile: null == technicalProfile ? _self.technicalProfile : technicalProfile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,counts: freezed == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as AssetCounts?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetCategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $AssetCategoryCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetLocationCopyWith<$Res> get location {
  
  return $AssetLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get responsible {
    if (_self.responsible == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.responsible!, (value) {
    return _then(_self.copyWith(responsible: value));
  });
}/// Create a copy of Asset
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
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NextMaintenanceCopyWith<$Res>? get nextMaintenance {
    if (_self.nextMaintenance == null) {
    return null;
  }

  return $NextMaintenanceCopyWith<$Res>(_self.nextMaintenance!, (value) {
    return _then(_self.copyWith(nextMaintenance: value));
  });
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingTransferCopyWith<$Res>? get pendingTransfer {
    if (_self.pendingTransfer == null) {
    return null;
  }

  return $PendingTransferCopyWith<$Res>(_self.pendingTransfer!, (value) {
    return _then(_self.copyWith(pendingTransfer: value));
  });
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetCountsCopyWith<$Res>? get counts {
    if (_self.counts == null) {
    return null;
  }

  return $AssetCountsCopyWith<$Res>(_self.counts!, (value) {
    return _then(_self.copyWith(counts: value));
  });
}
}


/// Adds pattern-matching-related methods to [Asset].
extension AssetPatterns on Asset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Asset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Asset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Asset value)  $default,){
final _that = this;
switch (_that) {
case _Asset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Asset value)?  $default,){
final _that = this;
switch (_that) {
case _Asset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String name, @AssetStatusConverter()  AssetStatus status, @AssetTypeConverter()  AssetType assetType,  String? description,  AssetCategory? category,  bool requiresMaintenance,  AssetLocation location,  NamedRef? responsible,  String? brand,  String? model,  String? serial,  String? acquisitionDate, @DoubleConverter()  double? acquisitionValue,  NamedRef? supplier,  String? invoiceNumber,  String? warrantyUntil,  String? retiredAt,  String? retirementReason,  String? notes,  NextMaintenance? nextMaintenance,  PendingTransfer? pendingTransfer,  Map<String, dynamic> technicalProfile,  AssetCounts? counts,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Asset() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.status,_that.assetType,_that.description,_that.category,_that.requiresMaintenance,_that.location,_that.responsible,_that.brand,_that.model,_that.serial,_that.acquisitionDate,_that.acquisitionValue,_that.supplier,_that.invoiceNumber,_that.warrantyUntil,_that.retiredAt,_that.retirementReason,_that.notes,_that.nextMaintenance,_that.pendingTransfer,_that.technicalProfile,_that.counts,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String name, @AssetStatusConverter()  AssetStatus status, @AssetTypeConverter()  AssetType assetType,  String? description,  AssetCategory? category,  bool requiresMaintenance,  AssetLocation location,  NamedRef? responsible,  String? brand,  String? model,  String? serial,  String? acquisitionDate, @DoubleConverter()  double? acquisitionValue,  NamedRef? supplier,  String? invoiceNumber,  String? warrantyUntil,  String? retiredAt,  String? retirementReason,  String? notes,  NextMaintenance? nextMaintenance,  PendingTransfer? pendingTransfer,  Map<String, dynamic> technicalProfile,  AssetCounts? counts,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Asset():
return $default(_that.id,_that.code,_that.name,_that.status,_that.assetType,_that.description,_that.category,_that.requiresMaintenance,_that.location,_that.responsible,_that.brand,_that.model,_that.serial,_that.acquisitionDate,_that.acquisitionValue,_that.supplier,_that.invoiceNumber,_that.warrantyUntil,_that.retiredAt,_that.retirementReason,_that.notes,_that.nextMaintenance,_that.pendingTransfer,_that.technicalProfile,_that.counts,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String name, @AssetStatusConverter()  AssetStatus status, @AssetTypeConverter()  AssetType assetType,  String? description,  AssetCategory? category,  bool requiresMaintenance,  AssetLocation location,  NamedRef? responsible,  String? brand,  String? model,  String? serial,  String? acquisitionDate, @DoubleConverter()  double? acquisitionValue,  NamedRef? supplier,  String? invoiceNumber,  String? warrantyUntil,  String? retiredAt,  String? retirementReason,  String? notes,  NextMaintenance? nextMaintenance,  PendingTransfer? pendingTransfer,  Map<String, dynamic> technicalProfile,  AssetCounts? counts,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Asset() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.status,_that.assetType,_that.description,_that.category,_that.requiresMaintenance,_that.location,_that.responsible,_that.brand,_that.model,_that.serial,_that.acquisitionDate,_that.acquisitionValue,_that.supplier,_that.invoiceNumber,_that.warrantyUntil,_that.retiredAt,_that.retirementReason,_that.notes,_that.nextMaintenance,_that.pendingTransfer,_that.technicalProfile,_that.counts,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Asset extends Asset {
  const _Asset({required this.id, required this.code, required this.name, @AssetStatusConverter() this.status = AssetStatus.unknown, @AssetTypeConverter() this.assetType = AssetType.unknown, this.description, this.category, this.requiresMaintenance = false, this.location = const AssetLocation(), this.responsible, this.brand, this.model, this.serial, this.acquisitionDate, @DoubleConverter() this.acquisitionValue, this.supplier, this.invoiceNumber, this.warrantyUntil, this.retiredAt, this.retirementReason, this.notes, this.nextMaintenance, this.pendingTransfer, final  Map<String, dynamic> technicalProfile = const {}, this.counts, this.createdAt}): _technicalProfile = technicalProfile,super._();
  factory _Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

@override final  int id;
@override final  String code;
@override final  String name;
@override@JsonKey()@AssetStatusConverter() final  AssetStatus status;
@override@JsonKey()@AssetTypeConverter() final  AssetType assetType;
@override final  String? description;
@override final  AssetCategory? category;
@override@JsonKey() final  bool requiresMaintenance;
@override@JsonKey() final  AssetLocation location;
@override final  NamedRef? responsible;
@override final  String? brand;
@override final  String? model;
@override final  String? serial;
@override final  String? acquisitionDate;
@override@DoubleConverter() final  double? acquisitionValue;
@override final  NamedRef? supplier;
@override final  String? invoiceNumber;
@override final  String? warrantyUntil;
@override final  String? retiredAt;
@override final  String? retirementReason;
@override final  String? notes;
@override final  NextMaintenance? nextMaintenance;
@override final  PendingTransfer? pendingTransfer;
 final  Map<String, dynamic> _technicalProfile;
@override@JsonKey() Map<String, dynamic> get technicalProfile {
  if (_technicalProfile is EqualUnmodifiableMapView) return _technicalProfile;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_technicalProfile);
}

@override final  AssetCounts? counts;
@override final  String? createdAt;

/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetCopyWith<_Asset> get copyWith => __$AssetCopyWithImpl<_Asset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Asset&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.assetType, assetType) || other.assetType == assetType)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.requiresMaintenance, requiresMaintenance) || other.requiresMaintenance == requiresMaintenance)&&(identical(other.location, location) || other.location == location)&&(identical(other.responsible, responsible) || other.responsible == responsible)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.serial, serial) || other.serial == serial)&&(identical(other.acquisitionDate, acquisitionDate) || other.acquisitionDate == acquisitionDate)&&(identical(other.acquisitionValue, acquisitionValue) || other.acquisitionValue == acquisitionValue)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.warrantyUntil, warrantyUntil) || other.warrantyUntil == warrantyUntil)&&(identical(other.retiredAt, retiredAt) || other.retiredAt == retiredAt)&&(identical(other.retirementReason, retirementReason) || other.retirementReason == retirementReason)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.nextMaintenance, nextMaintenance) || other.nextMaintenance == nextMaintenance)&&(identical(other.pendingTransfer, pendingTransfer) || other.pendingTransfer == pendingTransfer)&&const DeepCollectionEquality().equals(other._technicalProfile, _technicalProfile)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,code,name,status,assetType,description,category,requiresMaintenance,location,responsible,brand,model,serial,acquisitionDate,acquisitionValue,supplier,invoiceNumber,warrantyUntil,retiredAt,retirementReason,notes,nextMaintenance,pendingTransfer,const DeepCollectionEquality().hash(_technicalProfile),counts,createdAt]);

@override
String toString() {
  return 'Asset(id: $id, code: $code, name: $name, status: $status, assetType: $assetType, description: $description, category: $category, requiresMaintenance: $requiresMaintenance, location: $location, responsible: $responsible, brand: $brand, model: $model, serial: $serial, acquisitionDate: $acquisitionDate, acquisitionValue: $acquisitionValue, supplier: $supplier, invoiceNumber: $invoiceNumber, warrantyUntil: $warrantyUntil, retiredAt: $retiredAt, retirementReason: $retirementReason, notes: $notes, nextMaintenance: $nextMaintenance, pendingTransfer: $pendingTransfer, technicalProfile: $technicalProfile, counts: $counts, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AssetCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$AssetCopyWith(_Asset value, $Res Function(_Asset) _then) = __$AssetCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String name,@AssetStatusConverter() AssetStatus status,@AssetTypeConverter() AssetType assetType, String? description, AssetCategory? category, bool requiresMaintenance, AssetLocation location, NamedRef? responsible, String? brand, String? model, String? serial, String? acquisitionDate,@DoubleConverter() double? acquisitionValue, NamedRef? supplier, String? invoiceNumber, String? warrantyUntil, String? retiredAt, String? retirementReason, String? notes, NextMaintenance? nextMaintenance, PendingTransfer? pendingTransfer, Map<String, dynamic> technicalProfile, AssetCounts? counts, String? createdAt
});


@override $AssetCategoryCopyWith<$Res>? get category;@override $AssetLocationCopyWith<$Res> get location;@override $NamedRefCopyWith<$Res>? get responsible;@override $NamedRefCopyWith<$Res>? get supplier;@override $NextMaintenanceCopyWith<$Res>? get nextMaintenance;@override $PendingTransferCopyWith<$Res>? get pendingTransfer;@override $AssetCountsCopyWith<$Res>? get counts;

}
/// @nodoc
class __$AssetCopyWithImpl<$Res>
    implements _$AssetCopyWith<$Res> {
  __$AssetCopyWithImpl(this._self, this._then);

  final _Asset _self;
  final $Res Function(_Asset) _then;

/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? status = null,Object? assetType = null,Object? description = freezed,Object? category = freezed,Object? requiresMaintenance = null,Object? location = null,Object? responsible = freezed,Object? brand = freezed,Object? model = freezed,Object? serial = freezed,Object? acquisitionDate = freezed,Object? acquisitionValue = freezed,Object? supplier = freezed,Object? invoiceNumber = freezed,Object? warrantyUntil = freezed,Object? retiredAt = freezed,Object? retirementReason = freezed,Object? notes = freezed,Object? nextMaintenance = freezed,Object? pendingTransfer = freezed,Object? technicalProfile = null,Object? counts = freezed,Object? createdAt = freezed,}) {
  return _then(_Asset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AssetStatus,assetType: null == assetType ? _self.assetType : assetType // ignore: cast_nullable_to_non_nullable
as AssetType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as AssetCategory?,requiresMaintenance: null == requiresMaintenance ? _self.requiresMaintenance : requiresMaintenance // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as AssetLocation,responsible: freezed == responsible ? _self.responsible : responsible // ignore: cast_nullable_to_non_nullable
as NamedRef?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,serial: freezed == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as String?,acquisitionDate: freezed == acquisitionDate ? _self.acquisitionDate : acquisitionDate // ignore: cast_nullable_to_non_nullable
as String?,acquisitionValue: freezed == acquisitionValue ? _self.acquisitionValue : acquisitionValue // ignore: cast_nullable_to_non_nullable
as double?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,warrantyUntil: freezed == warrantyUntil ? _self.warrantyUntil : warrantyUntil // ignore: cast_nullable_to_non_nullable
as String?,retiredAt: freezed == retiredAt ? _self.retiredAt : retiredAt // ignore: cast_nullable_to_non_nullable
as String?,retirementReason: freezed == retirementReason ? _self.retirementReason : retirementReason // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,nextMaintenance: freezed == nextMaintenance ? _self.nextMaintenance : nextMaintenance // ignore: cast_nullable_to_non_nullable
as NextMaintenance?,pendingTransfer: freezed == pendingTransfer ? _self.pendingTransfer : pendingTransfer // ignore: cast_nullable_to_non_nullable
as PendingTransfer?,technicalProfile: null == technicalProfile ? _self._technicalProfile : technicalProfile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,counts: freezed == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as AssetCounts?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetCategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $AssetCategoryCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetLocationCopyWith<$Res> get location {
  
  return $AssetLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get responsible {
    if (_self.responsible == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.responsible!, (value) {
    return _then(_self.copyWith(responsible: value));
  });
}/// Create a copy of Asset
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
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NextMaintenanceCopyWith<$Res>? get nextMaintenance {
    if (_self.nextMaintenance == null) {
    return null;
  }

  return $NextMaintenanceCopyWith<$Res>(_self.nextMaintenance!, (value) {
    return _then(_self.copyWith(nextMaintenance: value));
  });
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PendingTransferCopyWith<$Res>? get pendingTransfer {
    if (_self.pendingTransfer == null) {
    return null;
  }

  return $PendingTransferCopyWith<$Res>(_self.pendingTransfer!, (value) {
    return _then(_self.copyWith(pendingTransfer: value));
  });
}/// Create a copy of Asset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetCountsCopyWith<$Res>? get counts {
    if (_self.counts == null) {
    return null;
  }

  return $AssetCountsCopyWith<$Res>(_self.counts!, (value) {
    return _then(_self.copyWith(counts: value));
  });
}
}

// dart format on
