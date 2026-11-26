import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'medical_service_node.freezed.dart';
part 'medical_service_node.g.dart';

/// Servicio médico con sus procedimientos (`GET /medical-services/tree`:
/// dos niveles, el servicio y sus `children`).
@freezed
abstract class MedicalServiceNode with _$MedicalServiceNode {
  const factory MedicalServiceNode({
    required int id,
    required String name,
    String? code,
    String? type,
    String? description,
    @Default(true) bool isActive,
    @Default([]) List<MedicalServiceNode> children,
  }) = _MedicalServiceNode;

  const MedicalServiceNode._();

  factory MedicalServiceNode.fromJson(Map<String, dynamic> json) =>
      _$MedicalServiceNodeFromJson(json);

  bool get isProcedure => type == 'procedure';
}

/// Tarifa de un procedimiento (`ProcedurePriceResource`).
@freezed
abstract class ProcedurePrice with _$ProcedurePrice {
  const factory ProcedurePrice({
    required int id,
    @DoubleConverter() double? unitPrice,
    String? effectiveFrom,
    String? effectiveTo,
    @Default(true) bool isActive,
    @Default(false) bool isCurrentlyValid,
    String? notes,
  }) = _ProcedurePrice;

  factory ProcedurePrice.fromJson(Map<String, dynamic> json) =>
      _$ProcedurePriceFromJson(json);
}
