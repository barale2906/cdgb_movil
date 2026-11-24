// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generic_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryRef {

 int get id; String get name; String? get code;
/// Create a copy of CategoryRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryRefCopyWith<CategoryRef> get copyWith => _$CategoryRefCopyWithImpl<CategoryRef>(this as CategoryRef, _$identity);

  /// Serializes this CategoryRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'CategoryRef(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class $CategoryRefCopyWith<$Res>  {
  factory $CategoryRefCopyWith(CategoryRef value, $Res Function(CategoryRef) _then) = _$CategoryRefCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code
});




}
/// @nodoc
class _$CategoryRefCopyWithImpl<$Res>
    implements $CategoryRefCopyWith<$Res> {
  _$CategoryRefCopyWithImpl(this._self, this._then);

  final CategoryRef _self;
  final $Res Function(CategoryRef) _then;

/// Create a copy of CategoryRef
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


/// Adds pattern-matching-related methods to [CategoryRef].
extension CategoryRefPatterns on CategoryRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryRef value)  $default,){
final _that = this;
switch (_that) {
case _CategoryRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryRef value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryRef() when $default != null:
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
case _CategoryRef() when $default != null:
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
case _CategoryRef():
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
case _CategoryRef() when $default != null:
return $default(_that.id,_that.name,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryRef implements CategoryRef {
  const _CategoryRef({required this.id, required this.name, this.code});
  factory _CategoryRef.fromJson(Map<String, dynamic> json) => _$CategoryRefFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;

/// Create a copy of CategoryRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryRefCopyWith<_CategoryRef> get copyWith => __$CategoryRefCopyWithImpl<_CategoryRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'CategoryRef(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class _$CategoryRefCopyWith<$Res> implements $CategoryRefCopyWith<$Res> {
  factory _$CategoryRefCopyWith(_CategoryRef value, $Res Function(_CategoryRef) _then) = __$CategoryRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code
});




}
/// @nodoc
class __$CategoryRefCopyWithImpl<$Res>
    implements _$CategoryRefCopyWith<$Res> {
  __$CategoryRefCopyWithImpl(this._self, this._then);

  final _CategoryRef _self;
  final $Res Function(_CategoryRef) _then;

/// Create a copy of CategoryRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,}) {
  return _then(_CategoryRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UnitRef {

 int get id; String get name; String? get abbreviation;
/// Create a copy of UnitRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnitRefCopyWith<UnitRef> get copyWith => _$UnitRefCopyWithImpl<UnitRef>(this as UnitRef, _$identity);

  /// Serializes this UnitRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnitRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,abbreviation);

@override
String toString() {
  return 'UnitRef(id: $id, name: $name, abbreviation: $abbreviation)';
}


}

/// @nodoc
abstract mixin class $UnitRefCopyWith<$Res>  {
  factory $UnitRefCopyWith(UnitRef value, $Res Function(UnitRef) _then) = _$UnitRefCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? abbreviation
});




}
/// @nodoc
class _$UnitRefCopyWithImpl<$Res>
    implements $UnitRefCopyWith<$Res> {
  _$UnitRefCopyWithImpl(this._self, this._then);

  final UnitRef _self;
  final $Res Function(UnitRef) _then;

/// Create a copy of UnitRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? abbreviation = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: freezed == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UnitRef].
extension UnitRefPatterns on UnitRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnitRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnitRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnitRef value)  $default,){
final _that = this;
switch (_that) {
case _UnitRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnitRef value)?  $default,){
final _that = this;
switch (_that) {
case _UnitRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? abbreviation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnitRef() when $default != null:
return $default(_that.id,_that.name,_that.abbreviation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? abbreviation)  $default,) {final _that = this;
switch (_that) {
case _UnitRef():
return $default(_that.id,_that.name,_that.abbreviation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? abbreviation)?  $default,) {final _that = this;
switch (_that) {
case _UnitRef() when $default != null:
return $default(_that.id,_that.name,_that.abbreviation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnitRef implements UnitRef {
  const _UnitRef({required this.id, required this.name, this.abbreviation});
  factory _UnitRef.fromJson(Map<String, dynamic> json) => _$UnitRefFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? abbreviation;

/// Create a copy of UnitRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnitRefCopyWith<_UnitRef> get copyWith => __$UnitRefCopyWithImpl<_UnitRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnitRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnitRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,abbreviation);

@override
String toString() {
  return 'UnitRef(id: $id, name: $name, abbreviation: $abbreviation)';
}


}

/// @nodoc
abstract mixin class _$UnitRefCopyWith<$Res> implements $UnitRefCopyWith<$Res> {
  factory _$UnitRefCopyWith(_UnitRef value, $Res Function(_UnitRef) _then) = __$UnitRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? abbreviation
});




}
/// @nodoc
class __$UnitRefCopyWithImpl<$Res>
    implements _$UnitRefCopyWith<$Res> {
  __$UnitRefCopyWithImpl(this._self, this._then);

  final _UnitRef _self;
  final $Res Function(_UnitRef) _then;

/// Create a copy of UnitRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? abbreviation = freezed,}) {
  return _then(_UnitRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: freezed == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ClassificationRef {

 int get id; String get name; String? get code;
/// Create a copy of ClassificationRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassificationRefCopyWith<ClassificationRef> get copyWith => _$ClassificationRefCopyWithImpl<ClassificationRef>(this as ClassificationRef, _$identity);

  /// Serializes this ClassificationRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassificationRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'ClassificationRef(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class $ClassificationRefCopyWith<$Res>  {
  factory $ClassificationRefCopyWith(ClassificationRef value, $Res Function(ClassificationRef) _then) = _$ClassificationRefCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code
});




}
/// @nodoc
class _$ClassificationRefCopyWithImpl<$Res>
    implements $ClassificationRefCopyWith<$Res> {
  _$ClassificationRefCopyWithImpl(this._self, this._then);

  final ClassificationRef _self;
  final $Res Function(ClassificationRef) _then;

/// Create a copy of ClassificationRef
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


/// Adds pattern-matching-related methods to [ClassificationRef].
extension ClassificationRefPatterns on ClassificationRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassificationRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassificationRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassificationRef value)  $default,){
final _that = this;
switch (_that) {
case _ClassificationRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassificationRef value)?  $default,){
final _that = this;
switch (_that) {
case _ClassificationRef() when $default != null:
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
case _ClassificationRef() when $default != null:
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
case _ClassificationRef():
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
case _ClassificationRef() when $default != null:
return $default(_that.id,_that.name,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClassificationRef implements ClassificationRef {
  const _ClassificationRef({required this.id, required this.name, this.code});
  factory _ClassificationRef.fromJson(Map<String, dynamic> json) => _$ClassificationRefFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;

/// Create a copy of ClassificationRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassificationRefCopyWith<_ClassificationRef> get copyWith => __$ClassificationRefCopyWithImpl<_ClassificationRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClassificationRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassificationRef&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code);

@override
String toString() {
  return 'ClassificationRef(id: $id, name: $name, code: $code)';
}


}

/// @nodoc
abstract mixin class _$ClassificationRefCopyWith<$Res> implements $ClassificationRefCopyWith<$Res> {
  factory _$ClassificationRefCopyWith(_ClassificationRef value, $Res Function(_ClassificationRef) _then) = __$ClassificationRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code
});




}
/// @nodoc
class __$ClassificationRefCopyWithImpl<$Res>
    implements _$ClassificationRefCopyWith<$Res> {
  __$ClassificationRefCopyWithImpl(this._self, this._then);

  final _ClassificationRef _self;
  final $Res Function(_ClassificationRef) _then;

/// Create a copy of ClassificationRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,}) {
  return _then(_ClassificationRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SanitaryRegistration {

 int get id; String get registrationNumber; String? get expiryDate; bool get isActive; bool get isExpired;
/// Create a copy of SanitaryRegistration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SanitaryRegistrationCopyWith<SanitaryRegistration> get copyWith => _$SanitaryRegistrationCopyWithImpl<SanitaryRegistration>(this as SanitaryRegistration, _$identity);

  /// Serializes this SanitaryRegistration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SanitaryRegistration&&(identical(other.id, id) || other.id == id)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,registrationNumber,expiryDate,isActive,isExpired);

@override
String toString() {
  return 'SanitaryRegistration(id: $id, registrationNumber: $registrationNumber, expiryDate: $expiryDate, isActive: $isActive, isExpired: $isExpired)';
}


}

/// @nodoc
abstract mixin class $SanitaryRegistrationCopyWith<$Res>  {
  factory $SanitaryRegistrationCopyWith(SanitaryRegistration value, $Res Function(SanitaryRegistration) _then) = _$SanitaryRegistrationCopyWithImpl;
@useResult
$Res call({
 int id, String registrationNumber, String? expiryDate, bool isActive, bool isExpired
});




}
/// @nodoc
class _$SanitaryRegistrationCopyWithImpl<$Res>
    implements $SanitaryRegistrationCopyWith<$Res> {
  _$SanitaryRegistrationCopyWithImpl(this._self, this._then);

  final SanitaryRegistration _self;
  final $Res Function(SanitaryRegistration) _then;

/// Create a copy of SanitaryRegistration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? registrationNumber = null,Object? expiryDate = freezed,Object? isActive = null,Object? isExpired = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,registrationNumber: null == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SanitaryRegistration].
extension SanitaryRegistrationPatterns on SanitaryRegistration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SanitaryRegistration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SanitaryRegistration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SanitaryRegistration value)  $default,){
final _that = this;
switch (_that) {
case _SanitaryRegistration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SanitaryRegistration value)?  $default,){
final _that = this;
switch (_that) {
case _SanitaryRegistration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String registrationNumber,  String? expiryDate,  bool isActive,  bool isExpired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SanitaryRegistration() when $default != null:
return $default(_that.id,_that.registrationNumber,_that.expiryDate,_that.isActive,_that.isExpired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String registrationNumber,  String? expiryDate,  bool isActive,  bool isExpired)  $default,) {final _that = this;
switch (_that) {
case _SanitaryRegistration():
return $default(_that.id,_that.registrationNumber,_that.expiryDate,_that.isActive,_that.isExpired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String registrationNumber,  String? expiryDate,  bool isActive,  bool isExpired)?  $default,) {final _that = this;
switch (_that) {
case _SanitaryRegistration() when $default != null:
return $default(_that.id,_that.registrationNumber,_that.expiryDate,_that.isActive,_that.isExpired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SanitaryRegistration implements SanitaryRegistration {
  const _SanitaryRegistration({required this.id, required this.registrationNumber, this.expiryDate, this.isActive = true, this.isExpired = false});
  factory _SanitaryRegistration.fromJson(Map<String, dynamic> json) => _$SanitaryRegistrationFromJson(json);

@override final  int id;
@override final  String registrationNumber;
@override final  String? expiryDate;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isExpired;

/// Create a copy of SanitaryRegistration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SanitaryRegistrationCopyWith<_SanitaryRegistration> get copyWith => __$SanitaryRegistrationCopyWithImpl<_SanitaryRegistration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SanitaryRegistrationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SanitaryRegistration&&(identical(other.id, id) || other.id == id)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,registrationNumber,expiryDate,isActive,isExpired);

@override
String toString() {
  return 'SanitaryRegistration(id: $id, registrationNumber: $registrationNumber, expiryDate: $expiryDate, isActive: $isActive, isExpired: $isExpired)';
}


}

/// @nodoc
abstract mixin class _$SanitaryRegistrationCopyWith<$Res> implements $SanitaryRegistrationCopyWith<$Res> {
  factory _$SanitaryRegistrationCopyWith(_SanitaryRegistration value, $Res Function(_SanitaryRegistration) _then) = __$SanitaryRegistrationCopyWithImpl;
@override @useResult
$Res call({
 int id, String registrationNumber, String? expiryDate, bool isActive, bool isExpired
});




}
/// @nodoc
class __$SanitaryRegistrationCopyWithImpl<$Res>
    implements _$SanitaryRegistrationCopyWith<$Res> {
  __$SanitaryRegistrationCopyWithImpl(this._self, this._then);

  final _SanitaryRegistration _self;
  final $Res Function(_SanitaryRegistration) _then;

/// Create a copy of SanitaryRegistration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? registrationNumber = null,Object? expiryDate = freezed,Object? isActive = null,Object? isExpired = null,}) {
  return _then(_SanitaryRegistration(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,registrationNumber: null == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ProductVariant {

 int get id; String? get labBrand; String? get brandSku; String? get commercialPresentation; String? get serieReference; String? get riskLevel; bool get isActive; List<SanitaryRegistration> get sanitaryRegistrations;
/// Create a copy of ProductVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductVariantCopyWith<ProductVariant> get copyWith => _$ProductVariantCopyWithImpl<ProductVariant>(this as ProductVariant, _$identity);

  /// Serializes this ProductVariant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.labBrand, labBrand) || other.labBrand == labBrand)&&(identical(other.brandSku, brandSku) || other.brandSku == brandSku)&&(identical(other.commercialPresentation, commercialPresentation) || other.commercialPresentation == commercialPresentation)&&(identical(other.serieReference, serieReference) || other.serieReference == serieReference)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.sanitaryRegistrations, sanitaryRegistrations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,labBrand,brandSku,commercialPresentation,serieReference,riskLevel,isActive,const DeepCollectionEquality().hash(sanitaryRegistrations));

@override
String toString() {
  return 'ProductVariant(id: $id, labBrand: $labBrand, brandSku: $brandSku, commercialPresentation: $commercialPresentation, serieReference: $serieReference, riskLevel: $riskLevel, isActive: $isActive, sanitaryRegistrations: $sanitaryRegistrations)';
}


}

/// @nodoc
abstract mixin class $ProductVariantCopyWith<$Res>  {
  factory $ProductVariantCopyWith(ProductVariant value, $Res Function(ProductVariant) _then) = _$ProductVariantCopyWithImpl;
@useResult
$Res call({
 int id, String? labBrand, String? brandSku, String? commercialPresentation, String? serieReference, String? riskLevel, bool isActive, List<SanitaryRegistration> sanitaryRegistrations
});




}
/// @nodoc
class _$ProductVariantCopyWithImpl<$Res>
    implements $ProductVariantCopyWith<$Res> {
  _$ProductVariantCopyWithImpl(this._self, this._then);

  final ProductVariant _self;
  final $Res Function(ProductVariant) _then;

/// Create a copy of ProductVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? labBrand = freezed,Object? brandSku = freezed,Object? commercialPresentation = freezed,Object? serieReference = freezed,Object? riskLevel = freezed,Object? isActive = null,Object? sanitaryRegistrations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,labBrand: freezed == labBrand ? _self.labBrand : labBrand // ignore: cast_nullable_to_non_nullable
as String?,brandSku: freezed == brandSku ? _self.brandSku : brandSku // ignore: cast_nullable_to_non_nullable
as String?,commercialPresentation: freezed == commercialPresentation ? _self.commercialPresentation : commercialPresentation // ignore: cast_nullable_to_non_nullable
as String?,serieReference: freezed == serieReference ? _self.serieReference : serieReference // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sanitaryRegistrations: null == sanitaryRegistrations ? _self.sanitaryRegistrations : sanitaryRegistrations // ignore: cast_nullable_to_non_nullable
as List<SanitaryRegistration>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductVariant].
extension ProductVariantPatterns on ProductVariant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductVariant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductVariant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductVariant value)  $default,){
final _that = this;
switch (_that) {
case _ProductVariant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductVariant value)?  $default,){
final _that = this;
switch (_that) {
case _ProductVariant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? labBrand,  String? brandSku,  String? commercialPresentation,  String? serieReference,  String? riskLevel,  bool isActive,  List<SanitaryRegistration> sanitaryRegistrations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductVariant() when $default != null:
return $default(_that.id,_that.labBrand,_that.brandSku,_that.commercialPresentation,_that.serieReference,_that.riskLevel,_that.isActive,_that.sanitaryRegistrations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? labBrand,  String? brandSku,  String? commercialPresentation,  String? serieReference,  String? riskLevel,  bool isActive,  List<SanitaryRegistration> sanitaryRegistrations)  $default,) {final _that = this;
switch (_that) {
case _ProductVariant():
return $default(_that.id,_that.labBrand,_that.brandSku,_that.commercialPresentation,_that.serieReference,_that.riskLevel,_that.isActive,_that.sanitaryRegistrations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? labBrand,  String? brandSku,  String? commercialPresentation,  String? serieReference,  String? riskLevel,  bool isActive,  List<SanitaryRegistration> sanitaryRegistrations)?  $default,) {final _that = this;
switch (_that) {
case _ProductVariant() when $default != null:
return $default(_that.id,_that.labBrand,_that.brandSku,_that.commercialPresentation,_that.serieReference,_that.riskLevel,_that.isActive,_that.sanitaryRegistrations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductVariant implements ProductVariant {
  const _ProductVariant({required this.id, this.labBrand, this.brandSku, this.commercialPresentation, this.serieReference, this.riskLevel, this.isActive = true, final  List<SanitaryRegistration> sanitaryRegistrations = const []}): _sanitaryRegistrations = sanitaryRegistrations;
  factory _ProductVariant.fromJson(Map<String, dynamic> json) => _$ProductVariantFromJson(json);

@override final  int id;
@override final  String? labBrand;
@override final  String? brandSku;
@override final  String? commercialPresentation;
@override final  String? serieReference;
@override final  String? riskLevel;
@override@JsonKey() final  bool isActive;
 final  List<SanitaryRegistration> _sanitaryRegistrations;
@override@JsonKey() List<SanitaryRegistration> get sanitaryRegistrations {
  if (_sanitaryRegistrations is EqualUnmodifiableListView) return _sanitaryRegistrations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sanitaryRegistrations);
}


/// Create a copy of ProductVariant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductVariantCopyWith<_ProductVariant> get copyWith => __$ProductVariantCopyWithImpl<_ProductVariant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductVariantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductVariant&&(identical(other.id, id) || other.id == id)&&(identical(other.labBrand, labBrand) || other.labBrand == labBrand)&&(identical(other.brandSku, brandSku) || other.brandSku == brandSku)&&(identical(other.commercialPresentation, commercialPresentation) || other.commercialPresentation == commercialPresentation)&&(identical(other.serieReference, serieReference) || other.serieReference == serieReference)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._sanitaryRegistrations, _sanitaryRegistrations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,labBrand,brandSku,commercialPresentation,serieReference,riskLevel,isActive,const DeepCollectionEquality().hash(_sanitaryRegistrations));

@override
String toString() {
  return 'ProductVariant(id: $id, labBrand: $labBrand, brandSku: $brandSku, commercialPresentation: $commercialPresentation, serieReference: $serieReference, riskLevel: $riskLevel, isActive: $isActive, sanitaryRegistrations: $sanitaryRegistrations)';
}


}

/// @nodoc
abstract mixin class _$ProductVariantCopyWith<$Res> implements $ProductVariantCopyWith<$Res> {
  factory _$ProductVariantCopyWith(_ProductVariant value, $Res Function(_ProductVariant) _then) = __$ProductVariantCopyWithImpl;
@override @useResult
$Res call({
 int id, String? labBrand, String? brandSku, String? commercialPresentation, String? serieReference, String? riskLevel, bool isActive, List<SanitaryRegistration> sanitaryRegistrations
});




}
/// @nodoc
class __$ProductVariantCopyWithImpl<$Res>
    implements _$ProductVariantCopyWith<$Res> {
  __$ProductVariantCopyWithImpl(this._self, this._then);

  final _ProductVariant _self;
  final $Res Function(_ProductVariant) _then;

/// Create a copy of ProductVariant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? labBrand = freezed,Object? brandSku = freezed,Object? commercialPresentation = freezed,Object? serieReference = freezed,Object? riskLevel = freezed,Object? isActive = null,Object? sanitaryRegistrations = null,}) {
  return _then(_ProductVariant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,labBrand: freezed == labBrand ? _self.labBrand : labBrand // ignore: cast_nullable_to_non_nullable
as String?,brandSku: freezed == brandSku ? _self.brandSku : brandSku // ignore: cast_nullable_to_non_nullable
as String?,commercialPresentation: freezed == commercialPresentation ? _self.commercialPresentation : commercialPresentation // ignore: cast_nullable_to_non_nullable
as String?,serieReference: freezed == serieReference ? _self.serieReference : serieReference // ignore: cast_nullable_to_non_nullable
as String?,riskLevel: freezed == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,sanitaryRegistrations: null == sanitaryRegistrations ? _self._sanitaryRegistrations : sanitaryRegistrations // ignore: cast_nullable_to_non_nullable
as List<SanitaryRegistration>,
  ));
}


}


/// @nodoc
mixin _$KitComponentProduct {

 int get id; String get name; String? get barcode;
/// Create a copy of KitComponentProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KitComponentProductCopyWith<KitComponentProduct> get copyWith => _$KitComponentProductCopyWithImpl<KitComponentProduct>(this as KitComponentProduct, _$identity);

  /// Serializes this KitComponentProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KitComponentProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.barcode, barcode) || other.barcode == barcode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,barcode);

@override
String toString() {
  return 'KitComponentProduct(id: $id, name: $name, barcode: $barcode)';
}


}

/// @nodoc
abstract mixin class $KitComponentProductCopyWith<$Res>  {
  factory $KitComponentProductCopyWith(KitComponentProduct value, $Res Function(KitComponentProduct) _then) = _$KitComponentProductCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? barcode
});




}
/// @nodoc
class _$KitComponentProductCopyWithImpl<$Res>
    implements $KitComponentProductCopyWith<$Res> {
  _$KitComponentProductCopyWithImpl(this._self, this._then);

  final KitComponentProduct _self;
  final $Res Function(KitComponentProduct) _then;

/// Create a copy of KitComponentProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? barcode = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [KitComponentProduct].
extension KitComponentProductPatterns on KitComponentProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KitComponentProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KitComponentProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KitComponentProduct value)  $default,){
final _that = this;
switch (_that) {
case _KitComponentProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KitComponentProduct value)?  $default,){
final _that = this;
switch (_that) {
case _KitComponentProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? barcode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KitComponentProduct() when $default != null:
return $default(_that.id,_that.name,_that.barcode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? barcode)  $default,) {final _that = this;
switch (_that) {
case _KitComponentProduct():
return $default(_that.id,_that.name,_that.barcode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? barcode)?  $default,) {final _that = this;
switch (_that) {
case _KitComponentProduct() when $default != null:
return $default(_that.id,_that.name,_that.barcode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KitComponentProduct implements KitComponentProduct {
  const _KitComponentProduct({required this.id, required this.name, this.barcode});
  factory _KitComponentProduct.fromJson(Map<String, dynamic> json) => _$KitComponentProductFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? barcode;

/// Create a copy of KitComponentProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KitComponentProductCopyWith<_KitComponentProduct> get copyWith => __$KitComponentProductCopyWithImpl<_KitComponentProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KitComponentProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KitComponentProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.barcode, barcode) || other.barcode == barcode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,barcode);

@override
String toString() {
  return 'KitComponentProduct(id: $id, name: $name, barcode: $barcode)';
}


}

/// @nodoc
abstract mixin class _$KitComponentProductCopyWith<$Res> implements $KitComponentProductCopyWith<$Res> {
  factory _$KitComponentProductCopyWith(_KitComponentProduct value, $Res Function(_KitComponentProduct) _then) = __$KitComponentProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? barcode
});




}
/// @nodoc
class __$KitComponentProductCopyWithImpl<$Res>
    implements _$KitComponentProductCopyWith<$Res> {
  __$KitComponentProductCopyWithImpl(this._self, this._then);

  final _KitComponentProduct _self;
  final $Res Function(_KitComponentProduct) _then;

/// Create a copy of KitComponentProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? barcode = freezed,}) {
  return _then(_KitComponentProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$KitComponent {

 int get id;@DoubleConverter() double? get quantityPerKit; KitComponentProduct? get component;
/// Create a copy of KitComponent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KitComponentCopyWith<KitComponent> get copyWith => _$KitComponentCopyWithImpl<KitComponent>(this as KitComponent, _$identity);

  /// Serializes this KitComponent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KitComponent&&(identical(other.id, id) || other.id == id)&&(identical(other.quantityPerKit, quantityPerKit) || other.quantityPerKit == quantityPerKit)&&(identical(other.component, component) || other.component == component));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quantityPerKit,component);

@override
String toString() {
  return 'KitComponent(id: $id, quantityPerKit: $quantityPerKit, component: $component)';
}


}

/// @nodoc
abstract mixin class $KitComponentCopyWith<$Res>  {
  factory $KitComponentCopyWith(KitComponent value, $Res Function(KitComponent) _then) = _$KitComponentCopyWithImpl;
@useResult
$Res call({
 int id,@DoubleConverter() double? quantityPerKit, KitComponentProduct? component
});


$KitComponentProductCopyWith<$Res>? get component;

}
/// @nodoc
class _$KitComponentCopyWithImpl<$Res>
    implements $KitComponentCopyWith<$Res> {
  _$KitComponentCopyWithImpl(this._self, this._then);

  final KitComponent _self;
  final $Res Function(KitComponent) _then;

/// Create a copy of KitComponent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quantityPerKit = freezed,Object? component = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,quantityPerKit: freezed == quantityPerKit ? _self.quantityPerKit : quantityPerKit // ignore: cast_nullable_to_non_nullable
as double?,component: freezed == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as KitComponentProduct?,
  ));
}
/// Create a copy of KitComponent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KitComponentProductCopyWith<$Res>? get component {
    if (_self.component == null) {
    return null;
  }

  return $KitComponentProductCopyWith<$Res>(_self.component!, (value) {
    return _then(_self.copyWith(component: value));
  });
}
}


/// Adds pattern-matching-related methods to [KitComponent].
extension KitComponentPatterns on KitComponent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KitComponent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KitComponent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KitComponent value)  $default,){
final _that = this;
switch (_that) {
case _KitComponent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KitComponent value)?  $default,){
final _that = this;
switch (_that) {
case _KitComponent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @DoubleConverter()  double? quantityPerKit,  KitComponentProduct? component)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KitComponent() when $default != null:
return $default(_that.id,_that.quantityPerKit,_that.component);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @DoubleConverter()  double? quantityPerKit,  KitComponentProduct? component)  $default,) {final _that = this;
switch (_that) {
case _KitComponent():
return $default(_that.id,_that.quantityPerKit,_that.component);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @DoubleConverter()  double? quantityPerKit,  KitComponentProduct? component)?  $default,) {final _that = this;
switch (_that) {
case _KitComponent() when $default != null:
return $default(_that.id,_that.quantityPerKit,_that.component);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KitComponent implements KitComponent {
  const _KitComponent({required this.id, @DoubleConverter() this.quantityPerKit, this.component});
  factory _KitComponent.fromJson(Map<String, dynamic> json) => _$KitComponentFromJson(json);

@override final  int id;
@override@DoubleConverter() final  double? quantityPerKit;
@override final  KitComponentProduct? component;

/// Create a copy of KitComponent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KitComponentCopyWith<_KitComponent> get copyWith => __$KitComponentCopyWithImpl<_KitComponent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KitComponentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KitComponent&&(identical(other.id, id) || other.id == id)&&(identical(other.quantityPerKit, quantityPerKit) || other.quantityPerKit == quantityPerKit)&&(identical(other.component, component) || other.component == component));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quantityPerKit,component);

@override
String toString() {
  return 'KitComponent(id: $id, quantityPerKit: $quantityPerKit, component: $component)';
}


}

/// @nodoc
abstract mixin class _$KitComponentCopyWith<$Res> implements $KitComponentCopyWith<$Res> {
  factory _$KitComponentCopyWith(_KitComponent value, $Res Function(_KitComponent) _then) = __$KitComponentCopyWithImpl;
@override @useResult
$Res call({
 int id,@DoubleConverter() double? quantityPerKit, KitComponentProduct? component
});


@override $KitComponentProductCopyWith<$Res>? get component;

}
/// @nodoc
class __$KitComponentCopyWithImpl<$Res>
    implements _$KitComponentCopyWith<$Res> {
  __$KitComponentCopyWithImpl(this._self, this._then);

  final _KitComponent _self;
  final $Res Function(_KitComponent) _then;

/// Create a copy of KitComponent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quantityPerKit = freezed,Object? component = freezed,}) {
  return _then(_KitComponent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,quantityPerKit: freezed == quantityPerKit ? _self.quantityPerKit : quantityPerKit // ignore: cast_nullable_to_non_nullable
as double?,component: freezed == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as KitComponentProduct?,
  ));
}

/// Create a copy of KitComponent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KitComponentProductCopyWith<$Res>? get component {
    if (_self.component == null) {
    return null;
  }

  return $KitComponentProductCopyWith<$Res>(_self.component!, (value) {
    return _then(_self.copyWith(component: value));
  });
}
}


/// @nodoc
mixin _$GenericProduct {

 int get id; String get name;@ProductTypeConverter() ProductType get productType; String? get barcode; String? get description; String? get concentration; String? get pharmaceuticalForm; bool get requiresColdChain;@DoubleConverter() double? get minStock;@DoubleConverter() double? get maxStock;@DoubleConverter() double? get reorderPoint;@DoubleConverter() double? get reorderQuantity; bool get isActive; CategoryRef? get category; UnitRef? get baseUnit; ClassificationRef? get classification; List<ProductVariant> get variants; List<KitComponent> get components;
/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenericProductCopyWith<GenericProduct> get copyWith => _$GenericProductCopyWithImpl<GenericProduct>(this as GenericProduct, _$identity);

  /// Serializes this GenericProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenericProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.description, description) || other.description == description)&&(identical(other.concentration, concentration) || other.concentration == concentration)&&(identical(other.pharmaceuticalForm, pharmaceuticalForm) || other.pharmaceuticalForm == pharmaceuticalForm)&&(identical(other.requiresColdChain, requiresColdChain) || other.requiresColdChain == requiresColdChain)&&(identical(other.minStock, minStock) || other.minStock == minStock)&&(identical(other.maxStock, maxStock) || other.maxStock == maxStock)&&(identical(other.reorderPoint, reorderPoint) || other.reorderPoint == reorderPoint)&&(identical(other.reorderQuantity, reorderQuantity) || other.reorderQuantity == reorderQuantity)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.category, category) || other.category == category)&&(identical(other.baseUnit, baseUnit) || other.baseUnit == baseUnit)&&(identical(other.classification, classification) || other.classification == classification)&&const DeepCollectionEquality().equals(other.variants, variants)&&const DeepCollectionEquality().equals(other.components, components));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,productType,barcode,description,concentration,pharmaceuticalForm,requiresColdChain,minStock,maxStock,reorderPoint,reorderQuantity,isActive,category,baseUnit,classification,const DeepCollectionEquality().hash(variants),const DeepCollectionEquality().hash(components));

@override
String toString() {
  return 'GenericProduct(id: $id, name: $name, productType: $productType, barcode: $barcode, description: $description, concentration: $concentration, pharmaceuticalForm: $pharmaceuticalForm, requiresColdChain: $requiresColdChain, minStock: $minStock, maxStock: $maxStock, reorderPoint: $reorderPoint, reorderQuantity: $reorderQuantity, isActive: $isActive, category: $category, baseUnit: $baseUnit, classification: $classification, variants: $variants, components: $components)';
}


}

/// @nodoc
abstract mixin class $GenericProductCopyWith<$Res>  {
  factory $GenericProductCopyWith(GenericProduct value, $Res Function(GenericProduct) _then) = _$GenericProductCopyWithImpl;
@useResult
$Res call({
 int id, String name,@ProductTypeConverter() ProductType productType, String? barcode, String? description, String? concentration, String? pharmaceuticalForm, bool requiresColdChain,@DoubleConverter() double? minStock,@DoubleConverter() double? maxStock,@DoubleConverter() double? reorderPoint,@DoubleConverter() double? reorderQuantity, bool isActive, CategoryRef? category, UnitRef? baseUnit, ClassificationRef? classification, List<ProductVariant> variants, List<KitComponent> components
});


$CategoryRefCopyWith<$Res>? get category;$UnitRefCopyWith<$Res>? get baseUnit;$ClassificationRefCopyWith<$Res>? get classification;

}
/// @nodoc
class _$GenericProductCopyWithImpl<$Res>
    implements $GenericProductCopyWith<$Res> {
  _$GenericProductCopyWithImpl(this._self, this._then);

  final GenericProduct _self;
  final $Res Function(GenericProduct) _then;

/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? productType = null,Object? barcode = freezed,Object? description = freezed,Object? concentration = freezed,Object? pharmaceuticalForm = freezed,Object? requiresColdChain = null,Object? minStock = freezed,Object? maxStock = freezed,Object? reorderPoint = freezed,Object? reorderQuantity = freezed,Object? isActive = null,Object? category = freezed,Object? baseUnit = freezed,Object? classification = freezed,Object? variants = null,Object? components = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as ProductType,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,concentration: freezed == concentration ? _self.concentration : concentration // ignore: cast_nullable_to_non_nullable
as String?,pharmaceuticalForm: freezed == pharmaceuticalForm ? _self.pharmaceuticalForm : pharmaceuticalForm // ignore: cast_nullable_to_non_nullable
as String?,requiresColdChain: null == requiresColdChain ? _self.requiresColdChain : requiresColdChain // ignore: cast_nullable_to_non_nullable
as bool,minStock: freezed == minStock ? _self.minStock : minStock // ignore: cast_nullable_to_non_nullable
as double?,maxStock: freezed == maxStock ? _self.maxStock : maxStock // ignore: cast_nullable_to_non_nullable
as double?,reorderPoint: freezed == reorderPoint ? _self.reorderPoint : reorderPoint // ignore: cast_nullable_to_non_nullable
as double?,reorderQuantity: freezed == reorderQuantity ? _self.reorderQuantity : reorderQuantity // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryRef?,baseUnit: freezed == baseUnit ? _self.baseUnit : baseUnit // ignore: cast_nullable_to_non_nullable
as UnitRef?,classification: freezed == classification ? _self.classification : classification // ignore: cast_nullable_to_non_nullable
as ClassificationRef?,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariant>,components: null == components ? _self.components : components // ignore: cast_nullable_to_non_nullable
as List<KitComponent>,
  ));
}
/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryRefCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $CategoryRefCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitRefCopyWith<$Res>? get baseUnit {
    if (_self.baseUnit == null) {
    return null;
  }

  return $UnitRefCopyWith<$Res>(_self.baseUnit!, (value) {
    return _then(_self.copyWith(baseUnit: value));
  });
}/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassificationRefCopyWith<$Res>? get classification {
    if (_self.classification == null) {
    return null;
  }

  return $ClassificationRefCopyWith<$Res>(_self.classification!, (value) {
    return _then(_self.copyWith(classification: value));
  });
}
}


/// Adds pattern-matching-related methods to [GenericProduct].
extension GenericProductPatterns on GenericProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenericProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenericProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenericProduct value)  $default,){
final _that = this;
switch (_that) {
case _GenericProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenericProduct value)?  $default,){
final _that = this;
switch (_that) {
case _GenericProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @ProductTypeConverter()  ProductType productType,  String? barcode,  String? description,  String? concentration,  String? pharmaceuticalForm,  bool requiresColdChain, @DoubleConverter()  double? minStock, @DoubleConverter()  double? maxStock, @DoubleConverter()  double? reorderPoint, @DoubleConverter()  double? reorderQuantity,  bool isActive,  CategoryRef? category,  UnitRef? baseUnit,  ClassificationRef? classification,  List<ProductVariant> variants,  List<KitComponent> components)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenericProduct() when $default != null:
return $default(_that.id,_that.name,_that.productType,_that.barcode,_that.description,_that.concentration,_that.pharmaceuticalForm,_that.requiresColdChain,_that.minStock,_that.maxStock,_that.reorderPoint,_that.reorderQuantity,_that.isActive,_that.category,_that.baseUnit,_that.classification,_that.variants,_that.components);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @ProductTypeConverter()  ProductType productType,  String? barcode,  String? description,  String? concentration,  String? pharmaceuticalForm,  bool requiresColdChain, @DoubleConverter()  double? minStock, @DoubleConverter()  double? maxStock, @DoubleConverter()  double? reorderPoint, @DoubleConverter()  double? reorderQuantity,  bool isActive,  CategoryRef? category,  UnitRef? baseUnit,  ClassificationRef? classification,  List<ProductVariant> variants,  List<KitComponent> components)  $default,) {final _that = this;
switch (_that) {
case _GenericProduct():
return $default(_that.id,_that.name,_that.productType,_that.barcode,_that.description,_that.concentration,_that.pharmaceuticalForm,_that.requiresColdChain,_that.minStock,_that.maxStock,_that.reorderPoint,_that.reorderQuantity,_that.isActive,_that.category,_that.baseUnit,_that.classification,_that.variants,_that.components);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @ProductTypeConverter()  ProductType productType,  String? barcode,  String? description,  String? concentration,  String? pharmaceuticalForm,  bool requiresColdChain, @DoubleConverter()  double? minStock, @DoubleConverter()  double? maxStock, @DoubleConverter()  double? reorderPoint, @DoubleConverter()  double? reorderQuantity,  bool isActive,  CategoryRef? category,  UnitRef? baseUnit,  ClassificationRef? classification,  List<ProductVariant> variants,  List<KitComponent> components)?  $default,) {final _that = this;
switch (_that) {
case _GenericProduct() when $default != null:
return $default(_that.id,_that.name,_that.productType,_that.barcode,_that.description,_that.concentration,_that.pharmaceuticalForm,_that.requiresColdChain,_that.minStock,_that.maxStock,_that.reorderPoint,_that.reorderQuantity,_that.isActive,_that.category,_that.baseUnit,_that.classification,_that.variants,_that.components);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenericProduct implements GenericProduct {
  const _GenericProduct({required this.id, required this.name, @ProductTypeConverter() this.productType = ProductType.simple, this.barcode, this.description, this.concentration, this.pharmaceuticalForm, this.requiresColdChain = false, @DoubleConverter() this.minStock, @DoubleConverter() this.maxStock, @DoubleConverter() this.reorderPoint, @DoubleConverter() this.reorderQuantity, this.isActive = true, this.category, this.baseUnit, this.classification, final  List<ProductVariant> variants = const [], final  List<KitComponent> components = const []}): _variants = variants,_components = components;
  factory _GenericProduct.fromJson(Map<String, dynamic> json) => _$GenericProductFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey()@ProductTypeConverter() final  ProductType productType;
@override final  String? barcode;
@override final  String? description;
@override final  String? concentration;
@override final  String? pharmaceuticalForm;
@override@JsonKey() final  bool requiresColdChain;
@override@DoubleConverter() final  double? minStock;
@override@DoubleConverter() final  double? maxStock;
@override@DoubleConverter() final  double? reorderPoint;
@override@DoubleConverter() final  double? reorderQuantity;
@override@JsonKey() final  bool isActive;
@override final  CategoryRef? category;
@override final  UnitRef? baseUnit;
@override final  ClassificationRef? classification;
 final  List<ProductVariant> _variants;
@override@JsonKey() List<ProductVariant> get variants {
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variants);
}

 final  List<KitComponent> _components;
@override@JsonKey() List<KitComponent> get components {
  if (_components is EqualUnmodifiableListView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_components);
}


/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenericProductCopyWith<_GenericProduct> get copyWith => __$GenericProductCopyWithImpl<_GenericProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenericProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenericProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.description, description) || other.description == description)&&(identical(other.concentration, concentration) || other.concentration == concentration)&&(identical(other.pharmaceuticalForm, pharmaceuticalForm) || other.pharmaceuticalForm == pharmaceuticalForm)&&(identical(other.requiresColdChain, requiresColdChain) || other.requiresColdChain == requiresColdChain)&&(identical(other.minStock, minStock) || other.minStock == minStock)&&(identical(other.maxStock, maxStock) || other.maxStock == maxStock)&&(identical(other.reorderPoint, reorderPoint) || other.reorderPoint == reorderPoint)&&(identical(other.reorderQuantity, reorderQuantity) || other.reorderQuantity == reorderQuantity)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.category, category) || other.category == category)&&(identical(other.baseUnit, baseUnit) || other.baseUnit == baseUnit)&&(identical(other.classification, classification) || other.classification == classification)&&const DeepCollectionEquality().equals(other._variants, _variants)&&const DeepCollectionEquality().equals(other._components, _components));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,productType,barcode,description,concentration,pharmaceuticalForm,requiresColdChain,minStock,maxStock,reorderPoint,reorderQuantity,isActive,category,baseUnit,classification,const DeepCollectionEquality().hash(_variants),const DeepCollectionEquality().hash(_components));

@override
String toString() {
  return 'GenericProduct(id: $id, name: $name, productType: $productType, barcode: $barcode, description: $description, concentration: $concentration, pharmaceuticalForm: $pharmaceuticalForm, requiresColdChain: $requiresColdChain, minStock: $minStock, maxStock: $maxStock, reorderPoint: $reorderPoint, reorderQuantity: $reorderQuantity, isActive: $isActive, category: $category, baseUnit: $baseUnit, classification: $classification, variants: $variants, components: $components)';
}


}

/// @nodoc
abstract mixin class _$GenericProductCopyWith<$Res> implements $GenericProductCopyWith<$Res> {
  factory _$GenericProductCopyWith(_GenericProduct value, $Res Function(_GenericProduct) _then) = __$GenericProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@ProductTypeConverter() ProductType productType, String? barcode, String? description, String? concentration, String? pharmaceuticalForm, bool requiresColdChain,@DoubleConverter() double? minStock,@DoubleConverter() double? maxStock,@DoubleConverter() double? reorderPoint,@DoubleConverter() double? reorderQuantity, bool isActive, CategoryRef? category, UnitRef? baseUnit, ClassificationRef? classification, List<ProductVariant> variants, List<KitComponent> components
});


@override $CategoryRefCopyWith<$Res>? get category;@override $UnitRefCopyWith<$Res>? get baseUnit;@override $ClassificationRefCopyWith<$Res>? get classification;

}
/// @nodoc
class __$GenericProductCopyWithImpl<$Res>
    implements _$GenericProductCopyWith<$Res> {
  __$GenericProductCopyWithImpl(this._self, this._then);

  final _GenericProduct _self;
  final $Res Function(_GenericProduct) _then;

/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? productType = null,Object? barcode = freezed,Object? description = freezed,Object? concentration = freezed,Object? pharmaceuticalForm = freezed,Object? requiresColdChain = null,Object? minStock = freezed,Object? maxStock = freezed,Object? reorderPoint = freezed,Object? reorderQuantity = freezed,Object? isActive = null,Object? category = freezed,Object? baseUnit = freezed,Object? classification = freezed,Object? variants = null,Object? components = null,}) {
  return _then(_GenericProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as ProductType,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,concentration: freezed == concentration ? _self.concentration : concentration // ignore: cast_nullable_to_non_nullable
as String?,pharmaceuticalForm: freezed == pharmaceuticalForm ? _self.pharmaceuticalForm : pharmaceuticalForm // ignore: cast_nullable_to_non_nullable
as String?,requiresColdChain: null == requiresColdChain ? _self.requiresColdChain : requiresColdChain // ignore: cast_nullable_to_non_nullable
as bool,minStock: freezed == minStock ? _self.minStock : minStock // ignore: cast_nullable_to_non_nullable
as double?,maxStock: freezed == maxStock ? _self.maxStock : maxStock // ignore: cast_nullable_to_non_nullable
as double?,reorderPoint: freezed == reorderPoint ? _self.reorderPoint : reorderPoint // ignore: cast_nullable_to_non_nullable
as double?,reorderQuantity: freezed == reorderQuantity ? _self.reorderQuantity : reorderQuantity // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryRef?,baseUnit: freezed == baseUnit ? _self.baseUnit : baseUnit // ignore: cast_nullable_to_non_nullable
as UnitRef?,classification: freezed == classification ? _self.classification : classification // ignore: cast_nullable_to_non_nullable
as ClassificationRef?,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<ProductVariant>,components: null == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as List<KitComponent>,
  ));
}

/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryRefCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $CategoryRefCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnitRefCopyWith<$Res>? get baseUnit {
    if (_self.baseUnit == null) {
    return null;
  }

  return $UnitRefCopyWith<$Res>(_self.baseUnit!, (value) {
    return _then(_self.copyWith(baseUnit: value));
  });
}/// Create a copy of GenericProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClassificationRefCopyWith<$Res>? get classification {
    if (_self.classification == null) {
    return null;
  }

  return $ClassificationRefCopyWith<$Res>(_self.classification!, (value) {
    return _then(_self.copyWith(classification: value));
  });
}
}

// dart format on
