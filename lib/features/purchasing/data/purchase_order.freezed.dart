// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PurchaseOrderItem {

 int get id; int? get productVariantId; int? get productPresentationId;@DoubleConverter() double? get quantityRequested;@DoubleConverter() double? get quantityReceived;@DoubleConverter() double? get unitPrice;@DoubleConverter() double? get taxRate;@DoubleConverter() double? get taxAmount;@DoubleConverter() double? get totalPrice; String? get notes; VariantRef? get variant; PresentationRef? get presentation;
/// Create a copy of PurchaseOrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseOrderItemCopyWith<PurchaseOrderItem> get copyWith => _$PurchaseOrderItemCopyWithImpl<PurchaseOrderItem>(this as PurchaseOrderItem, _$identity);

  /// Serializes this PurchaseOrderItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productVariantId, productVariantId) || other.productVariantId == productVariantId)&&(identical(other.productPresentationId, productPresentationId) || other.productPresentationId == productPresentationId)&&(identical(other.quantityRequested, quantityRequested) || other.quantityRequested == quantityRequested)&&(identical(other.quantityReceived, quantityReceived) || other.quantityReceived == quantityReceived)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.presentation, presentation) || other.presentation == presentation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productVariantId,productPresentationId,quantityRequested,quantityReceived,unitPrice,taxRate,taxAmount,totalPrice,notes,variant,presentation);

@override
String toString() {
  return 'PurchaseOrderItem(id: $id, productVariantId: $productVariantId, productPresentationId: $productPresentationId, quantityRequested: $quantityRequested, quantityReceived: $quantityReceived, unitPrice: $unitPrice, taxRate: $taxRate, taxAmount: $taxAmount, totalPrice: $totalPrice, notes: $notes, variant: $variant, presentation: $presentation)';
}


}

/// @nodoc
abstract mixin class $PurchaseOrderItemCopyWith<$Res>  {
  factory $PurchaseOrderItemCopyWith(PurchaseOrderItem value, $Res Function(PurchaseOrderItem) _then) = _$PurchaseOrderItemCopyWithImpl;
@useResult
$Res call({
 int id, int? productVariantId, int? productPresentationId,@DoubleConverter() double? quantityRequested,@DoubleConverter() double? quantityReceived,@DoubleConverter() double? unitPrice,@DoubleConverter() double? taxRate,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalPrice, String? notes, VariantRef? variant, PresentationRef? presentation
});


$VariantRefCopyWith<$Res>? get variant;$PresentationRefCopyWith<$Res>? get presentation;

}
/// @nodoc
class _$PurchaseOrderItemCopyWithImpl<$Res>
    implements $PurchaseOrderItemCopyWith<$Res> {
  _$PurchaseOrderItemCopyWithImpl(this._self, this._then);

  final PurchaseOrderItem _self;
  final $Res Function(PurchaseOrderItem) _then;

/// Create a copy of PurchaseOrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productVariantId = freezed,Object? productPresentationId = freezed,Object? quantityRequested = freezed,Object? quantityReceived = freezed,Object? unitPrice = freezed,Object? taxRate = freezed,Object? taxAmount = freezed,Object? totalPrice = freezed,Object? notes = freezed,Object? variant = freezed,Object? presentation = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productVariantId: freezed == productVariantId ? _self.productVariantId : productVariantId // ignore: cast_nullable_to_non_nullable
as int?,productPresentationId: freezed == productPresentationId ? _self.productPresentationId : productPresentationId // ignore: cast_nullable_to_non_nullable
as int?,quantityRequested: freezed == quantityRequested ? _self.quantityRequested : quantityRequested // ignore: cast_nullable_to_non_nullable
as double?,quantityReceived: freezed == quantityReceived ? _self.quantityReceived : quantityReceived // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as VariantRef?,presentation: freezed == presentation ? _self.presentation : presentation // ignore: cast_nullable_to_non_nullable
as PresentationRef?,
  ));
}
/// Create a copy of PurchaseOrderItem
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
}/// Create a copy of PurchaseOrderItem
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


/// Adds pattern-matching-related methods to [PurchaseOrderItem].
extension PurchaseOrderItemPatterns on PurchaseOrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseOrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseOrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseOrderItem value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseOrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseOrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseOrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? productVariantId,  int? productPresentationId, @DoubleConverter()  double? quantityRequested, @DoubleConverter()  double? quantityReceived, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  String? notes,  VariantRef? variant,  PresentationRef? presentation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseOrderItem() when $default != null:
return $default(_that.id,_that.productVariantId,_that.productPresentationId,_that.quantityRequested,_that.quantityReceived,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.notes,_that.variant,_that.presentation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? productVariantId,  int? productPresentationId, @DoubleConverter()  double? quantityRequested, @DoubleConverter()  double? quantityReceived, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  String? notes,  VariantRef? variant,  PresentationRef? presentation)  $default,) {final _that = this;
switch (_that) {
case _PurchaseOrderItem():
return $default(_that.id,_that.productVariantId,_that.productPresentationId,_that.quantityRequested,_that.quantityReceived,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.notes,_that.variant,_that.presentation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? productVariantId,  int? productPresentationId, @DoubleConverter()  double? quantityRequested, @DoubleConverter()  double? quantityReceived, @DoubleConverter()  double? unitPrice, @DoubleConverter()  double? taxRate, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalPrice,  String? notes,  VariantRef? variant,  PresentationRef? presentation)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseOrderItem() when $default != null:
return $default(_that.id,_that.productVariantId,_that.productPresentationId,_that.quantityRequested,_that.quantityReceived,_that.unitPrice,_that.taxRate,_that.taxAmount,_that.totalPrice,_that.notes,_that.variant,_that.presentation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseOrderItem extends PurchaseOrderItem {
  const _PurchaseOrderItem({required this.id, this.productVariantId, this.productPresentationId, @DoubleConverter() this.quantityRequested, @DoubleConverter() this.quantityReceived, @DoubleConverter() this.unitPrice, @DoubleConverter() this.taxRate, @DoubleConverter() this.taxAmount, @DoubleConverter() this.totalPrice, this.notes, this.variant, this.presentation}): super._();
  factory _PurchaseOrderItem.fromJson(Map<String, dynamic> json) => _$PurchaseOrderItemFromJson(json);

@override final  int id;
@override final  int? productVariantId;
@override final  int? productPresentationId;
@override@DoubleConverter() final  double? quantityRequested;
@override@DoubleConverter() final  double? quantityReceived;
@override@DoubleConverter() final  double? unitPrice;
@override@DoubleConverter() final  double? taxRate;
@override@DoubleConverter() final  double? taxAmount;
@override@DoubleConverter() final  double? totalPrice;
@override final  String? notes;
@override final  VariantRef? variant;
@override final  PresentationRef? presentation;

/// Create a copy of PurchaseOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseOrderItemCopyWith<_PurchaseOrderItem> get copyWith => __$PurchaseOrderItemCopyWithImpl<_PurchaseOrderItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseOrderItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseOrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productVariantId, productVariantId) || other.productVariantId == productVariantId)&&(identical(other.productPresentationId, productPresentationId) || other.productPresentationId == productPresentationId)&&(identical(other.quantityRequested, quantityRequested) || other.quantityRequested == quantityRequested)&&(identical(other.quantityReceived, quantityReceived) || other.quantityReceived == quantityReceived)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.presentation, presentation) || other.presentation == presentation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productVariantId,productPresentationId,quantityRequested,quantityReceived,unitPrice,taxRate,taxAmount,totalPrice,notes,variant,presentation);

@override
String toString() {
  return 'PurchaseOrderItem(id: $id, productVariantId: $productVariantId, productPresentationId: $productPresentationId, quantityRequested: $quantityRequested, quantityReceived: $quantityReceived, unitPrice: $unitPrice, taxRate: $taxRate, taxAmount: $taxAmount, totalPrice: $totalPrice, notes: $notes, variant: $variant, presentation: $presentation)';
}


}

/// @nodoc
abstract mixin class _$PurchaseOrderItemCopyWith<$Res> implements $PurchaseOrderItemCopyWith<$Res> {
  factory _$PurchaseOrderItemCopyWith(_PurchaseOrderItem value, $Res Function(_PurchaseOrderItem) _then) = __$PurchaseOrderItemCopyWithImpl;
@override @useResult
$Res call({
 int id, int? productVariantId, int? productPresentationId,@DoubleConverter() double? quantityRequested,@DoubleConverter() double? quantityReceived,@DoubleConverter() double? unitPrice,@DoubleConverter() double? taxRate,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalPrice, String? notes, VariantRef? variant, PresentationRef? presentation
});


@override $VariantRefCopyWith<$Res>? get variant;@override $PresentationRefCopyWith<$Res>? get presentation;

}
/// @nodoc
class __$PurchaseOrderItemCopyWithImpl<$Res>
    implements _$PurchaseOrderItemCopyWith<$Res> {
  __$PurchaseOrderItemCopyWithImpl(this._self, this._then);

  final _PurchaseOrderItem _self;
  final $Res Function(_PurchaseOrderItem) _then;

/// Create a copy of PurchaseOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productVariantId = freezed,Object? productPresentationId = freezed,Object? quantityRequested = freezed,Object? quantityReceived = freezed,Object? unitPrice = freezed,Object? taxRate = freezed,Object? taxAmount = freezed,Object? totalPrice = freezed,Object? notes = freezed,Object? variant = freezed,Object? presentation = freezed,}) {
  return _then(_PurchaseOrderItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productVariantId: freezed == productVariantId ? _self.productVariantId : productVariantId // ignore: cast_nullable_to_non_nullable
as int?,productPresentationId: freezed == productPresentationId ? _self.productPresentationId : productPresentationId // ignore: cast_nullable_to_non_nullable
as int?,quantityRequested: freezed == quantityRequested ? _self.quantityRequested : quantityRequested // ignore: cast_nullable_to_non_nullable
as double?,quantityReceived: freezed == quantityReceived ? _self.quantityReceived : quantityReceived // ignore: cast_nullable_to_non_nullable
as double?,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalPrice: freezed == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as VariantRef?,presentation: freezed == presentation ? _self.presentation : presentation // ignore: cast_nullable_to_non_nullable
as PresentationRef?,
  ));
}

/// Create a copy of PurchaseOrderItem
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
}/// Create a copy of PurchaseOrderItem
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
mixin _$PurchaseOrder {

 int get id; String get code;@OrderStatusConverter() OrderStatus get status; int? get supplierId; int? get warehouseId;@DoubleConverter() double? get subtotal;@DoubleConverter() double? get taxAmount;@DoubleConverter() double? get totalAmount; String? get notes; String? get expectedDeliveryDate; String? get sentAt; String? get receivedAt; String? get createdAt; NamedRef? get supplier; NamedRef? get warehouse; NamedRef? get costCenter; List<TaxLine> get taxBreakdown; List<PurchaseOrderItem> get items;
/// Create a copy of PurchaseOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseOrderCopyWith<PurchaseOrder> get copyWith => _$PurchaseOrderCopyWithImpl<PurchaseOrder>(this as PurchaseOrder, _$identity);

  /// Serializes this PurchaseOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.supplierId, supplierId) || other.supplierId == supplierId)&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.expectedDeliveryDate, expectedDeliveryDate) || other.expectedDeliveryDate == expectedDeliveryDate)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.warehouse, warehouse) || other.warehouse == warehouse)&&(identical(other.costCenter, costCenter) || other.costCenter == costCenter)&&const DeepCollectionEquality().equals(other.taxBreakdown, taxBreakdown)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,status,supplierId,warehouseId,subtotal,taxAmount,totalAmount,notes,expectedDeliveryDate,sentAt,receivedAt,createdAt,supplier,warehouse,costCenter,const DeepCollectionEquality().hash(taxBreakdown),const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'PurchaseOrder(id: $id, code: $code, status: $status, supplierId: $supplierId, warehouseId: $warehouseId, subtotal: $subtotal, taxAmount: $taxAmount, totalAmount: $totalAmount, notes: $notes, expectedDeliveryDate: $expectedDeliveryDate, sentAt: $sentAt, receivedAt: $receivedAt, createdAt: $createdAt, supplier: $supplier, warehouse: $warehouse, costCenter: $costCenter, taxBreakdown: $taxBreakdown, items: $items)';
}


}

/// @nodoc
abstract mixin class $PurchaseOrderCopyWith<$Res>  {
  factory $PurchaseOrderCopyWith(PurchaseOrder value, $Res Function(PurchaseOrder) _then) = _$PurchaseOrderCopyWithImpl;
@useResult
$Res call({
 int id, String code,@OrderStatusConverter() OrderStatus status, int? supplierId, int? warehouseId,@DoubleConverter() double? subtotal,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalAmount, String? notes, String? expectedDeliveryDate, String? sentAt, String? receivedAt, String? createdAt, NamedRef? supplier, NamedRef? warehouse, NamedRef? costCenter, List<TaxLine> taxBreakdown, List<PurchaseOrderItem> items
});


$NamedRefCopyWith<$Res>? get supplier;$NamedRefCopyWith<$Res>? get warehouse;$NamedRefCopyWith<$Res>? get costCenter;

}
/// @nodoc
class _$PurchaseOrderCopyWithImpl<$Res>
    implements $PurchaseOrderCopyWith<$Res> {
  _$PurchaseOrderCopyWithImpl(this._self, this._then);

  final PurchaseOrder _self;
  final $Res Function(PurchaseOrder) _then;

/// Create a copy of PurchaseOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? status = null,Object? supplierId = freezed,Object? warehouseId = freezed,Object? subtotal = freezed,Object? taxAmount = freezed,Object? totalAmount = freezed,Object? notes = freezed,Object? expectedDeliveryDate = freezed,Object? sentAt = freezed,Object? receivedAt = freezed,Object? createdAt = freezed,Object? supplier = freezed,Object? warehouse = freezed,Object? costCenter = freezed,Object? taxBreakdown = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,supplierId: freezed == supplierId ? _self.supplierId : supplierId // ignore: cast_nullable_to_non_nullable
as int?,warehouseId: freezed == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as int?,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,expectedDeliveryDate: freezed == expectedDeliveryDate ? _self.expectedDeliveryDate : expectedDeliveryDate // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,warehouse: freezed == warehouse ? _self.warehouse : warehouse // ignore: cast_nullable_to_non_nullable
as NamedRef?,costCenter: freezed == costCenter ? _self.costCenter : costCenter // ignore: cast_nullable_to_non_nullable
as NamedRef?,taxBreakdown: null == taxBreakdown ? _self.taxBreakdown : taxBreakdown // ignore: cast_nullable_to_non_nullable
as List<TaxLine>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PurchaseOrderItem>,
  ));
}
/// Create a copy of PurchaseOrder
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
}/// Create a copy of PurchaseOrder
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
}/// Create a copy of PurchaseOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get costCenter {
    if (_self.costCenter == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.costCenter!, (value) {
    return _then(_self.copyWith(costCenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [PurchaseOrder].
extension PurchaseOrderPatterns on PurchaseOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseOrder value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseOrder value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code, @OrderStatusConverter()  OrderStatus status,  int? supplierId,  int? warehouseId, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount,  String? notes,  String? expectedDeliveryDate,  String? sentAt,  String? receivedAt,  String? createdAt,  NamedRef? supplier,  NamedRef? warehouse,  NamedRef? costCenter,  List<TaxLine> taxBreakdown,  List<PurchaseOrderItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseOrder() when $default != null:
return $default(_that.id,_that.code,_that.status,_that.supplierId,_that.warehouseId,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.notes,_that.expectedDeliveryDate,_that.sentAt,_that.receivedAt,_that.createdAt,_that.supplier,_that.warehouse,_that.costCenter,_that.taxBreakdown,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code, @OrderStatusConverter()  OrderStatus status,  int? supplierId,  int? warehouseId, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount,  String? notes,  String? expectedDeliveryDate,  String? sentAt,  String? receivedAt,  String? createdAt,  NamedRef? supplier,  NamedRef? warehouse,  NamedRef? costCenter,  List<TaxLine> taxBreakdown,  List<PurchaseOrderItem> items)  $default,) {final _that = this;
switch (_that) {
case _PurchaseOrder():
return $default(_that.id,_that.code,_that.status,_that.supplierId,_that.warehouseId,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.notes,_that.expectedDeliveryDate,_that.sentAt,_that.receivedAt,_that.createdAt,_that.supplier,_that.warehouse,_that.costCenter,_that.taxBreakdown,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code, @OrderStatusConverter()  OrderStatus status,  int? supplierId,  int? warehouseId, @DoubleConverter()  double? subtotal, @DoubleConverter()  double? taxAmount, @DoubleConverter()  double? totalAmount,  String? notes,  String? expectedDeliveryDate,  String? sentAt,  String? receivedAt,  String? createdAt,  NamedRef? supplier,  NamedRef? warehouse,  NamedRef? costCenter,  List<TaxLine> taxBreakdown,  List<PurchaseOrderItem> items)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseOrder() when $default != null:
return $default(_that.id,_that.code,_that.status,_that.supplierId,_that.warehouseId,_that.subtotal,_that.taxAmount,_that.totalAmount,_that.notes,_that.expectedDeliveryDate,_that.sentAt,_that.receivedAt,_that.createdAt,_that.supplier,_that.warehouse,_that.costCenter,_that.taxBreakdown,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseOrder implements PurchaseOrder {
  const _PurchaseOrder({required this.id, required this.code, @OrderStatusConverter() this.status = OrderStatus.unknown, this.supplierId, this.warehouseId, @DoubleConverter() this.subtotal, @DoubleConverter() this.taxAmount, @DoubleConverter() this.totalAmount, this.notes, this.expectedDeliveryDate, this.sentAt, this.receivedAt, this.createdAt, this.supplier, this.warehouse, this.costCenter, final  List<TaxLine> taxBreakdown = const [], final  List<PurchaseOrderItem> items = const []}): _taxBreakdown = taxBreakdown,_items = items;
  factory _PurchaseOrder.fromJson(Map<String, dynamic> json) => _$PurchaseOrderFromJson(json);

@override final  int id;
@override final  String code;
@override@JsonKey()@OrderStatusConverter() final  OrderStatus status;
@override final  int? supplierId;
@override final  int? warehouseId;
@override@DoubleConverter() final  double? subtotal;
@override@DoubleConverter() final  double? taxAmount;
@override@DoubleConverter() final  double? totalAmount;
@override final  String? notes;
@override final  String? expectedDeliveryDate;
@override final  String? sentAt;
@override final  String? receivedAt;
@override final  String? createdAt;
@override final  NamedRef? supplier;
@override final  NamedRef? warehouse;
@override final  NamedRef? costCenter;
 final  List<TaxLine> _taxBreakdown;
@override@JsonKey() List<TaxLine> get taxBreakdown {
  if (_taxBreakdown is EqualUnmodifiableListView) return _taxBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taxBreakdown);
}

 final  List<PurchaseOrderItem> _items;
@override@JsonKey() List<PurchaseOrderItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of PurchaseOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseOrderCopyWith<_PurchaseOrder> get copyWith => __$PurchaseOrderCopyWithImpl<_PurchaseOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.supplierId, supplierId) || other.supplierId == supplierId)&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.expectedDeliveryDate, expectedDeliveryDate) || other.expectedDeliveryDate == expectedDeliveryDate)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.supplier, supplier) || other.supplier == supplier)&&(identical(other.warehouse, warehouse) || other.warehouse == warehouse)&&(identical(other.costCenter, costCenter) || other.costCenter == costCenter)&&const DeepCollectionEquality().equals(other._taxBreakdown, _taxBreakdown)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,status,supplierId,warehouseId,subtotal,taxAmount,totalAmount,notes,expectedDeliveryDate,sentAt,receivedAt,createdAt,supplier,warehouse,costCenter,const DeepCollectionEquality().hash(_taxBreakdown),const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'PurchaseOrder(id: $id, code: $code, status: $status, supplierId: $supplierId, warehouseId: $warehouseId, subtotal: $subtotal, taxAmount: $taxAmount, totalAmount: $totalAmount, notes: $notes, expectedDeliveryDate: $expectedDeliveryDate, sentAt: $sentAt, receivedAt: $receivedAt, createdAt: $createdAt, supplier: $supplier, warehouse: $warehouse, costCenter: $costCenter, taxBreakdown: $taxBreakdown, items: $items)';
}


}

/// @nodoc
abstract mixin class _$PurchaseOrderCopyWith<$Res> implements $PurchaseOrderCopyWith<$Res> {
  factory _$PurchaseOrderCopyWith(_PurchaseOrder value, $Res Function(_PurchaseOrder) _then) = __$PurchaseOrderCopyWithImpl;
@override @useResult
$Res call({
 int id, String code,@OrderStatusConverter() OrderStatus status, int? supplierId, int? warehouseId,@DoubleConverter() double? subtotal,@DoubleConverter() double? taxAmount,@DoubleConverter() double? totalAmount, String? notes, String? expectedDeliveryDate, String? sentAt, String? receivedAt, String? createdAt, NamedRef? supplier, NamedRef? warehouse, NamedRef? costCenter, List<TaxLine> taxBreakdown, List<PurchaseOrderItem> items
});


@override $NamedRefCopyWith<$Res>? get supplier;@override $NamedRefCopyWith<$Res>? get warehouse;@override $NamedRefCopyWith<$Res>? get costCenter;

}
/// @nodoc
class __$PurchaseOrderCopyWithImpl<$Res>
    implements _$PurchaseOrderCopyWith<$Res> {
  __$PurchaseOrderCopyWithImpl(this._self, this._then);

  final _PurchaseOrder _self;
  final $Res Function(_PurchaseOrder) _then;

/// Create a copy of PurchaseOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? status = null,Object? supplierId = freezed,Object? warehouseId = freezed,Object? subtotal = freezed,Object? taxAmount = freezed,Object? totalAmount = freezed,Object? notes = freezed,Object? expectedDeliveryDate = freezed,Object? sentAt = freezed,Object? receivedAt = freezed,Object? createdAt = freezed,Object? supplier = freezed,Object? warehouse = freezed,Object? costCenter = freezed,Object? taxBreakdown = null,Object? items = null,}) {
  return _then(_PurchaseOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,supplierId: freezed == supplierId ? _self.supplierId : supplierId // ignore: cast_nullable_to_non_nullable
as int?,warehouseId: freezed == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as int?,subtotal: freezed == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double?,taxAmount: freezed == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double?,totalAmount: freezed == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,expectedDeliveryDate: freezed == expectedDeliveryDate ? _self.expectedDeliveryDate : expectedDeliveryDate // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,supplier: freezed == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as NamedRef?,warehouse: freezed == warehouse ? _self.warehouse : warehouse // ignore: cast_nullable_to_non_nullable
as NamedRef?,costCenter: freezed == costCenter ? _self.costCenter : costCenter // ignore: cast_nullable_to_non_nullable
as NamedRef?,taxBreakdown: null == taxBreakdown ? _self._taxBreakdown : taxBreakdown // ignore: cast_nullable_to_non_nullable
as List<TaxLine>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PurchaseOrderItem>,
  ));
}

/// Create a copy of PurchaseOrder
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
}/// Create a copy of PurchaseOrder
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
}/// Create a copy of PurchaseOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedRefCopyWith<$Res>? get costCenter {
    if (_self.costCenter == null) {
    return null;
  }

  return $NamedRefCopyWith<$Res>(_self.costCenter!, (value) {
    return _then(_self.copyWith(costCenter: value));
  });
}
}

// dart format on
