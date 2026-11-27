import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'product_presentation.freezed.dart';
part 'product_presentation.g.dart';

/// Presentación de un producto (caja, blíster…) con su factor a unidad base.
@freezed
abstract class ProductPresentation with _$ProductPresentation {
  const factory ProductPresentation({
    required int id,
    required String name,
    String? code,
    @DoubleConverter() double? factorToBase,
    @Default(true) bool isActive,
  }) = _ProductPresentation;

  factory ProductPresentation.fromJson(Map<String, dynamic> json) =>
      _$ProductPresentationFromJson(json);
}
