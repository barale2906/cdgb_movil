// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryRef _$CategoryRefFromJson(Map<String, dynamic> json) => _CategoryRef(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  code: json['code'] as String?,
);

Map<String, dynamic> _$CategoryRefToJson(_CategoryRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };

_UnitRef _$UnitRefFromJson(Map<String, dynamic> json) => _UnitRef(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String?,
);

Map<String, dynamic> _$UnitRefToJson(_UnitRef instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'abbreviation': instance.abbreviation,
};

_ClassificationRef _$ClassificationRefFromJson(Map<String, dynamic> json) =>
    _ClassificationRef(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$ClassificationRefToJson(_ClassificationRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };

_SanitaryRegistration _$SanitaryRegistrationFromJson(
  Map<String, dynamic> json,
) => _SanitaryRegistration(
  id: (json['id'] as num).toInt(),
  registrationNumber: json['registration_number'] as String,
  expiryDate: json['expiry_date'] as String?,
  isActive: json['is_active'] as bool? ?? true,
  isExpired: json['is_expired'] as bool? ?? false,
);

Map<String, dynamic> _$SanitaryRegistrationToJson(
  _SanitaryRegistration instance,
) => <String, dynamic>{
  'id': instance.id,
  'registration_number': instance.registrationNumber,
  'expiry_date': instance.expiryDate,
  'is_active': instance.isActive,
  'is_expired': instance.isExpired,
};

_ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) =>
    _ProductVariant(
      id: (json['id'] as num).toInt(),
      labBrand: json['lab_brand'] as String?,
      brandSku: json['brand_sku'] as String?,
      commercialPresentation: json['commercial_presentation'] as String?,
      serieReference: json['serie_reference'] as String?,
      riskLevel: json['risk_level'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      sanitaryRegistrations:
          (json['sanitary_registrations'] as List<dynamic>?)
              ?.map(
                (e) => SanitaryRegistration.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductVariantToJson(_ProductVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lab_brand': instance.labBrand,
      'brand_sku': instance.brandSku,
      'commercial_presentation': instance.commercialPresentation,
      'serie_reference': instance.serieReference,
      'risk_level': instance.riskLevel,
      'is_active': instance.isActive,
      'sanitary_registrations': instance.sanitaryRegistrations
          .map((e) => e.toJson())
          .toList(),
    };

_KitComponentProduct _$KitComponentProductFromJson(Map<String, dynamic> json) =>
    _KitComponentProduct(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      barcode: json['barcode'] as String?,
    );

Map<String, dynamic> _$KitComponentProductToJson(
  _KitComponentProduct instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'barcode': instance.barcode,
};

_KitComponent _$KitComponentFromJson(
  Map<String, dynamic> json,
) => _KitComponent(
  id: (json['id'] as num).toInt(),
  quantityPerKit: const DoubleConverter().fromJson(json['quantity_per_kit']),
  component: json['component'] == null
      ? null
      : KitComponentProduct.fromJson(json['component'] as Map<String, dynamic>),
);

Map<String, dynamic> _$KitComponentToJson(
  _KitComponent instance,
) => <String, dynamic>{
  'id': instance.id,
  'quantity_per_kit': const DoubleConverter().toJson(instance.quantityPerKit),
  'component': instance.component?.toJson(),
};

_GenericProduct _$GenericProductFromJson(Map<String, dynamic> json) =>
    _GenericProduct(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      productType: json['product_type'] == null
          ? ProductType.simple
          : const ProductTypeConverter().fromJson(json['product_type']),
      barcode: json['barcode'] as String?,
      description: json['description'] as String?,
      concentration: json['concentration'] as String?,
      pharmaceuticalForm: json['pharmaceutical_form'] as String?,
      requiresColdChain: json['requires_cold_chain'] as bool? ?? false,
      minStock: const DoubleConverter().fromJson(json['min_stock']),
      maxStock: const DoubleConverter().fromJson(json['max_stock']),
      reorderPoint: const DoubleConverter().fromJson(json['reorder_point']),
      reorderQuantity: const DoubleConverter().fromJson(
        json['reorder_quantity'],
      ),
      isActive: json['is_active'] as bool? ?? true,
      category: json['category'] == null
          ? null
          : CategoryRef.fromJson(json['category'] as Map<String, dynamic>),
      baseUnit: json['base_unit'] == null
          ? null
          : UnitRef.fromJson(json['base_unit'] as Map<String, dynamic>),
      classification: json['classification'] == null
          ? null
          : ClassificationRef.fromJson(
              json['classification'] as Map<String, dynamic>,
            ),
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      components:
          (json['components'] as List<dynamic>?)
              ?.map((e) => KitComponent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GenericProductToJson(
  _GenericProduct instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'product_type': const ProductTypeConverter().toJson(instance.productType),
  'barcode': instance.barcode,
  'description': instance.description,
  'concentration': instance.concentration,
  'pharmaceutical_form': instance.pharmaceuticalForm,
  'requires_cold_chain': instance.requiresColdChain,
  'min_stock': const DoubleConverter().toJson(instance.minStock),
  'max_stock': const DoubleConverter().toJson(instance.maxStock),
  'reorder_point': const DoubleConverter().toJson(instance.reorderPoint),
  'reorder_quantity': const DoubleConverter().toJson(instance.reorderQuantity),
  'is_active': instance.isActive,
  'category': instance.category?.toJson(),
  'base_unit': instance.baseUnit?.toJson(),
  'classification': instance.classification?.toJson(),
  'variants': instance.variants.map((e) => e.toJson()).toList(),
  'components': instance.components.map((e) => e.toJson()).toList(),
};
