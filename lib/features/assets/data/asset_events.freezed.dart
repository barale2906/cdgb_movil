// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssetComment {

 int get id; String get comment; NamedRef? get user; String? get createdAt;
/// Create a copy of AssetComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetCommentCopyWith<AssetComment> get copyWith => _$AssetCommentCopyWithImpl<AssetComment>(this as AssetComment, _$identity);

  /// Serializes this AssetComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetComment&&(identical(other.id, id) || other.id == id)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.user, user) || other.user == user)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,comment,user,createdAt);

@override
String toString() {
  return 'AssetComment(id: $id, comment: $comment, user: $user, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AssetCommentCopyWith<$Res>  {
  factory $AssetCommentCopyWith(AssetComment value, $Res Function(AssetComment) _then) = _$AssetCommentCopyWithImpl;
@useResult
$Res call({
 int id, String comment, NamedRef? user, String? createdAt
});


$NamedRefCopyWith<$Res>? get user;

}
/// @nodoc
class _$AssetCommentCopyWithImpl<$Res>
    implements $AssetCommentCopyWith<$Res> {
  _$AssetCommentCopyWithImpl(this._self, this._then);

  final AssetComment _self;
  final $Res Function(AssetComment) _then;

/// Create a copy of AssetComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? comment = null,Object? user = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as NamedRef?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AssetComment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AssetComment].
extension AssetCommentPatterns on AssetComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetComment value)  $default,){
final _that = this;
switch (_that) {
case _AssetComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetComment value)?  $default,){
final _that = this;
switch (_that) {
case _AssetComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String comment,  NamedRef? user,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetComment() when $default != null:
return $default(_that.id,_that.comment,_that.user,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String comment,  NamedRef? user,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AssetComment():
return $default(_that.id,_that.comment,_that.user,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String comment,  NamedRef? user,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AssetComment() when $default != null:
return $default(_that.id,_that.comment,_that.user,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetComment implements AssetComment {
  const _AssetComment({required this.id, required this.comment, this.user, this.createdAt});
  factory _AssetComment.fromJson(Map<String, dynamic> json) => _$AssetCommentFromJson(json);

@override final  int id;
@override final  String comment;
@override final  NamedRef? user;
@override final  String? createdAt;

/// Create a copy of AssetComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetCommentCopyWith<_AssetComment> get copyWith => __$AssetCommentCopyWithImpl<_AssetComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetCommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetComment&&(identical(other.id, id) || other.id == id)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.user, user) || other.user == user)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,comment,user,createdAt);

@override
String toString() {
  return 'AssetComment(id: $id, comment: $comment, user: $user, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AssetCommentCopyWith<$Res> implements $AssetCommentCopyWith<$Res> {
  factory _$AssetCommentCopyWith(_AssetComment value, $Res Function(_AssetComment) _then) = __$AssetCommentCopyWithImpl;
@override @useResult
$Res call({
 int id, String comment, NamedRef? user, String? createdAt
});


@override $NamedRefCopyWith<$Res>? get user;

}
/// @nodoc
class __$AssetCommentCopyWithImpl<$Res>
    implements _$AssetCommentCopyWith<$Res> {
  __$AssetCommentCopyWithImpl(this._self, this._then);

  final _AssetComment _self;
  final $Res Function(_AssetComment) _then;

/// Create a copy of AssetComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? comment = null,Object? user = freezed,Object? createdAt = freezed,}) {
  return _then(_AssetComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as NamedRef?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AssetComment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$AssetMovement {

 int get id; String? get type; String? get typeLabel; String? get fromStatus; String? get toStatus; String? get description; int? get transferId; int? get maintenanceId; NamedRef? get user; String? get createdAt;
/// Create a copy of AssetMovement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetMovementCopyWith<AssetMovement> get copyWith => _$AssetMovementCopyWithImpl<AssetMovement>(this as AssetMovement, _$identity);

  /// Serializes this AssetMovement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetMovement&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.fromStatus, fromStatus) || other.fromStatus == fromStatus)&&(identical(other.toStatus, toStatus) || other.toStatus == toStatus)&&(identical(other.description, description) || other.description == description)&&(identical(other.transferId, transferId) || other.transferId == transferId)&&(identical(other.maintenanceId, maintenanceId) || other.maintenanceId == maintenanceId)&&(identical(other.user, user) || other.user == user)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,typeLabel,fromStatus,toStatus,description,transferId,maintenanceId,user,createdAt);

@override
String toString() {
  return 'AssetMovement(id: $id, type: $type, typeLabel: $typeLabel, fromStatus: $fromStatus, toStatus: $toStatus, description: $description, transferId: $transferId, maintenanceId: $maintenanceId, user: $user, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AssetMovementCopyWith<$Res>  {
  factory $AssetMovementCopyWith(AssetMovement value, $Res Function(AssetMovement) _then) = _$AssetMovementCopyWithImpl;
@useResult
$Res call({
 int id, String? type, String? typeLabel, String? fromStatus, String? toStatus, String? description, int? transferId, int? maintenanceId, NamedRef? user, String? createdAt
});


$NamedRefCopyWith<$Res>? get user;

}
/// @nodoc
class _$AssetMovementCopyWithImpl<$Res>
    implements $AssetMovementCopyWith<$Res> {
  _$AssetMovementCopyWithImpl(this._self, this._then);

  final AssetMovement _self;
  final $Res Function(AssetMovement) _then;

/// Create a copy of AssetMovement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = freezed,Object? fromStatus = freezed,Object? toStatus = freezed,Object? description = freezed,Object? transferId = freezed,Object? maintenanceId = freezed,Object? user = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,fromStatus: freezed == fromStatus ? _self.fromStatus : fromStatus // ignore: cast_nullable_to_non_nullable
as String?,toStatus: freezed == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,transferId: freezed == transferId ? _self.transferId : transferId // ignore: cast_nullable_to_non_nullable
as int?,maintenanceId: freezed == maintenanceId ? _self.maintenanceId : maintenanceId // ignore: cast_nullable_to_non_nullable
as int?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as NamedRef?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AssetMovement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AssetMovement].
extension AssetMovementPatterns on AssetMovement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetMovement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetMovement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetMovement value)  $default,){
final _that = this;
switch (_that) {
case _AssetMovement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetMovement value)?  $default,){
final _that = this;
switch (_that) {
case _AssetMovement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? type,  String? typeLabel,  String? fromStatus,  String? toStatus,  String? description,  int? transferId,  int? maintenanceId,  NamedRef? user,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetMovement() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel,_that.fromStatus,_that.toStatus,_that.description,_that.transferId,_that.maintenanceId,_that.user,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? type,  String? typeLabel,  String? fromStatus,  String? toStatus,  String? description,  int? transferId,  int? maintenanceId,  NamedRef? user,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AssetMovement():
return $default(_that.id,_that.type,_that.typeLabel,_that.fromStatus,_that.toStatus,_that.description,_that.transferId,_that.maintenanceId,_that.user,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? type,  String? typeLabel,  String? fromStatus,  String? toStatus,  String? description,  int? transferId,  int? maintenanceId,  NamedRef? user,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AssetMovement() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel,_that.fromStatus,_that.toStatus,_that.description,_that.transferId,_that.maintenanceId,_that.user,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetMovement implements AssetMovement {
  const _AssetMovement({required this.id, this.type, this.typeLabel, this.fromStatus, this.toStatus, this.description, this.transferId, this.maintenanceId, this.user, this.createdAt});
  factory _AssetMovement.fromJson(Map<String, dynamic> json) => _$AssetMovementFromJson(json);

@override final  int id;
@override final  String? type;
@override final  String? typeLabel;
@override final  String? fromStatus;
@override final  String? toStatus;
@override final  String? description;
@override final  int? transferId;
@override final  int? maintenanceId;
@override final  NamedRef? user;
@override final  String? createdAt;

/// Create a copy of AssetMovement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetMovementCopyWith<_AssetMovement> get copyWith => __$AssetMovementCopyWithImpl<_AssetMovement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetMovementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetMovement&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.fromStatus, fromStatus) || other.fromStatus == fromStatus)&&(identical(other.toStatus, toStatus) || other.toStatus == toStatus)&&(identical(other.description, description) || other.description == description)&&(identical(other.transferId, transferId) || other.transferId == transferId)&&(identical(other.maintenanceId, maintenanceId) || other.maintenanceId == maintenanceId)&&(identical(other.user, user) || other.user == user)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,typeLabel,fromStatus,toStatus,description,transferId,maintenanceId,user,createdAt);

@override
String toString() {
  return 'AssetMovement(id: $id, type: $type, typeLabel: $typeLabel, fromStatus: $fromStatus, toStatus: $toStatus, description: $description, transferId: $transferId, maintenanceId: $maintenanceId, user: $user, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AssetMovementCopyWith<$Res> implements $AssetMovementCopyWith<$Res> {
  factory _$AssetMovementCopyWith(_AssetMovement value, $Res Function(_AssetMovement) _then) = __$AssetMovementCopyWithImpl;
@override @useResult
$Res call({
 int id, String? type, String? typeLabel, String? fromStatus, String? toStatus, String? description, int? transferId, int? maintenanceId, NamedRef? user, String? createdAt
});


@override $NamedRefCopyWith<$Res>? get user;

}
/// @nodoc
class __$AssetMovementCopyWithImpl<$Res>
    implements _$AssetMovementCopyWith<$Res> {
  __$AssetMovementCopyWithImpl(this._self, this._then);

  final _AssetMovement _self;
  final $Res Function(_AssetMovement) _then;

/// Create a copy of AssetMovement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = freezed,Object? fromStatus = freezed,Object? toStatus = freezed,Object? description = freezed,Object? transferId = freezed,Object? maintenanceId = freezed,Object? user = freezed,Object? createdAt = freezed,}) {
  return _then(_AssetMovement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,typeLabel: freezed == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String?,fromStatus: freezed == fromStatus ? _self.fromStatus : fromStatus // ignore: cast_nullable_to_non_nullable
as String?,toStatus: freezed == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,transferId: freezed == transferId ? _self.transferId : transferId // ignore: cast_nullable_to_non_nullable
as int?,maintenanceId: freezed == maintenanceId ? _self.maintenanceId : maintenanceId // ignore: cast_nullable_to_non_nullable
as int?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as NamedRef?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AssetMovement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$LocationRecord {

 int get id; String? get location; bool get isOffPremises; bool get isCurrent; String? get fromDate; String? get toDate; String? get transferLabel; NamedRef? get assignedBy;
/// Create a copy of LocationRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationRecordCopyWith<LocationRecord> get copyWith => _$LocationRecordCopyWithImpl<LocationRecord>(this as LocationRecord, _$identity);

  /// Serializes this LocationRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.location, location) || other.location == location)&&(identical(other.isOffPremises, isOffPremises) || other.isOffPremises == isOffPremises)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.transferLabel, transferLabel) || other.transferLabel == transferLabel)&&(identical(other.assignedBy, assignedBy) || other.assignedBy == assignedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,location,isOffPremises,isCurrent,fromDate,toDate,transferLabel,assignedBy);

@override
String toString() {
  return 'LocationRecord(id: $id, location: $location, isOffPremises: $isOffPremises, isCurrent: $isCurrent, fromDate: $fromDate, toDate: $toDate, transferLabel: $transferLabel, assignedBy: $assignedBy)';
}


}

/// @nodoc
abstract mixin class $LocationRecordCopyWith<$Res>  {
  factory $LocationRecordCopyWith(LocationRecord value, $Res Function(LocationRecord) _then) = _$LocationRecordCopyWithImpl;
@useResult
$Res call({
 int id, String? location, bool isOffPremises, bool isCurrent, String? fromDate, String? toDate, String? transferLabel, NamedRef? assignedBy
});


$NamedRefCopyWith<$Res>? get assignedBy;

}
/// @nodoc
class _$LocationRecordCopyWithImpl<$Res>
    implements $LocationRecordCopyWith<$Res> {
  _$LocationRecordCopyWithImpl(this._self, this._then);

  final LocationRecord _self;
  final $Res Function(LocationRecord) _then;

/// Create a copy of LocationRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? location = freezed,Object? isOffPremises = null,Object? isCurrent = null,Object? fromDate = freezed,Object? toDate = freezed,Object? transferLabel = freezed,Object? assignedBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,isOffPremises: null == isOffPremises ? _self.isOffPremises : isOffPremises // ignore: cast_nullable_to_non_nullable
as bool,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String?,transferLabel: freezed == transferLabel ? _self.transferLabel : transferLabel // ignore: cast_nullable_to_non_nullable
as String?,assignedBy: freezed == assignedBy ? _self.assignedBy : assignedBy // ignore: cast_nullable_to_non_nullable
as NamedRef?,
  ));
}
/// Create a copy of LocationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get assignedBy {
    if (_self.assignedBy == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.assignedBy!, (value) {
    return _then(_self.copyWith(assignedBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationRecord].
extension LocationRecordPatterns on LocationRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationRecord value)  $default,){
final _that = this;
switch (_that) {
case _LocationRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationRecord value)?  $default,){
final _that = this;
switch (_that) {
case _LocationRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? location,  bool isOffPremises,  bool isCurrent,  String? fromDate,  String? toDate,  String? transferLabel,  NamedRef? assignedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationRecord() when $default != null:
return $default(_that.id,_that.location,_that.isOffPremises,_that.isCurrent,_that.fromDate,_that.toDate,_that.transferLabel,_that.assignedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? location,  bool isOffPremises,  bool isCurrent,  String? fromDate,  String? toDate,  String? transferLabel,  NamedRef? assignedBy)  $default,) {final _that = this;
switch (_that) {
case _LocationRecord():
return $default(_that.id,_that.location,_that.isOffPremises,_that.isCurrent,_that.fromDate,_that.toDate,_that.transferLabel,_that.assignedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? location,  bool isOffPremises,  bool isCurrent,  String? fromDate,  String? toDate,  String? transferLabel,  NamedRef? assignedBy)?  $default,) {final _that = this;
switch (_that) {
case _LocationRecord() when $default != null:
return $default(_that.id,_that.location,_that.isOffPremises,_that.isCurrent,_that.fromDate,_that.toDate,_that.transferLabel,_that.assignedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationRecord implements LocationRecord {
  const _LocationRecord({required this.id, this.location, this.isOffPremises = false, this.isCurrent = false, this.fromDate, this.toDate, this.transferLabel, this.assignedBy});
  factory _LocationRecord.fromJson(Map<String, dynamic> json) => _$LocationRecordFromJson(json);

@override final  int id;
@override final  String? location;
@override@JsonKey() final  bool isOffPremises;
@override@JsonKey() final  bool isCurrent;
@override final  String? fromDate;
@override final  String? toDate;
@override final  String? transferLabel;
@override final  NamedRef? assignedBy;

/// Create a copy of LocationRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationRecordCopyWith<_LocationRecord> get copyWith => __$LocationRecordCopyWithImpl<_LocationRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.location, location) || other.location == location)&&(identical(other.isOffPremises, isOffPremises) || other.isOffPremises == isOffPremises)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.transferLabel, transferLabel) || other.transferLabel == transferLabel)&&(identical(other.assignedBy, assignedBy) || other.assignedBy == assignedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,location,isOffPremises,isCurrent,fromDate,toDate,transferLabel,assignedBy);

@override
String toString() {
  return 'LocationRecord(id: $id, location: $location, isOffPremises: $isOffPremises, isCurrent: $isCurrent, fromDate: $fromDate, toDate: $toDate, transferLabel: $transferLabel, assignedBy: $assignedBy)';
}


}

/// @nodoc
abstract mixin class _$LocationRecordCopyWith<$Res> implements $LocationRecordCopyWith<$Res> {
  factory _$LocationRecordCopyWith(_LocationRecord value, $Res Function(_LocationRecord) _then) = __$LocationRecordCopyWithImpl;
@override @useResult
$Res call({
 int id, String? location, bool isOffPremises, bool isCurrent, String? fromDate, String? toDate, String? transferLabel, NamedRef? assignedBy
});


@override $NamedRefCopyWith<$Res>? get assignedBy;

}
/// @nodoc
class __$LocationRecordCopyWithImpl<$Res>
    implements _$LocationRecordCopyWith<$Res> {
  __$LocationRecordCopyWithImpl(this._self, this._then);

  final _LocationRecord _self;
  final $Res Function(_LocationRecord) _then;

/// Create a copy of LocationRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? location = freezed,Object? isOffPremises = null,Object? isCurrent = null,Object? fromDate = freezed,Object? toDate = freezed,Object? transferLabel = freezed,Object? assignedBy = freezed,}) {
  return _then(_LocationRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,isOffPremises: null == isOffPremises ? _self.isOffPremises : isOffPremises // ignore: cast_nullable_to_non_nullable
as bool,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String?,transferLabel: freezed == transferLabel ? _self.transferLabel : transferLabel // ignore: cast_nullable_to_non_nullable
as String?,assignedBy: freezed == assignedBy ? _self.assignedBy : assignedBy // ignore: cast_nullable_to_non_nullable
as NamedRef?,
  ));
}

/// Create a copy of LocationRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get assignedBy {
    if (_self.assignedBy == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.assignedBy!, (value) {
    return _then(_self.copyWith(assignedBy: value));
  });
}
}

// dart format on
