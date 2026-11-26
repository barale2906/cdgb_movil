// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consolidation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReorderSuggestion {

 int get genericProductId; String get productName; String? get productBarcode;@DoubleConverter() double? get currentStock;@DoubleConverter() double? get reorderPoint;@DoubleConverter() double? get dailyConsumption; int? get leadTimeDays;@DoubleConverter() double? get safetyStock;@DoubleConverter() double? get suggestedQuantity; NamedRef? get preferredSupplier;
/// Create a copy of ReorderSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReorderSuggestionCopyWith<ReorderSuggestion> get copyWith => _$ReorderSuggestionCopyWithImpl<ReorderSuggestion>(this as ReorderSuggestion, _$identity);

  /// Serializes this ReorderSuggestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReorderSuggestion&&(identical(other.genericProductId, genericProductId) || other.genericProductId == genericProductId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productBarcode, productBarcode) || other.productBarcode == productBarcode)&&(identical(other.currentStock, currentStock) || other.currentStock == currentStock)&&(identical(other.reorderPoint, reorderPoint) || other.reorderPoint == reorderPoint)&&(identical(other.dailyConsumption, dailyConsumption) || other.dailyConsumption == dailyConsumption)&&(identical(other.leadTimeDays, leadTimeDays) || other.leadTimeDays == leadTimeDays)&&(identical(other.safetyStock, safetyStock) || other.safetyStock == safetyStock)&&(identical(other.suggestedQuantity, suggestedQuantity) || other.suggestedQuantity == suggestedQuantity)&&(identical(other.preferredSupplier, preferredSupplier) || other.preferredSupplier == preferredSupplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,genericProductId,productName,productBarcode,currentStock,reorderPoint,dailyConsumption,leadTimeDays,safetyStock,suggestedQuantity,preferredSupplier);

@override
String toString() {
  return 'ReorderSuggestion(genericProductId: $genericProductId, productName: $productName, productBarcode: $productBarcode, currentStock: $currentStock, reorderPoint: $reorderPoint, dailyConsumption: $dailyConsumption, leadTimeDays: $leadTimeDays, safetyStock: $safetyStock, suggestedQuantity: $suggestedQuantity, preferredSupplier: $preferredSupplier)';
}


}

/// @nodoc
abstract mixin class $ReorderSuggestionCopyWith<$Res>  {
  factory $ReorderSuggestionCopyWith(ReorderSuggestion value, $Res Function(ReorderSuggestion) _then) = _$ReorderSuggestionCopyWithImpl;
@useResult
$Res call({
 int genericProductId, String productName, String? productBarcode,@DoubleConverter() double? currentStock,@DoubleConverter() double? reorderPoint,@DoubleConverter() double? dailyConsumption, int? leadTimeDays,@DoubleConverter() double? safetyStock,@DoubleConverter() double? suggestedQuantity, NamedRef? preferredSupplier
});


$NamedRefCopyWith<$Res>? get preferredSupplier;

}
/// @nodoc
class _$ReorderSuggestionCopyWithImpl<$Res>
    implements $ReorderSuggestionCopyWith<$Res> {
  _$ReorderSuggestionCopyWithImpl(this._self, this._then);

  final ReorderSuggestion _self;
  final $Res Function(ReorderSuggestion) _then;

/// Create a copy of ReorderSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? genericProductId = null,Object? productName = null,Object? productBarcode = freezed,Object? currentStock = freezed,Object? reorderPoint = freezed,Object? dailyConsumption = freezed,Object? leadTimeDays = freezed,Object? safetyStock = freezed,Object? suggestedQuantity = freezed,Object? preferredSupplier = freezed,}) {
  return _then(_self.copyWith(
genericProductId: null == genericProductId ? _self.genericProductId : genericProductId // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productBarcode: freezed == productBarcode ? _self.productBarcode : productBarcode // ignore: cast_nullable_to_non_nullable
as String?,currentStock: freezed == currentStock ? _self.currentStock : currentStock // ignore: cast_nullable_to_non_nullable
as double?,reorderPoint: freezed == reorderPoint ? _self.reorderPoint : reorderPoint // ignore: cast_nullable_to_non_nullable
as double?,dailyConsumption: freezed == dailyConsumption ? _self.dailyConsumption : dailyConsumption // ignore: cast_nullable_to_non_nullable
as double?,leadTimeDays: freezed == leadTimeDays ? _self.leadTimeDays : leadTimeDays // ignore: cast_nullable_to_non_nullable
as int?,safetyStock: freezed == safetyStock ? _self.safetyStock : safetyStock // ignore: cast_nullable_to_non_nullable
as double?,suggestedQuantity: freezed == suggestedQuantity ? _self.suggestedQuantity : suggestedQuantity // ignore: cast_nullable_to_non_nullable
as double?,preferredSupplier: freezed == preferredSupplier ? _self.preferredSupplier : preferredSupplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,
  ));
}
/// Create a copy of ReorderSuggestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get preferredSupplier {
    if (_self.preferredSupplier == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.preferredSupplier!, (value) {
    return _then(_self.copyWith(preferredSupplier: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReorderSuggestion].
extension ReorderSuggestionPatterns on ReorderSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReorderSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReorderSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReorderSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _ReorderSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReorderSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _ReorderSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int genericProductId,  String productName,  String? productBarcode, @DoubleConverter()  double? currentStock, @DoubleConverter()  double? reorderPoint, @DoubleConverter()  double? dailyConsumption,  int? leadTimeDays, @DoubleConverter()  double? safetyStock, @DoubleConverter()  double? suggestedQuantity,  NamedRef? preferredSupplier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReorderSuggestion() when $default != null:
return $default(_that.genericProductId,_that.productName,_that.productBarcode,_that.currentStock,_that.reorderPoint,_that.dailyConsumption,_that.leadTimeDays,_that.safetyStock,_that.suggestedQuantity,_that.preferredSupplier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int genericProductId,  String productName,  String? productBarcode, @DoubleConverter()  double? currentStock, @DoubleConverter()  double? reorderPoint, @DoubleConverter()  double? dailyConsumption,  int? leadTimeDays, @DoubleConverter()  double? safetyStock, @DoubleConverter()  double? suggestedQuantity,  NamedRef? preferredSupplier)  $default,) {final _that = this;
switch (_that) {
case _ReorderSuggestion():
return $default(_that.genericProductId,_that.productName,_that.productBarcode,_that.currentStock,_that.reorderPoint,_that.dailyConsumption,_that.leadTimeDays,_that.safetyStock,_that.suggestedQuantity,_that.preferredSupplier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int genericProductId,  String productName,  String? productBarcode, @DoubleConverter()  double? currentStock, @DoubleConverter()  double? reorderPoint, @DoubleConverter()  double? dailyConsumption,  int? leadTimeDays, @DoubleConverter()  double? safetyStock, @DoubleConverter()  double? suggestedQuantity,  NamedRef? preferredSupplier)?  $default,) {final _that = this;
switch (_that) {
case _ReorderSuggestion() when $default != null:
return $default(_that.genericProductId,_that.productName,_that.productBarcode,_that.currentStock,_that.reorderPoint,_that.dailyConsumption,_that.leadTimeDays,_that.safetyStock,_that.suggestedQuantity,_that.preferredSupplier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReorderSuggestion implements ReorderSuggestion {
  const _ReorderSuggestion({required this.genericProductId, required this.productName, this.productBarcode, @DoubleConverter() this.currentStock, @DoubleConverter() this.reorderPoint, @DoubleConverter() this.dailyConsumption, this.leadTimeDays, @DoubleConverter() this.safetyStock, @DoubleConverter() this.suggestedQuantity, this.preferredSupplier});
  factory _ReorderSuggestion.fromJson(Map<String, dynamic> json) => _$ReorderSuggestionFromJson(json);

@override final  int genericProductId;
@override final  String productName;
@override final  String? productBarcode;
@override@DoubleConverter() final  double? currentStock;
@override@DoubleConverter() final  double? reorderPoint;
@override@DoubleConverter() final  double? dailyConsumption;
@override final  int? leadTimeDays;
@override@DoubleConverter() final  double? safetyStock;
@override@DoubleConverter() final  double? suggestedQuantity;
@override final  NamedRef? preferredSupplier;

/// Create a copy of ReorderSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReorderSuggestionCopyWith<_ReorderSuggestion> get copyWith => __$ReorderSuggestionCopyWithImpl<_ReorderSuggestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReorderSuggestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReorderSuggestion&&(identical(other.genericProductId, genericProductId) || other.genericProductId == genericProductId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productBarcode, productBarcode) || other.productBarcode == productBarcode)&&(identical(other.currentStock, currentStock) || other.currentStock == currentStock)&&(identical(other.reorderPoint, reorderPoint) || other.reorderPoint == reorderPoint)&&(identical(other.dailyConsumption, dailyConsumption) || other.dailyConsumption == dailyConsumption)&&(identical(other.leadTimeDays, leadTimeDays) || other.leadTimeDays == leadTimeDays)&&(identical(other.safetyStock, safetyStock) || other.safetyStock == safetyStock)&&(identical(other.suggestedQuantity, suggestedQuantity) || other.suggestedQuantity == suggestedQuantity)&&(identical(other.preferredSupplier, preferredSupplier) || other.preferredSupplier == preferredSupplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,genericProductId,productName,productBarcode,currentStock,reorderPoint,dailyConsumption,leadTimeDays,safetyStock,suggestedQuantity,preferredSupplier);

@override
String toString() {
  return 'ReorderSuggestion(genericProductId: $genericProductId, productName: $productName, productBarcode: $productBarcode, currentStock: $currentStock, reorderPoint: $reorderPoint, dailyConsumption: $dailyConsumption, leadTimeDays: $leadTimeDays, safetyStock: $safetyStock, suggestedQuantity: $suggestedQuantity, preferredSupplier: $preferredSupplier)';
}


}

/// @nodoc
abstract mixin class _$ReorderSuggestionCopyWith<$Res> implements $ReorderSuggestionCopyWith<$Res> {
  factory _$ReorderSuggestionCopyWith(_ReorderSuggestion value, $Res Function(_ReorderSuggestion) _then) = __$ReorderSuggestionCopyWithImpl;
@override @useResult
$Res call({
 int genericProductId, String productName, String? productBarcode,@DoubleConverter() double? currentStock,@DoubleConverter() double? reorderPoint,@DoubleConverter() double? dailyConsumption, int? leadTimeDays,@DoubleConverter() double? safetyStock,@DoubleConverter() double? suggestedQuantity, NamedRef? preferredSupplier
});


@override $NamedRefCopyWith<$Res>? get preferredSupplier;

}
/// @nodoc
class __$ReorderSuggestionCopyWithImpl<$Res>
    implements _$ReorderSuggestionCopyWith<$Res> {
  __$ReorderSuggestionCopyWithImpl(this._self, this._then);

  final _ReorderSuggestion _self;
  final $Res Function(_ReorderSuggestion) _then;

/// Create a copy of ReorderSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? genericProductId = null,Object? productName = null,Object? productBarcode = freezed,Object? currentStock = freezed,Object? reorderPoint = freezed,Object? dailyConsumption = freezed,Object? leadTimeDays = freezed,Object? safetyStock = freezed,Object? suggestedQuantity = freezed,Object? preferredSupplier = freezed,}) {
  return _then(_ReorderSuggestion(
genericProductId: null == genericProductId ? _self.genericProductId : genericProductId // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productBarcode: freezed == productBarcode ? _self.productBarcode : productBarcode // ignore: cast_nullable_to_non_nullable
as String?,currentStock: freezed == currentStock ? _self.currentStock : currentStock // ignore: cast_nullable_to_non_nullable
as double?,reorderPoint: freezed == reorderPoint ? _self.reorderPoint : reorderPoint // ignore: cast_nullable_to_non_nullable
as double?,dailyConsumption: freezed == dailyConsumption ? _self.dailyConsumption : dailyConsumption // ignore: cast_nullable_to_non_nullable
as double?,leadTimeDays: freezed == leadTimeDays ? _self.leadTimeDays : leadTimeDays // ignore: cast_nullable_to_non_nullable
as int?,safetyStock: freezed == safetyStock ? _self.safetyStock : safetyStock // ignore: cast_nullable_to_non_nullable
as double?,suggestedQuantity: freezed == suggestedQuantity ? _self.suggestedQuantity : suggestedQuantity // ignore: cast_nullable_to_non_nullable
as double?,preferredSupplier: freezed == preferredSupplier ? _self.preferredSupplier : preferredSupplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,
  ));
}

/// Create a copy of ReorderSuggestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get preferredSupplier {
    if (_self.preferredSupplier == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.preferredSupplier!, (value) {
    return _then(_self.copyWith(preferredSupplier: value));
  });
}
}


/// @nodoc
mixin _$ConsolidableSupplier {

 int get id; String get name; String? get taxId;
/// Create a copy of ConsolidableSupplier
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsolidableSupplierCopyWith<ConsolidableSupplier> get copyWith => _$ConsolidableSupplierCopyWithImpl<ConsolidableSupplier>(this as ConsolidableSupplier, _$identity);

  /// Serializes this ConsolidableSupplier to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsolidableSupplier&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId);

@override
String toString() {
  return 'ConsolidableSupplier(id: $id, name: $name, taxId: $taxId)';
}


}

/// @nodoc
abstract mixin class $ConsolidableSupplierCopyWith<$Res>  {
  factory $ConsolidableSupplierCopyWith(ConsolidableSupplier value, $Res Function(ConsolidableSupplier) _then) = _$ConsolidableSupplierCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? taxId
});




}
/// @nodoc
class _$ConsolidableSupplierCopyWithImpl<$Res>
    implements $ConsolidableSupplierCopyWith<$Res> {
  _$ConsolidableSupplierCopyWithImpl(this._self, this._then);

  final ConsolidableSupplier _self;
  final $Res Function(ConsolidableSupplier) _then;

/// Create a copy of ConsolidableSupplier
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? taxId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taxId: freezed == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConsolidableSupplier].
extension ConsolidableSupplierPatterns on ConsolidableSupplier {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsolidableSupplier value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsolidableSupplier() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsolidableSupplier value)  $default,){
final _that = this;
switch (_that) {
case _ConsolidableSupplier():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsolidableSupplier value)?  $default,){
final _that = this;
switch (_that) {
case _ConsolidableSupplier() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? taxId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsolidableSupplier() when $default != null:
return $default(_that.id,_that.name,_that.taxId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? taxId)  $default,) {final _that = this;
switch (_that) {
case _ConsolidableSupplier():
return $default(_that.id,_that.name,_that.taxId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? taxId)?  $default,) {final _that = this;
switch (_that) {
case _ConsolidableSupplier() when $default != null:
return $default(_that.id,_that.name,_that.taxId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsolidableSupplier implements ConsolidableSupplier {
  const _ConsolidableSupplier({required this.id, required this.name, this.taxId});
  factory _ConsolidableSupplier.fromJson(Map<String, dynamic> json) => _$ConsolidableSupplierFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? taxId;

/// Create a copy of ConsolidableSupplier
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsolidableSupplierCopyWith<_ConsolidableSupplier> get copyWith => __$ConsolidableSupplierCopyWithImpl<_ConsolidableSupplier>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsolidableSupplierToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsolidableSupplier&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId);

@override
String toString() {
  return 'ConsolidableSupplier(id: $id, name: $name, taxId: $taxId)';
}


}

/// @nodoc
abstract mixin class _$ConsolidableSupplierCopyWith<$Res> implements $ConsolidableSupplierCopyWith<$Res> {
  factory _$ConsolidableSupplierCopyWith(_ConsolidableSupplier value, $Res Function(_ConsolidableSupplier) _then) = __$ConsolidableSupplierCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? taxId
});




}
/// @nodoc
class __$ConsolidableSupplierCopyWithImpl<$Res>
    implements _$ConsolidableSupplierCopyWith<$Res> {
  __$ConsolidableSupplierCopyWithImpl(this._self, this._then);

  final _ConsolidableSupplier _self;
  final $Res Function(_ConsolidableSupplier) _then;

/// Create a copy of ConsolidableSupplier
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? taxId = freezed,}) {
  return _then(_ConsolidableSupplier(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taxId: freezed == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ConsolidatedItem {

@DoubleConverter() double? get quantity;@DoubleConverter() double? get unitPrice;@DoubleConverter() double? get taxRate;@DoubleConverter() double? get taxAmount;@DoubleConverter() double? get totalPrice; List<String> get sourceOrderCodes; VariantRef? get variant; PresentationRef? get presentation;
/// Create a copy of ConsolidatedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsolidatedItemCopyWith<ConsolidatedItem> get copyWith => _$ConsolidatedItemCopyWithImpl<ConsolidatedItem>(this as ConsolidatedItem, _$identity);

  /// Serializes this ConsolidatedItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsolidatedItem&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&const DeepCollectionEquality().equals(other.sourceOrderCodes, sourceOrderCodes)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.presentation, presentation) || other.presentation == presentation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quantity,unitPrice,taxRate,taxAmount,totalPrice,const DeepCollectionEquality().hash(sourceOrderCodes),variant,presentation);

@override
String toString() {
  return 'ConsolidatedItem(quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, taxAmount: $taxAmount, totalPrice: $totalPrice, sourceOrderCodes: $sourceOrderCodes, variant: $variant, presentation: $presentation)';
}


}

/// @nodoc
abstract mixin class $ConsolidatedItemCopyWith<$Res>  {
  factory $ConsolidatedItemCopyWith(ConsolidatedItem value, $Res Function(ConsolidatedItem) _then) = _$ConsolidatedItemCopyWithImpl;
@useResult
$Res call({
@DoubleConverter() double? quantity,@DoubleConverter() double? unitPrice,@DoubleConverter() double? taxRate,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalPrice, List<String> sourceOrderCodes, VariantRef? variant, PresentationRef? presentation
});


$VariantRefCopyWith<$Res>? get variant;$PresentationRefCopyWith<$Res>? get presentation;

}
/// @nodoc
class _$ConsolidatedItemCopyWithImpl<$Res>
    implements $ConsolidatedItemCopyWith<$Res> {
  _$ConsolidatedItemCopyWithImpl(this._self, this._then);

  final ConsolidatedItem _self;
  final $Res Function(ConsolidatedItem) _then;

/// Create a copy of ConsolidatedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quantity = freezed,Object? unitPrice = freezed,Object? taxRate = freezed,Object? taxAmount = freezed,Object? totalPrice = freezed,Object? sourceOrderCodes = null,Object? variant = freezed,Object? presentation = freezed,}) {
  return _then(_self.copyWith(
quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,sourceOrderCodes: null == sourceOrderCodes ? _self.sourceOrderCodes : sourceOrderCodes // ignore: cast_nullable_to_non_nullable
as List<String>,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as VariantRef?,presentation: freezed == presentation ? _self.presentation : presentation // ignore: cast_nullable_to_non_nullable
as PresentationRef?,
  ));
}
/// Create a copy of ConsolidatedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VariantRefCopyWith<$Res>? get variant {
    if (_self.variant == null) {
    return null;
  }

  return $VariantRefCopyWith<$Res>(_self.variant!, (value) {
    return _then(_self.copyWith(variant: value));
  });
}/// Create a copy of ConsolidatedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PresentationRefCopyWith<$Res>? get presentation {
    if (_self.presentation == null) {
    return null;
  }

  return $PresentationRefCopyWith<$Res>(_self.presentation!, (value) {
    return _then(_self.copyWith(presentation: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConsolidatedItem].
extension ConsolidatedItemPatterns on ConsolidatedItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsolidatedItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsolidatedItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsolidatedItem value)  $default,){
final _that = this;
switch (_that) {
case _ConsolidatedItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsolidatedItem value)?  $default,){
final _that = this;
switch (_that) {
case _ConsolidatedItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  List<String> sourceOrderCodes,  VariantRef? variant,  PresentationRef? presentation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsolidatedItem() when $default != null:
return $default(_that.quantity,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.sourceOrderCodes,_that.variant,_that.presentation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  List<String> sourceOrderCodes,  VariantRef? variant,  PresentationRef? presentation)  $default,) {final _that = this;
switch (_that) {
case _ConsolidatedItem():
return $default(_that.quantity,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.sourceOrderCodes,_that.variant,_that.presentation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DoubleConverter()  double? quantity, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  List<String> sourceOrderCodes,  VariantRef? variant,  PresentationRef? presentation)?  $default,) {final _that = this;
switch (_that) {
case _ConsolidatedItem() when $default != null:
return $default(_that.quantity,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.sourceOrderCodes,_that.variant,_that.presentation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsolidatedItem implements ConsolidatedItem {
  const _ConsolidatedItem({@DoubleConverter() this.quantity, @DoubleConverter() this.unitPrice, @DoubleConverter() this.taxRate, @DoubleConverter() this.taxAmount, @DoubleConverter() this.totalPrice, final  List<String> sourceOrderCodes = const [], this.variant, this.presentation}): _sourceOrderCodes = sourceOrderCodes;
  factory _ConsolidatedItem.fromJson(Map<String, dynamic> json) => _$ConsolidatedItemFromJson(json);

@override@DoubleConverter() final  double? quantity;
@override@DoubleConverter() final  double? unitPrice;
@override@DoubleConverter() final  double? taxRate;
@override@DoubleConverter() final  double? taxAmount;
@override@DoubleConverter() final  double? totalPrice;
 final  List<String> _sourceOrderCodes;
@override@JsonKey() List<String> get sourceOrderCodes {
  if (_sourceOrderCodes is EqualUnmodifiableListView) return _sourceOrderCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sourceOrderCodes);
}

@override final  VariantRef? variant;
@override final  PresentationRef? presentation;

/// Create a copy of ConsolidatedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsolidatedItemCopyWith<_ConsolidatedItem> get copyWith => __$ConsolidatedItemCopyWithImpl<_ConsolidatedItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsolidatedItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsolidatedItem&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&const DeepCollectionEquality().equals(other._sourceOrderCodes, _sourceOrderCodes)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.presentation, presentation) || other.presentation == presentation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quantity,unitPrice,taxRate,taxAmount,totalPrice,const DeepCollectionEquality().hash(_sourceOrderCodes),variant,presentation);

@override
String toString() {
  return 'ConsolidatedItem(quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, taxAmount: $taxAmount, totalPrice: $totalPrice, sourceOrderCodes: $sourceOrderCodes, variant: $variant, presentation: $presentation)';
}


}

/// @nodoc
abstract mixin class _$ConsolidatedItemCopyWith<$Res> implements $ConsolidatedItemCopyWith<$Res> {
  factory _$ConsolidatedItemCopyWith(_ConsolidatedItem value, $Res Function(_ConsolidatedItem) _then) = __$ConsolidatedItemCopyWithImpl;
@override @useResult
$Res call({
@DoubleConverter() double? quantity,@DoubleConverter() double? unitPrice,@DoubleConverter() double? taxRate,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalPrice, List<String> sourceOrderCodes, VariantRef? variant, PresentationRef? presentation
});


@override $VariantRefCopyWith<$Res>? get variant;@override $PresentationRefCopyWith<$Res>? get presentation;

}
/// @nodoc
class __$ConsolidatedItemCopyWithImpl<$Res>
    implements _$ConsolidatedItemCopyWith<$Res> {
  __$ConsolidatedItemCopyWithImpl(this._self, this._then);

  final _ConsolidatedItem _self;
  final $Res Function(_ConsolidatedItem) _then;

/// Create a copy of ConsolidatedItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quantity = freezed,Object? unitPrice = freezed,Object? taxRate = freezed,Object? taxAmount = freezed,Object? totalPrice = freezed,Object? sourceOrderCodes = null,Object? variant = freezed,Object? presentation = freezed,}) {
  return _then(_ConsolidatedItem(
quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,sourceOrderCodes: null == sourceOrderCodes ? _self._sourceOrderCodes : sourceOrderCodes // ignore: cast_nullable_to_non_nullable
as List<String>,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as VariantRef?,presentation: freezed == presentation ? _self.presentation : presentation // ignore: cast_nullable_to_non_nullable
as PresentationRef?,
  ));
}

/// Create a copy of ConsolidatedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VariantRefCopyWith<$Res>? get variant {
    if (_self.variant == null) {
    return null;
  }

  return $VariantRefCopyWith<$Res>(_self.variant!, (value) {
    return _then(_self.copyWith(variant: value));
  });
}/// Create a copy of ConsolidatedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PresentationRefCopyWith<$Res>? get presentation {
    if (_self.presentation == null) {
    return null;
  }

  return $PresentationRefCopyWith<$Res>(_self.presentation!, (value) {
    return _then(_self.copyWith(presentation: value));
  });
}
}


/// @nodoc
mixin _$ConsolidationSource {

 int get id; String get code;@DoubleConverter() double? get totalAmount; NamedRef? get warehouse;
/// Create a copy of ConsolidationSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsolidationSourceCopyWith<ConsolidationSource> get copyWith => _$ConsolidationSourceCopyWithImpl<ConsolidationSource>(this as ConsolidationSource, _$identity);

  /// Serializes this ConsolidationSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsolidationSource&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.warehouse, warehouse) || other.warehouse == warehouse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,totalAmount,warehouse);

@override
String toString() {
  return 'ConsolidationSource(id: $id, code: $code, totalAmount: $totalAmount, warehouse: $warehouse)';
}


}

/// @nodoc
abstract mixin class $ConsolidationSourceCopyWith<$Res>  {
  factory $ConsolidationSourceCopyWith(ConsolidationSource value, $Res Function(ConsolidationSource) _then) = _$ConsolidationSourceCopyWithImpl;
@useResult
$Res call({
 int id, String code,@DoubleConverter() double? totalAmount, NamedRef? warehouse
});


$NamedRefCopyWith<$Res>? get warehouse;

}
/// @nodoc
class _$ConsolidationSourceCopyWithImpl<$Res>
    implements $ConsolidationSourceCopyWith<$Res> {
  _$ConsolidationSourceCopyWithImpl(this._self, this._then);

  final ConsolidationSource _self;
  final $Res Function(ConsolidationSource) _then;

/// Create a copy of ConsolidationSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? totalAmount = freezed,Object? warehouse = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,warehouse: freezed == warehouse ? _self.warehouse : warehouse // ignore: cast_nullable_to_non_nullable
as NamedRef?,
  ));
}
/// Create a copy of ConsolidationSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get warehouse {
    if (_self.warehouse == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.warehouse!, (value) {
    return _then(_self.copyWith(warehouse: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConsolidationSource].
extension ConsolidationSourcePatterns on ConsolidationSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsolidationSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsolidationSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsolidationSource value)  $default,){
final _that = this;
switch (_that) {
case _ConsolidationSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsolidationSource value)?  $default,){
final _that = this;
switch (_that) {
case _ConsolidationSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code, @DoubleConverter()  double? totalAmount,  NamedRef? warehouse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsolidationSource() when $default != null:
return $default(_that.id,_that.code,_that.totalAmount,_that.warehouse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code, @DoubleConverter()  double? totalAmount,  NamedRef? warehouse)  $default,) {final _that = this;
switch (_that) {
case _ConsolidationSource():
return $default(_that.id,_that.code,_that.totalAmount,_that.warehouse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code, @DoubleConverter()  double? totalAmount,  NamedRef? warehouse)?  $default,) {final _that = this;
switch (_that) {
case _ConsolidationSource() when $default != null:
return $default(_that.id,_that.code,_that.totalAmount,_that.warehouse);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsolidationSource implements ConsolidationSource {
  const _ConsolidationSource({required this.id, required this.code, @DoubleConverter() this.totalAmount, this.warehouse});
  factory _ConsolidationSource.fromJson(Map<String, dynamic> json) => _$ConsolidationSourceFromJson(json);

@override final  int id;
@override final  String code;
@override@DoubleConverter() final  double? totalAmount;
@override final  NamedRef? warehouse;

/// Create a copy of ConsolidationSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsolidationSourceCopyWith<_ConsolidationSource> get copyWith => __$ConsolidationSourceCopyWithImpl<_ConsolidationSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsolidationSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsolidationSource&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.warehouse, warehouse) || other.warehouse == warehouse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,totalAmount,warehouse);

@override
String toString() {
  return 'ConsolidationSource(id: $id, code: $code, totalAmount: $totalAmount, warehouse: $warehouse)';
}


}

/// @nodoc
abstract mixin class _$ConsolidationSourceCopyWith<$Res> implements $ConsolidationSourceCopyWith<$Res> {
  factory _$ConsolidationSourceCopyWith(_ConsolidationSource value, $Res Function(_ConsolidationSource) _then) = __$ConsolidationSourceCopyWithImpl;
@override @useResult
$Res call({
 int id, String code,@DoubleConverter() double? totalAmount, NamedRef? warehouse
});


@override $NamedRefCopyWith<$Res>? get warehouse;

}
/// @nodoc
class __$ConsolidationSourceCopyWithImpl<$Res>
    implements _$ConsolidationSourceCopyWith<$Res> {
  __$ConsolidationSourceCopyWithImpl(this._self, this._then);

  final _ConsolidationSource _self;
  final $Res Function(_ConsolidationSource) _then;

/// Create a copy of ConsolidationSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? totalAmount = freezed,Object? warehouse = freezed,}) {
  return _then(_ConsolidationSource(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,warehouse: freezed == warehouse ? _self.warehouse : warehouse // ignore: cast_nullable_to_non_nullable
as NamedRef?,
  ));
}

/// Create a copy of ConsolidationSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get warehouse {
    if (_self.warehouse == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.warehouse!, (value) {
    return _then(_self.copyWith(warehouse: value));
  });
}
}


/// @nodoc
mixin _$ConsolidationPreview {

 NamedRef? get supplier; List<ConsolidationSource> get purchaseOrders; List<ConsolidatedItem> get items;@DoubleConverter() double? get subtotal;@DoubleConverter() double? get taxAmount;@DoubleConverter() double? get totalAmount;
/// Create a copy of ConsolidationPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsolidationPreviewCopyWith<ConsolidationPreview> get copyWith => _$ConsolidationPreviewCopyWithImpl<ConsolidationPreview>(this as ConsolidationPreview, _$identity);

  /// Serializes this ConsolidationPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsolidationPreview&&(identical(other.supplier, supplier) || other.supplier == supplier)&&const DeepCollectionEquality().equals(other.purchaseOrders, purchaseOrders)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supplier,const DeepCollectionEquality().hash(purchaseOrders),const DeepCollectionEquality().hash(items),subtotal,taxAmount,totalAmount);

@override
String toString() {
  return 'ConsolidationPreview(supplier: $supplier, purchaseOrders: $purchaseOrders, items: $items, subtotal: $subtotal, taxAmount: $taxAmount, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class $ConsolidationPreviewCopyWith<$Res>  {
  factory $ConsolidationPreviewCopyWith(ConsolidationPreview value, $Res Function(ConsolidationPreview) _then) = _$ConsolidationPreviewCopyWithImpl;
@useResult
$Res call({
 NamedRef? supplier, List<ConsolidationSource> purchaseOrders, List<ConsolidatedItem> items,@DoubleConverter() double? subtotal,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalAmount
});


$NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class _$ConsolidationPreviewCopyWithImpl<$Res>
    implements $ConsolidationPreviewCopyWith<$Res> {
  _$ConsolidationPreviewCopyWithImpl(this._self, this._then);

  final ConsolidationPreview _self;
  final $Res Function(ConsolidationPreview) _then;

/// Create a copy of ConsolidationPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? supplier = freezed,Object? purchaseOrders = null,Object? items = null,Object? subtotal = freezed,Object? taxAmount = freezed,Object? totalAmount = freezed,}) {
  return _then(_self.copyWith(
supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,purchaseOrders: null == purchaseOrders ? _self.purchaseOrders : purchaseOrders // ignore: cast_nullable_to_non_nullable
as List<ConsolidationSource>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ConsolidatedItem>,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of ConsolidationPreview
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
}
}


/// Adds pattern-matching-related methods to [ConsolidationPreview].
extension ConsolidationPreviewPatterns on ConsolidationPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsolidationPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsolidationPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsolidationPreview value)  $default,){
final _that = this;
switch (_that) {
case _ConsolidationPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsolidationPreview value)?  $default,){
final _that = this;
switch (_that) {
case _ConsolidationPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NamedRef? supplier,  List<ConsolidationSource> purchaseOrders,  List<ConsolidatedItem> items, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsolidationPreview() when $default != null:
return $default(_that.supplier,_that.purchaseOrders,_that.items,_that.subtotal,_that.taxAmount,_that.totalAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NamedRef? supplier,  List<ConsolidationSource> purchaseOrders,  List<ConsolidatedItem> items, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount)  $default,) {final _that = this;
switch (_that) {
case _ConsolidationPreview():
return $default(_that.supplier,_that.purchaseOrders,_that.items,_that.subtotal,_that.taxAmount,_that.totalAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NamedRef? supplier,  List<ConsolidationSource> purchaseOrders,  List<ConsolidatedItem> items, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount)?  $default,) {final _that = this;
switch (_that) {
case _ConsolidationPreview() when $default != null:
return $default(_that.supplier,_that.purchaseOrders,_that.items,_that.subtotal,_that.taxAmount,_that.totalAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsolidationPreview implements ConsolidationPreview {
  const _ConsolidationPreview({this.supplier, final  List<ConsolidationSource> purchaseOrders = const [], final  List<ConsolidatedItem> items = const [], @DoubleConverter() this.subtotal, @DoubleConverter() this.taxAmount, @DoubleConverter() this.totalAmount}): _purchaseOrders = purchaseOrders,_items = items;
  factory _ConsolidationPreview.fromJson(Map<String, dynamic> json) => _$ConsolidationPreviewFromJson(json);

@override final  NamedRef? supplier;
 final  List<ConsolidationSource> _purchaseOrders;
@override@JsonKey() List<ConsolidationSource> get purchaseOrders {
  if (_purchaseOrders is EqualUnmodifiableListView) return _purchaseOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_purchaseOrders);
}

 final  List<ConsolidatedItem> _items;
@override@JsonKey() List<ConsolidatedItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@DoubleConverter() final  double? subtotal;
@override@DoubleConverter() final  double? taxAmount;
@override@DoubleConverter() final  double? totalAmount;

/// Create a copy of ConsolidationPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsolidationPreviewCopyWith<_ConsolidationPreview> get copyWith => __$ConsolidationPreviewCopyWithImpl<_ConsolidationPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsolidationPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsolidationPreview&&(identical(other.supplier, supplier) || other.supplier == supplier)&&const DeepCollectionEquality().equals(other._purchaseOrders, _purchaseOrders)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supplier,const DeepCollectionEquality().hash(_purchaseOrders),const DeepCollectionEquality().hash(_items),subtotal,taxAmount,totalAmount);

@override
String toString() {
  return 'ConsolidationPreview(supplier: $supplier, purchaseOrders: $purchaseOrders, items: $items, subtotal: $subtotal, taxAmount: $taxAmount, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class _$ConsolidationPreviewCopyWith<$Res> implements $ConsolidationPreviewCopyWith<$Res> {
  factory _$ConsolidationPreviewCopyWith(_ConsolidationPreview value, $Res Function(_ConsolidationPreview) _then) = __$ConsolidationPreviewCopyWithImpl;
@override @useResult
$Res call({
 NamedRef? supplier, List<ConsolidationSource> purchaseOrders, List<ConsolidatedItem> items,@DoubleConverter() double? subtotal,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalAmount
});


@override $NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class __$ConsolidationPreviewCopyWithImpl<$Res>
    implements _$ConsolidationPreviewCopyWith<$Res> {
  __$ConsolidationPreviewCopyWithImpl(this._self, this._then);

  final _ConsolidationPreview _self;
  final $Res Function(_ConsolidationPreview) _then;

/// Create a copy of ConsolidationPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? supplier = freezed,Object? purchaseOrders = null,Object? items = null,Object? subtotal = freezed,Object? taxAmount = freezed,Object? totalAmount = freezed,}) {
  return _then(_ConsolidationPreview(
supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,purchaseOrders: null == purchaseOrders ? _self._purchaseOrders : purchaseOrders // ignore: cast_nullable_to_non_nullable
as List<ConsolidationSource>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ConsolidatedItem>,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of ConsolidationPreview
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
}
}


/// @nodoc
mixin _$ConsolidatedOrder {

 int get id; String get code; int? get supplierId; String? get periodFrom; String? get periodTo;@DoubleConverter() double? get subtotal;@DoubleConverter() double? get taxAmount;@DoubleConverter() double? get totalAmount; String? get notes; String? get createdAt; NamedRef? get supplier; List<ConsolidatedItem> get items; List<PurchaseOrder> get purchaseOrders;
/// Create a copy of ConsolidatedOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsolidatedOrderCopyWith<ConsolidatedOrder> get copyWith => _$ConsolidatedOrderCopyWithImpl<ConsolidatedOrder>(this as ConsolidatedOrder, _$identity);

  /// Serializes this ConsolidatedOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsolidatedOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.supplierId, supplierId) || other.supplierId == supplierId)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.purchaseOrders, purchaseOrders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,supplierId,periodFrom,periodTo,subtotal,taxAmount,totalAmount,notes,createdAt,supplier,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(purchaseOrders));

@override
String toString() {
  return 'ConsolidatedOrder(id: $id, code: $code, supplierId: $supplierId, periodFrom: $periodFrom, periodTo: $periodTo, subtotal: $subtotal, taxAmount: $taxAmount, totalAmount: $totalAmount, notes: $notes, createdAt: $createdAt, supplier: $supplier, items: $items, purchaseOrders: $purchaseOrders)';
}


}

/// @nodoc
abstract mixin class $ConsolidatedOrderCopyWith<$Res>  {
  factory $ConsolidatedOrderCopyWith(ConsolidatedOrder value, $Res Function(ConsolidatedOrder) _then) = _$ConsolidatedOrderCopyWithImpl;
@useResult
$Res call({
 int id, String code, int? supplierId, String? periodFrom, String? periodTo,@DoubleConverter() double? subtotal,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalAmount, String? notes, String? createdAt, NamedRef? supplier, List<ConsolidatedItem> items, List<PurchaseOrder> purchaseOrders
});


$NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class _$ConsolidatedOrderCopyWithImpl<$Res>
    implements $ConsolidatedOrderCopyWith<$Res> {
  _$ConsolidatedOrderCopyWithImpl(this._self, this._then);

  final ConsolidatedOrder _self;
  final $Res Function(ConsolidatedOrder) _then;

/// Create a copy of ConsolidatedOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? supplierId = freezed,Object? periodFrom = freezed,Object? periodTo = freezed,Object? subtotal = freezed,Object? taxAmount = freezed,Object? totalAmount = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? supplier = freezed,Object? items = null,Object? purchaseOrders = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,supplierId: freezed == supplierId ? _self.supplierId : supplierId // ignore: cast_nullable_to_non_nullable
as int?,periodFrom: freezed == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as String?,periodTo: freezed == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as String?,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ConsolidatedItem>,purchaseOrders: null == purchaseOrders ? _self.purchaseOrders : purchaseOrders // ignore: cast_nullable_to_non_nullable
as List<PurchaseOrder>,
  ));
}
/// Create a copy of ConsolidatedOrder
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
}
}


/// Adds pattern-matching-related methods to [ConsolidatedOrder].
extension ConsolidatedOrderPatterns on ConsolidatedOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConsolidatedOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConsolidatedOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConsolidatedOrder value)  $default,){
final _that = this;
switch (_that) {
case _ConsolidatedOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConsolidatedOrder value)?  $default,){
final _that = this;
switch (_that) {
case _ConsolidatedOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  int? supplierId,  String? periodFrom,  String? periodTo, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount,  String? notes,  String? createdAt,  NamedRef? supplier,  List<ConsolidatedItem> items,  List<PurchaseOrder> purchaseOrders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConsolidatedOrder() when $default != null:
return $default(_that.id,_that.code,_that.supplierId,_that.periodFrom,_that.periodTo,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.notes,_that.createdAt,_that.supplier,_that.items,_that.purchaseOrders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  int? supplierId,  String? periodFrom,  String? periodTo, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount,  String? notes,  String? createdAt,  NamedRef? supplier,  List<ConsolidatedItem> items,  List<PurchaseOrder> purchaseOrders)  $default,) {final _that = this;
switch (_that) {
case _ConsolidatedOrder():
return $default(_that.id,_that.code,_that.supplierId,_that.periodFrom,_that.periodTo,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.notes,_that.createdAt,_that.supplier,_that.items,_that.purchaseOrders);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  int? supplierId,  String? periodFrom,  String? periodTo, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount,  String? notes,  String? createdAt,  NamedRef? supplier,  List<ConsolidatedItem> items,  List<PurchaseOrder> purchaseOrders)?  $default,) {final _that = this;
switch (_that) {
case _ConsolidatedOrder() when $default != null:
return $default(_that.id,_that.code,_that.supplierId,_that.periodFrom,_that.periodTo,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.notes,_that.createdAt,_that.supplier,_that.items,_that.purchaseOrders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConsolidatedOrder implements ConsolidatedOrder {
  const _ConsolidatedOrder({required this.id, required this.code, this.supplierId, this.periodFrom, this.periodTo, @DoubleConverter() this.subtotal, @DoubleConverter() this.taxAmount, @DoubleConverter() this.totalAmount, this.notes, this.createdAt, this.supplier, final  List<ConsolidatedItem> items = const [], final  List<PurchaseOrder> purchaseOrders = const []}): _items = items,_purchaseOrders = purchaseOrders;
  factory _ConsolidatedOrder.fromJson(Map<String, dynamic> json) => _$ConsolidatedOrderFromJson(json);

@override final  int id;
@override final  String code;
@override final  int? supplierId;
@override final  String? periodFrom;
@override final  String? periodTo;
@override@DoubleConverter() final  double? subtotal;
@override@DoubleConverter() final  double? taxAmount;
@override@DoubleConverter() final  double? totalAmount;
@override final  String? notes;
@override final  String? createdAt;
@override final  NamedRef? supplier;
 final  List<ConsolidatedItem> _items;
@override@JsonKey() List<ConsolidatedItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<PurchaseOrder> _purchaseOrders;
@override@JsonKey() List<PurchaseOrder> get purchaseOrders {
  if (_purchaseOrders is EqualUnmodifiableListView) return _purchaseOrders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_purchaseOrders);
}


/// Create a copy of ConsolidatedOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsolidatedOrderCopyWith<_ConsolidatedOrder> get copyWith => __$ConsolidatedOrderCopyWithImpl<_ConsolidatedOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConsolidatedOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsolidatedOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.supplierId, supplierId) || other.supplierId == supplierId)&&(identical(other.periodFrom, periodFrom) || other.periodFrom == periodFrom)&&(identical(other.periodTo, periodTo) || other.periodTo == periodTo)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._purchaseOrders, _purchaseOrders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,supplierId,periodFrom,periodTo,subtotal,taxAmount,totalAmount,notes,createdAt,supplier,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_purchaseOrders));

@override
String toString() {
  return 'ConsolidatedOrder(id: $id, code: $code, supplierId: $supplierId, periodFrom: $periodFrom, periodTo: $periodTo, subtotal: $subtotal, taxAmount: $taxAmount, totalAmount: $totalAmount, notes: $notes, createdAt: $createdAt, supplier: $supplier, items: $items, purchaseOrders: $purchaseOrders)';
}


}

/// @nodoc
abstract mixin class _$ConsolidatedOrderCopyWith<$Res> implements $ConsolidatedOrderCopyWith<$Res> {
  factory _$ConsolidatedOrderCopyWith(_ConsolidatedOrder value, $Res Function(_ConsolidatedOrder) _then) = __$ConsolidatedOrderCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, int? supplierId, String? periodFrom, String? periodTo,@DoubleConverter() double? subtotal,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalAmount, String? notes, String? createdAt, NamedRef? supplier, List<ConsolidatedItem> items, List<PurchaseOrder> purchaseOrders
});


@override $NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class __$ConsolidatedOrderCopyWithImpl<$Res>
    implements _$ConsolidatedOrderCopyWith<$Res> {
  __$ConsolidatedOrderCopyWithImpl(this._self, this._then);

  final _ConsolidatedOrder _self;
  final $Res Function(_ConsolidatedOrder) _then;

/// Create a copy of ConsolidatedOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? supplierId = freezed,Object? periodFrom = freezed,Object? periodTo = freezed,Object? subtotal = freezed,Object? taxAmount = freezed,Object? totalAmount = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? supplier = freezed,Object? items = null,Object? purchaseOrders = null,}) {
  return _then(_ConsolidatedOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,supplierId: freezed == supplierId ? _self.supplierId : supplierId // ignore: cast_nullable_to_non_nullable
as int?,periodFrom: freezed == periodFrom ? _self.periodFrom : periodFrom // ignore: cast_nullable_to_non_nullable
as String?,periodTo: freezed == periodTo ? _self.periodTo : periodTo // ignore: cast_nullable_to_non_nullable
as String?,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ConsolidatedItem>,purchaseOrders: null == purchaseOrders ? _self._purchaseOrders : purchaseOrders // ignore: cast_nullable_to_non_nullable
as List<PurchaseOrder>,
  ));
}

/// Create a copy of ConsolidatedOrder
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
}
}

// dart format on
