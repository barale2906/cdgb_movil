import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';
import 'package:sga_bojanini/features/inventory/data/stock_item.dart';

part 'batch.freezed.dart';
part 'batch.g.dart';

enum BatchStatus { active, expired, depleted, unknown }

class BatchStatusConverter implements JsonConverter<BatchStatus, Object?> {
  const BatchStatusConverter();

  @override
  BatchStatus fromJson(Object? json) => BatchStatus.values.firstWhere(
    (status) => status.name == json,
    orElse: () => BatchStatus.unknown,
  );

  @override
  Object toJson(BatchStatus object) => object.name;
}

@freezed
abstract class BatchZone with _$BatchZone {
  const factory BatchZone({
    int? warehouseId,
    String? warehouseName,
    String? zoneName,
  }) = _BatchZone;

  factory BatchZone.fromJson(Map<String, dynamic> json) =>
      _$BatchZoneFromJson(json);
}

@freezed
abstract class BatchLocation with _$BatchLocation {
  const factory BatchLocation({
    required int locationId,
    String? locationName,
    String? locationCode,
    @DoubleConverter() double? quantity,
    BatchZone? zone,
  }) = _BatchLocation;

  factory BatchLocation.fromJson(Map<String, dynamic> json) =>
      _$BatchLocationFromJson(json);
}

/// Lote (`BatchResource`). Con filtro de almacén, [quantityAvailable] es el
/// saldo en ese almacén y [totalQuantityAvailable] el global.
@freezed
abstract class Batch with _$Batch {
  const factory Batch({
    required int id,
    required String lotNumber,
    int? productVariantId,
    String? expirationDate,
    String? manufacturingDate,
    @DoubleConverter() double? quantityAvailable,
    @DoubleConverter() double? totalQuantityAvailable,
    @BatchStatusConverter() @Default(BatchStatus.unknown) BatchStatus status,
    int? daysUntilExpiry,
    String? notes,
    StockVariant? variant,
    @Default([]) List<BatchLocation> locations,
  }) = _Batch;

  const Batch._();

  factory Batch.fromJson(Map<String, dynamic> json) => _$BatchFromJson(json);

  String get productName => variant?.generic?.name ?? '';

  /// Vencido por estado o por fecha.
  bool get isExpired =>
      status == BatchStatus.expired || (daysUntilExpiry ?? 1) < 0;
}
