// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuditLog {

 int get id; String get action; int? get userId; String? get userName; String? get auditableType;@JsonKey(fromJson: _idToString) String? get auditableId;@JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? get oldValues;@JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? get newValues; String? get ipAddress; String? get userAgent; String? get createdAt;
/// Create a copy of AuditLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogCopyWith<AuditLog> get copyWith => _$AuditLogCopyWithImpl<AuditLog>(this as AuditLog, _$identity);

  /// Serializes this AuditLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLog&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.auditableType, auditableType) || other.auditableType == auditableType)&&(identical(other.auditableId, auditableId) || other.auditableId == auditableId)&&const DeepCollectionEquality().equals(other.oldValues, oldValues)&&const DeepCollectionEquality().equals(other.newValues, newValues)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,action,userId,userName,auditableType,auditableId,const DeepCollectionEquality().hash(oldValues),const DeepCollectionEquality().hash(newValues),ipAddress,userAgent,createdAt);

@override
String toString() {
  return 'AuditLog(id: $id, action: $action, userId: $userId, userName: $userName, auditableType: $auditableType, auditableId: $auditableId, oldValues: $oldValues, newValues: $newValues, ipAddress: $ipAddress, userAgent: $userAgent, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AuditLogCopyWith<$Res>  {
  factory $AuditLogCopyWith(AuditLog value, $Res Function(AuditLog) _then) = _$AuditLogCopyWithImpl;
@useResult
$Res call({
 int id, String action, int? userId, String? userName, String? auditableType,@JsonKey(fromJson: _idToString) String? auditableId,@JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? oldValues,@JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? newValues, String? ipAddress, String? userAgent, String? createdAt
});




}
/// @nodoc
class _$AuditLogCopyWithImpl<$Res>
    implements $AuditLogCopyWith<$Res> {
  _$AuditLogCopyWithImpl(this._self, this._then);

  final AuditLog _self;
  final $Res Function(AuditLog) _then;

/// Create a copy of AuditLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? action = null,Object? userId = freezed,Object? userName = freezed,Object? auditableType = freezed,Object? auditableId = freezed,Object? oldValues = freezed,Object? newValues = freezed,Object? ipAddress = freezed,Object? userAgent = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,auditableType: freezed == auditableType ? _self.auditableType : auditableType // ignore: cast_nullable_to_non_nullable
as String?,auditableId: freezed == auditableId ? _self.auditableId : auditableId // ignore: cast_nullable_to_non_nullable
as String?,oldValues: freezed == oldValues ? _self.oldValues : oldValues // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,newValues: freezed == newValues ? _self.newValues : newValues // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLog].
extension AuditLogPatterns on AuditLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLog value)  $default,){
final _that = this;
switch (_that) {
case _AuditLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLog value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String action,  int? userId,  String? userName,  String? auditableType, @JsonKey(fromJson: _idToString)  String? auditableId, @JsonKey(fromJson: _valuesOrNull)  Map<String, dynamic>? oldValues, @JsonKey(fromJson: _valuesOrNull)  Map<String, dynamic>? newValues,  String? ipAddress,  String? userAgent,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLog() when $default != null:
return $default(_that.id,_that.action,_that.userId,_that.userName,_that.auditableType,_that.auditableId,_that.oldValues,_that.newValues,_that.ipAddress,_that.userAgent,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String action,  int? userId,  String? userName,  String? auditableType, @JsonKey(fromJson: _idToString)  String? auditableId, @JsonKey(fromJson: _valuesOrNull)  Map<String, dynamic>? oldValues, @JsonKey(fromJson: _valuesOrNull)  Map<String, dynamic>? newValues,  String? ipAddress,  String? userAgent,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AuditLog():
return $default(_that.id,_that.action,_that.userId,_that.userName,_that.auditableType,_that.auditableId,_that.oldValues,_that.newValues,_that.ipAddress,_that.userAgent,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String action,  int? userId,  String? userName,  String? auditableType, @JsonKey(fromJson: _idToString)  String? auditableId, @JsonKey(fromJson: _valuesOrNull)  Map<String, dynamic>? oldValues, @JsonKey(fromJson: _valuesOrNull)  Map<String, dynamic>? newValues,  String? ipAddress,  String? userAgent,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AuditLog() when $default != null:
return $default(_that.id,_that.action,_that.userId,_that.userName,_that.auditableType,_that.auditableId,_that.oldValues,_that.newValues,_that.ipAddress,_that.userAgent,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditLog implements AuditLog {
  const _AuditLog({required this.id, required this.action, this.userId, this.userName, this.auditableType, @JsonKey(fromJson: _idToString) this.auditableId, @JsonKey(fromJson: _valuesOrNull) final  Map<String, dynamic>? oldValues, @JsonKey(fromJson: _valuesOrNull) final  Map<String, dynamic>? newValues, this.ipAddress, this.userAgent, this.createdAt}): _oldValues = oldValues,_newValues = newValues;
  factory _AuditLog.fromJson(Map<String, dynamic> json) => _$AuditLogFromJson(json);

@override final  int id;
@override final  String action;
@override final  int? userId;
@override final  String? userName;
@override final  String? auditableType;
@override@JsonKey(fromJson: _idToString) final  String? auditableId;
 final  Map<String, dynamic>? _oldValues;
@override@JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? get oldValues {
  final value = _oldValues;
  if (value == null) return null;
  if (_oldValues is EqualUnmodifiableMapView) return _oldValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _newValues;
@override@JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? get newValues {
  final value = _newValues;
  if (value == null) return null;
  if (_newValues is EqualUnmodifiableMapView) return _newValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? ipAddress;
@override final  String? userAgent;
@override final  String? createdAt;

/// Create a copy of AuditLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogCopyWith<_AuditLog> get copyWith => __$AuditLogCopyWithImpl<_AuditLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLog&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.auditableType, auditableType) || other.auditableType == auditableType)&&(identical(other.auditableId, auditableId) || other.auditableId == auditableId)&&const DeepCollectionEquality().equals(other._oldValues, _oldValues)&&const DeepCollectionEquality().equals(other._newValues, _newValues)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,action,userId,userName,auditableType,auditableId,const DeepCollectionEquality().hash(_oldValues),const DeepCollectionEquality().hash(_newValues),ipAddress,userAgent,createdAt);

@override
String toString() {
  return 'AuditLog(id: $id, action: $action, userId: $userId, userName: $userName, auditableType: $auditableType, auditableId: $auditableId, oldValues: $oldValues, newValues: $newValues, ipAddress: $ipAddress, userAgent: $userAgent, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AuditLogCopyWith<$Res> implements $AuditLogCopyWith<$Res> {
  factory _$AuditLogCopyWith(_AuditLog value, $Res Function(_AuditLog) _then) = __$AuditLogCopyWithImpl;
@override @useResult
$Res call({
 int id, String action, int? userId, String? userName, String? auditableType,@JsonKey(fromJson: _idToString) String? auditableId,@JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? oldValues,@JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? newValues, String? ipAddress, String? userAgent, String? createdAt
});




}
/// @nodoc
class __$AuditLogCopyWithImpl<$Res>
    implements _$AuditLogCopyWith<$Res> {
  __$AuditLogCopyWithImpl(this._self, this._then);

  final _AuditLog _self;
  final $Res Function(_AuditLog) _then;

/// Create a copy of AuditLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? action = null,Object? userId = freezed,Object? userName = freezed,Object? auditableType = freezed,Object? auditableId = freezed,Object? oldValues = freezed,Object? newValues = freezed,Object? ipAddress = freezed,Object? userAgent = freezed,Object? createdAt = freezed,}) {
  return _then(_AuditLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,auditableType: freezed == auditableType ? _self.auditableType : auditableType // ignore: cast_nullable_to_non_nullable
as String?,auditableId: freezed == auditableId ? _self.auditableId : auditableId // ignore: cast_nullable_to_non_nullable
as String?,oldValues: freezed == oldValues ? _self._oldValues : oldValues // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,newValues: freezed == newValues ? _self._newValues : newValues // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
