// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monitoring_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SensorZone {

 int get id; String? get name; String? get code;@DoubleConverter() double? get tempMin;@DoubleConverter() double? get tempMax;@DoubleConverter() double? get humidityMin;@DoubleConverter() double? get humidityMax; String? get warehouseName;
/// Create a copy of SensorZone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorZoneCopyWith<SensorZone> get copyWith => _$SensorZoneCopyWithImpl<SensorZone>(this as SensorZone, _$identity);

  /// Serializes this SensorZone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SensorZone&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.tempMin, tempMin) || other.tempMin == tempMin)&&(identical(other.tempMax, tempMax) || other.tempMax == tempMax)&&(identical(other.humidityMin, humidityMin) || other.humidityMin == humidityMin)&&(identical(other.humidityMax, humidityMax) || other.humidityMax == humidityMax)&&(identical(other.warehouseName, warehouseName) || other.warehouseName == warehouseName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,tempMin,tempMax,humidityMin,humidityMax,warehouseName);

@override
String toString() {
  return 'SensorZone(id: $id, name: $name, code: $code, tempMin: $tempMin, tempMax: $tempMax, humidityMin: $humidityMin, humidityMax: $humidityMax, warehouseName: $warehouseName)';
}


}

/// @nodoc
abstract mixin class $SensorZoneCopyWith<$Res>  {
  factory $SensorZoneCopyWith(SensorZone value, $Res Function(SensorZone) _then) = _$SensorZoneCopyWithImpl;
@useResult
$Res call({
 int id, String? name, String? code,@DoubleConverter() double? tempMin,@DoubleConverter() double? tempMax,@DoubleConverter() double? humidityMin,@DoubleConverter() double? humidityMax, String? warehouseName
});




}
/// @nodoc
class _$SensorZoneCopyWithImpl<$Res>
    implements $SensorZoneCopyWith<$Res> {
  _$SensorZoneCopyWithImpl(this._self, this._then);

  final SensorZone _self;
  final $Res Function(SensorZone) _then;

/// Create a copy of SensorZone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? code = freezed,Object? tempMin = freezed,Object? tempMax = freezed,Object? humidityMin = freezed,Object? humidityMax = freezed,Object? warehouseName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,tempMin: freezed == tempMin ? _self.tempMin : tempMin // ignore: cast_nullable_to_non_nullable
as double?,tempMax: freezed == tempMax ? _self.tempMax : tempMax // ignore: cast_nullable_to_non_nullable
as double?,humidityMin: freezed == humidityMin ? _self.humidityMin : humidityMin // ignore: cast_nullable_to_non_nullable
as double?,humidityMax: freezed == humidityMax ? _self.humidityMax : humidityMax // ignore: cast_nullable_to_non_nullable
as double?,warehouseName: freezed == warehouseName ? _self.warehouseName : warehouseName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SensorZone].
extension SensorZonePatterns on SensorZone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SensorZone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SensorZone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SensorZone value)  $default,){
final _that = this;
switch (_that) {
case _SensorZone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SensorZone value)?  $default,){
final _that = this;
switch (_that) {
case _SensorZone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  String? code, @DoubleConverter()  double? tempMin, @DoubleConverter()  double? tempMax, @DoubleConverter()  double? humidityMin, @DoubleConverter()  double? humidityMax,  String? warehouseName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SensorZone() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.tempMin,_that.tempMax,_that.humidityMin,_that.humidityMax,_that.warehouseName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  String? code, @DoubleConverter()  double? tempMin, @DoubleConverter()  double? tempMax, @DoubleConverter()  double? humidityMin, @DoubleConverter()  double? humidityMax,  String? warehouseName)  $default,) {final _that = this;
switch (_that) {
case _SensorZone():
return $default(_that.id,_that.name,_that.code,_that.tempMin,_that.tempMax,_that.humidityMin,_that.humidityMax,_that.warehouseName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  String? code, @DoubleConverter()  double? tempMin, @DoubleConverter()  double? tempMax, @DoubleConverter()  double? humidityMin, @DoubleConverter()  double? humidityMax,  String? warehouseName)?  $default,) {final _that = this;
switch (_that) {
case _SensorZone() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.tempMin,_that.tempMax,_that.humidityMin,_that.humidityMax,_that.warehouseName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SensorZone implements SensorZone {
  const _SensorZone({required this.id, this.name, this.code, @DoubleConverter() this.tempMin, @DoubleConverter() this.tempMax, @DoubleConverter() this.humidityMin, @DoubleConverter() this.humidityMax, this.warehouseName});
  factory _SensorZone.fromJson(Map<String, dynamic> json) => _$SensorZoneFromJson(json);

@override final  int id;
@override final  String? name;
@override final  String? code;
@override@DoubleConverter() final  double? tempMin;
@override@DoubleConverter() final  double? tempMax;
@override@DoubleConverter() final  double? humidityMin;
@override@DoubleConverter() final  double? humidityMax;
@override final  String? warehouseName;

/// Create a copy of SensorZone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorZoneCopyWith<_SensorZone> get copyWith => __$SensorZoneCopyWithImpl<_SensorZone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SensorZoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SensorZone&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.tempMin, tempMin) || other.tempMin == tempMin)&&(identical(other.tempMax, tempMax) || other.tempMax == tempMax)&&(identical(other.humidityMin, humidityMin) || other.humidityMin == humidityMin)&&(identical(other.humidityMax, humidityMax) || other.humidityMax == humidityMax)&&(identical(other.warehouseName, warehouseName) || other.warehouseName == warehouseName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,tempMin,tempMax,humidityMin,humidityMax,warehouseName);

@override
String toString() {
  return 'SensorZone(id: $id, name: $name, code: $code, tempMin: $tempMin, tempMax: $tempMax, humidityMin: $humidityMin, humidityMax: $humidityMax, warehouseName: $warehouseName)';
}


}

/// @nodoc
abstract mixin class _$SensorZoneCopyWith<$Res> implements $SensorZoneCopyWith<$Res> {
  factory _$SensorZoneCopyWith(_SensorZone value, $Res Function(_SensorZone) _then) = __$SensorZoneCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, String? code,@DoubleConverter() double? tempMin,@DoubleConverter() double? tempMax,@DoubleConverter() double? humidityMin,@DoubleConverter() double? humidityMax, String? warehouseName
});




}
/// @nodoc
class __$SensorZoneCopyWithImpl<$Res>
    implements _$SensorZoneCopyWith<$Res> {
  __$SensorZoneCopyWithImpl(this._self, this._then);

  final _SensorZone _self;
  final $Res Function(_SensorZone) _then;

/// Create a copy of SensorZone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? code = freezed,Object? tempMin = freezed,Object? tempMax = freezed,Object? humidityMin = freezed,Object? humidityMax = freezed,Object? warehouseName = freezed,}) {
  return _then(_SensorZone(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,tempMin: freezed == tempMin ? _self.tempMin : tempMin // ignore: cast_nullable_to_non_nullable
as double?,tempMax: freezed == tempMax ? _self.tempMax : tempMax // ignore: cast_nullable_to_non_nullable
as double?,humidityMin: freezed == humidityMin ? _self.humidityMin : humidityMin // ignore: cast_nullable_to_non_nullable
as double?,humidityMax: freezed == humidityMax ? _self.humidityMax : humidityMax // ignore: cast_nullable_to_non_nullable
as double?,warehouseName: freezed == warehouseName ? _self.warehouseName : warehouseName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SensorCalibration {

 String get status; String? get statusLabel; String? get expiresAt; int? get daysLeft;
/// Create a copy of SensorCalibration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorCalibrationCopyWith<SensorCalibration> get copyWith => _$SensorCalibrationCopyWithImpl<SensorCalibration>(this as SensorCalibration, _$identity);

  /// Serializes this SensorCalibration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SensorCalibration&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.daysLeft, daysLeft) || other.daysLeft == daysLeft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,statusLabel,expiresAt,daysLeft);

@override
String toString() {
  return 'SensorCalibration(status: $status, statusLabel: $statusLabel, expiresAt: $expiresAt, daysLeft: $daysLeft)';
}


}

/// @nodoc
abstract mixin class $SensorCalibrationCopyWith<$Res>  {
  factory $SensorCalibrationCopyWith(SensorCalibration value, $Res Function(SensorCalibration) _then) = _$SensorCalibrationCopyWithImpl;
@useResult
$Res call({
 String status, String? statusLabel, String? expiresAt, int? daysLeft
});




}
/// @nodoc
class _$SensorCalibrationCopyWithImpl<$Res>
    implements $SensorCalibrationCopyWith<$Res> {
  _$SensorCalibrationCopyWithImpl(this._self, this._then);

  final SensorCalibration _self;
  final $Res Function(SensorCalibration) _then;

/// Create a copy of SensorCalibration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? statusLabel = freezed,Object? expiresAt = freezed,Object? daysLeft = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,daysLeft: freezed == daysLeft ? _self.daysLeft : daysLeft // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SensorCalibration].
extension SensorCalibrationPatterns on SensorCalibration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SensorCalibration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SensorCalibration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SensorCalibration value)  $default,){
final _that = this;
switch (_that) {
case _SensorCalibration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SensorCalibration value)?  $default,){
final _that = this;
switch (_that) {
case _SensorCalibration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String? statusLabel,  String? expiresAt,  int? daysLeft)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SensorCalibration() when $default != null:
return $default(_that.status,_that.statusLabel,_that.expiresAt,_that.daysLeft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String? statusLabel,  String? expiresAt,  int? daysLeft)  $default,) {final _that = this;
switch (_that) {
case _SensorCalibration():
return $default(_that.status,_that.statusLabel,_that.expiresAt,_that.daysLeft);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String? statusLabel,  String? expiresAt,  int? daysLeft)?  $default,) {final _that = this;
switch (_that) {
case _SensorCalibration() when $default != null:
return $default(_that.status,_that.statusLabel,_that.expiresAt,_that.daysLeft);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SensorCalibration implements SensorCalibration {
  const _SensorCalibration({this.status = 'missing', this.statusLabel, this.expiresAt, this.daysLeft});
  factory _SensorCalibration.fromJson(Map<String, dynamic> json) => _$SensorCalibrationFromJson(json);

@override@JsonKey() final  String status;
@override final  String? statusLabel;
@override final  String? expiresAt;
@override final  int? daysLeft;

/// Create a copy of SensorCalibration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorCalibrationCopyWith<_SensorCalibration> get copyWith => __$SensorCalibrationCopyWithImpl<_SensorCalibration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SensorCalibrationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SensorCalibration&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.daysLeft, daysLeft) || other.daysLeft == daysLeft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,statusLabel,expiresAt,daysLeft);

@override
String toString() {
  return 'SensorCalibration(status: $status, statusLabel: $statusLabel, expiresAt: $expiresAt, daysLeft: $daysLeft)';
}


}

/// @nodoc
abstract mixin class _$SensorCalibrationCopyWith<$Res> implements $SensorCalibrationCopyWith<$Res> {
  factory _$SensorCalibrationCopyWith(_SensorCalibration value, $Res Function(_SensorCalibration) _then) = __$SensorCalibrationCopyWithImpl;
@override @useResult
$Res call({
 String status, String? statusLabel, String? expiresAt, int? daysLeft
});




}
/// @nodoc
class __$SensorCalibrationCopyWithImpl<$Res>
    implements _$SensorCalibrationCopyWith<$Res> {
  __$SensorCalibrationCopyWithImpl(this._self, this._then);

  final _SensorCalibration _self;
  final $Res Function(_SensorCalibration) _then;

/// Create a copy of SensorCalibration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? statusLabel = freezed,Object? expiresAt = freezed,Object? daysLeft = freezed,}) {
  return _then(_SensorCalibration(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,daysLeft: freezed == daysLeft ? _self.daysLeft : daysLeft // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$LastReading {

@DoubleConverter() double? get value; String? get recordedAt; String? get readingSource; String? get userName;
/// Create a copy of LastReading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastReadingCopyWith<LastReading> get copyWith => _$LastReadingCopyWithImpl<LastReading>(this as LastReading, _$identity);

  /// Serializes this LastReading to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastReading&&(identical(other.value, value) || other.value == value)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.readingSource, readingSource) || other.readingSource == readingSource)&&(identical(other.userName, userName) || other.userName == userName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,recordedAt,readingSource,userName);

@override
String toString() {
  return 'LastReading(value: $value, recordedAt: $recordedAt, readingSource: $readingSource, userName: $userName)';
}


}

/// @nodoc
abstract mixin class $LastReadingCopyWith<$Res>  {
  factory $LastReadingCopyWith(LastReading value, $Res Function(LastReading) _then) = _$LastReadingCopyWithImpl;
@useResult
$Res call({
@DoubleConverter() double? value, String? recordedAt, String? readingSource, String? userName
});




}
/// @nodoc
class _$LastReadingCopyWithImpl<$Res>
    implements $LastReadingCopyWith<$Res> {
  _$LastReadingCopyWithImpl(this._self, this._then);

  final LastReading _self;
  final $Res Function(LastReading) _then;

/// Create a copy of LastReading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? recordedAt = freezed,Object? readingSource = freezed,Object? userName = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as String?,readingSource: freezed == readingSource ? _self.readingSource : readingSource // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LastReading].
extension LastReadingPatterns on LastReading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LastReading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LastReading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LastReading value)  $default,){
final _that = this;
switch (_that) {
case _LastReading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LastReading value)?  $default,){
final _that = this;
switch (_that) {
case _LastReading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DoubleConverter()  double? value,  String? recordedAt,  String? readingSource,  String? userName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LastReading() when $default != null:
return $default(_that.value,_that.recordedAt,_that.readingSource,_that.userName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DoubleConverter()  double? value,  String? recordedAt,  String? readingSource,  String? userName)  $default,) {final _that = this;
switch (_that) {
case _LastReading():
return $default(_that.value,_that.recordedAt,_that.readingSource,_that.userName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DoubleConverter()  double? value,  String? recordedAt,  String? readingSource,  String? userName)?  $default,) {final _that = this;
switch (_that) {
case _LastReading() when $default != null:
return $default(_that.value,_that.recordedAt,_that.readingSource,_that.userName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LastReading implements LastReading {
  const _LastReading({@DoubleConverter() this.value, this.recordedAt, this.readingSource, this.userName});
  factory _LastReading.fromJson(Map<String, dynamic> json) => _$LastReadingFromJson(json);

@override@DoubleConverter() final  double? value;
@override final  String? recordedAt;
@override final  String? readingSource;
@override final  String? userName;

/// Create a copy of LastReading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastReadingCopyWith<_LastReading> get copyWith => __$LastReadingCopyWithImpl<_LastReading>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LastReadingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastReading&&(identical(other.value, value) || other.value == value)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.readingSource, readingSource) || other.readingSource == readingSource)&&(identical(other.userName, userName) || other.userName == userName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,recordedAt,readingSource,userName);

@override
String toString() {
  return 'LastReading(value: $value, recordedAt: $recordedAt, readingSource: $readingSource, userName: $userName)';
}


}

/// @nodoc
abstract mixin class _$LastReadingCopyWith<$Res> implements $LastReadingCopyWith<$Res> {
  factory _$LastReadingCopyWith(_LastReading value, $Res Function(_LastReading) _then) = __$LastReadingCopyWithImpl;
@override @useResult
$Res call({
@DoubleConverter() double? value, String? recordedAt, String? readingSource, String? userName
});




}
/// @nodoc
class __$LastReadingCopyWithImpl<$Res>
    implements _$LastReadingCopyWith<$Res> {
  __$LastReadingCopyWithImpl(this._self, this._then);

  final _LastReading _self;
  final $Res Function(_LastReading) _then;

/// Create a copy of LastReading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? recordedAt = freezed,Object? readingSource = freezed,Object? userName = freezed,}) {
  return _then(_LastReading(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as String?,readingSource: freezed == readingSource ? _self.readingSource : readingSource // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Sensor {

 int get id; String get name;@SensorTypeConverter() SensorType get type; String get unit; String? get code; bool get isActive; SensorZone? get zone; SensorCalibration? get calibration; LastReading? get lastReading;
/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorCopyWith<Sensor> get copyWith => _$SensorCopyWithImpl<Sensor>(this as Sensor, _$identity);

  /// Serializes this Sensor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sensor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.code, code) || other.code == code)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.calibration, calibration) || other.calibration == calibration)&&(identical(other.lastReading, lastReading) || other.lastReading == lastReading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,unit,code,isActive,zone,calibration,lastReading);

@override
String toString() {
  return 'Sensor(id: $id, name: $name, type: $type, unit: $unit, code: $code, isActive: $isActive, zone: $zone, calibration: $calibration, lastReading: $lastReading)';
}


}

/// @nodoc
abstract mixin class $SensorCopyWith<$Res>  {
  factory $SensorCopyWith(Sensor value, $Res Function(Sensor) _then) = _$SensorCopyWithImpl;
@useResult
$Res call({
 int id, String name,@SensorTypeConverter() SensorType type, String unit, String? code, bool isActive, SensorZone? zone, SensorCalibration? calibration, LastReading? lastReading
});


$SensorZoneCopyWith<$Res>? get zone;$SensorCalibrationCopyWith<$Res>? get calibration;$LastReadingCopyWith<$Res>? get lastReading;

}
/// @nodoc
class _$SensorCopyWithImpl<$Res>
    implements $SensorCopyWith<$Res> {
  _$SensorCopyWithImpl(this._self, this._then);

  final Sensor _self;
  final $Res Function(Sensor) _then;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? unit = null,Object? code = freezed,Object? isActive = null,Object? zone = freezed,Object? calibration = freezed,Object? lastReading = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SensorType,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as SensorZone?,calibration: freezed == calibration ? _self.calibration : calibration // ignore: cast_nullable_to_non_nullable
as SensorCalibration?,lastReading: freezed == lastReading ? _self.lastReading : lastReading // ignore: cast_nullable_to_non_nullable
as LastReading?,
  ));
}
/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SensorZoneCopyWith<$Res>? get zone {
    if (_self.zone == null) {
    return null;
  }

  return $SensorZoneCopyWith<$Res>(_self.zone!, (value) {
    return _then(_self.copyWith(zone: value));
  });
}/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SensorCalibrationCopyWith<$Res>? get calibration {
    if (_self.calibration == null) {
    return null;
  }

  return $SensorCalibrationCopyWith<$Res>(_self.calibration!, (value) {
    return _then(_self.copyWith(calibration: value));
  });
}/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastReadingCopyWith<$Res>? get lastReading {
    if (_self.lastReading == null) {
    return null;
  }

  return $LastReadingCopyWith<$Res>(_self.lastReading!, (value) {
    return _then(_self.copyWith(lastReading: value));
  });
}
}


/// Adds pattern-matching-related methods to [Sensor].
extension SensorPatterns on Sensor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sensor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sensor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sensor value)  $default,){
final _that = this;
switch (_that) {
case _Sensor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sensor value)?  $default,){
final _that = this;
switch (_that) {
case _Sensor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @SensorTypeConverter()  SensorType type,  String unit,  String? code,  bool isActive,  SensorZone? zone,  SensorCalibration? calibration,  LastReading? lastReading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.unit,_that.code,_that.isActive,_that.zone,_that.calibration,_that.lastReading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @SensorTypeConverter()  SensorType type,  String unit,  String? code,  bool isActive,  SensorZone? zone,  SensorCalibration? calibration,  LastReading? lastReading)  $default,) {final _that = this;
switch (_that) {
case _Sensor():
return $default(_that.id,_that.name,_that.type,_that.unit,_that.code,_that.isActive,_that.zone,_that.calibration,_that.lastReading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @SensorTypeConverter()  SensorType type,  String unit,  String? code,  bool isActive,  SensorZone? zone,  SensorCalibration? calibration,  LastReading? lastReading)?  $default,) {final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.unit,_that.code,_that.isActive,_that.zone,_that.calibration,_that.lastReading);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Sensor extends Sensor {
  const _Sensor({required this.id, required this.name, @SensorTypeConverter() this.type = SensorType.unknown, this.unit = '', this.code, this.isActive = true, this.zone, this.calibration, this.lastReading}): super._();
  factory _Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey()@SensorTypeConverter() final  SensorType type;
@override@JsonKey() final  String unit;
@override final  String? code;
@override@JsonKey() final  bool isActive;
@override final  SensorZone? zone;
@override final  SensorCalibration? calibration;
@override final  LastReading? lastReading;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorCopyWith<_Sensor> get copyWith => __$SensorCopyWithImpl<_Sensor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SensorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sensor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.code, code) || other.code == code)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.calibration, calibration) || other.calibration == calibration)&&(identical(other.lastReading, lastReading) || other.lastReading == lastReading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,unit,code,isActive,zone,calibration,lastReading);

@override
String toString() {
  return 'Sensor(id: $id, name: $name, type: $type, unit: $unit, code: $code, isActive: $isActive, zone: $zone, calibration: $calibration, lastReading: $lastReading)';
}


}

/// @nodoc
abstract mixin class _$SensorCopyWith<$Res> implements $SensorCopyWith<$Res> {
  factory _$SensorCopyWith(_Sensor value, $Res Function(_Sensor) _then) = __$SensorCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@SensorTypeConverter() SensorType type, String unit, String? code, bool isActive, SensorZone? zone, SensorCalibration? calibration, LastReading? lastReading
});


@override $SensorZoneCopyWith<$Res>? get zone;@override $SensorCalibrationCopyWith<$Res>? get calibration;@override $LastReadingCopyWith<$Res>? get lastReading;

}
/// @nodoc
class __$SensorCopyWithImpl<$Res>
    implements _$SensorCopyWith<$Res> {
  __$SensorCopyWithImpl(this._self, this._then);

  final _Sensor _self;
  final $Res Function(_Sensor) _then;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? unit = null,Object? code = freezed,Object? isActive = null,Object? zone = freezed,Object? calibration = freezed,Object? lastReading = freezed,}) {
  return _then(_Sensor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SensorType,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,zone: freezed == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as SensorZone?,calibration: freezed == calibration ? _self.calibration : calibration // ignore: cast_nullable_to_non_nullable
as SensorCalibration?,lastReading: freezed == lastReading ? _self.lastReading : lastReading // ignore: cast_nullable_to_non_nullable
as LastReading?,
  ));
}

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SensorZoneCopyWith<$Res>? get zone {
    if (_self.zone == null) {
    return null;
  }

  return $SensorZoneCopyWith<$Res>(_self.zone!, (value) {
    return _then(_self.copyWith(zone: value));
  });
}/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SensorCalibrationCopyWith<$Res>? get calibration {
    if (_self.calibration == null) {
    return null;
  }

  return $SensorCalibrationCopyWith<$Res>(_self.calibration!, (value) {
    return _then(_self.copyWith(calibration: value));
  });
}/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastReadingCopyWith<$Res>? get lastReading {
    if (_self.lastReading == null) {
    return null;
  }

  return $LastReadingCopyWith<$Res>(_self.lastReading!, (value) {
    return _then(_self.copyWith(lastReading: value));
  });
}
}


/// @nodoc
mixin _$Reading {

 int get id;@DoubleConverter() double? get value; String? get readingSource; String? get recordedAt;
/// Create a copy of Reading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingCopyWith<Reading> get copyWith => _$ReadingCopyWithImpl<Reading>(this as Reading, _$identity);

  /// Serializes this Reading to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reading&&(identical(other.id, id) || other.id == id)&&(identical(other.value, value) || other.value == value)&&(identical(other.readingSource, readingSource) || other.readingSource == readingSource)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,value,readingSource,recordedAt);

@override
String toString() {
  return 'Reading(id: $id, value: $value, readingSource: $readingSource, recordedAt: $recordedAt)';
}


}

/// @nodoc
abstract mixin class $ReadingCopyWith<$Res>  {
  factory $ReadingCopyWith(Reading value, $Res Function(Reading) _then) = _$ReadingCopyWithImpl;
@useResult
$Res call({
 int id,@DoubleConverter() double? value, String? readingSource, String? recordedAt
});




}
/// @nodoc
class _$ReadingCopyWithImpl<$Res>
    implements $ReadingCopyWith<$Res> {
  _$ReadingCopyWithImpl(this._self, this._then);

  final Reading _self;
  final $Res Function(Reading) _then;

/// Create a copy of Reading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? value = freezed,Object? readingSource = freezed,Object? recordedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,readingSource: freezed == readingSource ? _self.readingSource : readingSource // ignore: cast_nullable_to_non_nullable
as String?,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Reading].
extension ReadingPatterns on Reading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reading value)  $default,){
final _that = this;
switch (_that) {
case _Reading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reading value)?  $default,){
final _that = this;
switch (_that) {
case _Reading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @DoubleConverter()  double? value,  String? readingSource,  String? recordedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reading() when $default != null:
return $default(_that.id,_that.value,_that.readingSource,_that.recordedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @DoubleConverter()  double? value,  String? readingSource,  String? recordedAt)  $default,) {final _that = this;
switch (_that) {
case _Reading():
return $default(_that.id,_that.value,_that.readingSource,_that.recordedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @DoubleConverter()  double? value,  String? readingSource,  String? recordedAt)?  $default,) {final _that = this;
switch (_that) {
case _Reading() when $default != null:
return $default(_that.id,_that.value,_that.readingSource,_that.recordedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reading implements Reading {
  const _Reading({required this.id, @DoubleConverter() this.value, this.readingSource, this.recordedAt});
  factory _Reading.fromJson(Map<String, dynamic> json) => _$ReadingFromJson(json);

@override final  int id;
@override@DoubleConverter() final  double? value;
@override final  String? readingSource;
@override final  String? recordedAt;

/// Create a copy of Reading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingCopyWith<_Reading> get copyWith => __$ReadingCopyWithImpl<_Reading>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reading&&(identical(other.id, id) || other.id == id)&&(identical(other.value, value) || other.value == value)&&(identical(other.readingSource, readingSource) || other.readingSource == readingSource)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,value,readingSource,recordedAt);

@override
String toString() {
  return 'Reading(id: $id, value: $value, readingSource: $readingSource, recordedAt: $recordedAt)';
}


}

/// @nodoc
abstract mixin class _$ReadingCopyWith<$Res> implements $ReadingCopyWith<$Res> {
  factory _$ReadingCopyWith(_Reading value, $Res Function(_Reading) _then) = __$ReadingCopyWithImpl;
@override @useResult
$Res call({
 int id,@DoubleConverter() double? value, String? readingSource, String? recordedAt
});




}
/// @nodoc
class __$ReadingCopyWithImpl<$Res>
    implements _$ReadingCopyWith<$Res> {
  __$ReadingCopyWithImpl(this._self, this._then);

  final _Reading _self;
  final $Res Function(_Reading) _then;

/// Create a copy of Reading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? value = freezed,Object? readingSource = freezed,Object? recordedAt = freezed,}) {
  return _then(_Reading(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,readingSource: freezed == readingSource ? _self.readingSource : readingSource // ignore: cast_nullable_to_non_nullable
as String?,recordedAt: freezed == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ConsecutiveRule {

 bool get hasTrend; String? get direction; int get longestStreak;
/// Create a copy of ConsecutiveRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsecutiveRuleCopyWith<ConsecutiveRule> get copyWith => _$ConsecutiveRuleCopyWithImpl<ConsecutiveRule>(this as ConsecutiveRule, _$identity);

  /// Serializes this ConsecutiveRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsecutiveRule&&(identical(other.hasTrend, hasTrend) || other.hasTrend == hasTrend)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasTrend,direction,longestStreak);

@override
String toString() {
  return 'ConsecutiveRule(hasTrend: $hasTrend, direction: $direction, longestStreak: $longestStreak)';
}


}

/// @nodoc
abstract mixin class $ConsecutiveRuleCopyWith<$Res>  {
  factory $ConsecutiveRuleCopyWith(ConsecutiveRule value, $Res Function(ConsecutiveRule) _then) = _$ConsecutiveRuleCopyWithImpl;
@useResult
$Res call({
 bool hasTrend, String? direction, int longestStreak
});




}
/// @nodoc
class _$ConsecutiveRuleCopyWithImpl<$Res>
    implements $ConsecutiveRuleCopyWith<$Res> {
  _$ConsecutiveRuleCopyWithImpl(this._self, this._then);

  final ConsecutiveRule _self;
  final $Res Function(ConsecutiveRule) _then;

/// Create a copy of ConsecutiveRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasTrend = null,Object? direction = freezed,Object? longestStreak = null,}) {
  return _then(_self.copyWith(
hasTrend: null == hasTrend ? _self.hasTrend : hasTrend // ignore: cast_nullable_to_non_nullable
as bool,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ConsecutiveRule].
extension ConsecutiveRulePatterns on ConsecutiveRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsecutiveRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsecutiveRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsecutiveRule value)  $default,){
final _that = this;
switch (_that) {
case _ConsecutiveRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsecutiveRule value)?  $default,){
final _that = this;
switch (_that) {
case _ConsecutiveRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasTrend,  String? direction,  int longestStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsecutiveRule() when $default != null:
return $default(_that.hasTrend,_that.direction,_that.longestStreak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasTrend,  String? direction,  int longestStreak)  $default,) {final _that = this;
switch (_that) {
case _ConsecutiveRule():
return $default(_that.hasTrend,_that.direction,_that.longestStreak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasTrend,  String? direction,  int longestStreak)?  $default,) {final _that = this;
switch (_that) {
case _ConsecutiveRule() when $default != null:
return $default(_that.hasTrend,_that.direction,_that.longestStreak);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsecutiveRule implements ConsecutiveRule {
  const _ConsecutiveRule({this.hasTrend = false, this.direction, this.longestStreak = 0});
  factory _ConsecutiveRule.fromJson(Map<String, dynamic> json) => _$ConsecutiveRuleFromJson(json);

@override@JsonKey() final  bool hasTrend;
@override final  String? direction;
@override@JsonKey() final  int longestStreak;

/// Create a copy of ConsecutiveRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsecutiveRuleCopyWith<_ConsecutiveRule> get copyWith => __$ConsecutiveRuleCopyWithImpl<_ConsecutiveRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsecutiveRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsecutiveRule&&(identical(other.hasTrend, hasTrend) || other.hasTrend == hasTrend)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasTrend,direction,longestStreak);

@override
String toString() {
  return 'ConsecutiveRule(hasTrend: $hasTrend, direction: $direction, longestStreak: $longestStreak)';
}


}

/// @nodoc
abstract mixin class _$ConsecutiveRuleCopyWith<$Res> implements $ConsecutiveRuleCopyWith<$Res> {
  factory _$ConsecutiveRuleCopyWith(_ConsecutiveRule value, $Res Function(_ConsecutiveRule) _then) = __$ConsecutiveRuleCopyWithImpl;
@override @useResult
$Res call({
 bool hasTrend, String? direction, int longestStreak
});




}
/// @nodoc
class __$ConsecutiveRuleCopyWithImpl<$Res>
    implements _$ConsecutiveRuleCopyWith<$Res> {
  __$ConsecutiveRuleCopyWithImpl(this._self, this._then);

  final _ConsecutiveRule _self;
  final $Res Function(_ConsecutiveRule) _then;

/// Create a copy of ConsecutiveRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasTrend = null,Object? direction = freezed,Object? longestStreak = null,}) {
  return _then(_ConsecutiveRule(
hasTrend: null == hasTrend ? _self.hasTrend : hasTrend // ignore: cast_nullable_to_non_nullable
as bool,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LinearRegression {

 bool get hasTrend; String? get direction; String? get interpretation;
/// Create a copy of LinearRegression
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinearRegressionCopyWith<LinearRegression> get copyWith => _$LinearRegressionCopyWithImpl<LinearRegression>(this as LinearRegression, _$identity);

  /// Serializes this LinearRegression to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinearRegression&&(identical(other.hasTrend, hasTrend) || other.hasTrend == hasTrend)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.interpretation, interpretation) || other.interpretation == interpretation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasTrend,direction,interpretation);

@override
String toString() {
  return 'LinearRegression(hasTrend: $hasTrend, direction: $direction, interpretation: $interpretation)';
}


}

/// @nodoc
abstract mixin class $LinearRegressionCopyWith<$Res>  {
  factory $LinearRegressionCopyWith(LinearRegression value, $Res Function(LinearRegression) _then) = _$LinearRegressionCopyWithImpl;
@useResult
$Res call({
 bool hasTrend, String? direction, String? interpretation
});




}
/// @nodoc
class _$LinearRegressionCopyWithImpl<$Res>
    implements $LinearRegressionCopyWith<$Res> {
  _$LinearRegressionCopyWithImpl(this._self, this._then);

  final LinearRegression _self;
  final $Res Function(LinearRegression) _then;

/// Create a copy of LinearRegression
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasTrend = null,Object? direction = freezed,Object? interpretation = freezed,}) {
  return _then(_self.copyWith(
hasTrend: null == hasTrend ? _self.hasTrend : hasTrend // ignore: cast_nullable_to_non_nullable
as bool,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,interpretation: freezed == interpretation ? _self.interpretation : interpretation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LinearRegression].
extension LinearRegressionPatterns on LinearRegression {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinearRegression value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinearRegression() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinearRegression value)  $default,){
final _that = this;
switch (_that) {
case _LinearRegression():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinearRegression value)?  $default,){
final _that = this;
switch (_that) {
case _LinearRegression() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasTrend,  String? direction,  String? interpretation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinearRegression() when $default != null:
return $default(_that.hasTrend,_that.direction,_that.interpretation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasTrend,  String? direction,  String? interpretation)  $default,) {final _that = this;
switch (_that) {
case _LinearRegression():
return $default(_that.hasTrend,_that.direction,_that.interpretation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasTrend,  String? direction,  String? interpretation)?  $default,) {final _that = this;
switch (_that) {
case _LinearRegression() when $default != null:
return $default(_that.hasTrend,_that.direction,_that.interpretation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinearRegression implements LinearRegression {
  const _LinearRegression({this.hasTrend = false, this.direction, this.interpretation});
  factory _LinearRegression.fromJson(Map<String, dynamic> json) => _$LinearRegressionFromJson(json);

@override@JsonKey() final  bool hasTrend;
@override final  String? direction;
@override final  String? interpretation;

/// Create a copy of LinearRegression
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinearRegressionCopyWith<_LinearRegression> get copyWith => __$LinearRegressionCopyWithImpl<_LinearRegression>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinearRegressionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinearRegression&&(identical(other.hasTrend, hasTrend) || other.hasTrend == hasTrend)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.interpretation, interpretation) || other.interpretation == interpretation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasTrend,direction,interpretation);

@override
String toString() {
  return 'LinearRegression(hasTrend: $hasTrend, direction: $direction, interpretation: $interpretation)';
}


}

/// @nodoc
abstract mixin class _$LinearRegressionCopyWith<$Res> implements $LinearRegressionCopyWith<$Res> {
  factory _$LinearRegressionCopyWith(_LinearRegression value, $Res Function(_LinearRegression) _then) = __$LinearRegressionCopyWithImpl;
@override @useResult
$Res call({
 bool hasTrend, String? direction, String? interpretation
});




}
/// @nodoc
class __$LinearRegressionCopyWithImpl<$Res>
    implements _$LinearRegressionCopyWith<$Res> {
  __$LinearRegressionCopyWithImpl(this._self, this._then);

  final _LinearRegression _self;
  final $Res Function(_LinearRegression) _then;

/// Create a copy of LinearRegression
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasTrend = null,Object? direction = freezed,Object? interpretation = freezed,}) {
  return _then(_LinearRegression(
hasTrend: null == hasTrend ? _self.hasTrend : hasTrend // ignore: cast_nullable_to_non_nullable
as bool,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,interpretation: freezed == interpretation ? _self.interpretation : interpretation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TrendAnalysis {

 int get totalReadings; bool get overallTrend; String? get overallDirection; String get confidence; ConsecutiveRule? get consecutiveRule; LinearRegression? get linearRegression;
/// Create a copy of TrendAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendAnalysisCopyWith<TrendAnalysis> get copyWith => _$TrendAnalysisCopyWithImpl<TrendAnalysis>(this as TrendAnalysis, _$identity);

  /// Serializes this TrendAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendAnalysis&&(identical(other.totalReadings, totalReadings) || other.totalReadings == totalReadings)&&(identical(other.overallTrend, overallTrend) || other.overallTrend == overallTrend)&&(identical(other.overallDirection, overallDirection) || other.overallDirection == overallDirection)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.consecutiveRule, consecutiveRule) || other.consecutiveRule == consecutiveRule)&&(identical(other.linearRegression, linearRegression) || other.linearRegression == linearRegression));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalReadings,overallTrend,overallDirection,confidence,consecutiveRule,linearRegression);

@override
String toString() {
  return 'TrendAnalysis(totalReadings: $totalReadings, overallTrend: $overallTrend, overallDirection: $overallDirection, confidence: $confidence, consecutiveRule: $consecutiveRule, linearRegression: $linearRegression)';
}


}

/// @nodoc
abstract mixin class $TrendAnalysisCopyWith<$Res>  {
  factory $TrendAnalysisCopyWith(TrendAnalysis value, $Res Function(TrendAnalysis) _then) = _$TrendAnalysisCopyWithImpl;
@useResult
$Res call({
 int totalReadings, bool overallTrend, String? overallDirection, String confidence, ConsecutiveRule? consecutiveRule, LinearRegression? linearRegression
});


$ConsecutiveRuleCopyWith<$Res>? get consecutiveRule;$LinearRegressionCopyWith<$Res>? get linearRegression;

}
/// @nodoc
class _$TrendAnalysisCopyWithImpl<$Res>
    implements $TrendAnalysisCopyWith<$Res> {
  _$TrendAnalysisCopyWithImpl(this._self, this._then);

  final TrendAnalysis _self;
  final $Res Function(TrendAnalysis) _then;

/// Create a copy of TrendAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalReadings = null,Object? overallTrend = null,Object? overallDirection = freezed,Object? confidence = null,Object? consecutiveRule = freezed,Object? linearRegression = freezed,}) {
  return _then(_self.copyWith(
totalReadings: null == totalReadings ? _self.totalReadings : totalReadings // ignore: cast_nullable_to_non_nullable
as int,overallTrend: null == overallTrend ? _self.overallTrend : overallTrend // ignore: cast_nullable_to_non_nullable
as bool,overallDirection: freezed == overallDirection ? _self.overallDirection : overallDirection // ignore: cast_nullable_to_non_nullable
as String?,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,consecutiveRule: freezed == consecutiveRule ? _self.consecutiveRule : consecutiveRule // ignore: cast_nullable_to_non_nullable
as ConsecutiveRule?,linearRegression: freezed == linearRegression ? _self.linearRegression : linearRegression // ignore: cast_nullable_to_non_nullable
as LinearRegression?,
  ));
}
/// Create a copy of TrendAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConsecutiveRuleCopyWith<$Res>? get consecutiveRule {
    if (_self.consecutiveRule == null) {
    return null;
  }

  return $ConsecutiveRuleCopyWith<$Res>(_self.consecutiveRule!, (value) {
    return _then(_self.copyWith(consecutiveRule: value));
  });
}/// Create a copy of TrendAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinearRegressionCopyWith<$Res>? get linearRegression {
    if (_self.linearRegression == null) {
    return null;
  }

  return $LinearRegressionCopyWith<$Res>(_self.linearRegression!, (value) {
    return _then(_self.copyWith(linearRegression: value));
  });
}
}


/// Adds pattern-matching-related methods to [TrendAnalysis].
extension TrendAnalysisPatterns on TrendAnalysis {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendAnalysis value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendAnalysis() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendAnalysis value)  $default,){
final _that = this;
switch (_that) {
case _TrendAnalysis():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendAnalysis value)?  $default,){
final _that = this;
switch (_that) {
case _TrendAnalysis() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalReadings,  bool overallTrend,  String? overallDirection,  String confidence,  ConsecutiveRule? consecutiveRule,  LinearRegression? linearRegression)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendAnalysis() when $default != null:
return $default(_that.totalReadings,_that.overallTrend,_that.overallDirection,_that.confidence,_that.consecutiveRule,_that.linearRegression);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalReadings,  bool overallTrend,  String? overallDirection,  String confidence,  ConsecutiveRule? consecutiveRule,  LinearRegression? linearRegression)  $default,) {final _that = this;
switch (_that) {
case _TrendAnalysis():
return $default(_that.totalReadings,_that.overallTrend,_that.overallDirection,_that.confidence,_that.consecutiveRule,_that.linearRegression);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalReadings,  bool overallTrend,  String? overallDirection,  String confidence,  ConsecutiveRule? consecutiveRule,  LinearRegression? linearRegression)?  $default,) {final _that = this;
switch (_that) {
case _TrendAnalysis() when $default != null:
return $default(_that.totalReadings,_that.overallTrend,_that.overallDirection,_that.confidence,_that.consecutiveRule,_that.linearRegression);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendAnalysis implements TrendAnalysis {
  const _TrendAnalysis({this.totalReadings = 0, this.overallTrend = false, this.overallDirection, this.confidence = 'none', this.consecutiveRule, this.linearRegression});
  factory _TrendAnalysis.fromJson(Map<String, dynamic> json) => _$TrendAnalysisFromJson(json);

@override@JsonKey() final  int totalReadings;
@override@JsonKey() final  bool overallTrend;
@override final  String? overallDirection;
@override@JsonKey() final  String confidence;
@override final  ConsecutiveRule? consecutiveRule;
@override final  LinearRegression? linearRegression;

/// Create a copy of TrendAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendAnalysisCopyWith<_TrendAnalysis> get copyWith => __$TrendAnalysisCopyWithImpl<_TrendAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendAnalysis&&(identical(other.totalReadings, totalReadings) || other.totalReadings == totalReadings)&&(identical(other.overallTrend, overallTrend) || other.overallTrend == overallTrend)&&(identical(other.overallDirection, overallDirection) || other.overallDirection == overallDirection)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.consecutiveRule, consecutiveRule) || other.consecutiveRule == consecutiveRule)&&(identical(other.linearRegression, linearRegression) || other.linearRegression == linearRegression));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalReadings,overallTrend,overallDirection,confidence,consecutiveRule,linearRegression);

@override
String toString() {
  return 'TrendAnalysis(totalReadings: $totalReadings, overallTrend: $overallTrend, overallDirection: $overallDirection, confidence: $confidence, consecutiveRule: $consecutiveRule, linearRegression: $linearRegression)';
}


}

/// @nodoc
abstract mixin class _$TrendAnalysisCopyWith<$Res> implements $TrendAnalysisCopyWith<$Res> {
  factory _$TrendAnalysisCopyWith(_TrendAnalysis value, $Res Function(_TrendAnalysis) _then) = __$TrendAnalysisCopyWithImpl;
@override @useResult
$Res call({
 int totalReadings, bool overallTrend, String? overallDirection, String confidence, ConsecutiveRule? consecutiveRule, LinearRegression? linearRegression
});


@override $ConsecutiveRuleCopyWith<$Res>? get consecutiveRule;@override $LinearRegressionCopyWith<$Res>? get linearRegression;

}
/// @nodoc
class __$TrendAnalysisCopyWithImpl<$Res>
    implements _$TrendAnalysisCopyWith<$Res> {
  __$TrendAnalysisCopyWithImpl(this._self, this._then);

  final _TrendAnalysis _self;
  final $Res Function(_TrendAnalysis) _then;

/// Create a copy of TrendAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalReadings = null,Object? overallTrend = null,Object? overallDirection = freezed,Object? confidence = null,Object? consecutiveRule = freezed,Object? linearRegression = freezed,}) {
  return _then(_TrendAnalysis(
totalReadings: null == totalReadings ? _self.totalReadings : totalReadings // ignore: cast_nullable_to_non_nullable
as int,overallTrend: null == overallTrend ? _self.overallTrend : overallTrend // ignore: cast_nullable_to_non_nullable
as bool,overallDirection: freezed == overallDirection ? _self.overallDirection : overallDirection // ignore: cast_nullable_to_non_nullable
as String?,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,consecutiveRule: freezed == consecutiveRule ? _self.consecutiveRule : consecutiveRule // ignore: cast_nullable_to_non_nullable
as ConsecutiveRule?,linearRegression: freezed == linearRegression ? _self.linearRegression : linearRegression // ignore: cast_nullable_to_non_nullable
as LinearRegression?,
  ));
}

/// Create a copy of TrendAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConsecutiveRuleCopyWith<$Res>? get consecutiveRule {
    if (_self.consecutiveRule == null) {
    return null;
  }

  return $ConsecutiveRuleCopyWith<$Res>(_self.consecutiveRule!, (value) {
    return _then(_self.copyWith(consecutiveRule: value));
  });
}/// Create a copy of TrendAnalysis
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LinearRegressionCopyWith<$Res>? get linearRegression {
    if (_self.linearRegression == null) {
    return null;
  }

  return $LinearRegressionCopyWith<$Res>(_self.linearRegression!, (value) {
    return _then(_self.copyWith(linearRegression: value));
  });
}
}


/// @nodoc
mixin _$CalibrationCertificate {

 int get id; String? get certificateNumber; String? get laboratory; String? get calibratedAt; String? get expiresAt; int? get daysLeft; bool get isCurrent; String get status; String? get statusLabel; String? get originalName;
/// Create a copy of CalibrationCertificate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalibrationCertificateCopyWith<CalibrationCertificate> get copyWith => _$CalibrationCertificateCopyWithImpl<CalibrationCertificate>(this as CalibrationCertificate, _$identity);

  /// Serializes this CalibrationCertificate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalibrationCertificate&&(identical(other.id, id) || other.id == id)&&(identical(other.certificateNumber, certificateNumber) || other.certificateNumber == certificateNumber)&&(identical(other.laboratory, laboratory) || other.laboratory == laboratory)&&(identical(other.calibratedAt, calibratedAt) || other.calibratedAt == calibratedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.daysLeft, daysLeft) || other.daysLeft == daysLeft)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.originalName, originalName) || other.originalName == originalName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,certificateNumber,laboratory,calibratedAt,expiresAt,daysLeft,isCurrent,status,statusLabel,originalName);

@override
String toString() {
  return 'CalibrationCertificate(id: $id, certificateNumber: $certificateNumber, laboratory: $laboratory, calibratedAt: $calibratedAt, expiresAt: $expiresAt, daysLeft: $daysLeft, isCurrent: $isCurrent, status: $status, statusLabel: $statusLabel, originalName: $originalName)';
}


}

/// @nodoc
abstract mixin class $CalibrationCertificateCopyWith<$Res>  {
  factory $CalibrationCertificateCopyWith(CalibrationCertificate value, $Res Function(CalibrationCertificate) _then) = _$CalibrationCertificateCopyWithImpl;
@useResult
$Res call({
 int id, String? certificateNumber, String? laboratory, String? calibratedAt, String? expiresAt, int? daysLeft, bool isCurrent, String status, String? statusLabel, String? originalName
});




}
/// @nodoc
class _$CalibrationCertificateCopyWithImpl<$Res>
    implements $CalibrationCertificateCopyWith<$Res> {
  _$CalibrationCertificateCopyWithImpl(this._self, this._then);

  final CalibrationCertificate _self;
  final $Res Function(CalibrationCertificate) _then;

/// Create a copy of CalibrationCertificate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? certificateNumber = freezed,Object? laboratory = freezed,Object? calibratedAt = freezed,Object? expiresAt = freezed,Object? daysLeft = freezed,Object? isCurrent = null,Object? status = null,Object? statusLabel = freezed,Object? originalName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,certificateNumber: freezed == certificateNumber ? _self.certificateNumber : certificateNumber // ignore: cast_nullable_to_non_nullable
as String?,laboratory: freezed == laboratory ? _self.laboratory : laboratory // ignore: cast_nullable_to_non_nullable
as String?,calibratedAt: freezed == calibratedAt ? _self.calibratedAt : calibratedAt // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,daysLeft: freezed == daysLeft ? _self.daysLeft : daysLeft // ignore: cast_nullable_to_non_nullable
as int?,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,originalName: freezed == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalibrationCertificate].
extension CalibrationCertificatePatterns on CalibrationCertificate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalibrationCertificate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalibrationCertificate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalibrationCertificate value)  $default,){
final _that = this;
switch (_that) {
case _CalibrationCertificate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalibrationCertificate value)?  $default,){
final _that = this;
switch (_that) {
case _CalibrationCertificate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? certificateNumber,  String? laboratory,  String? calibratedAt,  String? expiresAt,  int? daysLeft,  bool isCurrent,  String status,  String? statusLabel,  String? originalName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalibrationCertificate() when $default != null:
return $default(_that.id,_that.certificateNumber,_that.laboratory,_that.calibratedAt,_that.expiresAt,_that.daysLeft,_that.isCurrent,_that.status,_that.statusLabel,_that.originalName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? certificateNumber,  String? laboratory,  String? calibratedAt,  String? expiresAt,  int? daysLeft,  bool isCurrent,  String status,  String? statusLabel,  String? originalName)  $default,) {final _that = this;
switch (_that) {
case _CalibrationCertificate():
return $default(_that.id,_that.certificateNumber,_that.laboratory,_that.calibratedAt,_that.expiresAt,_that.daysLeft,_that.isCurrent,_that.status,_that.statusLabel,_that.originalName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? certificateNumber,  String? laboratory,  String? calibratedAt,  String? expiresAt,  int? daysLeft,  bool isCurrent,  String status,  String? statusLabel,  String? originalName)?  $default,) {final _that = this;
switch (_that) {
case _CalibrationCertificate() when $default != null:
return $default(_that.id,_that.certificateNumber,_that.laboratory,_that.calibratedAt,_that.expiresAt,_that.daysLeft,_that.isCurrent,_that.status,_that.statusLabel,_that.originalName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalibrationCertificate implements CalibrationCertificate {
  const _CalibrationCertificate({required this.id, this.certificateNumber, this.laboratory, this.calibratedAt, this.expiresAt, this.daysLeft, this.isCurrent = false, this.status = '', this.statusLabel, this.originalName});
  factory _CalibrationCertificate.fromJson(Map<String, dynamic> json) => _$CalibrationCertificateFromJson(json);

@override final  int id;
@override final  String? certificateNumber;
@override final  String? laboratory;
@override final  String? calibratedAt;
@override final  String? expiresAt;
@override final  int? daysLeft;
@override@JsonKey() final  bool isCurrent;
@override@JsonKey() final  String status;
@override final  String? statusLabel;
@override final  String? originalName;

/// Create a copy of CalibrationCertificate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalibrationCertificateCopyWith<_CalibrationCertificate> get copyWith => __$CalibrationCertificateCopyWithImpl<_CalibrationCertificate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalibrationCertificateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalibrationCertificate&&(identical(other.id, id) || other.id == id)&&(identical(other.certificateNumber, certificateNumber) || other.certificateNumber == certificateNumber)&&(identical(other.laboratory, laboratory) || other.laboratory == laboratory)&&(identical(other.calibratedAt, calibratedAt) || other.calibratedAt == calibratedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.daysLeft, daysLeft) || other.daysLeft == daysLeft)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.originalName, originalName) || other.originalName == originalName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,certificateNumber,laboratory,calibratedAt,expiresAt,daysLeft,isCurrent,status,statusLabel,originalName);

@override
String toString() {
  return 'CalibrationCertificate(id: $id, certificateNumber: $certificateNumber, laboratory: $laboratory, calibratedAt: $calibratedAt, expiresAt: $expiresAt, daysLeft: $daysLeft, isCurrent: $isCurrent, status: $status, statusLabel: $statusLabel, originalName: $originalName)';
}


}

/// @nodoc
abstract mixin class _$CalibrationCertificateCopyWith<$Res> implements $CalibrationCertificateCopyWith<$Res> {
  factory _$CalibrationCertificateCopyWith(_CalibrationCertificate value, $Res Function(_CalibrationCertificate) _then) = __$CalibrationCertificateCopyWithImpl;
@override @useResult
$Res call({
 int id, String? certificateNumber, String? laboratory, String? calibratedAt, String? expiresAt, int? daysLeft, bool isCurrent, String status, String? statusLabel, String? originalName
});




}
/// @nodoc
class __$CalibrationCertificateCopyWithImpl<$Res>
    implements _$CalibrationCertificateCopyWith<$Res> {
  __$CalibrationCertificateCopyWithImpl(this._self, this._then);

  final _CalibrationCertificate _self;
  final $Res Function(_CalibrationCertificate) _then;

/// Create a copy of CalibrationCertificate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? certificateNumber = freezed,Object? laboratory = freezed,Object? calibratedAt = freezed,Object? expiresAt = freezed,Object? daysLeft = freezed,Object? isCurrent = null,Object? status = null,Object? statusLabel = freezed,Object? originalName = freezed,}) {
  return _then(_CalibrationCertificate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,certificateNumber: freezed == certificateNumber ? _self.certificateNumber : certificateNumber // ignore: cast_nullable_to_non_nullable
as String?,laboratory: freezed == laboratory ? _self.laboratory : laboratory // ignore: cast_nullable_to_non_nullable
as String?,calibratedAt: freezed == calibratedAt ? _self.calibratedAt : calibratedAt // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,daysLeft: freezed == daysLeft ? _self.daysLeft : daysLeft // ignore: cast_nullable_to_non_nullable
as int?,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,statusLabel: freezed == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String?,originalName: freezed == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AlertRule {

 int get id; String get conditionType;@DoubleConverter() double? get threshold; int? get consecutiveReadings; bool get isActive; List<String> get notificationChannels;
/// Create a copy of AlertRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertRuleCopyWith<AlertRule> get copyWith => _$AlertRuleCopyWithImpl<AlertRule>(this as AlertRule, _$identity);

  /// Serializes this AlertRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertRule&&(identical(other.id, id) || other.id == id)&&(identical(other.conditionType, conditionType) || other.conditionType == conditionType)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.consecutiveReadings, consecutiveReadings) || other.consecutiveReadings == consecutiveReadings)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.notificationChannels, notificationChannels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conditionType,threshold,consecutiveReadings,isActive,const DeepCollectionEquality().hash(notificationChannels));

@override
String toString() {
  return 'AlertRule(id: $id, conditionType: $conditionType, threshold: $threshold, consecutiveReadings: $consecutiveReadings, isActive: $isActive, notificationChannels: $notificationChannels)';
}


}

/// @nodoc
abstract mixin class $AlertRuleCopyWith<$Res>  {
  factory $AlertRuleCopyWith(AlertRule value, $Res Function(AlertRule) _then) = _$AlertRuleCopyWithImpl;
@useResult
$Res call({
 int id, String conditionType,@DoubleConverter() double? threshold, int? consecutiveReadings, bool isActive, List<String> notificationChannels
});




}
/// @nodoc
class _$AlertRuleCopyWithImpl<$Res>
    implements $AlertRuleCopyWith<$Res> {
  _$AlertRuleCopyWithImpl(this._self, this._then);

  final AlertRule _self;
  final $Res Function(AlertRule) _then;

/// Create a copy of AlertRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conditionType = null,Object? threshold = freezed,Object? consecutiveReadings = freezed,Object? isActive = null,Object? notificationChannels = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conditionType: null == conditionType ? _self.conditionType : conditionType // ignore: cast_nullable_to_non_nullable
as String,threshold: freezed == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double?,consecutiveReadings: freezed == consecutiveReadings ? _self.consecutiveReadings : consecutiveReadings // ignore: cast_nullable_to_non_nullable
as int?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,notificationChannels: null == notificationChannels ? _self.notificationChannels : notificationChannels // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AlertRule].
extension AlertRulePatterns on AlertRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlertRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlertRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlertRule value)  $default,){
final _that = this;
switch (_that) {
case _AlertRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlertRule value)?  $default,){
final _that = this;
switch (_that) {
case _AlertRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String conditionType, @DoubleConverter()  double? threshold,  int? consecutiveReadings,  bool isActive,  List<String> notificationChannels)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlertRule() when $default != null:
return $default(_that.id,_that.conditionType,_that.threshold,_that.consecutiveReadings,_that.isActive,_that.notificationChannels);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String conditionType, @DoubleConverter()  double? threshold,  int? consecutiveReadings,  bool isActive,  List<String> notificationChannels)  $default,) {final _that = this;
switch (_that) {
case _AlertRule():
return $default(_that.id,_that.conditionType,_that.threshold,_that.consecutiveReadings,_that.isActive,_that.notificationChannels);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String conditionType, @DoubleConverter()  double? threshold,  int? consecutiveReadings,  bool isActive,  List<String> notificationChannels)?  $default,) {final _that = this;
switch (_that) {
case _AlertRule() when $default != null:
return $default(_that.id,_that.conditionType,_that.threshold,_that.consecutiveReadings,_that.isActive,_that.notificationChannels);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlertRule implements AlertRule {
  const _AlertRule({required this.id, this.conditionType = '', @DoubleConverter() this.threshold, this.consecutiveReadings, this.isActive = true, final  List<String> notificationChannels = const []}): _notificationChannels = notificationChannels;
  factory _AlertRule.fromJson(Map<String, dynamic> json) => _$AlertRuleFromJson(json);

@override final  int id;
@override@JsonKey() final  String conditionType;
@override@DoubleConverter() final  double? threshold;
@override final  int? consecutiveReadings;
@override@JsonKey() final  bool isActive;
 final  List<String> _notificationChannels;
@override@JsonKey() List<String> get notificationChannels {
  if (_notificationChannels is EqualUnmodifiableListView) return _notificationChannels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notificationChannels);
}


/// Create a copy of AlertRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertRuleCopyWith<_AlertRule> get copyWith => __$AlertRuleCopyWithImpl<_AlertRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertRule&&(identical(other.id, id) || other.id == id)&&(identical(other.conditionType, conditionType) || other.conditionType == conditionType)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.consecutiveReadings, consecutiveReadings) || other.consecutiveReadings == consecutiveReadings)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._notificationChannels, _notificationChannels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conditionType,threshold,consecutiveReadings,isActive,const DeepCollectionEquality().hash(_notificationChannels));

@override
String toString() {
  return 'AlertRule(id: $id, conditionType: $conditionType, threshold: $threshold, consecutiveReadings: $consecutiveReadings, isActive: $isActive, notificationChannels: $notificationChannels)';
}


}

/// @nodoc
abstract mixin class _$AlertRuleCopyWith<$Res> implements $AlertRuleCopyWith<$Res> {
  factory _$AlertRuleCopyWith(_AlertRule value, $Res Function(_AlertRule) _then) = __$AlertRuleCopyWithImpl;
@override @useResult
$Res call({
 int id, String conditionType,@DoubleConverter() double? threshold, int? consecutiveReadings, bool isActive, List<String> notificationChannels
});




}
/// @nodoc
class __$AlertRuleCopyWithImpl<$Res>
    implements _$AlertRuleCopyWith<$Res> {
  __$AlertRuleCopyWithImpl(this._self, this._then);

  final _AlertRule _self;
  final $Res Function(_AlertRule) _then;

/// Create a copy of AlertRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conditionType = null,Object? threshold = freezed,Object? consecutiveReadings = freezed,Object? isActive = null,Object? notificationChannels = null,}) {
  return _then(_AlertRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conditionType: null == conditionType ? _self.conditionType : conditionType // ignore: cast_nullable_to_non_nullable
as String,threshold: freezed == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double?,consecutiveReadings: freezed == consecutiveReadings ? _self.consecutiveReadings : consecutiveReadings // ignore: cast_nullable_to_non_nullable
as int?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,notificationChannels: null == notificationChannels ? _self._notificationChannels : notificationChannels // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
