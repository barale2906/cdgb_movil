import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'generic_product.freezed.dart';
part 'generic_product.g.dart';

enum ProductType { simple, kit, unknown }

/// Un tipo nuevo del backend no debe romper la lista: cae en `unknown`.
class ProductTypeConverter implements JsonConverter<ProductType, Object?> {
  const ProductTypeConverter();

  @override
  ProductType fromJson(Object? json) => ProductType.values.firstWhere(
    (type) => type.name == json,
    orElse: () => json == null ? ProductType.simple : ProductType.unknown,
  );

  @override
  Object toJson(ProductType object) => object.name;
}

@freezed
abstract class CategoryRef with _$CategoryRef {
  const factory CategoryRef({
    required int id,
    required String name,
    String? code,
  }) = _CategoryRef;

  factory CategoryRef.fromJson(Map<String, dynamic> json) =>
      _$CategoryRefFromJson(json);
}

@freezed
abstract class UnitRef with _$UnitRef {
  const factory UnitRef({
    required int id,
    required String name,
    String? abbreviation,
  }) = _UnitRef;

  factory UnitRef.fromJson(Map<String, dynamic> json) =>
      _$UnitRefFromJson(json);
}

@freezed
abstract class ClassificationRef with _$ClassificationRef {
  const factory ClassificationRef({
    required int id,
    required String name,
    String? code,
  }) = _ClassificationRef;

  factory ClassificationRef.fromJson(Map<String, dynamic> json) =>
      _$ClassificationRefFromJson(json);
}

@freezed
abstract class SanitaryRegistration with _$SanitaryRegistration {
  const factory SanitaryRegistration({
    required int id,
    required String registrationNumber,
    String? expiryDate,
    @Default(true) bool isActive,
    @Default(false) bool isExpired,
  }) = _SanitaryRegistration;

  factory SanitaryRegistration.fromJson(Map<String, dynamic> json) =>
      _$SanitaryRegistrationFromJson(json);
}

@freezed
abstract class ProductVariant with _$ProductVariant {
  const factory ProductVariant({
    required int id,
    String? labBrand,
    String? brandSku,
    String? commercialPresentation,
    String? serieReference,
    String? riskLevel,
    @Default(true) bool isActive,
    @Default([]) List<SanitaryRegistration> sanitaryRegistrations,
  }) = _ProductVariant;

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);
}

@freezed
abstract class KitComponentProduct with _$KitComponentProduct {
  const factory KitComponentProduct({
    required int id,
    required String name,
    String? barcode,
  }) = _KitComponentProduct;

  factory KitComponentProduct.fromJson(Map<String, dynamic> json) =>
      _$KitComponentProductFromJson(json);
}

@freezed
abstract class KitComponent with _$KitComponent {
  const factory KitComponent({
    required int id,
    @DoubleConverter() double? quantityPerKit,
    KitComponentProduct? component,
  }) = _KitComponent;

  factory KitComponent.fromJson(Map<String, dynamic> json) =>
      _$KitComponentFromJson(json);
}

/// Producto genérico. El listado trae solo los campos planos; el detalle
/// (`GET /generic-products/{id}`) añade categoría, unidad, clasificación,
/// variantes y componentes del kit.
@freezed
abstract class GenericProduct with _$GenericProduct {
  const factory GenericProduct({
    required int id,
    required String name,
    @ProductTypeConverter()
    @Default(ProductType.simple)
    ProductType productType,
    String? barcode,
    String? description,
    String? concentration,
    String? pharmaceuticalForm,
    @Default(false) bool requiresColdChain,
    @DoubleConverter() double? minStock,
    @DoubleConverter() double? maxStock,
    @DoubleConverter() double? reorderPoint,
    @DoubleConverter() double? reorderQuantity,
    @Default(true) bool isActive,
    CategoryRef? category,
    UnitRef? baseUnit,
    ClassificationRef? classification,
    @Default([]) List<ProductVariant> variants,
    @Default([]) List<KitComponent> components,
  }) = _GenericProduct;

  factory GenericProduct.fromJson(Map<String, dynamic> json) =>
      _$GenericProductFromJson(json);
}
