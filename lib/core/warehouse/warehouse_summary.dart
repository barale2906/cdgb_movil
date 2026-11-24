import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_summary.freezed.dart';
part 'warehouse_summary.g.dart';

/// Datos mínimos de un almacén para el selector global. El módulo de
/// almacenes (fase 2) usa modelos propios con zonas y ubicaciones.
@freezed
abstract class WarehouseSummary with _$WarehouseSummary {
  const factory WarehouseSummary({
    required int id,
    required String name,
    String? code,
    @Default(true) bool isActive,
  }) = _WarehouseSummary;

  factory WarehouseSummary.fromJson(Map<String, dynamic> json) =>
      _$WarehouseSummaryFromJson(json);
}
