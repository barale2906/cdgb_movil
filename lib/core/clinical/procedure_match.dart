import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'procedure_match.freezed.dart';
part 'procedure_match.g.dart';

/// Tarifa vigente de un procedimiento.
@freezed
abstract class CurrentPrice with _$CurrentPrice {
  const factory CurrentPrice({@DoubleConverter() double? unitPrice}) =
      _CurrentPrice;

  factory CurrentPrice.fromJson(Map<String, dynamic> json) =>
      _$CurrentPriceFromJson(json);
}

/// Procedimiento hallado en `GET /medical-services/search`, con su tarifa
/// vigente (puede no tener).
@freezed
abstract class ProcedureMatch with _$ProcedureMatch {
  const factory ProcedureMatch({
    required int id,
    required String code,
    required String name,
    CurrentPrice? currentPrice,
  }) = _ProcedureMatch;

  const ProcedureMatch._();

  factory ProcedureMatch.fromJson(Map<String, dynamic> json) =>
      _$ProcedureMatchFromJson(json);

  double? get unitPrice => currentPrice?.unitPrice;
}
