// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_maintenance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaintenanceAsset {

 int get id; String? get code; String? get name; String? get location;
/// Create a copy of MaintenanceAsset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenanceAssetCopyWith<MaintenanceAsset> get copyWith => _$MaintenanceAssetCopyWithImpl<MaintenanceAsset>(this as MaintenanceAsset, _$identity);

  /// Serializes this MaintenanceAsset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenanceAsset&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,location);

@override
String toString() {
  return 'MaintenanceAsset(id: $id, code: $code, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class $MaintenanceAssetCopyWith<$Res>  {
  factory $MaintenanceAssetCopyWith(MaintenanceAsset value, $Res Function(MaintenanceAsset) _then) = _$MaintenanceAssetCopyWithImpl;
@useResult
$Res call({
 int id, String? code, String? name, String? location
});




}
/// @nodoc
class _$MaintenanceAssetCopyWithImpl<$Res>
    implements $MaintenanceAssetCopyWith<$Res> {
  _$MaintenanceAssetCopyWithImpl(this._self, this._then);

  final MaintenanceAsset _self;
  final $Res Function(MaintenanceAsset) _then;

/// Create a copy of MaintenanceAsset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = freezed,Object? name = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MaintenanceAsset].
extension MaintenanceAssetPatterns on MaintenanceAsset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaintenanceAsset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaintenanceAsset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaintenanceAsset value)  $default,){
final _that = this;
switch (_that) {
case _MaintenanceAsset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaintenanceAsset value)?  $default,){
final _that = this;
switch (_that) {
case _MaintenanceAsset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? code,  String? name,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaintenanceAsset() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? code,  String? name,  String? location)  $default,) {final _that = this;
switch (_that) {
case _MaintenanceAsset():
return $default(_that.id,_that.code,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? code,  String? name,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _MaintenanceAsset() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaintenanceAsset implements MaintenanceAsset {
  const _MaintenanceAsset({required this.id, this.code, this.name, this.location});
  factory _MaintenanceAsset.fromJson(Map<String, dynamic> json) => _$MaintenanceAssetFromJson(json);

@override final  int id;
@override final  String? code;
@override final  String? name;
@override final  String? location;

/// Create a copy of MaintenanceAsset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenanceAssetCopyWith<_MaintenanceAsset> get copyWith => __$MaintenanceAssetCopyWithImpl<_MaintenanceAsset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaintenanceAssetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenanceAsset&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,name,location);

@override
String toString() {
  return 'MaintenanceAsset(id: $id, code: $code, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class _$MaintenanceAssetCopyWith<$Res> implements $MaintenanceAssetCopyWith<$Res> {
  factory _$MaintenanceAssetCopyWith(_MaintenanceAsset value, $Res Function(_MaintenanceAsset) _then) = __$MaintenanceAssetCopyWithImpl;
@override @useResult
$Res call({
 int id, String? code, String? name, String? location
});




}
/// @nodoc
class __$MaintenanceAssetCopyWithImpl<$Res>
    implements _$MaintenanceAssetCopyWith<$Res> {
  __$MaintenanceAssetCopyWithImpl(this._self, this._then);

  final _MaintenanceAsset _self;
  final $Res Function(_MaintenanceAsset) _then;

/// Create a copy of MaintenanceAsset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = freezed,Object? name = freezed,Object? location = freezed,}) {
  return _then(_MaintenanceAsset(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ReplacedPart {

 String get name;@DoubleConverter() double? get quantity;@DoubleConverter() double? get cost;
/// Create a copy of ReplacedPart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplacedPartCopyWith<ReplacedPart> get copyWith => _$ReplacedPartCopyWithImpl<ReplacedPart>(this as ReplacedPart, _$identity);

  /// Serializes this ReplacedPart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplacedPart&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.cost, cost) || other.cost == cost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,cost);

@override
String toString() {
  return 'ReplacedPart(name: $name, quantity: $quantity, cost: $cost)';
}


}

/// @nodoc
abstract mixin class $ReplacedPartCopyWith<$Res>  {
  factory $ReplacedPartCopyWith(ReplacedPart value, $Res Function(ReplacedPart) _then) = _$ReplacedPartCopyWithImpl;
@useResult
$Res call({
 String name,@DoubleConverter() double? quantity,@DoubleConverter() double? cost
});




}
/// @nodoc
class _$ReplacedPartCopyWithImpl<$Res>
    implements $ReplacedPartCopyWith<$Res> {
  _$ReplacedPartCopyWithImpl(this._self, this._then);

  final ReplacedPart _self;
  final $Res Function(ReplacedPart) _then;

/// Create a copy of ReplacedPart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantity = freezed,Object? cost = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplacedPart].
extension ReplacedPartPatterns on ReplacedPart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplacedPart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplacedPart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplacedPart value)  $default,){
final _that = this;
switch (_that) {
case _ReplacedPart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplacedPart value)?  $default,){
final _that = this;
switch (_that) {
case _ReplacedPart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @DoubleConverter()  double? quantity, @DoubleConverter()  double? cost)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplacedPart() when $default != null:
return $default(_that.name,_that.quantity,_that.cost);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @DoubleConverter()  double? quantity, @DoubleConverter()  double? cost)  $default,) {final _that = this;
switch (_that) {
case _ReplacedPart():
return $default(_that.name,_that.quantity,_that.cost);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @DoubleConverter()  double? quantity, @DoubleConverter()  double? cost)?  $default,) {final _that = this;
switch (_that) {
case _ReplacedPart() when $default != null:
return $default(_that.name,_that.quantity,_that.cost);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplacedPart implements ReplacedPart {
  const _ReplacedPart({required this.name, @DoubleConverter() this.quantity, @DoubleConverter() this.cost});
  factory _ReplacedPart.fromJson(Map<String, dynamic> json) => _$ReplacedPartFromJson(json);

@override final  String name;
@override@DoubleConverter() final  double? quantity;
@override@DoubleConverter() final  double? cost;

/// Create a copy of ReplacedPart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplacedPartCopyWith<_ReplacedPart> get copyWith => __$ReplacedPartCopyWithImpl<_ReplacedPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplacedPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplacedPart&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.cost, cost) || other.cost == cost));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,cost);

@override
String toString() {
  return 'ReplacedPart(name: $name, quantity: $quantity, cost: $cost)';
}


}

/// @nodoc
abstract mixin class _$ReplacedPartCopyWith<$Res> implements $ReplacedPartCopyWith<$Res> {
  factory _$ReplacedPartCopyWith(_ReplacedPart value, $Res Function(_ReplacedPart) _then) = __$ReplacedPartCopyWithImpl;
@override @useResult
$Res call({
 String name,@DoubleConverter() double? quantity,@DoubleConverter() double? cost
});




}
/// @nodoc
class __$ReplacedPartCopyWithImpl<$Res>
    implements _$ReplacedPartCopyWith<$Res> {
  __$ReplacedPartCopyWithImpl(this._self, this._then);

  final _ReplacedPart _self;
  final $Res Function(_ReplacedPart) _then;

/// Create a copy of ReplacedPart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantity = freezed,Object? cost = freezed,}) {
  return _then(_ReplacedPart(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double?,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$AssetMaintenance {

 int get id; MaintenanceAsset? get asset; int? get planId; String? get maintenanceType;@MaintenanceStatusConverter() MaintenanceStatus get status; bool get isOverdue; String? get scheduledDate; String? get startedAt; String? get performedAt; String? get performedByType; NamedRef? get technician; NamedRef? get supplier; String? get externalTechnicianName; String? get reportedFailure; String? get activitiesPerformed; String? get findings; String? get recommendations; List<ReplacedPart> get partsReplaced;@DoubleConverter() double? get cost; String? get result; String? get cancelReason; int get documentsCount; List<TransferSignature> get signatures; String? get createdAt;
/// Create a copy of AssetMaintenance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetMaintenanceCopyWith<AssetMaintenance> get copyWith => _$AssetMaintenanceCopyWithImpl<AssetMaintenance>(this as AssetMaintenance, _$identity);

  /// Serializes this AssetMaintenance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetMaintenance&&(identical(other.id, id) || other.id == id)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.maintenanceType, maintenanceType) || other.maintenanceType == maintenanceType)&&(identical(other.status, status) || other.status == status)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.performedAt, performedAt) || other.performedAt == performedAt)&&(identical(other.performedByType, performedByType) || other.performedByType == performedByType)&&(identical(other.technician, technician) || other.technician == technician)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.externalTechnicianName, externalTechnicianName) || other.externalTechnicianName == externalTechnicianName)&&(identical(other.reportedFailure, reportedFailure) || other.reportedFailure == reportedFailure)&&(identical(other.activitiesPerformed, activitiesPerformed) || other.activitiesPerformed == activitiesPerformed)&&(identical(other.findings, findings) || other.findings == findings)&&(identical(other.recommendations, recommendations) || other.recommendations == recommendations)&&const DeepCollectionEquality().equals(other.partsReplaced, partsReplaced)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.result, result) || other.result == result)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.documentsCount, documentsCount) || other.documentsCount == documentsCount)&&const DeepCollectionEquality().equals(other.signatures, signatures)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,asset,planId,maintenanceType,status,isOverdue,scheduledDate,startedAt,performedAt,performedByType,technician,supplier,externalTechnicianName,reportedFailure,activitiesPerformed,findings,recommendations,const DeepCollectionEquality().hash(partsReplaced),cost,result,cancelReason,documentsCount,const DeepCollectionEquality().hash(signatures),createdAt]);

@override
String toString() {
  return 'AssetMaintenance(id: $id, asset: $asset, planId: $planId, maintenanceType: $maintenanceType, status: $status, isOverdue: $isOverdue, scheduledDate: $scheduledDate, startedAt: $startedAt, performedAt: $performedAt, performedByType: $performedByType, technician: $technician, supplier: $supplier, externalTechnicianName: $externalTechnicianName, reportedFailure: $reportedFailure, activitiesPerformed: $activitiesPerformed, findings: $findings, recommendations: $recommendations, partsReplaced: $partsReplaced, cost: $cost, result: $result, cancelReason: $cancelReason, documentsCount: $documentsCount, signatures: $signatures, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AssetMaintenanceCopyWith<$Res>  {
  factory $AssetMaintenanceCopyWith(AssetMaintenance value, $Res Function(AssetMaintenance) _then) = _$AssetMaintenanceCopyWithImpl;
@useResult
$Res call({
 int id, MaintenanceAsset? asset, int? planId, String? maintenanceType,@MaintenanceStatusConverter() MaintenanceStatus status, bool isOverdue, String? scheduledDate, String? startedAt, String? performedAt, String? performedByType, NamedRef? technician, NamedRef? supplier, String? externalTechnicianName, String? reportedFailure, String? activitiesPerformed, String? findings, String? recommendations, List<ReplacedPart> partsReplaced,@DoubleConverter() double? cost, String? result, String? cancelReason, int documentsCount, List<TransferSignature> signatures, String? createdAt
});


$MaintenanceAssetCopyWith<$Res>? get asset;$NamedRefCopyWith<$Res>? get technician;$NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class _$AssetMaintenanceCopyWithImpl<$Res>
    implements $AssetMaintenanceCopyWith<$Res> {
  _$AssetMaintenanceCopyWithImpl(this._self, this._then);

  final AssetMaintenance _self;
  final $Res Function(AssetMaintenance) _then;

/// Create a copy of AssetMaintenance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? asset = freezed,Object? planId = freezed,Object? maintenanceType = freezed,Object? status = null,Object? isOverdue = null,Object? scheduledDate = freezed,Object? startedAt = freezed,Object? performedAt = freezed,Object? performedByType = freezed,Object? technician = freezed,Object? supplier = freezed,Object? externalTechnicianName = freezed,Object? reportedFailure = freezed,Object? activitiesPerformed = freezed,Object? findings = freezed,Object? recommendations = freezed,Object? partsReplaced = null,Object? cost = freezed,Object? result = freezed,Object? cancelReason = freezed,Object? documentsCount = null,Object? signatures = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,asset: freezed == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as MaintenanceAsset?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,maintenanceType: freezed == maintenanceType ? _self.maintenanceType : maintenanceType // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MaintenanceStatus,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,scheduledDate: freezed == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,performedAt: freezed == performedAt ? _self.performedAt : performedAt // ignore: cast_nullable_to_non_nullable
as String?,performedByType: freezed == performedByType ? _self.performedByType : performedByType // ignore: cast_nullable_to_non_nullable
as String?,technician: freezed == technician ? _self.technician : technician // ignore: cast_nullable_to_non_nullable
as NamedRef?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,externalTechnicianName: freezed == externalTechnicianName ? _self.externalTechnicianName : externalTechnicianName // ignore: cast_nullable_to_non_nullable
as String?,reportedFailure: freezed == reportedFailure ? _self.reportedFailure : reportedFailure // ignore: cast_nullable_to_non_nullable
as String?,activitiesPerformed: freezed == activitiesPerformed ? _self.activitiesPerformed : activitiesPerformed // ignore: cast_nullable_to_non_nullable
as String?,findings: freezed == findings ? _self.findings : findings // ignore: cast_nullable_to_non_nullable
as String?,recommendations: freezed == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as String?,partsReplaced: null == partsReplaced ? _self.partsReplaced : partsReplaced // ignore: cast_nullable_to_non_nullable
as List<ReplacedPart>,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String?,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,documentsCount: null == documentsCount ? _self.documentsCount : documentsCount // ignore: cast_nullable_to_non_nullable
as int,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<TransferSignature>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AssetMaintenance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MaintenanceAssetCopyWith<$Res>? get asset {
    if (_self.asset == null) {
    return null;
  }

  return $MaintenanceAssetCopyWith<$Res>(_self.asset!, (value) {
    return _then(_self.copyWith(asset: value));
  });
}/// Create a copy of AssetMaintenance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get technician {
    if (_self.technician == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.technician!, (value) {
    return _then(_self.copyWith(technician: value));
  });
}/// Create a copy of AssetMaintenance
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


/// Adds pattern-matching-related methods to [AssetMaintenance].
extension AssetMaintenancePatterns on AssetMaintenance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetMaintenance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetMaintenance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetMaintenance value)  $default,){
final _that = this;
switch (_that) {
case _AssetMaintenance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetMaintenance value)?  $default,){
final _that = this;
switch (_that) {
case _AssetMaintenance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  MaintenanceAsset? asset,  int? planId,  String? maintenanceType, @MaintenanceStatusConverter()  MaintenanceStatus status,  bool isOverdue,  String? scheduledDate,  String? startedAt,  String? performedAt,  String? performedByType,  NamedRef? technician,  NamedRef? supplier,  String? externalTechnicianName,  String? reportedFailure,  String? activitiesPerformed,  String? findings,  String? recommendations,  List<ReplacedPart> partsReplaced, @DoubleConverter()  double? cost,  String? result,  String? cancelReason,  int documentsCount,  List<TransferSignature> signatures,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetMaintenance() when $default != null:
return $default(_that.id,_that.asset,_that.planId,_that.maintenanceType,_that.status,_that.isOverdue,_that.scheduledDate,_that.startedAt,_that.performedAt,_that.performedByType,_that.technician,_that.supplier,_that.externalTechnicianName,_that.reportedFailure,_that.activitiesPerformed,_that.findings,_that.recommendations,_that.partsReplaced,_that.cost,_that.result,_that.cancelReason,_that.documentsCount,_that.signatures,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  MaintenanceAsset? asset,  int? planId,  String? maintenanceType, @MaintenanceStatusConverter()  MaintenanceStatus status,  bool isOverdue,  String? scheduledDate,  String? startedAt,  String? performedAt,  String? performedByType,  NamedRef? technician,  NamedRef? supplier,  String? externalTechnicianName,  String? reportedFailure,  String? activitiesPerformed,  String? findings,  String? recommendations,  List<ReplacedPart> partsReplaced, @DoubleConverter()  double? cost,  String? result,  String? cancelReason,  int documentsCount,  List<TransferSignature> signatures,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AssetMaintenance():
return $default(_that.id,_that.asset,_that.planId,_that.maintenanceType,_that.status,_that.isOverdue,_that.scheduledDate,_that.startedAt,_that.performedAt,_that.performedByType,_that.technician,_that.supplier,_that.externalTechnicianName,_that.reportedFailure,_that.activitiesPerformed,_that.findings,_that.recommendations,_that.partsReplaced,_that.cost,_that.result,_that.cancelReason,_that.documentsCount,_that.signatures,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  MaintenanceAsset? asset,  int? planId,  String? maintenanceType, @MaintenanceStatusConverter()  MaintenanceStatus status,  bool isOverdue,  String? scheduledDate,  String? startedAt,  String? performedAt,  String? performedByType,  NamedRef? technician,  NamedRef? supplier,  String? externalTechnicianName,  String? reportedFailure,  String? activitiesPerformed,  String? findings,  String? recommendations,  List<ReplacedPart> partsReplaced, @DoubleConverter()  double? cost,  String? result,  String? cancelReason,  int documentsCount,  List<TransferSignature> signatures,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AssetMaintenance() when $default != null:
return $default(_that.id,_that.asset,_that.planId,_that.maintenanceType,_that.status,_that.isOverdue,_that.scheduledDate,_that.startedAt,_that.performedAt,_that.performedByType,_that.technician,_that.supplier,_that.externalTechnicianName,_that.reportedFailure,_that.activitiesPerformed,_that.findings,_that.recommendations,_that.partsReplaced,_that.cost,_that.result,_that.cancelReason,_that.documentsCount,_that.signatures,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetMaintenance extends AssetMaintenance {
  const _AssetMaintenance({required this.id, this.asset, this.planId, this.maintenanceType, @MaintenanceStatusConverter() this.status = MaintenanceStatus.unknown, this.isOverdue = false, this.scheduledDate, this.startedAt, this.performedAt, this.performedByType, this.technician, this.supplier, this.externalTechnicianName, this.reportedFailure, this.activitiesPerformed, this.findings, this.recommendations, final  List<ReplacedPart> partsReplaced = const [], @DoubleConverter() this.cost, this.result, this.cancelReason, this.documentsCount = 0, final  List<TransferSignature> signatures = const [], this.createdAt}): _partsReplaced = partsReplaced,_signatures = signatures,super._();
  factory _AssetMaintenance.fromJson(Map<String, dynamic> json) => _$AssetMaintenanceFromJson(json);

@override final  int id;
@override final  MaintenanceAsset? asset;
@override final  int? planId;
@override final  String? maintenanceType;
@override@JsonKey()@MaintenanceStatusConverter() final  MaintenanceStatus status;
@override@JsonKey() final  bool isOverdue;
@override final  String? scheduledDate;
@override final  String? startedAt;
@override final  String? performedAt;
@override final  String? performedByType;
@override final  NamedRef? technician;
@override final  NamedRef? supplier;
@override final  String? externalTechnicianName;
@override final  String? reportedFailure;
@override final  String? activitiesPerformed;
@override final  String? findings;
@override final  String? recommendations;
 final  List<ReplacedPart> _partsReplaced;
@override@JsonKey() List<ReplacedPart> get partsReplaced {
  if (_partsReplaced is EqualUnmodifiableListView) return _partsReplaced;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_partsReplaced);
}

@override@DoubleConverter() final  double? cost;
@override final  String? result;
@override final  String? cancelReason;
@override@JsonKey() final  int documentsCount;
 final  List<TransferSignature> _signatures;
@override@JsonKey() List<TransferSignature> get signatures {
  if (_signatures is EqualUnmodifiableListView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signatures);
}

@override final  String? createdAt;

/// Create a copy of AssetMaintenance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetMaintenanceCopyWith<_AssetMaintenance> get copyWith => __$AssetMaintenanceCopyWithImpl<_AssetMaintenance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetMaintenanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetMaintenance&&(identical(other.id, id) || other.id == id)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.maintenanceType, maintenanceType) || other.maintenanceType == maintenanceType)&&(identical(other.status, status) || other.status == status)&&(identical(other.isOverdue, isOverdue) || other.isOverdue == isOverdue)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.performedAt, performedAt) || other.performedAt == performedAt)&&(identical(other.performedByType, performedByType) || other.performedByType == performedByType)&&(identical(other.technician, technician) || other.technician == technician)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.externalTechnicianName, externalTechnicianName) || other.externalTechnicianName == externalTechnicianName)&&(identical(other.reportedFailure, reportedFailure) || other.reportedFailure == reportedFailure)&&(identical(other.activitiesPerformed, activitiesPerformed) || other.activitiesPerformed == activitiesPerformed)&&(identical(other.findings, findings) || other.findings == findings)&&(identical(other.recommendations, recommendations) || other.recommendations == recommendations)&&const DeepCollectionEquality().equals(other._partsReplaced, _partsReplaced)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.result, result) || other.result == result)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.documentsCount, documentsCount) || other.documentsCount == documentsCount)&&const DeepCollectionEquality().equals(other._signatures, _signatures)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,asset,planId,maintenanceType,status,isOverdue,scheduledDate,startedAt,performedAt,performedByType,technician,supplier,externalTechnicianName,reportedFailure,activitiesPerformed,findings,recommendations,const DeepCollectionEquality().hash(_partsReplaced),cost,result,cancelReason,documentsCount,const DeepCollectionEquality().hash(_signatures),createdAt]);

@override
String toString() {
  return 'AssetMaintenance(id: $id, asset: $asset, planId: $planId, maintenanceType: $maintenanceType, status: $status, isOverdue: $isOverdue, scheduledDate: $scheduledDate, startedAt: $startedAt, performedAt: $performedAt, performedByType: $performedByType, technician: $technician, supplier: $supplier, externalTechnicianName: $externalTechnicianName, reportedFailure: $reportedFailure, activitiesPerformed: $activitiesPerformed, findings: $findings, recommendations: $recommendations, partsReplaced: $partsReplaced, cost: $cost, result: $result, cancelReason: $cancelReason, documentsCount: $documentsCount, signatures: $signatures, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AssetMaintenanceCopyWith<$Res> implements $AssetMaintenanceCopyWith<$Res> {
  factory _$AssetMaintenanceCopyWith(_AssetMaintenance value, $Res Function(_AssetMaintenance) _then) = __$AssetMaintenanceCopyWithImpl;
@override @useResult
$Res call({
 int id, MaintenanceAsset? asset, int? planId, String? maintenanceType,@MaintenanceStatusConverter() MaintenanceStatus status, bool isOverdue, String? scheduledDate, String? startedAt, String? performedAt, String? performedByType, NamedRef? technician, NamedRef? supplier, String? externalTechnicianName, String? reportedFailure, String? activitiesPerformed, String? findings, String? recommendations, List<ReplacedPart> partsReplaced,@DoubleConverter() double? cost, String? result, String? cancelReason, int documentsCount, List<TransferSignature> signatures, String? createdAt
});


@override $MaintenanceAssetCopyWith<$Res>? get asset;@override $NamedRefCopyWith<$Res>? get technician;@override $NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class __$AssetMaintenanceCopyWithImpl<$Res>
    implements _$AssetMaintenanceCopyWith<$Res> {
  __$AssetMaintenanceCopyWithImpl(this._self, this._then);

  final _AssetMaintenance _self;
  final $Res Function(_AssetMaintenance) _then;

/// Create a copy of AssetMaintenance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? asset = freezed,Object? planId = freezed,Object? maintenanceType = freezed,Object? status = null,Object? isOverdue = null,Object? scheduledDate = freezed,Object? startedAt = freezed,Object? performedAt = freezed,Object? performedByType = freezed,Object? technician = freezed,Object? supplier = freezed,Object? externalTechnicianName = freezed,Object? reportedFailure = freezed,Object? activitiesPerformed = freezed,Object? findings = freezed,Object? recommendations = freezed,Object? partsReplaced = null,Object? cost = freezed,Object? result = freezed,Object? cancelReason = freezed,Object? documentsCount = null,Object? signatures = null,Object? createdAt = freezed,}) {
  return _then(_AssetMaintenance(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,asset: freezed == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as MaintenanceAsset?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,maintenanceType: freezed == maintenanceType ? _self.maintenanceType : maintenanceType // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MaintenanceStatus,isOverdue: null == isOverdue ? _self.isOverdue : isOverdue // ignore: cast_nullable_to_non_nullable
as bool,scheduledDate: freezed == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,performedAt: freezed == performedAt ? _self.performedAt : performedAt // ignore: cast_nullable_to_non_nullable
as String?,performedByType: freezed == performedByType ? _self.performedByType : performedByType // ignore: cast_nullable_to_non_nullable
as String?,technician: freezed == technician ? _self.technician : technician // ignore: cast_nullable_to_non_nullable
as NamedRef?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,externalTechnicianName: freezed == externalTechnicianName ? _self.externalTechnicianName : externalTechnicianName // ignore: cast_nullable_to_non_nullable
as String?,reportedFailure: freezed == reportedFailure ? _self.reportedFailure : reportedFailure // ignore: cast_nullable_to_non_nullable
as String?,activitiesPerformed: freezed == activitiesPerformed ? _self.activitiesPerformed : activitiesPerformed // ignore: cast_nullable_to_non_nullable
as String?,findings: freezed == findings ? _self.findings : findings // ignore: cast_nullable_to_non_nullable
as String?,recommendations: freezed == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as String?,partsReplaced: null == partsReplaced ? _self._partsReplaced : partsReplaced // ignore: cast_nullable_to_non_nullable
as List<ReplacedPart>,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String?,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,documentsCount: null == documentsCount ? _self.documentsCount : documentsCount // ignore: cast_nullable_to_non_nullable
as int,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<TransferSignature>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AssetMaintenance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MaintenanceAssetCopyWith<$Res>? get asset {
    if (_self.asset == null) {
    return null;
  }

  return $MaintenanceAssetCopyWith<$Res>(_self.asset!, (value) {
    return _then(_self.copyWith(asset: value));
  });
}/// Create a copy of AssetMaintenance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get technician {
    if (_self.technician == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.technician!, (value) {
    return _then(_self.copyWith(technician: value));
  });
}/// Create a copy of AssetMaintenance
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
mixin _$MaintenancePlan {

 int get id; String? get maintenanceType; int? get frequencyValue; String? get frequencyUnit; String? get startDate; String? get performedByType; NamedRef? get technician; NamedRef? get supplier; String? get notes; bool get isActive; String? get nextDate;
/// Create a copy of MaintenancePlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaintenancePlanCopyWith<MaintenancePlan> get copyWith => _$MaintenancePlanCopyWithImpl<MaintenancePlan>(this as MaintenancePlan, _$identity);

  /// Serializes this MaintenancePlan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaintenancePlan&&(identical(other.id, id) || other.id == id)&&(identical(other.maintenanceType, maintenanceType) || other.maintenanceType == maintenanceType)&&(identical(other.frequencyValue, frequencyValue) || other.frequencyValue == frequencyValue)&&(identical(other.frequencyUnit, frequencyUnit) || other.frequencyUnit == frequencyUnit)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.performedByType, performedByType) || other.performedByType == performedByType)&&(identical(other.technician, technician) || other.technician == technician)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.nextDate, nextDate) || other.nextDate == nextDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,maintenanceType,frequencyValue,frequencyUnit,startDate,performedByType,technician,supplier,notes,isActive,nextDate);

@override
String toString() {
  return 'MaintenancePlan(id: $id, maintenanceType: $maintenanceType, frequencyValue: $frequencyValue, frequencyUnit: $frequencyUnit, startDate: $startDate, performedByType: $performedByType, technician: $technician, supplier: $supplier, notes: $notes, isActive: $isActive, nextDate: $nextDate)';
}


}

/// @nodoc
abstract mixin class $MaintenancePlanCopyWith<$Res>  {
  factory $MaintenancePlanCopyWith(MaintenancePlan value, $Res Function(MaintenancePlan) _then) = _$MaintenancePlanCopyWithImpl;
@useResult
$Res call({
 int id, String? maintenanceType, int? frequencyValue, String? frequencyUnit, String? startDate, String? performedByType, NamedRef? technician, NamedRef? supplier, String? notes, bool isActive, String? nextDate
});


$NamedRefCopyWith<$Res>? get technician;$NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class _$MaintenancePlanCopyWithImpl<$Res>
    implements $MaintenancePlanCopyWith<$Res> {
  _$MaintenancePlanCopyWithImpl(this._self, this._then);

  final MaintenancePlan _self;
  final $Res Function(MaintenancePlan) _then;

/// Create a copy of MaintenancePlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? maintenanceType = freezed,Object? frequencyValue = freezed,Object? frequencyUnit = freezed,Object? startDate = freezed,Object? performedByType = freezed,Object? technician = freezed,Object? supplier = freezed,Object? notes = freezed,Object? isActive = null,Object? nextDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,maintenanceType: freezed == maintenanceType ? _self.maintenanceType : maintenanceType // ignore: cast_nullable_to_non_nullable
as String?,frequencyValue: freezed == frequencyValue ? _self.frequencyValue : frequencyValue // ignore: cast_nullable_to_non_nullable
as int?,frequencyUnit: freezed == frequencyUnit ? _self.frequencyUnit : frequencyUnit // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,performedByType: freezed == performedByType ? _self.performedByType : performedByType // ignore: cast_nullable_to_non_nullable
as String?,technician: freezed == technician ? _self.technician : technician // ignore: cast_nullable_to_non_nullable
as NamedRef?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,nextDate: freezed == nextDate ? _self.nextDate : nextDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MaintenancePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get technician {
    if (_self.technician == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.technician!, (value) {
    return _then(_self.copyWith(technician: value));
  });
}/// Create a copy of MaintenancePlan
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


/// Adds pattern-matching-related methods to [MaintenancePlan].
extension MaintenancePlanPatterns on MaintenancePlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaintenancePlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaintenancePlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaintenancePlan value)  $default,){
final _that = this;
switch (_that) {
case _MaintenancePlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaintenancePlan value)?  $default,){
final _that = this;
switch (_that) {
case _MaintenancePlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? maintenanceType,  int? frequencyValue,  String? frequencyUnit,  String? startDate,  String? performedByType,  NamedRef? technician,  NamedRef? supplier,  String? notes,  bool isActive,  String? nextDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaintenancePlan() when $default != null:
return $default(_that.id,_that.maintenanceType,_that.frequencyValue,_that.frequencyUnit,_that.startDate,_that.performedByType,_that.technician,_that.supplier,_that.notes,_that.isActive,_that.nextDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? maintenanceType,  int? frequencyValue,  String? frequencyUnit,  String? startDate,  String? performedByType,  NamedRef? technician,  NamedRef? supplier,  String? notes,  bool isActive,  String? nextDate)  $default,) {final _that = this;
switch (_that) {
case _MaintenancePlan():
return $default(_that.id,_that.maintenanceType,_that.frequencyValue,_that.frequencyUnit,_that.startDate,_that.performedByType,_that.technician,_that.supplier,_that.notes,_that.isActive,_that.nextDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? maintenanceType,  int? frequencyValue,  String? frequencyUnit,  String? startDate,  String? performedByType,  NamedRef? technician,  NamedRef? supplier,  String? notes,  bool isActive,  String? nextDate)?  $default,) {final _that = this;
switch (_that) {
case _MaintenancePlan() when $default != null:
return $default(_that.id,_that.maintenanceType,_that.frequencyValue,_that.frequencyUnit,_that.startDate,_that.performedByType,_that.technician,_that.supplier,_that.notes,_that.isActive,_that.nextDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaintenancePlan extends MaintenancePlan {
  const _MaintenancePlan({required this.id, this.maintenanceType, this.frequencyValue, this.frequencyUnit, this.startDate, this.performedByType, this.technician, this.supplier, this.notes, this.isActive = true, this.nextDate}): super._();
  factory _MaintenancePlan.fromJson(Map<String, dynamic> json) => _$MaintenancePlanFromJson(json);

@override final  int id;
@override final  String? maintenanceType;
@override final  int? frequencyValue;
@override final  String? frequencyUnit;
@override final  String? startDate;
@override final  String? performedByType;
@override final  NamedRef? technician;
@override final  NamedRef? supplier;
@override final  String? notes;
@override@JsonKey() final  bool isActive;
@override final  String? nextDate;

/// Create a copy of MaintenancePlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaintenancePlanCopyWith<_MaintenancePlan> get copyWith => __$MaintenancePlanCopyWithImpl<_MaintenancePlan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaintenancePlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaintenancePlan&&(identical(other.id, id) || other.id == id)&&(identical(other.maintenanceType, maintenanceType) || other.maintenanceType == maintenanceType)&&(identical(other.frequencyValue, frequencyValue) || other.frequencyValue == frequencyValue)&&(identical(other.frequencyUnit, frequencyUnit) || other.frequencyUnit == frequencyUnit)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.performedByType, performedByType) || other.performedByType == performedByType)&&(identical(other.technician, technician) || other.technician == technician)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.nextDate, nextDate) || other.nextDate == nextDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,maintenanceType,frequencyValue,frequencyUnit,startDate,performedByType,technician,supplier,notes,isActive,nextDate);

@override
String toString() {
  return 'MaintenancePlan(id: $id, maintenanceType: $maintenanceType, frequencyValue: $frequencyValue, frequencyUnit: $frequencyUnit, startDate: $startDate, performedByType: $performedByType, technician: $technician, supplier: $supplier, notes: $notes, isActive: $isActive, nextDate: $nextDate)';
}


}

/// @nodoc
abstract mixin class _$MaintenancePlanCopyWith<$Res> implements $MaintenancePlanCopyWith<$Res> {
  factory _$MaintenancePlanCopyWith(_MaintenancePlan value, $Res Function(_MaintenancePlan) _then) = __$MaintenancePlanCopyWithImpl;
@override @useResult
$Res call({
 int id, String? maintenanceType, int? frequencyValue, String? frequencyUnit, String? startDate, String? performedByType, NamedRef? technician, NamedRef? supplier, String? notes, bool isActive, String? nextDate
});


@override $NamedRefCopyWith<$Res>? get technician;@override $NamedRefCopyWith<$Res>? get supplier;

}
/// @nodoc
class __$MaintenancePlanCopyWithImpl<$Res>
    implements _$MaintenancePlanCopyWith<$Res> {
  __$MaintenancePlanCopyWithImpl(this._self, this._then);

  final _MaintenancePlan _self;
  final $Res Function(_MaintenancePlan) _then;

/// Create a copy of MaintenancePlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? maintenanceType = freezed,Object? frequencyValue = freezed,Object? frequencyUnit = freezed,Object? startDate = freezed,Object? performedByType = freezed,Object? technician = freezed,Object? supplier = freezed,Object? notes = freezed,Object? isActive = null,Object? nextDate = freezed,}) {
  return _then(_MaintenancePlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,maintenanceType: freezed == maintenanceType ? _self.maintenanceType : maintenanceType // ignore: cast_nullable_to_non_nullable
as String?,frequencyValue: freezed == frequencyValue ? _self.frequencyValue : frequencyValue // ignore: cast_nullable_to_non_nullable
as int?,frequencyUnit: freezed == frequencyUnit ? _self.frequencyUnit : frequencyUnit // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,performedByType: freezed == performedByType ? _self.performedByType : performedByType // ignore: cast_nullable_to_non_nullable
as String?,technician: freezed == technician ? _self.technician : technician // ignore: cast_nullable_to_non_nullable
as NamedRef?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,nextDate: freezed == nextDate ? _self.nextDate : nextDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MaintenancePlan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get technician {
    if (_self.technician == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.technician!, (value) {
    return _then(_self.copyWith(technician: value));
  });
}/// Create a copy of MaintenancePlan
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
