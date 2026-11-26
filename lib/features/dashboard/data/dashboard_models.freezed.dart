// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopConsumedProduct {

 int get id; String get name; String? get barcode;@DoubleConverter() double? get totalConsumed;
/// Create a copy of TopConsumedProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopConsumedProductCopyWith<TopConsumedProduct> get copyWith => _$TopConsumedProductCopyWithImpl<TopConsumedProduct>(this as TopConsumedProduct, _$identity);

  /// Serializes this TopConsumedProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopConsumedProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.totalConsumed, totalConsumed) || other.totalConsumed == totalConsumed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,barcode,totalConsumed);

@override
String toString() {
  return 'TopConsumedProduct(id: $id, name: $name, barcode: $barcode, totalConsumed: $totalConsumed)';
}


}

/// @nodoc
abstract mixin class $TopConsumedProductCopyWith<$Res>  {
  factory $TopConsumedProductCopyWith(TopConsumedProduct value, $Res Function(TopConsumedProduct) _then) = _$TopConsumedProductCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? barcode,@DoubleConverter() double? totalConsumed
});




}
/// @nodoc
class _$TopConsumedProductCopyWithImpl<$Res>
    implements $TopConsumedProductCopyWith<$Res> {
  _$TopConsumedProductCopyWithImpl(this._self, this._then);

  final TopConsumedProduct _self;
  final $Res Function(TopConsumedProduct) _then;

/// Create a copy of TopConsumedProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? barcode = freezed,Object? totalConsumed = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,totalConsumed: freezed == totalConsumed ? _self.totalConsumed : totalConsumed // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TopConsumedProduct].
extension TopConsumedProductPatterns on TopConsumedProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopConsumedProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopConsumedProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopConsumedProduct value)  $default,){
final _that = this;
switch (_that) {
case _TopConsumedProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopConsumedProduct value)?  $default,){
final _that = this;
switch (_that) {
case _TopConsumedProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? barcode, @DoubleConverter()  double? totalConsumed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopConsumedProduct() when $default != null:
return $default(_that.id,_that.name,_that.barcode,_that.totalConsumed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? barcode, @DoubleConverter()  double? totalConsumed)  $default,) {final _that = this;
switch (_that) {
case _TopConsumedProduct():
return $default(_that.id,_that.name,_that.barcode,_that.totalConsumed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? barcode, @DoubleConverter()  double? totalConsumed)?  $default,) {final _that = this;
switch (_that) {
case _TopConsumedProduct() when $default != null:
return $default(_that.id,_that.name,_that.barcode,_that.totalConsumed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopConsumedProduct implements TopConsumedProduct {
  const _TopConsumedProduct({required this.id, required this.name, this.barcode, @DoubleConverter() this.totalConsumed});
  factory _TopConsumedProduct.fromJson(Map<String, dynamic> json) => _$TopConsumedProductFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? barcode;
@override@DoubleConverter() final  double? totalConsumed;

/// Create a copy of TopConsumedProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopConsumedProductCopyWith<_TopConsumedProduct> get copyWith => __$TopConsumedProductCopyWithImpl<_TopConsumedProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopConsumedProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopConsumedProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.totalConsumed, totalConsumed) || other.totalConsumed == totalConsumed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,barcode,totalConsumed);

@override
String toString() {
  return 'TopConsumedProduct(id: $id, name: $name, barcode: $barcode, totalConsumed: $totalConsumed)';
}


}

/// @nodoc
abstract mixin class _$TopConsumedProductCopyWith<$Res> implements $TopConsumedProductCopyWith<$Res> {
  factory _$TopConsumedProductCopyWith(_TopConsumedProduct value, $Res Function(_TopConsumedProduct) _then) = __$TopConsumedProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? barcode,@DoubleConverter() double? totalConsumed
});




}
/// @nodoc
class __$TopConsumedProductCopyWithImpl<$Res>
    implements _$TopConsumedProductCopyWith<$Res> {
  __$TopConsumedProductCopyWithImpl(this._self, this._then);

  final _TopConsumedProduct _self;
  final $Res Function(_TopConsumedProduct) _then;

/// Create a copy of TopConsumedProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? barcode = freezed,Object? totalConsumed = freezed,}) {
  return _then(_TopConsumedProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,totalConsumed: freezed == totalConsumed ? _self.totalConsumed : totalConsumed // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$InventoryDashboard {

 int get totalProducts; int get totalUnits; int get stockOkCount; int get stockLowCount; int get stockCriticalCount; int get expiringToday;@JsonKey(name: 'expiring_7_days') int get expiring7Days;@JsonKey(name: 'expiring_30_days') int get expiring30Days; int get movementsToday; List<TopConsumedProduct> get topConsumedProducts;
/// Create a copy of InventoryDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryDashboardCopyWith<InventoryDashboard> get copyWith => _$InventoryDashboardCopyWithImpl<InventoryDashboard>(this as InventoryDashboard, _$identity);

  /// Serializes this InventoryDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryDashboard&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalUnits, totalUnits) || other.totalUnits == totalUnits)&&(identical(other.stockOkCount, stockOkCount) || other.stockOkCount == stockOkCount)&&(identical(other.stockLowCount, stockLowCount) || other.stockLowCount == stockLowCount)&&(identical(other.stockCriticalCount, stockCriticalCount) || other.stockCriticalCount == stockCriticalCount)&&(identical(other.expiringToday, expiringToday) || other.expiringToday == expiringToday)&&(identical(other.expiring7Days, expiring7Days) || other.expiring7Days == expiring7Days)&&(identical(other.expiring30Days, expiring30Days) || other.expiring30Days == expiring30Days)&&(identical(other.movementsToday, movementsToday) || other.movementsToday == movementsToday)&&const DeepCollectionEquality().equals(other.topConsumedProducts, topConsumedProducts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalProducts,totalUnits,stockOkCount,stockLowCount,stockCriticalCount,expiringToday,expiring7Days,expiring30Days,movementsToday,const DeepCollectionEquality().hash(topConsumedProducts));

@override
String toString() {
  return 'InventoryDashboard(totalProducts: $totalProducts, totalUnits: $totalUnits, stockOkCount: $stockOkCount, stockLowCount: $stockLowCount, stockCriticalCount: $stockCriticalCount, expiringToday: $expiringToday, expiring7Days: $expiring7Days, expiring30Days: $expiring30Days, movementsToday: $movementsToday, topConsumedProducts: $topConsumedProducts)';
}


}

/// @nodoc
abstract mixin class $InventoryDashboardCopyWith<$Res>  {
  factory $InventoryDashboardCopyWith(InventoryDashboard value, $Res Function(InventoryDashboard) _then) = _$InventoryDashboardCopyWithImpl;
@useResult
$Res call({
 int totalProducts, int totalUnits, int stockOkCount, int stockLowCount, int stockCriticalCount, int expiringToday,@JsonKey(name: 'expiring_7_days') int expiring7Days,@JsonKey(name: 'expiring_30_days') int expiring30Days, int movementsToday, List<TopConsumedProduct> topConsumedProducts
});




}
/// @nodoc
class _$InventoryDashboardCopyWithImpl<$Res>
    implements $InventoryDashboardCopyWith<$Res> {
  _$InventoryDashboardCopyWithImpl(this._self, this._then);

  final InventoryDashboard _self;
  final $Res Function(InventoryDashboard) _then;

/// Create a copy of InventoryDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalProducts = null,Object? totalUnits = null,Object? stockOkCount = null,Object? stockLowCount = null,Object? stockCriticalCount = null,Object? expiringToday = null,Object? expiring7Days = null,Object? expiring30Days = null,Object? movementsToday = null,Object? topConsumedProducts = null,}) {
  return _then(_self.copyWith(
totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalUnits: null == totalUnits ? _self.totalUnits : totalUnits // ignore: cast_nullable_to_non_nullable
as int,stockOkCount: null == stockOkCount ? _self.stockOkCount : stockOkCount // ignore: cast_nullable_to_non_nullable
as int,stockLowCount: null == stockLowCount ? _self.stockLowCount : stockLowCount // ignore: cast_nullable_to_non_nullable
as int,stockCriticalCount: null == stockCriticalCount ? _self.stockCriticalCount : stockCriticalCount // ignore: cast_nullable_to_non_nullable
as int,expiringToday: null == expiringToday ? _self.expiringToday : expiringToday // ignore: cast_nullable_to_non_nullable
as int,expiring7Days: null == expiring7Days ? _self.expiring7Days : expiring7Days // ignore: cast_nullable_to_non_nullable
as int,expiring30Days: null == expiring30Days ? _self.expiring30Days : expiring30Days // ignore: cast_nullable_to_non_nullable
as int,movementsToday: null == movementsToday ? _self.movementsToday : movementsToday // ignore: cast_nullable_to_non_nullable
as int,topConsumedProducts: null == topConsumedProducts ? _self.topConsumedProducts : topConsumedProducts // ignore: cast_nullable_to_non_nullable
as List<TopConsumedProduct>,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryDashboard].
extension InventoryDashboardPatterns on InventoryDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryDashboard value)  $default,){
final _that = this;
switch (_that) {
case _InventoryDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalProducts,  int totalUnits,  int stockOkCount,  int stockLowCount,  int stockCriticalCount,  int expiringToday, @JsonKey(name: 'expiring_7_days')  int expiring7Days, @JsonKey(name: 'expiring_30_days')  int expiring30Days,  int movementsToday,  List<TopConsumedProduct> topConsumedProducts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryDashboard() when $default != null:
return $default(_that.totalProducts,_that.totalUnits,_that.stockOkCount,_that.stockLowCount,_that.stockCriticalCount,_that.expiringToday,_that.expiring7Days,_that.expiring30Days,_that.movementsToday,_that.topConsumedProducts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalProducts,  int totalUnits,  int stockOkCount,  int stockLowCount,  int stockCriticalCount,  int expiringToday, @JsonKey(name: 'expiring_7_days')  int expiring7Days, @JsonKey(name: 'expiring_30_days')  int expiring30Days,  int movementsToday,  List<TopConsumedProduct> topConsumedProducts)  $default,) {final _that = this;
switch (_that) {
case _InventoryDashboard():
return $default(_that.totalProducts,_that.totalUnits,_that.stockOkCount,_that.stockLowCount,_that.stockCriticalCount,_that.expiringToday,_that.expiring7Days,_that.expiring30Days,_that.movementsToday,_that.topConsumedProducts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalProducts,  int totalUnits,  int stockOkCount,  int stockLowCount,  int stockCriticalCount,  int expiringToday, @JsonKey(name: 'expiring_7_days')  int expiring7Days, @JsonKey(name: 'expiring_30_days')  int expiring30Days,  int movementsToday,  List<TopConsumedProduct> topConsumedProducts)?  $default,) {final _that = this;
switch (_that) {
case _InventoryDashboard() when $default != null:
return $default(_that.totalProducts,_that.totalUnits,_that.stockOkCount,_that.stockLowCount,_that.stockCriticalCount,_that.expiringToday,_that.expiring7Days,_that.expiring30Days,_that.movementsToday,_that.topConsumedProducts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InventoryDashboard implements InventoryDashboard {
  const _InventoryDashboard({this.totalProducts = 0, this.totalUnits = 0, this.stockOkCount = 0, this.stockLowCount = 0, this.stockCriticalCount = 0, this.expiringToday = 0, @JsonKey(name: 'expiring_7_days') this.expiring7Days = 0, @JsonKey(name: 'expiring_30_days') this.expiring30Days = 0, this.movementsToday = 0, final  List<TopConsumedProduct> topConsumedProducts = const []}): _topConsumedProducts = topConsumedProducts;
  factory _InventoryDashboard.fromJson(Map<String, dynamic> json) => _$InventoryDashboardFromJson(json);

@override@JsonKey() final  int totalProducts;
@override@JsonKey() final  int totalUnits;
@override@JsonKey() final  int stockOkCount;
@override@JsonKey() final  int stockLowCount;
@override@JsonKey() final  int stockCriticalCount;
@override@JsonKey() final  int expiringToday;
@override@JsonKey(name: 'expiring_7_days') final  int expiring7Days;
@override@JsonKey(name: 'expiring_30_days') final  int expiring30Days;
@override@JsonKey() final  int movementsToday;
 final  List<TopConsumedProduct> _topConsumedProducts;
@override@JsonKey() List<TopConsumedProduct> get topConsumedProducts {
  if (_topConsumedProducts is EqualUnmodifiableListView) return _topConsumedProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topConsumedProducts);
}


/// Create a copy of InventoryDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryDashboardCopyWith<_InventoryDashboard> get copyWith => __$InventoryDashboardCopyWithImpl<_InventoryDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InventoryDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryDashboard&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalUnits, totalUnits) || other.totalUnits == totalUnits)&&(identical(other.stockOkCount, stockOkCount) || other.stockOkCount == stockOkCount)&&(identical(other.stockLowCount, stockLowCount) || other.stockLowCount == stockLowCount)&&(identical(other.stockCriticalCount, stockCriticalCount) || other.stockCriticalCount == stockCriticalCount)&&(identical(other.expiringToday, expiringToday) || other.expiringToday == expiringToday)&&(identical(other.expiring7Days, expiring7Days) || other.expiring7Days == expiring7Days)&&(identical(other.expiring30Days, expiring30Days) || other.expiring30Days == expiring30Days)&&(identical(other.movementsToday, movementsToday) || other.movementsToday == movementsToday)&&const DeepCollectionEquality().equals(other._topConsumedProducts, _topConsumedProducts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalProducts,totalUnits,stockOkCount,stockLowCount,stockCriticalCount,expiringToday,expiring7Days,expiring30Days,movementsToday,const DeepCollectionEquality().hash(_topConsumedProducts));

@override
String toString() {
  return 'InventoryDashboard(totalProducts: $totalProducts, totalUnits: $totalUnits, stockOkCount: $stockOkCount, stockLowCount: $stockLowCount, stockCriticalCount: $stockCriticalCount, expiringToday: $expiringToday, expiring7Days: $expiring7Days, expiring30Days: $expiring30Days, movementsToday: $movementsToday, topConsumedProducts: $topConsumedProducts)';
}


}

/// @nodoc
abstract mixin class _$InventoryDashboardCopyWith<$Res> implements $InventoryDashboardCopyWith<$Res> {
  factory _$InventoryDashboardCopyWith(_InventoryDashboard value, $Res Function(_InventoryDashboard) _then) = __$InventoryDashboardCopyWithImpl;
@override @useResult
$Res call({
 int totalProducts, int totalUnits, int stockOkCount, int stockLowCount, int stockCriticalCount, int expiringToday,@JsonKey(name: 'expiring_7_days') int expiring7Days,@JsonKey(name: 'expiring_30_days') int expiring30Days, int movementsToday, List<TopConsumedProduct> topConsumedProducts
});




}
/// @nodoc
class __$InventoryDashboardCopyWithImpl<$Res>
    implements _$InventoryDashboardCopyWith<$Res> {
  __$InventoryDashboardCopyWithImpl(this._self, this._then);

  final _InventoryDashboard _self;
  final $Res Function(_InventoryDashboard) _then;

/// Create a copy of InventoryDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalProducts = null,Object? totalUnits = null,Object? stockOkCount = null,Object? stockLowCount = null,Object? stockCriticalCount = null,Object? expiringToday = null,Object? expiring7Days = null,Object? expiring30Days = null,Object? movementsToday = null,Object? topConsumedProducts = null,}) {
  return _then(_InventoryDashboard(
totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalUnits: null == totalUnits ? _self.totalUnits : totalUnits // ignore: cast_nullable_to_non_nullable
as int,stockOkCount: null == stockOkCount ? _self.stockOkCount : stockOkCount // ignore: cast_nullable_to_non_nullable
as int,stockLowCount: null == stockLowCount ? _self.stockLowCount : stockLowCount // ignore: cast_nullable_to_non_nullable
as int,stockCriticalCount: null == stockCriticalCount ? _self.stockCriticalCount : stockCriticalCount // ignore: cast_nullable_to_non_nullable
as int,expiringToday: null == expiringToday ? _self.expiringToday : expiringToday // ignore: cast_nullable_to_non_nullable
as int,expiring7Days: null == expiring7Days ? _self.expiring7Days : expiring7Days // ignore: cast_nullable_to_non_nullable
as int,expiring30Days: null == expiring30Days ? _self.expiring30Days : expiring30Days // ignore: cast_nullable_to_non_nullable
as int,movementsToday: null == movementsToday ? _self.movementsToday : movementsToday // ignore: cast_nullable_to_non_nullable
as int,topConsumedProducts: null == topConsumedProducts ? _self._topConsumedProducts : topConsumedProducts // ignore: cast_nullable_to_non_nullable
as List<TopConsumedProduct>,
  ));
}


}


/// @nodoc
mixin _$PurchasingDashboard {

 int get pendingOrders; int get approvedOrders;@DoubleConverter() double? get totalMonth;
/// Create a copy of PurchasingDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchasingDashboardCopyWith<PurchasingDashboard> get copyWith => _$PurchasingDashboardCopyWithImpl<PurchasingDashboard>(this as PurchasingDashboard, _$identity);

  /// Serializes this PurchasingDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchasingDashboard&&(identical(other.pendingOrders, pendingOrders) || other.pendingOrders == pendingOrders)&&(identical(other.approvedOrders, approvedOrders) || other.approvedOrders == approvedOrders)&&(identical(other.totalMonth, totalMonth) || other.totalMonth == totalMonth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pendingOrders,approvedOrders,totalMonth);

@override
String toString() {
  return 'PurchasingDashboard(pendingOrders: $pendingOrders, approvedOrders: $approvedOrders, totalMonth: $totalMonth)';
}


}

/// @nodoc
abstract mixin class $PurchasingDashboardCopyWith<$Res>  {
  factory $PurchasingDashboardCopyWith(PurchasingDashboard value, $Res Function(PurchasingDashboard) _then) = _$PurchasingDashboardCopyWithImpl;
@useResult
$Res call({
 int pendingOrders, int approvedOrders,@DoubleConverter() double? totalMonth
});




}
/// @nodoc
class _$PurchasingDashboardCopyWithImpl<$Res>
    implements $PurchasingDashboardCopyWith<$Res> {
  _$PurchasingDashboardCopyWithImpl(this._self, this._then);

  final PurchasingDashboard _self;
  final $Res Function(PurchasingDashboard) _then;

/// Create a copy of PurchasingDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pendingOrders = null,Object? approvedOrders = null,Object? totalMonth = freezed,}) {
  return _then(_self.copyWith(
pendingOrders: null == pendingOrders ? _self.pendingOrders : pendingOrders // ignore: cast_nullable_to_non_nullable
as int,approvedOrders: null == approvedOrders ? _self.approvedOrders : approvedOrders // ignore: cast_nullable_to_non_nullable
as int,totalMonth: freezed == totalMonth ? _self.totalMonth : totalMonth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchasingDashboard].
extension PurchasingDashboardPatterns on PurchasingDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchasingDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchasingDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchasingDashboard value)  $default,){
final _that = this;
switch (_that) {
case _PurchasingDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchasingDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _PurchasingDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pendingOrders,  int approvedOrders, @DoubleConverter()  double? totalMonth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchasingDashboard() when $default != null:
return $default(_that.pendingOrders,_that.approvedOrders,_that.totalMonth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pendingOrders,  int approvedOrders, @DoubleConverter()  double? totalMonth)  $default,) {final _that = this;
switch (_that) {
case _PurchasingDashboard():
return $default(_that.pendingOrders,_that.approvedOrders,_that.totalMonth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pendingOrders,  int approvedOrders, @DoubleConverter()  double? totalMonth)?  $default,) {final _that = this;
switch (_that) {
case _PurchasingDashboard() when $default != null:
return $default(_that.pendingOrders,_that.approvedOrders,_that.totalMonth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchasingDashboard implements PurchasingDashboard {
  const _PurchasingDashboard({this.pendingOrders = 0, this.approvedOrders = 0, @DoubleConverter() this.totalMonth});
  factory _PurchasingDashboard.fromJson(Map<String, dynamic> json) => _$PurchasingDashboardFromJson(json);

@override@JsonKey() final  int pendingOrders;
@override@JsonKey() final  int approvedOrders;
@override@DoubleConverter() final  double? totalMonth;

/// Create a copy of PurchasingDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchasingDashboardCopyWith<_PurchasingDashboard> get copyWith => __$PurchasingDashboardCopyWithImpl<_PurchasingDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchasingDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchasingDashboard&&(identical(other.pendingOrders, pendingOrders) || other.pendingOrders == pendingOrders)&&(identical(other.approvedOrders, approvedOrders) || other.approvedOrders == approvedOrders)&&(identical(other.totalMonth, totalMonth) || other.totalMonth == totalMonth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pendingOrders,approvedOrders,totalMonth);

@override
String toString() {
  return 'PurchasingDashboard(pendingOrders: $pendingOrders, approvedOrders: $approvedOrders, totalMonth: $totalMonth)';
}


}

/// @nodoc
abstract mixin class _$PurchasingDashboardCopyWith<$Res> implements $PurchasingDashboardCopyWith<$Res> {
  factory _$PurchasingDashboardCopyWith(_PurchasingDashboard value, $Res Function(_PurchasingDashboard) _then) = __$PurchasingDashboardCopyWithImpl;
@override @useResult
$Res call({
 int pendingOrders, int approvedOrders,@DoubleConverter() double? totalMonth
});




}
/// @nodoc
class __$PurchasingDashboardCopyWithImpl<$Res>
    implements _$PurchasingDashboardCopyWith<$Res> {
  __$PurchasingDashboardCopyWithImpl(this._self, this._then);

  final _PurchasingDashboard _self;
  final $Res Function(_PurchasingDashboard) _then;

/// Create a copy of PurchasingDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pendingOrders = null,Object? approvedOrders = null,Object? totalMonth = freezed,}) {
  return _then(_PurchasingDashboard(
pendingOrders: null == pendingOrders ? _self.pendingOrders : pendingOrders // ignore: cast_nullable_to_non_nullable
as int,approvedOrders: null == approvedOrders ? _self.approvedOrders : approvedOrders // ignore: cast_nullable_to_non_nullable
as int,totalMonth: freezed == totalMonth ? _self.totalMonth : totalMonth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$MonitoringDashboard {

 int get activeSensors; int get alertsToday; int get readingsToday;
/// Create a copy of MonitoringDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonitoringDashboardCopyWith<MonitoringDashboard> get copyWith => _$MonitoringDashboardCopyWithImpl<MonitoringDashboard>(this as MonitoringDashboard, _$identity);

  /// Serializes this MonitoringDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonitoringDashboard&&(identical(other.activeSensors, activeSensors) || other.activeSensors == activeSensors)&&(identical(other.alertsToday, alertsToday) || other.alertsToday == alertsToday)&&(identical(other.readingsToday, readingsToday) || other.readingsToday == readingsToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeSensors,alertsToday,readingsToday);

@override
String toString() {
  return 'MonitoringDashboard(activeSensors: $activeSensors, alertsToday: $alertsToday, readingsToday: $readingsToday)';
}


}

/// @nodoc
abstract mixin class $MonitoringDashboardCopyWith<$Res>  {
  factory $MonitoringDashboardCopyWith(MonitoringDashboard value, $Res Function(MonitoringDashboard) _then) = _$MonitoringDashboardCopyWithImpl;
@useResult
$Res call({
 int activeSensors, int alertsToday, int readingsToday
});




}
/// @nodoc
class _$MonitoringDashboardCopyWithImpl<$Res>
    implements $MonitoringDashboardCopyWith<$Res> {
  _$MonitoringDashboardCopyWithImpl(this._self, this._then);

  final MonitoringDashboard _self;
  final $Res Function(MonitoringDashboard) _then;

/// Create a copy of MonitoringDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeSensors = null,Object? alertsToday = null,Object? readingsToday = null,}) {
  return _then(_self.copyWith(
activeSensors: null == activeSensors ? _self.activeSensors : activeSensors // ignore: cast_nullable_to_non_nullable
as int,alertsToday: null == alertsToday ? _self.alertsToday : alertsToday // ignore: cast_nullable_to_non_nullable
as int,readingsToday: null == readingsToday ? _self.readingsToday : readingsToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonitoringDashboard].
extension MonitoringDashboardPatterns on MonitoringDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonitoringDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonitoringDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonitoringDashboard value)  $default,){
final _that = this;
switch (_that) {
case _MonitoringDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonitoringDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _MonitoringDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeSensors,  int alertsToday,  int readingsToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonitoringDashboard() when $default != null:
return $default(_that.activeSensors,_that.alertsToday,_that.readingsToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeSensors,  int alertsToday,  int readingsToday)  $default,) {final _that = this;
switch (_that) {
case _MonitoringDashboard():
return $default(_that.activeSensors,_that.alertsToday,_that.readingsToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeSensors,  int alertsToday,  int readingsToday)?  $default,) {final _that = this;
switch (_that) {
case _MonitoringDashboard() when $default != null:
return $default(_that.activeSensors,_that.alertsToday,_that.readingsToday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonitoringDashboard implements MonitoringDashboard {
  const _MonitoringDashboard({this.activeSensors = 0, this.alertsToday = 0, this.readingsToday = 0});
  factory _MonitoringDashboard.fromJson(Map<String, dynamic> json) => _$MonitoringDashboardFromJson(json);

@override@JsonKey() final  int activeSensors;
@override@JsonKey() final  int alertsToday;
@override@JsonKey() final  int readingsToday;

/// Create a copy of MonitoringDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonitoringDashboardCopyWith<_MonitoringDashboard> get copyWith => __$MonitoringDashboardCopyWithImpl<_MonitoringDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonitoringDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonitoringDashboard&&(identical(other.activeSensors, activeSensors) || other.activeSensors == activeSensors)&&(identical(other.alertsToday, alertsToday) || other.alertsToday == alertsToday)&&(identical(other.readingsToday, readingsToday) || other.readingsToday == readingsToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeSensors,alertsToday,readingsToday);

@override
String toString() {
  return 'MonitoringDashboard(activeSensors: $activeSensors, alertsToday: $alertsToday, readingsToday: $readingsToday)';
}


}

/// @nodoc
abstract mixin class _$MonitoringDashboardCopyWith<$Res> implements $MonitoringDashboardCopyWith<$Res> {
  factory _$MonitoringDashboardCopyWith(_MonitoringDashboard value, $Res Function(_MonitoringDashboard) _then) = __$MonitoringDashboardCopyWithImpl;
@override @useResult
$Res call({
 int activeSensors, int alertsToday, int readingsToday
});




}
/// @nodoc
class __$MonitoringDashboardCopyWithImpl<$Res>
    implements _$MonitoringDashboardCopyWith<$Res> {
  __$MonitoringDashboardCopyWithImpl(this._self, this._then);

  final _MonitoringDashboard _self;
  final $Res Function(_MonitoringDashboard) _then;

/// Create a copy of MonitoringDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeSensors = null,Object? alertsToday = null,Object? readingsToday = null,}) {
  return _then(_MonitoringDashboard(
activeSensors: null == activeSensors ? _self.activeSensors : activeSensors // ignore: cast_nullable_to_non_nullable
as int,alertsToday: null == alertsToday ? _self.alertsToday : alertsToday // ignore: cast_nullable_to_non_nullable
as int,readingsToday: null == readingsToday ? _self.readingsToday : readingsToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ActivityEntry {

 String get action; String? get auditableType; String? get createdAt; String? get userName;
/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityEntryCopyWith<ActivityEntry> get copyWith => _$ActivityEntryCopyWithImpl<ActivityEntry>(this as ActivityEntry, _$identity);

  /// Serializes this ActivityEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityEntry&&(identical(other.action, action) || other.action == action)&&(identical(other.auditableType, auditableType) || other.auditableType == auditableType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.userName, userName) || other.userName == userName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,auditableType,createdAt,userName);

@override
String toString() {
  return 'ActivityEntry(action: $action, auditableType: $auditableType, createdAt: $createdAt, userName: $userName)';
}


}

/// @nodoc
abstract mixin class $ActivityEntryCopyWith<$Res>  {
  factory $ActivityEntryCopyWith(ActivityEntry value, $Res Function(ActivityEntry) _then) = _$ActivityEntryCopyWithImpl;
@useResult
$Res call({
 String action, String? auditableType, String? createdAt, String? userName
});




}
/// @nodoc
class _$ActivityEntryCopyWithImpl<$Res>
    implements $ActivityEntryCopyWith<$Res> {
  _$ActivityEntryCopyWithImpl(this._self, this._then);

  final ActivityEntry _self;
  final $Res Function(ActivityEntry) _then;

/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? action = null,Object? auditableType = freezed,Object? createdAt = freezed,Object? userName = freezed,}) {
  return _then(_self.copyWith(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,auditableType: freezed == auditableType ? _self.auditableType : auditableType // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityEntry].
extension ActivityEntryPatterns on ActivityEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityEntry value)  $default,){
final _that = this;
switch (_that) {
case _ActivityEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String action,  String? auditableType,  String? createdAt,  String? userName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
return $default(_that.action,_that.auditableType,_that.createdAt,_that.userName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String action,  String? auditableType,  String? createdAt,  String? userName)  $default,) {final _that = this;
switch (_that) {
case _ActivityEntry():
return $default(_that.action,_that.auditableType,_that.createdAt,_that.userName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String action,  String? auditableType,  String? createdAt,  String? userName)?  $default,) {final _that = this;
switch (_that) {
case _ActivityEntry() when $default != null:
return $default(_that.action,_that.auditableType,_that.createdAt,_that.userName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityEntry implements ActivityEntry {
  const _ActivityEntry({this.action = '', this.auditableType, this.createdAt, this.userName});
  factory _ActivityEntry.fromJson(Map<String, dynamic> json) => _$ActivityEntryFromJson(json);

@override@JsonKey() final  String action;
@override final  String? auditableType;
@override final  String? createdAt;
@override final  String? userName;

/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityEntryCopyWith<_ActivityEntry> get copyWith => __$ActivityEntryCopyWithImpl<_ActivityEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityEntry&&(identical(other.action, action) || other.action == action)&&(identical(other.auditableType, auditableType) || other.auditableType == auditableType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.userName, userName) || other.userName == userName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,action,auditableType,createdAt,userName);

@override
String toString() {
  return 'ActivityEntry(action: $action, auditableType: $auditableType, createdAt: $createdAt, userName: $userName)';
}


}

/// @nodoc
abstract mixin class _$ActivityEntryCopyWith<$Res> implements $ActivityEntryCopyWith<$Res> {
  factory _$ActivityEntryCopyWith(_ActivityEntry value, $Res Function(_ActivityEntry) _then) = __$ActivityEntryCopyWithImpl;
@override @useResult
$Res call({
 String action, String? auditableType, String? createdAt, String? userName
});




}
/// @nodoc
class __$ActivityEntryCopyWithImpl<$Res>
    implements _$ActivityEntryCopyWith<$Res> {
  __$ActivityEntryCopyWithImpl(this._self, this._then);

  final _ActivityEntry _self;
  final $Res Function(_ActivityEntry) _then;

/// Create a copy of ActivityEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? action = null,Object? auditableType = freezed,Object? createdAt = freezed,Object? userName = freezed,}) {
  return _then(_ActivityEntry(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,auditableType: freezed == auditableType ? _self.auditableType : auditableType // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DashboardAlert {

 String get id; String get title; String get message; String get severity; String? get createdAt;
/// Create a copy of DashboardAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardAlertCopyWith<DashboardAlert> get copyWith => _$DashboardAlertCopyWithImpl<DashboardAlert>(this as DashboardAlert, _$identity);

  /// Serializes this DashboardAlert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,message,severity,createdAt);

@override
String toString() {
  return 'DashboardAlert(id: $id, title: $title, message: $message, severity: $severity, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DashboardAlertCopyWith<$Res>  {
  factory $DashboardAlertCopyWith(DashboardAlert value, $Res Function(DashboardAlert) _then) = _$DashboardAlertCopyWithImpl;
@useResult
$Res call({
 String id, String title, String message, String severity, String? createdAt
});




}
/// @nodoc
class _$DashboardAlertCopyWithImpl<$Res>
    implements $DashboardAlertCopyWith<$Res> {
  _$DashboardAlertCopyWithImpl(this._self, this._then);

  final DashboardAlert _self;
  final $Res Function(DashboardAlert) _then;

/// Create a copy of DashboardAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? message = null,Object? severity = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardAlert].
extension DashboardAlertPatterns on DashboardAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardAlert value)  $default,){
final _that = this;
switch (_that) {
case _DashboardAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardAlert value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String message,  String severity,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardAlert() when $default != null:
return $default(_that.id,_that.title,_that.message,_that.severity,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String message,  String severity,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _DashboardAlert():
return $default(_that.id,_that.title,_that.message,_that.severity,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String message,  String severity,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DashboardAlert() when $default != null:
return $default(_that.id,_that.title,_that.message,_that.severity,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardAlert implements DashboardAlert {
  const _DashboardAlert({required this.id, this.title = '', this.message = '', this.severity = 'info', this.createdAt});
  factory _DashboardAlert.fromJson(Map<String, dynamic> json) => _$DashboardAlertFromJson(json);

@override final  String id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String message;
@override@JsonKey() final  String severity;
@override final  String? createdAt;

/// Create a copy of DashboardAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardAlertCopyWith<_DashboardAlert> get copyWith => __$DashboardAlertCopyWithImpl<_DashboardAlert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardAlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,message,severity,createdAt);

@override
String toString() {
  return 'DashboardAlert(id: $id, title: $title, message: $message, severity: $severity, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DashboardAlertCopyWith<$Res> implements $DashboardAlertCopyWith<$Res> {
  factory _$DashboardAlertCopyWith(_DashboardAlert value, $Res Function(_DashboardAlert) _then) = __$DashboardAlertCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String message, String severity, String? createdAt
});




}
/// @nodoc
class __$DashboardAlertCopyWithImpl<$Res>
    implements _$DashboardAlertCopyWith<$Res> {
  __$DashboardAlertCopyWithImpl(this._self, this._then);

  final _DashboardAlert _self;
  final $Res Function(_DashboardAlert) _then;

/// Create a copy of DashboardAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? message = null,Object? severity = null,Object? createdAt = freezed,}) {
  return _then(_DashboardAlert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
