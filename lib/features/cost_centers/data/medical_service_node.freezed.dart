// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_service_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MedicalServiceNode {

 int get id; String get name; String? get code; String? get type; String? get description; bool get isActive; List<MedicalServiceNode> get children;
/// Create a copy of MedicalServiceNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicalServiceNodeCopyWith<MedicalServiceNode> get copyWith => _$MedicalServiceNodeCopyWithImpl<MedicalServiceNode>(this as MedicalServiceNode, _$identity);

  /// Serializes this MedicalServiceNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalServiceNode&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,type,description,isActive,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'MedicalServiceNode(id: $id, name: $name, code: $code, type: $type, description: $description, isActive: $isActive, children: $children)';
}


}

/// @nodoc
abstract mixin class $MedicalServiceNodeCopyWith<$Res>  {
  factory $MedicalServiceNodeCopyWith(MedicalServiceNode value, $Res Function(MedicalServiceNode) _then) = _$MedicalServiceNodeCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code, String? type, String? description, bool isActive, List<MedicalServiceNode> children
});




}
/// @nodoc
class _$MedicalServiceNodeCopyWithImpl<$Res>
    implements $MedicalServiceNodeCopyWith<$Res> {
  _$MedicalServiceNodeCopyWithImpl(this._self, this._then);

  final MedicalServiceNode _self;
  final $Res Function(MedicalServiceNode) _then;

/// Create a copy of MedicalServiceNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? type = freezed,Object? description = freezed,Object? isActive = null,Object? children = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<MedicalServiceNode>,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicalServiceNode].
extension MedicalServiceNodePatterns on MedicalServiceNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicalServiceNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicalServiceNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicalServiceNode value)  $default,){
final _that = this;
switch (_that) {
case _MedicalServiceNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicalServiceNode value)?  $default,){
final _that = this;
switch (_that) {
case _MedicalServiceNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? code,  String? type,  String? description,  bool isActive,  List<MedicalServiceNode> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicalServiceNode() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.type,_that.description,_that.isActive,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? code,  String? type,  String? description,  bool isActive,  List<MedicalServiceNode> children)  $default,) {final _that = this;
switch (_that) {
case _MedicalServiceNode():
return $default(_that.id,_that.name,_that.code,_that.type,_that.description,_that.isActive,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? code,  String? type,  String? description,  bool isActive,  List<MedicalServiceNode> children)?  $default,) {final _that = this;
switch (_that) {
case _MedicalServiceNode() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.type,_that.description,_that.isActive,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MedicalServiceNode extends MedicalServiceNode {
  const _MedicalServiceNode({required this.id, required this.name, this.code, this.type, this.description, this.isActive = true, final  List<MedicalServiceNode> children = const []}): _children = children,super._();
  factory _MedicalServiceNode.fromJson(Map<String, dynamic> json) => _$MedicalServiceNodeFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;
@override final  String? type;
@override final  String? description;
@override@JsonKey() final  bool isActive;
 final  List<MedicalServiceNode> _children;
@override@JsonKey() List<MedicalServiceNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of MedicalServiceNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicalServiceNodeCopyWith<_MedicalServiceNode> get copyWith => __$MedicalServiceNodeCopyWithImpl<_MedicalServiceNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedicalServiceNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicalServiceNode&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,type,description,isActive,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'MedicalServiceNode(id: $id, name: $name, code: $code, type: $type, description: $description, isActive: $isActive, children: $children)';
}


}

/// @nodoc
abstract mixin class _$MedicalServiceNodeCopyWith<$Res> implements $MedicalServiceNodeCopyWith<$Res> {
  factory _$MedicalServiceNodeCopyWith(_MedicalServiceNode value, $Res Function(_MedicalServiceNode) _then) = __$MedicalServiceNodeCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code, String? type, String? description, bool isActive, List<MedicalServiceNode> children
});




}
/// @nodoc
class __$MedicalServiceNodeCopyWithImpl<$Res>
    implements _$MedicalServiceNodeCopyWith<$Res> {
  __$MedicalServiceNodeCopyWithImpl(this._self, this._then);

  final _MedicalServiceNode _self;
  final $Res Function(_MedicalServiceNode) _then;

/// Create a copy of MedicalServiceNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? type = freezed,Object? description = freezed,Object? isActive = null,Object? children = null,}) {
  return _then(_MedicalServiceNode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<MedicalServiceNode>,
  ));
}


}


/// @nodoc
mixin _$ProcedurePrice {

 int get id;@DoubleConverter() double? get unitPrice; String? get effectiveFrom; String? get effectiveTo; bool get isActive; bool get isCurrentlyValid; String? get notes;
/// Create a copy of ProcedurePrice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProcedurePriceCopyWith<ProcedurePrice> get copyWith => _$ProcedurePriceCopyWithImpl<ProcedurePrice>(this as ProcedurePrice, _$identity);

  /// Serializes this ProcedurePrice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProcedurePrice&&(identical(other.id, id) || other.id == id)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.effectiveFrom, effectiveFrom) || other.effectiveFrom == effectiveFrom)&&(identical(other.effectiveTo, effectiveTo) || other.effectiveTo == effectiveTo)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isCurrentlyValid, isCurrentlyValid) || other.isCurrentlyValid == isCurrentlyValid)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,unitPrice,effectiveFrom,effectiveTo,isActive,isCurrentlyValid,notes);

@override
String toString() {
  return 'ProcedurePrice(id: $id, unitPrice: $unitPrice, effectiveFrom: $effectiveFrom, effectiveTo: $effectiveTo, isActive: $isActive, isCurrentlyValid: $isCurrentlyValid, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ProcedurePriceCopyWith<$Res>  {
  factory $ProcedurePriceCopyWith(ProcedurePrice value, $Res Function(ProcedurePrice) _then) = _$ProcedurePriceCopyWithImpl;
@useResult
$Res call({
 int id,@DoubleConverter() double? unitPrice, String? effectiveFrom, String? effectiveTo, bool isActive, bool isCurrentlyValid, String? notes
});




}
/// @nodoc
class _$ProcedurePriceCopyWithImpl<$Res>
    implements $ProcedurePriceCopyWith<$Res> {
  _$ProcedurePriceCopyWithImpl(this._self, this._then);

  final ProcedurePrice _self;
  final $Res Function(ProcedurePrice) _then;

/// Create a copy of ProcedurePrice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? unitPrice = freezed,Object? effectiveFrom = freezed,Object? effectiveTo = freezed,Object? isActive = null,Object? isCurrentlyValid = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,effectiveFrom: freezed == effectiveFrom ? _self.effectiveFrom : effectiveFrom // ignore: cast_nullable_to_non_nullable
as String?,effectiveTo: freezed == effectiveTo ? _self.effectiveTo : effectiveTo // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isCurrentlyValid: null == isCurrentlyValid ? _self.isCurrentlyValid : isCurrentlyValid // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProcedurePrice].
extension ProcedurePricePatterns on ProcedurePrice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProcedurePrice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProcedurePrice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProcedurePrice value)  $default,){
final _that = this;
switch (_that) {
case _ProcedurePrice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProcedurePrice value)?  $default,){
final _that = this;
switch (_that) {
case _ProcedurePrice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @DoubleConverter()  double? unitPrice,  String? effectiveFrom,  String? effectiveTo,  bool isActive,  bool isCurrentlyValid,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProcedurePrice() when $default != null:
return $default(_that.id,_that.unitPrice,_that.effectiveFrom,_that.effectiveTo,_that.isActive,_that.isCurrentlyValid,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @DoubleConverter()  double? unitPrice,  String? effectiveFrom,  String? effectiveTo,  bool isActive,  bool isCurrentlyValid,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _ProcedurePrice():
return $default(_that.id,_that.unitPrice,_that.effectiveFrom,_that.effectiveTo,_that.isActive,_that.isCurrentlyValid,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @DoubleConverter()  double? unitPrice,  String? effectiveFrom,  String? effectiveTo,  bool isActive,  bool isCurrentlyValid,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _ProcedurePrice() when $default != null:
return $default(_that.id,_that.unitPrice,_that.effectiveFrom,_that.effectiveTo,_that.isActive,_that.isCurrentlyValid,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProcedurePrice implements ProcedurePrice {
  const _ProcedurePrice({required this.id, @DoubleConverter() this.unitPrice, this.effectiveFrom, this.effectiveTo, this.isActive = true, this.isCurrentlyValid = false, this.notes});
  factory _ProcedurePrice.fromJson(Map<String, dynamic> json) => _$ProcedurePriceFromJson(json);

@override final  int id;
@override@DoubleConverter() final  double? unitPrice;
@override final  String? effectiveFrom;
@override final  String? effectiveTo;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isCurrentlyValid;
@override final  String? notes;

/// Create a copy of ProcedurePrice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProcedurePriceCopyWith<_ProcedurePrice> get copyWith => __$ProcedurePriceCopyWithImpl<_ProcedurePrice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProcedurePriceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProcedurePrice&&(identical(other.id, id) || other.id == id)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.effectiveFrom, effectiveFrom) || other.effectiveFrom == effectiveFrom)&&(identical(other.effectiveTo, effectiveTo) || other.effectiveTo == effectiveTo)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isCurrentlyValid, isCurrentlyValid) || other.isCurrentlyValid == isCurrentlyValid)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,unitPrice,effectiveFrom,effectiveTo,isActive,isCurrentlyValid,notes);

@override
String toString() {
  return 'ProcedurePrice(id: $id, unitPrice: $unitPrice, effectiveFrom: $effectiveFrom, effectiveTo: $effectiveTo, isActive: $isActive, isCurrentlyValid: $isCurrentlyValid, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ProcedurePriceCopyWith<$Res> implements $ProcedurePriceCopyWith<$Res> {
  factory _$ProcedurePriceCopyWith(_ProcedurePrice value, $Res Function(_ProcedurePrice) _then) = __$ProcedurePriceCopyWithImpl;
@override @useResult
$Res call({
 int id,@DoubleConverter() double? unitPrice, String? effectiveFrom, String? effectiveTo, bool isActive, bool isCurrentlyValid, String? notes
});




}
/// @nodoc
class __$ProcedurePriceCopyWithImpl<$Res>
    implements _$ProcedurePriceCopyWith<$Res> {
  __$ProcedurePriceCopyWithImpl(this._self, this._then);

  final _ProcedurePrice _self;
  final $Res Function(_ProcedurePrice) _then;

/// Create a copy of ProcedurePrice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? unitPrice = freezed,Object? effectiveFrom = freezed,Object? effectiveTo = freezed,Object? isActive = null,Object? isCurrentlyValid = null,Object? notes = freezed,}) {
  return _then(_ProcedurePrice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,effectiveFrom: freezed == effectiveFrom ? _self.effectiveFrom : effectiveFrom // ignore: cast_nullable_to_non_nullable
as String?,effectiveTo: freezed == effectiveTo ? _self.effectiveTo : effectiveTo // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isCurrentlyValid: null == isCurrentlyValid ? _self.isCurrentlyValid : isCurrentlyValid // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
