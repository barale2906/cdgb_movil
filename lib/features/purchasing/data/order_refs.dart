import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'order_refs.freezed.dart';
part 'order_refs.g.dart';

/// Referencia corta (`{id, name}`) a proveedor, almacén o usuario.
@freezed
abstract class NamedRef with _$NamedRef {
  const factory NamedRef({
    required int id,
    required String name,
    String? code,
    String? email,
  }) = _NamedRef;

  factory NamedRef.fromJson(Map<String, dynamic> json) =>
      _$NamedRefFromJson(json);
}

@freezed
abstract class GenericRef with _$GenericRef {
  const factory GenericRef({
    required int id,
    required String name,
    String? barcode,
  }) = _GenericRef;

  factory GenericRef.fromJson(Map<String, dynamic> json) =>
      _$GenericRefFromJson(json);
}

/// Variante del producto de una línea (marca/laboratorio y genérico).
@freezed
abstract class VariantRef with _$VariantRef {
  const factory VariantRef({
    required int id,
    String? labBrand,
    String? brandSku,
    GenericRef? generic,
  }) = _VariantRef;

  factory VariantRef.fromJson(Map<String, dynamic> json) =>
      _$VariantRefFromJson(json);
}

@freezed
abstract class PresentationRef with _$PresentationRef {
  const factory PresentationRef({
    required int id,
    required String name,
    String? code,
  }) = _PresentationRef;

  factory PresentationRef.fromJson(Map<String, dynamic> json) =>
      _$PresentationRefFromJson(json);
}

/// Impuesto agrupado por tarifa (`tax_breakdown`).
@freezed
abstract class TaxLine with _$TaxLine {
  const factory TaxLine({
    @DoubleConverter() double? taxRate,
    @DoubleConverter() double? rate,
    @DoubleConverter() double? taxableBase,
    @DoubleConverter() double? taxAmount,
  }) = _TaxLine;

  factory TaxLine.fromJson(Map<String, dynamic> json) =>
      _$TaxLineFromJson(json);
}
