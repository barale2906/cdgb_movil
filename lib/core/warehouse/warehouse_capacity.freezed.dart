// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_capacity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VolumeUsage {

 double? get maxCm3; double get usedCm3; double? get availableCm3; double? get usagePct;
/// Create a copy of VolumeUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VolumeUsageCopyWith<VolumeUsage> get copyWith => _$VolumeUsageCopyWithImpl<VolumeUsage>(this as VolumeUsage, _$identity);

  /// Serializes this VolumeUsage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VolumeUsage&&(identical(other.maxCm3, maxCm3) || other.maxCm3 == maxCm3)&&(identical(other.usedCm3, usedCm3) || other.usedCm3 == usedCm3)&&(identical(other.availableCm3, availableCm3) || other.availableCm3 == availableCm3)&&(identical(other.usagePct, usagePct) || other.usagePct == usagePct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxCm3,usedCm3,availableCm3,usagePct);

@override
String toString() {
  return 'VolumeUsage(maxCm3: $maxCm3, usedCm3: $usedCm3, availableCm3: $availableCm3, usagePct: $usagePct)';
}


}

/// @nodoc
abstract mixin class $VolumeUsageCopyWith<$Res>  {
  factory $VolumeUsageCopyWith(VolumeUsage value, $Res Function(VolumeUsage) _then) = _$VolumeUsageCopyWithImpl;
@useResult
$Res call({
 double? maxCm3, double usedCm3, double? availableCm3, double? usagePct
});




}
/// @nodoc
class _$VolumeUsageCopyWithImpl<$Res>
    implements $VolumeUsageCopyWith<$Res> {
  _$VolumeUsageCopyWithImpl(this._self, this._then);

  final VolumeUsage _self;
  final $Res Function(VolumeUsage) _then;

/// Create a copy of VolumeUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxCm3 = freezed,Object? usedCm3 = null,Object? availableCm3 = freezed,Object? usagePct = freezed,}) {
  return _then(_self.copyWith(
maxCm3: freezed == maxCm3 ? _self.maxCm3 : maxCm3 // ignore: cast_nullable_to_non_nullable
as double?,usedCm3: null == usedCm3 ? _self.usedCm3 : usedCm3 // ignore: cast_nullable_to_non_nullable
as double,availableCm3: freezed == availableCm3 ? _self.availableCm3 : availableCm3 // ignore: cast_nullable_to_non_nullable
as double?,usagePct: freezed == usagePct ? _self.usagePct : usagePct // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [VolumeUsage].
extension VolumeUsagePatterns on VolumeUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VolumeUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VolumeUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VolumeUsage value)  $default,){
final _that = this;
switch (_that) {
case _VolumeUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VolumeUsage value)?  $default,){
final _that = this;
switch (_that) {
case _VolumeUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? maxCm3,  double usedCm3,  double? availableCm3,  double? usagePct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VolumeUsage() when $default != null:
return $default(_that.maxCm3,_that.usedCm3,_that.availableCm3,_that.usagePct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? maxCm3,  double usedCm3,  double? availableCm3,  double? usagePct)  $default,) {final _that = this;
switch (_that) {
case _VolumeUsage():
return $default(_that.maxCm3,_that.usedCm3,_that.availableCm3,_that.usagePct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? maxCm3,  double usedCm3,  double? availableCm3,  double? usagePct)?  $default,) {final _that = this;
switch (_that) {
case _VolumeUsage() when $default != null:
return $default(_that.maxCm3,_that.usedCm3,_that.availableCm3,_that.usagePct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VolumeUsage implements VolumeUsage {
  const _VolumeUsage({this.maxCm3, this.usedCm3 = 0, this.availableCm3, this.usagePct});
  factory _VolumeUsage.fromJson(Map<String, dynamic> json) => _$VolumeUsageFromJson(json);

@override final  double? maxCm3;
@override@JsonKey() final  double usedCm3;
@override final  double? availableCm3;
@override final  double? usagePct;

/// Create a copy of VolumeUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VolumeUsageCopyWith<_VolumeUsage> get copyWith => __$VolumeUsageCopyWithImpl<_VolumeUsage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VolumeUsageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VolumeUsage&&(identical(other.maxCm3, maxCm3) || other.maxCm3 == maxCm3)&&(identical(other.usedCm3, usedCm3) || other.usedCm3 == usedCm3)&&(identical(other.availableCm3, availableCm3) || other.availableCm3 == availableCm3)&&(identical(other.usagePct, usagePct) || other.usagePct == usagePct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxCm3,usedCm3,availableCm3,usagePct);

@override
String toString() {
  return 'VolumeUsage(maxCm3: $maxCm3, usedCm3: $usedCm3, availableCm3: $availableCm3, usagePct: $usagePct)';
}


}

/// @nodoc
abstract mixin class _$VolumeUsageCopyWith<$Res> implements $VolumeUsageCopyWith<$Res> {
  factory _$VolumeUsageCopyWith(_VolumeUsage value, $Res Function(_VolumeUsage) _then) = __$VolumeUsageCopyWithImpl;
@override @useResult
$Res call({
 double? maxCm3, double usedCm3, double? availableCm3, double? usagePct
});




}
/// @nodoc
class __$VolumeUsageCopyWithImpl<$Res>
    implements _$VolumeUsageCopyWith<$Res> {
  __$VolumeUsageCopyWithImpl(this._self, this._then);

  final _VolumeUsage _self;
  final $Res Function(_VolumeUsage) _then;

/// Create a copy of VolumeUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxCm3 = freezed,Object? usedCm3 = null,Object? availableCm3 = freezed,Object? usagePct = freezed,}) {
  return _then(_VolumeUsage(
maxCm3: freezed == maxCm3 ? _self.maxCm3 : maxCm3 // ignore: cast_nullable_to_non_nullable
as double?,usedCm3: null == usedCm3 ? _self.usedCm3 : usedCm3 // ignore: cast_nullable_to_non_nullable
as double,availableCm3: freezed == availableCm3 ? _self.availableCm3 : availableCm3 // ignore: cast_nullable_to_non_nullable
as double?,usagePct: freezed == usagePct ? _self.usagePct : usagePct // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$WeightUsage {

 double? get maxKg; double get usedKg; double? get availableKg; double? get usagePct;
/// Create a copy of WeightUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeightUsageCopyWith<WeightUsage> get copyWith => _$WeightUsageCopyWithImpl<WeightUsage>(this as WeightUsage, _$identity);

  /// Serializes this WeightUsage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeightUsage&&(identical(other.maxKg, maxKg) || other.maxKg == maxKg)&&(identical(other.usedKg, usedKg) || other.usedKg == usedKg)&&(identical(other.availableKg, availableKg) || other.availableKg == availableKg)&&(identical(other.usagePct, usagePct) || other.usagePct == usagePct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxKg,usedKg,availableKg,usagePct);

@override
String toString() {
  return 'WeightUsage(maxKg: $maxKg, usedKg: $usedKg, availableKg: $availableKg, usagePct: $usagePct)';
}


}

/// @nodoc
abstract mixin class $WeightUsageCopyWith<$Res>  {
  factory $WeightUsageCopyWith(WeightUsage value, $Res Function(WeightUsage) _then) = _$WeightUsageCopyWithImpl;
@useResult
$Res call({
 double? maxKg, double usedKg, double? availableKg, double? usagePct
});




}
/// @nodoc
class _$WeightUsageCopyWithImpl<$Res>
    implements $WeightUsageCopyWith<$Res> {
  _$WeightUsageCopyWithImpl(this._self, this._then);

  final WeightUsage _self;
  final $Res Function(WeightUsage) _then;

/// Create a copy of WeightUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxKg = freezed,Object? usedKg = null,Object? availableKg = freezed,Object? usagePct = freezed,}) {
  return _then(_self.copyWith(
maxKg: freezed == maxKg ? _self.maxKg : maxKg // ignore: cast_nullable_to_non_nullable
as double?,usedKg: null == usedKg ? _self.usedKg : usedKg // ignore: cast_nullable_to_non_nullable
as double,availableKg: freezed == availableKg ? _self.availableKg : availableKg // ignore: cast_nullable_to_non_nullable
as double?,usagePct: freezed == usagePct ? _self.usagePct : usagePct // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [WeightUsage].
extension WeightUsagePatterns on WeightUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeightUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeightUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeightUsage value)  $default,){
final _that = this;
switch (_that) {
case _WeightUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeightUsage value)?  $default,){
final _that = this;
switch (_that) {
case _WeightUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? maxKg,  double usedKg,  double? availableKg,  double? usagePct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeightUsage() when $default != null:
return $default(_that.maxKg,_that.usedKg,_that.availableKg,_that.usagePct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? maxKg,  double usedKg,  double? availableKg,  double? usagePct)  $default,) {final _that = this;
switch (_that) {
case _WeightUsage():
return $default(_that.maxKg,_that.usedKg,_that.availableKg,_that.usagePct);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? maxKg,  double usedKg,  double? availableKg,  double? usagePct)?  $default,) {final _that = this;
switch (_that) {
case _WeightUsage() when $default != null:
return $default(_that.maxKg,_that.usedKg,_that.availableKg,_that.usagePct);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeightUsage implements WeightUsage {
  const _WeightUsage({this.maxKg, this.usedKg = 0, this.availableKg, this.usagePct});
  factory _WeightUsage.fromJson(Map<String, dynamic> json) => _$WeightUsageFromJson(json);

@override final  double? maxKg;
@override@JsonKey() final  double usedKg;
@override final  double? availableKg;
@override final  double? usagePct;

/// Create a copy of WeightUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeightUsageCopyWith<_WeightUsage> get copyWith => __$WeightUsageCopyWithImpl<_WeightUsage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeightUsageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeightUsage&&(identical(other.maxKg, maxKg) || other.maxKg == maxKg)&&(identical(other.usedKg, usedKg) || other.usedKg == usedKg)&&(identical(other.availableKg, availableKg) || other.availableKg == availableKg)&&(identical(other.usagePct, usagePct) || other.usagePct == usagePct));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxKg,usedKg,availableKg,usagePct);

@override
String toString() {
  return 'WeightUsage(maxKg: $maxKg, usedKg: $usedKg, availableKg: $availableKg, usagePct: $usagePct)';
}


}

/// @nodoc
abstract mixin class _$WeightUsageCopyWith<$Res> implements $WeightUsageCopyWith<$Res> {
  factory _$WeightUsageCopyWith(_WeightUsage value, $Res Function(_WeightUsage) _then) = __$WeightUsageCopyWithImpl;
@override @useResult
$Res call({
 double? maxKg, double usedKg, double? availableKg, double? usagePct
});




}
/// @nodoc
class __$WeightUsageCopyWithImpl<$Res>
    implements _$WeightUsageCopyWith<$Res> {
  __$WeightUsageCopyWithImpl(this._self, this._then);

  final _WeightUsage _self;
  final $Res Function(_WeightUsage) _then;

/// Create a copy of WeightUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxKg = freezed,Object? usedKg = null,Object? availableKg = freezed,Object? usagePct = freezed,}) {
  return _then(_WeightUsage(
maxKg: freezed == maxKg ? _self.maxKg : maxKg // ignore: cast_nullable_to_non_nullable
as double?,usedKg: null == usedKg ? _self.usedKg : usedKg // ignore: cast_nullable_to_non_nullable
as double,availableKg: freezed == availableKg ? _self.availableKg : availableKg // ignore: cast_nullable_to_non_nullable
as double?,usagePct: freezed == usagePct ? _self.usagePct : usagePct // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$LocationCapacity {

 int get id; String get name; VolumeUsage get capacityVolume; WeightUsage get capacityWeight; String? get code;
/// Create a copy of LocationCapacity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCapacityCopyWith<LocationCapacity> get copyWith => _$LocationCapacityCopyWithImpl<LocationCapacity>(this as LocationCapacity, _$identity);

  /// Serializes this LocationCapacity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationCapacity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacityVolume, capacityVolume) || other.capacityVolume == capacityVolume)&&(identical(other.capacityWeight, capacityWeight) || other.capacityWeight == capacityWeight)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,capacityVolume,capacityWeight,code);

@override
String toString() {
  return 'LocationCapacity(id: $id, name: $name, capacityVolume: $capacityVolume, capacityWeight: $capacityWeight, code: $code)';
}


}

/// @nodoc
abstract mixin class $LocationCapacityCopyWith<$Res>  {
  factory $LocationCapacityCopyWith(LocationCapacity value, $Res Function(LocationCapacity) _then) = _$LocationCapacityCopyWithImpl;
@useResult
$Res call({
 int id, String name, VolumeUsage capacityVolume, WeightUsage capacityWeight, String? code
});


$VolumeUsageCopyWith<$Res> get capacityVolume;$WeightUsageCopyWith<$Res> get capacityWeight;

}
/// @nodoc
class _$LocationCapacityCopyWithImpl<$Res>
    implements $LocationCapacityCopyWith<$Res> {
  _$LocationCapacityCopyWithImpl(this._self, this._then);

  final LocationCapacity _self;
  final $Res Function(LocationCapacity) _then;

/// Create a copy of LocationCapacity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? capacityVolume = null,Object? capacityWeight = null,Object? code = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacityVolume: null == capacityVolume ? _self.capacityVolume : capacityVolume // ignore: cast_nullable_to_non_nullable
as VolumeUsage,capacityWeight: null == capacityWeight ? _self.capacityWeight : capacityWeight // ignore: cast_nullable_to_non_nullable
as WeightUsage,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LocationCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VolumeUsageCopyWith<$Res> get capacityVolume {
  
  return $VolumeUsageCopyWith<$Res>(_self.capacityVolume, (value) {
    return _then(_self.copyWith(capacityVolume: value));
  });
}/// Create a copy of LocationCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeightUsageCopyWith<$Res> get capacityWeight {
  
  return $WeightUsageCopyWith<$Res>(_self.capacityWeight, (value) {
    return _then(_self.copyWith(capacityWeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationCapacity].
extension LocationCapacityPatterns on LocationCapacity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationCapacity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationCapacity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationCapacity value)  $default,){
final _that = this;
switch (_that) {
case _LocationCapacity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationCapacity value)?  $default,){
final _that = this;
switch (_that) {
case _LocationCapacity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationCapacity() when $default != null:
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code)  $default,) {final _that = this;
switch (_that) {
case _LocationCapacity():
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code)?  $default,) {final _that = this;
switch (_that) {
case _LocationCapacity() when $default != null:
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationCapacity implements LocationCapacity {
  const _LocationCapacity({required this.id, required this.name, required this.capacityVolume, required this.capacityWeight, this.code});
  factory _LocationCapacity.fromJson(Map<String, dynamic> json) => _$LocationCapacityFromJson(json);

@override final  int id;
@override final  String name;
@override final  VolumeUsage capacityVolume;
@override final  WeightUsage capacityWeight;
@override final  String? code;

/// Create a copy of LocationCapacity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCapacityCopyWith<_LocationCapacity> get copyWith => __$LocationCapacityCopyWithImpl<_LocationCapacity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationCapacityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationCapacity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacityVolume, capacityVolume) || other.capacityVolume == capacityVolume)&&(identical(other.capacityWeight, capacityWeight) || other.capacityWeight == capacityWeight)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,capacityVolume,capacityWeight,code);

@override
String toString() {
  return 'LocationCapacity(id: $id, name: $name, capacityVolume: $capacityVolume, capacityWeight: $capacityWeight, code: $code)';
}


}

/// @nodoc
abstract mixin class _$LocationCapacityCopyWith<$Res> implements $LocationCapacityCopyWith<$Res> {
  factory _$LocationCapacityCopyWith(_LocationCapacity value, $Res Function(_LocationCapacity) _then) = __$LocationCapacityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, VolumeUsage capacityVolume, WeightUsage capacityWeight, String? code
});


@override $VolumeUsageCopyWith<$Res> get capacityVolume;@override $WeightUsageCopyWith<$Res> get capacityWeight;

}
/// @nodoc
class __$LocationCapacityCopyWithImpl<$Res>
    implements _$LocationCapacityCopyWith<$Res> {
  __$LocationCapacityCopyWithImpl(this._self, this._then);

  final _LocationCapacity _self;
  final $Res Function(_LocationCapacity) _then;

/// Create a copy of LocationCapacity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? capacityVolume = null,Object? capacityWeight = null,Object? code = freezed,}) {
  return _then(_LocationCapacity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacityVolume: null == capacityVolume ? _self.capacityVolume : capacityVolume // ignore: cast_nullable_to_non_nullable
as VolumeUsage,capacityWeight: null == capacityWeight ? _self.capacityWeight : capacityWeight // ignore: cast_nullable_to_non_nullable
as WeightUsage,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LocationCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VolumeUsageCopyWith<$Res> get capacityVolume {
  
  return $VolumeUsageCopyWith<$Res>(_self.capacityVolume, (value) {
    return _then(_self.copyWith(capacityVolume: value));
  });
}/// Create a copy of LocationCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeightUsageCopyWith<$Res> get capacityWeight {
  
  return $WeightUsageCopyWith<$Res>(_self.capacityWeight, (value) {
    return _then(_self.copyWith(capacityWeight: value));
  });
}
}


/// @nodoc
mixin _$ZoneCapacity {

 int get id; String get name; VolumeUsage get capacityVolume; WeightUsage get capacityWeight; String? get code; List<LocationCapacity> get locations;
/// Create a copy of ZoneCapacity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZoneCapacityCopyWith<ZoneCapacity> get copyWith => _$ZoneCapacityCopyWithImpl<ZoneCapacity>(this as ZoneCapacity, _$identity);

  /// Serializes this ZoneCapacity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZoneCapacity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacityVolume, capacityVolume) || other.capacityVolume == capacityVolume)&&(identical(other.capacityWeight, capacityWeight) || other.capacityWeight == capacityWeight)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.locations, locations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,capacityVolume,capacityWeight,code,const DeepCollectionEquality().hash(locations));

@override
String toString() {
  return 'ZoneCapacity(id: $id, name: $name, capacityVolume: $capacityVolume, capacityWeight: $capacityWeight, code: $code, locations: $locations)';
}


}

/// @nodoc
abstract mixin class $ZoneCapacityCopyWith<$Res>  {
  factory $ZoneCapacityCopyWith(ZoneCapacity value, $Res Function(ZoneCapacity) _then) = _$ZoneCapacityCopyWithImpl;
@useResult
$Res call({
 int id, String name, VolumeUsage capacityVolume, WeightUsage capacityWeight, String? code, List<LocationCapacity> locations
});


$VolumeUsageCopyWith<$Res> get capacityVolume;$WeightUsageCopyWith<$Res> get capacityWeight;

}
/// @nodoc
class _$ZoneCapacityCopyWithImpl<$Res>
    implements $ZoneCapacityCopyWith<$Res> {
  _$ZoneCapacityCopyWithImpl(this._self, this._then);

  final ZoneCapacity _self;
  final $Res Function(ZoneCapacity) _then;

/// Create a copy of ZoneCapacity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? capacityVolume = null,Object? capacityWeight = null,Object? code = freezed,Object? locations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacityVolume: null == capacityVolume ? _self.capacityVolume : capacityVolume // ignore: cast_nullable_to_non_nullable
as VolumeUsage,capacityWeight: null == capacityWeight ? _self.capacityWeight : capacityWeight // ignore: cast_nullable_to_non_nullable
as WeightUsage,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<LocationCapacity>,
  ));
}
/// Create a copy of ZoneCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VolumeUsageCopyWith<$Res> get capacityVolume {
  
  return $VolumeUsageCopyWith<$Res>(_self.capacityVolume, (value) {
    return _then(_self.copyWith(capacityVolume: value));
  });
}/// Create a copy of ZoneCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeightUsageCopyWith<$Res> get capacityWeight {
  
  return $WeightUsageCopyWith<$Res>(_self.capacityWeight, (value) {
    return _then(_self.copyWith(capacityWeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [ZoneCapacity].
extension ZoneCapacityPatterns on ZoneCapacity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZoneCapacity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZoneCapacity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZoneCapacity value)  $default,){
final _that = this;
switch (_that) {
case _ZoneCapacity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZoneCapacity value)?  $default,){
final _that = this;
switch (_that) {
case _ZoneCapacity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code,  List<LocationCapacity> locations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZoneCapacity() when $default != null:
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code,_that.locations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code,  List<LocationCapacity> locations)  $default,) {final _that = this;
switch (_that) {
case _ZoneCapacity():
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code,_that.locations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code,  List<LocationCapacity> locations)?  $default,) {final _that = this;
switch (_that) {
case _ZoneCapacity() when $default != null:
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code,_that.locations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ZoneCapacity implements ZoneCapacity {
  const _ZoneCapacity({required this.id, required this.name, required this.capacityVolume, required this.capacityWeight, this.code, final  List<LocationCapacity> locations = const []}): _locations = locations;
  factory _ZoneCapacity.fromJson(Map<String, dynamic> json) => _$ZoneCapacityFromJson(json);

@override final  int id;
@override final  String name;
@override final  VolumeUsage capacityVolume;
@override final  WeightUsage capacityWeight;
@override final  String? code;
 final  List<LocationCapacity> _locations;
@override@JsonKey() List<LocationCapacity> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}


/// Create a copy of ZoneCapacity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZoneCapacityCopyWith<_ZoneCapacity> get copyWith => __$ZoneCapacityCopyWithImpl<_ZoneCapacity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZoneCapacityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZoneCapacity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacityVolume, capacityVolume) || other.capacityVolume == capacityVolume)&&(identical(other.capacityWeight, capacityWeight) || other.capacityWeight == capacityWeight)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other._locations, _locations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,capacityVolume,capacityWeight,code,const DeepCollectionEquality().hash(_locations));

@override
String toString() {
  return 'ZoneCapacity(id: $id, name: $name, capacityVolume: $capacityVolume, capacityWeight: $capacityWeight, code: $code, locations: $locations)';
}


}

/// @nodoc
abstract mixin class _$ZoneCapacityCopyWith<$Res> implements $ZoneCapacityCopyWith<$Res> {
  factory _$ZoneCapacityCopyWith(_ZoneCapacity value, $Res Function(_ZoneCapacity) _then) = __$ZoneCapacityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, VolumeUsage capacityVolume, WeightUsage capacityWeight, String? code, List<LocationCapacity> locations
});


@override $VolumeUsageCopyWith<$Res> get capacityVolume;@override $WeightUsageCopyWith<$Res> get capacityWeight;

}
/// @nodoc
class __$ZoneCapacityCopyWithImpl<$Res>
    implements _$ZoneCapacityCopyWith<$Res> {
  __$ZoneCapacityCopyWithImpl(this._self, this._then);

  final _ZoneCapacity _self;
  final $Res Function(_ZoneCapacity) _then;

/// Create a copy of ZoneCapacity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? capacityVolume = null,Object? capacityWeight = null,Object? code = freezed,Object? locations = null,}) {
  return _then(_ZoneCapacity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacityVolume: null == capacityVolume ? _self.capacityVolume : capacityVolume // ignore: cast_nullable_to_non_nullable
as VolumeUsage,capacityWeight: null == capacityWeight ? _self.capacityWeight : capacityWeight // ignore: cast_nullable_to_non_nullable
as WeightUsage,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<LocationCapacity>,
  ));
}

/// Create a copy of ZoneCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VolumeUsageCopyWith<$Res> get capacityVolume {
  
  return $VolumeUsageCopyWith<$Res>(_self.capacityVolume, (value) {
    return _then(_self.copyWith(capacityVolume: value));
  });
}/// Create a copy of ZoneCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeightUsageCopyWith<$Res> get capacityWeight {
  
  return $WeightUsageCopyWith<$Res>(_self.capacityWeight, (value) {
    return _then(_self.copyWith(capacityWeight: value));
  });
}
}


/// @nodoc
mixin _$WarehouseCapacity {

 int get id; String get name; VolumeUsage get capacityVolume; WeightUsage get capacityWeight; String? get code; List<ZoneCapacity> get zones;
/// Create a copy of WarehouseCapacity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WarehouseCapacityCopyWith<WarehouseCapacity> get copyWith => _$WarehouseCapacityCopyWithImpl<WarehouseCapacity>(this as WarehouseCapacity, _$identity);

  /// Serializes this WarehouseCapacity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WarehouseCapacity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacityVolume, capacityVolume) || other.capacityVolume == capacityVolume)&&(identical(other.capacityWeight, capacityWeight) || other.capacityWeight == capacityWeight)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other.zones, zones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,capacityVolume,capacityWeight,code,const DeepCollectionEquality().hash(zones));

@override
String toString() {
  return 'WarehouseCapacity(id: $id, name: $name, capacityVolume: $capacityVolume, capacityWeight: $capacityWeight, code: $code, zones: $zones)';
}


}

/// @nodoc
abstract mixin class $WarehouseCapacityCopyWith<$Res>  {
  factory $WarehouseCapacityCopyWith(WarehouseCapacity value, $Res Function(WarehouseCapacity) _then) = _$WarehouseCapacityCopyWithImpl;
@useResult
$Res call({
 int id, String name, VolumeUsage capacityVolume, WeightUsage capacityWeight, String? code, List<ZoneCapacity> zones
});


$VolumeUsageCopyWith<$Res> get capacityVolume;$WeightUsageCopyWith<$Res> get capacityWeight;

}
/// @nodoc
class _$WarehouseCapacityCopyWithImpl<$Res>
    implements $WarehouseCapacityCopyWith<$Res> {
  _$WarehouseCapacityCopyWithImpl(this._self, this._then);

  final WarehouseCapacity _self;
  final $Res Function(WarehouseCapacity) _then;

/// Create a copy of WarehouseCapacity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? capacityVolume = null,Object? capacityWeight = null,Object? code = freezed,Object? zones = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacityVolume: null == capacityVolume ? _self.capacityVolume : capacityVolume // ignore: cast_nullable_to_non_nullable
as VolumeUsage,capacityWeight: null == capacityWeight ? _self.capacityWeight : capacityWeight // ignore: cast_nullable_to_non_nullable
as WeightUsage,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,zones: null == zones ? _self.zones : zones // ignore: cast_nullable_to_non_nullable
as List<ZoneCapacity>,
  ));
}
/// Create a copy of WarehouseCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VolumeUsageCopyWith<$Res> get capacityVolume {
  
  return $VolumeUsageCopyWith<$Res>(_self.capacityVolume, (value) {
    return _then(_self.copyWith(capacityVolume: value));
  });
}/// Create a copy of WarehouseCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeightUsageCopyWith<$Res> get capacityWeight {
  
  return $WeightUsageCopyWith<$Res>(_self.capacityWeight, (value) {
    return _then(_self.copyWith(capacityWeight: value));
  });
}
}


/// Adds pattern-matching-related methods to [WarehouseCapacity].
extension WarehouseCapacityPatterns on WarehouseCapacity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WarehouseCapacity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WarehouseCapacity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WarehouseCapacity value)  $default,){
final _that = this;
switch (_that) {
case _WarehouseCapacity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WarehouseCapacity value)?  $default,){
final _that = this;
switch (_that) {
case _WarehouseCapacity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code,  List<ZoneCapacity> zones)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WarehouseCapacity() when $default != null:
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code,_that.zones);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code,  List<ZoneCapacity> zones)  $default,) {final _that = this;
switch (_that) {
case _WarehouseCapacity():
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code,_that.zones);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  VolumeUsage capacityVolume,  WeightUsage capacityWeight,  String? code,  List<ZoneCapacity> zones)?  $default,) {final _that = this;
switch (_that) {
case _WarehouseCapacity() when $default != null:
return $default(_that.id,_that.name,_that.capacityVolume,_that.capacityWeight,_that.code,_that.zones);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WarehouseCapacity implements WarehouseCapacity {
  const _WarehouseCapacity({required this.id, required this.name, required this.capacityVolume, required this.capacityWeight, this.code, final  List<ZoneCapacity> zones = const []}): _zones = zones;
  factory _WarehouseCapacity.fromJson(Map<String, dynamic> json) => _$WarehouseCapacityFromJson(json);

@override final  int id;
@override final  String name;
@override final  VolumeUsage capacityVolume;
@override final  WeightUsage capacityWeight;
@override final  String? code;
 final  List<ZoneCapacity> _zones;
@override@JsonKey() List<ZoneCapacity> get zones {
  if (_zones is EqualUnmodifiableListView) return _zones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_zones);
}


/// Create a copy of WarehouseCapacity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WarehouseCapacityCopyWith<_WarehouseCapacity> get copyWith => __$WarehouseCapacityCopyWithImpl<_WarehouseCapacity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WarehouseCapacityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WarehouseCapacity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacityVolume, capacityVolume) || other.capacityVolume == capacityVolume)&&(identical(other.capacityWeight, capacityWeight) || other.capacityWeight == capacityWeight)&&(identical(other.code, code) || other.code == code)&&const DeepCollectionEquality().equals(other._zones, _zones));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,capacityVolume,capacityWeight,code,const DeepCollectionEquality().hash(_zones));

@override
String toString() {
  return 'WarehouseCapacity(id: $id, name: $name, capacityVolume: $capacityVolume, capacityWeight: $capacityWeight, code: $code, zones: $zones)';
}


}

/// @nodoc
abstract mixin class _$WarehouseCapacityCopyWith<$Res> implements $WarehouseCapacityCopyWith<$Res> {
  factory _$WarehouseCapacityCopyWith(_WarehouseCapacity value, $Res Function(_WarehouseCapacity) _then) = __$WarehouseCapacityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, VolumeUsage capacityVolume, WeightUsage capacityWeight, String? code, List<ZoneCapacity> zones
});


@override $VolumeUsageCopyWith<$Res> get capacityVolume;@override $WeightUsageCopyWith<$Res> get capacityWeight;

}
/// @nodoc
class __$WarehouseCapacityCopyWithImpl<$Res>
    implements _$WarehouseCapacityCopyWith<$Res> {
  __$WarehouseCapacityCopyWithImpl(this._self, this._then);

  final _WarehouseCapacity _self;
  final $Res Function(_WarehouseCapacity) _then;

/// Create a copy of WarehouseCapacity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? capacityVolume = null,Object? capacityWeight = null,Object? code = freezed,Object? zones = null,}) {
  return _then(_WarehouseCapacity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacityVolume: null == capacityVolume ? _self.capacityVolume : capacityVolume // ignore: cast_nullable_to_non_nullable
as VolumeUsage,capacityWeight: null == capacityWeight ? _self.capacityWeight : capacityWeight // ignore: cast_nullable_to_non_nullable
as WeightUsage,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,zones: null == zones ? _self._zones : zones // ignore: cast_nullable_to_non_nullable
as List<ZoneCapacity>,
  ));
}

/// Create a copy of WarehouseCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VolumeUsageCopyWith<$Res> get capacityVolume {
  
  return $VolumeUsageCopyWith<$Res>(_self.capacityVolume, (value) {
    return _then(_self.copyWith(capacityVolume: value));
  });
}/// Create a copy of WarehouseCapacity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WeightUsageCopyWith<$Res> get capacityWeight {
  
  return $WeightUsageCopyWith<$Res>(_self.capacityWeight, (value) {
    return _then(_self.copyWith(capacityWeight: value));
  });
}
}

// dart format on
