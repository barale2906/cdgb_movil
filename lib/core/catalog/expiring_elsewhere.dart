import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'expiring_elsewhere.freezed.dart';
part 'expiring_elsewhere.g.dart';

/// Saldo de un lote próximo a vencer en un almacén (`items` de
/// `GET /generic-products/{id}/batches/other-warehouses-expiring`).
@freezed
abstract class ExpiringBatch with _$ExpiringBatch {
  const factory ExpiringBatch({
    required int batchId,
    required String lotNumber,
    String? expirationDate,
    @Default(0) int daysUntilExpiry,
    String? labBrand,
    NamedRef? warehouse,
    @DoubleConverter() double? quantity,
  }) = _ExpiringBatch;

  factory ExpiringBatch.fromJson(Map<String, dynamic> json) =>
      _$ExpiringBatchFromJson(json);
}

/// Lotes que vencen pronto en almacenes distintos del activo, para decidir
/// un traslado antes de que se pierdan.
@freezed
abstract class ExpiringElsewhere with _$ExpiringElsewhere {
  const factory ExpiringElsewhere({
    @Default(0) int days,
    @Default([]) List<ExpiringBatch> items,
  }) = _ExpiringElsewhere;

  factory ExpiringElsewhere.fromJson(Map<String, dynamic> json) =>
      _$ExpiringElsewhereFromJson(json);
}
