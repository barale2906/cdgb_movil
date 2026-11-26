// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_catalogs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssetSite {

 int get id; String get name; List<AssetPlace> get places;
/// Create a copy of AssetSite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetSiteCopyWith<AssetSite> get copyWith => _$AssetSiteCopyWithImpl<AssetSite>(this as AssetSite, _$identity);

  /// Serializes this AssetSite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetSite&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.places, places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(places));

@override
String toString() {
  return 'AssetSite(id: $id, name: $name, places: $places)';
}


}

/// @nodoc
abstract mixin class $AssetSiteCopyWith<$Res>  {
  factory $AssetSiteCopyWith(AssetSite value, $Res Function(AssetSite) _then) = _$AssetSiteCopyWithImpl;
@useResult
$Res call({
 int id, String name, List<AssetPlace> places
});




}
/// @nodoc
class _$AssetSiteCopyWithImpl<$Res>
    implements $AssetSiteCopyWith<$Res> {
  _$AssetSiteCopyWithImpl(this._self, this._then);

  final AssetSite _self;
  final $Res Function(AssetSite) _then;

/// Create a copy of AssetSite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? places = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<AssetPlace>,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetSite].
extension AssetSitePatterns on AssetSite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetSite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetSite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetSite value)  $default,){
final _that = this;
switch (_that) {
case _AssetSite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetSite value)?  $default,){
final _that = this;
switch (_that) {
case _AssetSite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  List<AssetPlace> places)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetSite() when $default != null:
return $default(_that.id,_that.name,_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  List<AssetPlace> places)  $default,) {final _that = this;
switch (_that) {
case _AssetSite():
return $default(_that.id,_that.name,_that.places);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  List<AssetPlace> places)?  $default,) {final _that = this;
switch (_that) {
case _AssetSite() when $default != null:
return $default(_that.id,_that.name,_that.places);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetSite implements AssetSite {
  const _AssetSite({required this.id, required this.name, final  List<AssetPlace> places = const []}): _places = places;
  factory _AssetSite.fromJson(Map<String, dynamic> json) => _$AssetSiteFromJson(json);

@override final  int id;
@override final  String name;
 final  List<AssetPlace> _places;
@override@JsonKey() List<AssetPlace> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of AssetSite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetSiteCopyWith<_AssetSite> get copyWith => __$AssetSiteCopyWithImpl<_AssetSite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetSiteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetSite&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._places, _places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_places));

@override
String toString() {
  return 'AssetSite(id: $id, name: $name, places: $places)';
}


}

/// @nodoc
abstract mixin class _$AssetSiteCopyWith<$Res> implements $AssetSiteCopyWith<$Res> {
  factory _$AssetSiteCopyWith(_AssetSite value, $Res Function(_AssetSite) _then) = __$AssetSiteCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, List<AssetPlace> places
});




}
/// @nodoc
class __$AssetSiteCopyWithImpl<$Res>
    implements _$AssetSiteCopyWith<$Res> {
  __$AssetSiteCopyWithImpl(this._self, this._then);

  final _AssetSite _self;
  final $Res Function(_AssetSite) _then;

/// Create a copy of AssetSite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? places = null,}) {
  return _then(_AssetSite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<AssetPlace>,
  ));
}


}


/// @nodoc
mixin _$AssetPlace {

 int get id; String get name;
/// Create a copy of AssetPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetPlaceCopyWith<AssetPlace> get copyWith => _$AssetPlaceCopyWithImpl<AssetPlace>(this as AssetPlace, _$identity);

  /// Serializes this AssetPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'AssetPlace(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $AssetPlaceCopyWith<$Res>  {
  factory $AssetPlaceCopyWith(AssetPlace value, $Res Function(AssetPlace) _then) = _$AssetPlaceCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$AssetPlaceCopyWithImpl<$Res>
    implements $AssetPlaceCopyWith<$Res> {
  _$AssetPlaceCopyWithImpl(this._self, this._then);

  final AssetPlace _self;
  final $Res Function(AssetPlace) _then;

/// Create a copy of AssetPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetPlace].
extension AssetPlacePatterns on AssetPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetPlace value)  $default,){
final _that = this;
switch (_that) {
case _AssetPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetPlace value)?  $default,){
final _that = this;
switch (_that) {
case _AssetPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetPlace() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name)  $default,) {final _that = this;
switch (_that) {
case _AssetPlace():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _AssetPlace() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetPlace implements AssetPlace {
  const _AssetPlace({required this.id, required this.name});
  factory _AssetPlace.fromJson(Map<String, dynamic> json) => _$AssetPlaceFromJson(json);

@override final  int id;
@override final  String name;

/// Create a copy of AssetPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetPlaceCopyWith<_AssetPlace> get copyWith => __$AssetPlaceCopyWithImpl<_AssetPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'AssetPlace(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$AssetPlaceCopyWith<$Res> implements $AssetPlaceCopyWith<$Res> {
  factory _$AssetPlaceCopyWith(_AssetPlace value, $Res Function(_AssetPlace) _then) = __$AssetPlaceCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$AssetPlaceCopyWithImpl<$Res>
    implements _$AssetPlaceCopyWith<$Res> {
  __$AssetPlaceCopyWithImpl(this._self, this._then);

  final _AssetPlace _self;
  final $Res Function(_AssetPlace) _then;

/// Create a copy of AssetPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_AssetPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CatalogOption {

 String get value; String get label; bool get requiresSignature;
/// Create a copy of CatalogOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogOptionCopyWith<CatalogOption> get copyWith => _$CatalogOptionCopyWithImpl<CatalogOption>(this as CatalogOption, _$identity);

  /// Serializes this CatalogOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogOption&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.requiresSignature, requiresSignature) || other.requiresSignature == requiresSignature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label,requiresSignature);

@override
String toString() {
  return 'CatalogOption(value: $value, label: $label, requiresSignature: $requiresSignature)';
}


}

/// @nodoc
abstract mixin class $CatalogOptionCopyWith<$Res>  {
  factory $CatalogOptionCopyWith(CatalogOption value, $Res Function(CatalogOption) _then) = _$CatalogOptionCopyWithImpl;
@useResult
$Res call({
 String value, String label, bool requiresSignature
});




}
/// @nodoc
class _$CatalogOptionCopyWithImpl<$Res>
    implements $CatalogOptionCopyWith<$Res> {
  _$CatalogOptionCopyWithImpl(this._self, this._then);

  final CatalogOption _self;
  final $Res Function(CatalogOption) _then;

/// Create a copy of CatalogOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,Object? requiresSignature = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,requiresSignature: null == requiresSignature ? _self.requiresSignature : requiresSignature // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogOption].
extension CatalogOptionPatterns on CatalogOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogOption value)  $default,){
final _that = this;
switch (_that) {
case _CatalogOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogOption value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String label,  bool requiresSignature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogOption() when $default != null:
return $default(_that.value,_that.label,_that.requiresSignature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String label,  bool requiresSignature)  $default,) {final _that = this;
switch (_that) {
case _CatalogOption():
return $default(_that.value,_that.label,_that.requiresSignature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String label,  bool requiresSignature)?  $default,) {final _that = this;
switch (_that) {
case _CatalogOption() when $default != null:
return $default(_that.value,_that.label,_that.requiresSignature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogOption implements CatalogOption {
  const _CatalogOption({required this.value, required this.label, this.requiresSignature = false});
  factory _CatalogOption.fromJson(Map<String, dynamic> json) => _$CatalogOptionFromJson(json);

@override final  String value;
@override final  String label;
@override@JsonKey() final  bool requiresSignature;

/// Create a copy of CatalogOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogOptionCopyWith<_CatalogOption> get copyWith => __$CatalogOptionCopyWithImpl<_CatalogOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogOption&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.requiresSignature, requiresSignature) || other.requiresSignature == requiresSignature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label,requiresSignature);

@override
String toString() {
  return 'CatalogOption(value: $value, label: $label, requiresSignature: $requiresSignature)';
}


}

/// @nodoc
abstract mixin class _$CatalogOptionCopyWith<$Res> implements $CatalogOptionCopyWith<$Res> {
  factory _$CatalogOptionCopyWith(_CatalogOption value, $Res Function(_CatalogOption) _then) = __$CatalogOptionCopyWithImpl;
@override @useResult
$Res call({
 String value, String label, bool requiresSignature
});




}
/// @nodoc
class __$CatalogOptionCopyWithImpl<$Res>
    implements _$CatalogOptionCopyWith<$Res> {
  __$CatalogOptionCopyWithImpl(this._self, this._then);

  final _CatalogOption _self;
  final $Res Function(_CatalogOption) _then;

/// Create a copy of CatalogOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,Object? requiresSignature = null,}) {
  return _then(_CatalogOption(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,requiresSignature: null == requiresSignature ? _self.requiresSignature : requiresSignature // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AssetFilters {

 List<AssetSite> get sites; List<CatalogOption> get transferTypes; List<CatalogOption> get maintenanceResults; List<CatalogOption> get documentTypes; List<CatalogOption> get settableStatuses;
/// Create a copy of AssetFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetFiltersCopyWith<AssetFilters> get copyWith => _$AssetFiltersCopyWithImpl<AssetFilters>(this as AssetFilters, _$identity);

  /// Serializes this AssetFilters to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetFilters&&const DeepCollectionEquality().equals(other.sites, sites)&&const DeepCollectionEquality().equals(other.transferTypes, transferTypes)&&const DeepCollectionEquality().equals(other.maintenanceResults, maintenanceResults)&&const DeepCollectionEquality().equals(other.documentTypes, documentTypes)&&const DeepCollectionEquality().equals(other.settableStatuses, settableStatuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sites),const DeepCollectionEquality().hash(transferTypes),const DeepCollectionEquality().hash(maintenanceResults),const DeepCollectionEquality().hash(documentTypes),const DeepCollectionEquality().hash(settableStatuses));

@override
String toString() {
  return 'AssetFilters(sites: $sites, transferTypes: $transferTypes, maintenanceResults: $maintenanceResults, documentTypes: $documentTypes, settableStatuses: $settableStatuses)';
}


}

/// @nodoc
abstract mixin class $AssetFiltersCopyWith<$Res>  {
  factory $AssetFiltersCopyWith(AssetFilters value, $Res Function(AssetFilters) _then) = _$AssetFiltersCopyWithImpl;
@useResult
$Res call({
 List<AssetSite> sites, List<CatalogOption> transferTypes, List<CatalogOption> maintenanceResults, List<CatalogOption> documentTypes, List<CatalogOption> settableStatuses
});




}
/// @nodoc
class _$AssetFiltersCopyWithImpl<$Res>
    implements $AssetFiltersCopyWith<$Res> {
  _$AssetFiltersCopyWithImpl(this._self, this._then);

  final AssetFilters _self;
  final $Res Function(AssetFilters) _then;

/// Create a copy of AssetFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sites = null,Object? transferTypes = null,Object? maintenanceResults = null,Object? documentTypes = null,Object? settableStatuses = null,}) {
  return _then(_self.copyWith(
sites: null == sites ? _self.sites : sites // ignore: cast_nullable_to_non_nullable
as List<AssetSite>,transferTypes: null == transferTypes ? _self.transferTypes : transferTypes // ignore: cast_nullable_to_non_nullable
as List<CatalogOption>,maintenanceResults: null == maintenanceResults ? _self.maintenanceResults : maintenanceResults // ignore: cast_nullable_to_non_nullable
as List<CatalogOption>,documentTypes: null == documentTypes ? _self.documentTypes : documentTypes // ignore: cast_nullable_to_non_nullable
as List<CatalogOption>,settableStatuses: null == settableStatuses ? _self.settableStatuses : settableStatuses // ignore: cast_nullable_to_non_nullable
as List<CatalogOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetFilters].
extension AssetFiltersPatterns on AssetFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetFilters value)  $default,){
final _that = this;
switch (_that) {
case _AssetFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetFilters value)?  $default,){
final _that = this;
switch (_that) {
case _AssetFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AssetSite> sites,  List<CatalogOption> transferTypes,  List<CatalogOption> maintenanceResults,  List<CatalogOption> documentTypes,  List<CatalogOption> settableStatuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetFilters() when $default != null:
return $default(_that.sites,_that.transferTypes,_that.maintenanceResults,_that.documentTypes,_that.settableStatuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AssetSite> sites,  List<CatalogOption> transferTypes,  List<CatalogOption> maintenanceResults,  List<CatalogOption> documentTypes,  List<CatalogOption> settableStatuses)  $default,) {final _that = this;
switch (_that) {
case _AssetFilters():
return $default(_that.sites,_that.transferTypes,_that.maintenanceResults,_that.documentTypes,_that.settableStatuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AssetSite> sites,  List<CatalogOption> transferTypes,  List<CatalogOption> maintenanceResults,  List<CatalogOption> documentTypes,  List<CatalogOption> settableStatuses)?  $default,) {final _that = this;
switch (_that) {
case _AssetFilters() when $default != null:
return $default(_that.sites,_that.transferTypes,_that.maintenanceResults,_that.documentTypes,_that.settableStatuses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetFilters implements AssetFilters {
  const _AssetFilters({final  List<AssetSite> sites = const [], final  List<CatalogOption> transferTypes = const [], final  List<CatalogOption> maintenanceResults = const [], final  List<CatalogOption> documentTypes = const [], final  List<CatalogOption> settableStatuses = const []}): _sites = sites,_transferTypes = transferTypes,_maintenanceResults = maintenanceResults,_documentTypes = documentTypes,_settableStatuses = settableStatuses;
  factory _AssetFilters.fromJson(Map<String, dynamic> json) => _$AssetFiltersFromJson(json);

 final  List<AssetSite> _sites;
@override@JsonKey() List<AssetSite> get sites {
  if (_sites is EqualUnmodifiableListView) return _sites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sites);
}

 final  List<CatalogOption> _transferTypes;
@override@JsonKey() List<CatalogOption> get transferTypes {
  if (_transferTypes is EqualUnmodifiableListView) return _transferTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transferTypes);
}

 final  List<CatalogOption> _maintenanceResults;
@override@JsonKey() List<CatalogOption> get maintenanceResults {
  if (_maintenanceResults is EqualUnmodifiableListView) return _maintenanceResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_maintenanceResults);
}

 final  List<CatalogOption> _documentTypes;
@override@JsonKey() List<CatalogOption> get documentTypes {
  if (_documentTypes is EqualUnmodifiableListView) return _documentTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documentTypes);
}

 final  List<CatalogOption> _settableStatuses;
@override@JsonKey() List<CatalogOption> get settableStatuses {
  if (_settableStatuses is EqualUnmodifiableListView) return _settableStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_settableStatuses);
}


/// Create a copy of AssetFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetFiltersCopyWith<_AssetFilters> get copyWith => __$AssetFiltersCopyWithImpl<_AssetFilters>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetFiltersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetFilters&&const DeepCollectionEquality().equals(other._sites, _sites)&&const DeepCollectionEquality().equals(other._transferTypes, _transferTypes)&&const DeepCollectionEquality().equals(other._maintenanceResults, _maintenanceResults)&&const DeepCollectionEquality().equals(other._documentTypes, _documentTypes)&&const DeepCollectionEquality().equals(other._settableStatuses, _settableStatuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sites),const DeepCollectionEquality().hash(_transferTypes),const DeepCollectionEquality().hash(_maintenanceResults),const DeepCollectionEquality().hash(_documentTypes),const DeepCollectionEquality().hash(_settableStatuses));

@override
String toString() {
  return 'AssetFilters(sites: $sites, transferTypes: $transferTypes, maintenanceResults: $maintenanceResults, documentTypes: $documentTypes, settableStatuses: $settableStatuses)';
}


}

/// @nodoc
abstract mixin class _$AssetFiltersCopyWith<$Res> implements $AssetFiltersCopyWith<$Res> {
  factory _$AssetFiltersCopyWith(_AssetFilters value, $Res Function(_AssetFilters) _then) = __$AssetFiltersCopyWithImpl;
@override @useResult
$Res call({
 List<AssetSite> sites, List<CatalogOption> transferTypes, List<CatalogOption> maintenanceResults, List<CatalogOption> documentTypes, List<CatalogOption> settableStatuses
});




}
/// @nodoc
class __$AssetFiltersCopyWithImpl<$Res>
    implements _$AssetFiltersCopyWith<$Res> {
  __$AssetFiltersCopyWithImpl(this._self, this._then);

  final _AssetFilters _self;
  final $Res Function(_AssetFilters) _then;

/// Create a copy of AssetFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sites = null,Object? transferTypes = null,Object? maintenanceResults = null,Object? documentTypes = null,Object? settableStatuses = null,}) {
  return _then(_AssetFilters(
sites: null == sites ? _self._sites : sites // ignore: cast_nullable_to_non_nullable
as List<AssetSite>,transferTypes: null == transferTypes ? _self._transferTypes : transferTypes // ignore: cast_nullable_to_non_nullable
as List<CatalogOption>,maintenanceResults: null == maintenanceResults ? _self._maintenanceResults : maintenanceResults // ignore: cast_nullable_to_non_nullable
as List<CatalogOption>,documentTypes: null == documentTypes ? _self._documentTypes : documentTypes // ignore: cast_nullable_to_non_nullable
as List<CatalogOption>,settableStatuses: null == settableStatuses ? _self._settableStatuses : settableStatuses // ignore: cast_nullable_to_non_nullable
as List<CatalogOption>,
  ));
}


}


/// @nodoc
mixin _$MaintenanceCounts {

 int get overdue; int get upcoming; int get inProgress;
/// Create a copy of MaintenanceCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceCountsCopyWith<MaintenanceCounts> get copyWith => _$MaintenanceCountsCopyWithImpl<MaintenanceCounts>(this as MaintenanceCounts, _$identity);

  /// Serializes this MaintenanceCounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceCounts&&(identical(other.overdue, overdue) || other.overdue == overdue)&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.inProgress, inProgress) || other.inProgress == inProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overdue,upcoming,inProgress);

@override
String toString() {
  return 'MaintenanceCounts(overdue: $overdue, upcoming: $upcoming, inProgress: $inProgress)';
}


}

/// @nodoc
abstract mixin class $MaintenanceCountsCopyWith<$Res>  {
  factory $MaintenanceCountsCopyWith(MaintenanceCounts value, $Res Function(MaintenanceCounts) _then) = _$MaintenanceCountsCopyWithImpl;
@useResult
$Res call({
 int overdue, int upcoming, int inProgress
});




}
/// @nodoc
class _$MaintenanceCountsCopyWithImpl<$Res>
    implements $MaintenanceCountsCopyWith<$Res> {
  _$MaintenanceCountsCopyWithImpl(this._self, this._then);

  final MaintenanceCounts _self;
  final $Res Function(MaintenanceCounts) _then;

/// Create a copy of MaintenanceCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overdue = null,Object? upcoming = null,Object? inProgress = null,}) {
  return _then(_self.copyWith(
overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as int,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as int,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MaintenanceCounts].
extension MaintenanceCountsPatterns on MaintenanceCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaintenanceCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaintenanceCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaintenanceCounts value)  $default,){
final _that = this;
switch (_that) {
case _MaintenanceCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaintenanceCounts value)?  $default,){
final _that = this;
switch (_that) {
case _MaintenanceCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int overdue,  int upcoming,  int inProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaintenanceCounts() when $default != null:
return $default(_that.overdue,_that.upcoming,_that.inProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int overdue,  int upcoming,  int inProgress)  $default,) {final _that = this;
switch (_that) {
case _MaintenanceCounts():
return $default(_that.overdue,_that.upcoming,_that.inProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int overdue,  int upcoming,  int inProgress)?  $default,) {final _that = this;
switch (_that) {
case _MaintenanceCounts() when $default != null:
return $default(_that.overdue,_that.upcoming,_that.inProgress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaintenanceCounts implements MaintenanceCounts {
  const _MaintenanceCounts({this.overdue = 0, this.upcoming = 0, this.inProgress = 0});
  factory _MaintenanceCounts.fromJson(Map<String, dynamic> json) => _$MaintenanceCountsFromJson(json);

@override@JsonKey() final  int overdue;
@override@JsonKey() final  int upcoming;
@override@JsonKey() final  int inProgress;

/// Create a copy of MaintenanceCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenanceCountsCopyWith<_MaintenanceCounts> get copyWith => __$MaintenanceCountsCopyWithImpl<_MaintenanceCounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaintenanceCountsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenanceCounts&&(identical(other.overdue, overdue) || other.overdue == overdue)&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.inProgress, inProgress) || other.inProgress == inProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overdue,upcoming,inProgress);

@override
String toString() {
  return 'MaintenanceCounts(overdue: $overdue, upcoming: $upcoming, inProgress: $inProgress)';
}


}

/// @nodoc
abstract mixin class _$MaintenanceCountsCopyWith<$Res> implements $MaintenanceCountsCopyWith<$Res> {
  factory _$MaintenanceCountsCopyWith(_MaintenanceCounts value, $Res Function(_MaintenanceCounts) _then) = __$MaintenanceCountsCopyWithImpl;
@override @useResult
$Res call({
 int overdue, int upcoming, int inProgress
});




}
/// @nodoc
class __$MaintenanceCountsCopyWithImpl<$Res>
    implements _$MaintenanceCountsCopyWith<$Res> {
  __$MaintenanceCountsCopyWithImpl(this._self, this._then);

  final _MaintenanceCounts _self;
  final $Res Function(_MaintenanceCounts) _then;

/// Create a copy of MaintenanceCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overdue = null,Object? upcoming = null,Object? inProgress = null,}) {
  return _then(_MaintenanceCounts(
overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as int,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as int,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AssetStatistics {

 int get total; Map<String, int> get byStatus; int get offPremises;@DoubleConverter() double? get totalValue; int get pendingTransfers; MaintenanceCounts get maintenance;
/// Create a copy of AssetStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetStatisticsCopyWith<AssetStatistics> get copyWith => _$AssetStatisticsCopyWithImpl<AssetStatistics>(this as AssetStatistics, _$identity);

  /// Serializes this AssetStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetStatistics&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.byStatus, byStatus)&&(identical(other.offPremises, offPremises) || other.offPremises == offPremises)&&(identical(other.totalValue, totalValue) || other.totalValue == totalValue)&&(identical(other.pendingTransfers, pendingTransfers) || other.pendingTransfers == pendingTransfers)&&(identical(other.maintenance, maintenance) || other.maintenance == maintenance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,const DeepCollectionEquality().hash(byStatus),offPremises,totalValue,pendingTransfers,maintenance);

@override
String toString() {
  return 'AssetStatistics(total: $total, byStatus: $byStatus, offPremises: $offPremises, totalValue: $totalValue, pendingTransfers: $pendingTransfers, maintenance: $maintenance)';
}


}

/// @nodoc
abstract mixin class $AssetStatisticsCopyWith<$Res>  {
  factory $AssetStatisticsCopyWith(AssetStatistics value, $Res Function(AssetStatistics) _then) = _$AssetStatisticsCopyWithImpl;
@useResult
$Res call({
 int total, Map<String, int> byStatus, int offPremises,@DoubleConverter() double? totalValue, int pendingTransfers, MaintenanceCounts maintenance
});


$MaintenanceCountsCopyWith<$Res> get maintenance;

}
/// @nodoc
class _$AssetStatisticsCopyWithImpl<$Res>
    implements $AssetStatisticsCopyWith<$Res> {
  _$AssetStatisticsCopyWithImpl(this._self, this._then);

  final AssetStatistics _self;
  final $Res Function(AssetStatistics) _then;

/// Create a copy of AssetStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? byStatus = null,Object? offPremises = null,Object? totalValue = freezed,Object? pendingTransfers = null,Object? maintenance = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,byStatus: null == byStatus ? _self.byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,offPremises: null == offPremises ? _self.offPremises : offPremises // ignore: cast_nullable_to_non_nullable
as int,totalValue: freezed == totalValue ? _self.totalValue : totalValue // ignore: cast_nullable_to_non_nullable
as double?,pendingTransfers: null == pendingTransfers ? _self.pendingTransfers : pendingTransfers // ignore: cast_nullable_to_non_nullable
as int,maintenance: null == maintenance ? _self.maintenance : maintenance // ignore: cast_nullable_to_non_nullable
as MaintenanceCounts,
  ));
}
/// Create a copy of AssetStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MaintenanceCountsCopyWith<$Res> get maintenance {
  
  return $MaintenanceCountsCopyWith<$Res>(_self.maintenance, (value) {
    return _then(_self.copyWith(maintenance: value));
  });
}
}


/// Adds pattern-matching-related methods to [AssetStatistics].
extension AssetStatisticsPatterns on AssetStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetStatistics value)  $default,){
final _that = this;
switch (_that) {
case _AssetStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _AssetStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  Map<String, int> byStatus,  int offPremises, @DoubleConverter()  double? totalValue,  int pendingTransfers,  MaintenanceCounts maintenance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetStatistics() when $default != null:
return $default(_that.total,_that.byStatus,_that.offPremises,_that.totalValue,_that.pendingTransfers,_that.maintenance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  Map<String, int> byStatus,  int offPremises, @DoubleConverter()  double? totalValue,  int pendingTransfers,  MaintenanceCounts maintenance)  $default,) {final _that = this;
switch (_that) {
case _AssetStatistics():
return $default(_that.total,_that.byStatus,_that.offPremises,_that.totalValue,_that.pendingTransfers,_that.maintenance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  Map<String, int> byStatus,  int offPremises, @DoubleConverter()  double? totalValue,  int pendingTransfers,  MaintenanceCounts maintenance)?  $default,) {final _that = this;
switch (_that) {
case _AssetStatistics() when $default != null:
return $default(_that.total,_that.byStatus,_that.offPremises,_that.totalValue,_that.pendingTransfers,_that.maintenance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetStatistics implements AssetStatistics {
  const _AssetStatistics({this.total = 0, final  Map<String, int> byStatus = const {}, this.offPremises = 0, @DoubleConverter() this.totalValue, this.pendingTransfers = 0, this.maintenance = const MaintenanceCounts()}): _byStatus = byStatus;
  factory _AssetStatistics.fromJson(Map<String, dynamic> json) => _$AssetStatisticsFromJson(json);

@override@JsonKey() final  int total;
 final  Map<String, int> _byStatus;
@override@JsonKey() Map<String, int> get byStatus {
  if (_byStatus is EqualUnmodifiableMapView) return _byStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byStatus);
}

@override@JsonKey() final  int offPremises;
@override@DoubleConverter() final  double? totalValue;
@override@JsonKey() final  int pendingTransfers;
@override@JsonKey() final  MaintenanceCounts maintenance;

/// Create a copy of AssetStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetStatisticsCopyWith<_AssetStatistics> get copyWith => __$AssetStatisticsCopyWithImpl<_AssetStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetStatistics&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._byStatus, _byStatus)&&(identical(other.offPremises, offPremises) || other.offPremises == offPremises)&&(identical(other.totalValue, totalValue) || other.totalValue == totalValue)&&(identical(other.pendingTransfers, pendingTransfers) || other.pendingTransfers == pendingTransfers)&&(identical(other.maintenance, maintenance) || other.maintenance == maintenance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,const DeepCollectionEquality().hash(_byStatus),offPremises,totalValue,pendingTransfers,maintenance);

@override
String toString() {
  return 'AssetStatistics(total: $total, byStatus: $byStatus, offPremises: $offPremises, totalValue: $totalValue, pendingTransfers: $pendingTransfers, maintenance: $maintenance)';
}


}

/// @nodoc
abstract mixin class _$AssetStatisticsCopyWith<$Res> implements $AssetStatisticsCopyWith<$Res> {
  factory _$AssetStatisticsCopyWith(_AssetStatistics value, $Res Function(_AssetStatistics) _then) = __$AssetStatisticsCopyWithImpl;
@override @useResult
$Res call({
 int total, Map<String, int> byStatus, int offPremises,@DoubleConverter() double? totalValue, int pendingTransfers, MaintenanceCounts maintenance
});


@override $MaintenanceCountsCopyWith<$Res> get maintenance;

}
/// @nodoc
class __$AssetStatisticsCopyWithImpl<$Res>
    implements _$AssetStatisticsCopyWith<$Res> {
  __$AssetStatisticsCopyWithImpl(this._self, this._then);

  final _AssetStatistics _self;
  final $Res Function(_AssetStatistics) _then;

/// Create a copy of AssetStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? byStatus = null,Object? offPremises = null,Object? totalValue = freezed,Object? pendingTransfers = null,Object? maintenance = null,}) {
  return _then(_AssetStatistics(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,byStatus: null == byStatus ? _self._byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,offPremises: null == offPremises ? _self.offPremises : offPremises // ignore: cast_nullable_to_non_nullable
as int,totalValue: freezed == totalValue ? _self.totalValue : totalValue // ignore: cast_nullable_to_non_nullable
as double?,pendingTransfers: null == pendingTransfers ? _self.pendingTransfers : pendingTransfers // ignore: cast_nullable_to_non_nullable
as int,maintenance: null == maintenance ? _self.maintenance : maintenance // ignore: cast_nullable_to_non_nullable
as MaintenanceCounts,
  ));
}

/// Create a copy of AssetStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MaintenanceCountsCopyWith<$Res> get maintenance {
  
  return $MaintenanceCountsCopyWith<$Res>(_self.maintenance, (value) {
    return _then(_self.copyWith(maintenance: value));
  });
}
}

// dart format on
