import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_center.freezed.dart';
part 'cost_center.g.dart';

/// Centro de costo (`CostCenterResource`): interno (áreas) o externo.
@freezed
abstract class CostCenter with _$CostCenter {
  const factory CostCenter({
    required int id,
    required String name,
    String? code,
    String? type,
    String? typeLabel,
    @Default(false) bool isExternal,
    String? description,
    @Default(true) bool isActive,
  }) = _CostCenter;

  factory CostCenter.fromJson(Map<String, dynamic> json) =>
      _$CostCenterFromJson(json);
}
