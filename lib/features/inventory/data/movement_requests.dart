import 'package:flutter/foundation.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';

Map<String, dynamic> _clean(Map<String, dynamic> json) =>
    json..removeWhere((_, value) => value == null);

@immutable
class EntryItem {
  const EntryItem({
    required this.productVariantId,
    required this.locationId,
    required this.lotNumber,
    required this.expirationDate,
    this.manufacturingDate,
    this.quantityBase,
    this.presentationId,
    this.quantityInPresentation,
    this.notes,
  });

  final int productVariantId;
  final int locationId;
  final String lotNumber;
  final DateTime expirationDate;
  final DateTime? manufacturingDate;

  /// Cantidad en unidad base, o bien presentación + cantidad en ella.
  final double? quantityBase;
  final int? presentationId;
  final double? quantityInPresentation;
  final String? notes;

  Map<String, dynamic> toJson() => _clean({
    'product_variant_id': productVariantId,
    'location_id': locationId,
    'lot_number': lotNumber,
    'expiration_date': ColombiaTime.formatDate(expirationDate),
    'manufacturing_date': manufacturingDate == null
        ? null
        : ColombiaTime.formatDate(manufacturingDate!),
    'quantity_base': quantityBase,
    'product_presentation_id': presentationId,
    'quantity_in_presentation': quantityInPresentation,
    'notes': notes,
  });
}

@immutable
class EntryRequest {
  const EntryRequest({
    required this.warehouseId,
    required this.items,
    this.invoiceNumber,
    this.entryTemperature,
    this.reason,
  });

  final int warehouseId;
  final List<EntryItem> items;
  final String? invoiceNumber;
  final double? entryTemperature;
  final String? reason;

  Map<String, dynamic> toJson() => _clean({
    'warehouse_id': warehouseId,
    'invoice_number': invoiceNumber,
    'entry_temperature': entryTemperature,
    'reason': reason,
    'items': [for (final item in items) item.toJson()],
  });
}

@immutable
class ExitItem {
  const ExitItem({
    required this.genericProductId,
    required this.quantity,
    this.batchId,
    this.notes,
  });

  final int genericProductId;
  final double quantity;

  /// Sin lote, el servidor reparte por FEFO.
  final int? batchId;
  final String? notes;

  Map<String, dynamic> toJson() => _clean({
    'generic_product_id': genericProductId,
    'quantity': quantity,
    'batch_id': batchId,
    'notes': notes,
  });
}

@immutable
class ExitRequest {
  const ExitRequest({
    required this.warehouseId,
    required this.costCenterId,
    required this.items,
    this.patientDocument,
    this.reason,
  });

  final int warehouseId;
  final int costCenterId;
  final List<ExitItem> items;
  final String? patientDocument;
  final String? reason;

  Map<String, dynamic> toJson() => _clean({
    'warehouse_id': warehouseId,
    'cost_center_id': costCenterId,
    'patient_document': patientDocument,
    'reason': reason,
    'items': [for (final item in items) item.toJson()],
  });
}

@immutable
class TransferItem {
  const TransferItem({
    required this.productVariantId,
    required this.locationToId,
    required this.quantity,
    this.batchId,
    this.locationFromId,
    this.notes,
  });

  final int productVariantId;
  final int locationToId;
  final double quantity;
  final int? batchId;
  final int? locationFromId;
  final String? notes;

  Map<String, dynamic> toJson() => _clean({
    'product_variant_id': productVariantId,
    'location_to_id': locationToId,
    'quantity': quantity,
    'batch_id': batchId,
    'location_from_id': locationFromId,
    'notes': notes,
  });
}

@immutable
class TransferRequest {
  const TransferRequest({
    required this.warehouseFromId,
    required this.warehouseToId,
    required this.items,
    this.reason,
  });

  final int warehouseFromId;
  final int warehouseToId;
  final List<TransferItem> items;
  final String? reason;

  Map<String, dynamic> toJson() => _clean({
    'warehouse_from_id': warehouseFromId,
    'warehouse_to_id': warehouseToId,
    'reason': reason,
    'items': [for (final item in items) item.toJson()],
  });
}

/// Ajuste con cantidad con signo (positivo suma, negativo resta).
@immutable
class AdjustmentRequest {
  const AdjustmentRequest({
    required this.productVariantId,
    required this.warehouseId,
    required this.locationId,
    required this.quantity,
    required this.reason,
    this.batchId,
    this.notes,
  });

  final int productVariantId;
  final int warehouseId;
  final int locationId;
  final double quantity;
  final String reason;
  final int? batchId;
  final String? notes;

  Map<String, dynamic> toJson() => _clean({
    'product_variant_id': productVariantId,
    'warehouse_id': warehouseId,
    'location_id': locationId,
    'quantity': quantity,
    'reason': reason,
    'batch_id': batchId,
    'notes': notes,
  });
}

@immutable
class ReturnRequest {
  const ReturnRequest({
    required this.productVariantId,
    required this.warehouseId,
    required this.quantity,
    this.locationId,
    this.batchId,
    this.reason,
    this.notes,
  });

  final int productVariantId;
  final int warehouseId;
  final double quantity;
  final int? locationId;
  final int? batchId;
  final String? reason;
  final String? notes;

  Map<String, dynamic> toJson() => _clean({
    'product_variant_id': productVariantId,
    'warehouse_id': warehouseId,
    'quantity': quantity,
    'location_id': locationId,
    'batch_id': batchId,
    'reason': reason,
    'notes': notes,
  });
}

/// Baja por vencimiento de un lote completo.
@immutable
class WriteOffRequest {
  const WriteOffRequest({
    required this.batchId,
    required this.warehouseId,
    this.locationId,
    this.reason,
    this.notes,
  });

  final int batchId;
  final int warehouseId;
  final int? locationId;
  final String? reason;
  final String? notes;

  Map<String, dynamic> toJson() => _clean({
    'batch_id': batchId,
    'warehouse_id': warehouseId,
    'location_id': locationId,
    'reason': reason,
    'notes': notes,
  });
}

/// Pérdida (rotura, extravío…) de una cantidad de un lote.
@immutable
class LossRequest {
  const LossRequest({
    required this.productVariantId,
    required this.warehouseId,
    required this.locationId,
    required this.batchId,
    required this.quantity,
    required this.reason,
    this.notes,
  });

  final int productVariantId;
  final int warehouseId;
  final int locationId;
  final int batchId;
  final double quantity;
  final String reason;
  final String? notes;

  Map<String, dynamic> toJson() => _clean({
    'product_variant_id': productVariantId,
    'warehouse_id': warehouseId,
    'location_id': locationId,
    'batch_id': batchId,
    'quantity': quantity,
    'reason': reason,
    'notes': notes,
  });
}
