import 'package:flutter/foundation.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';

/// Filtros de lotes del listado paginado.
@immutable
class BatchQuery {
  const BatchQuery({this.warehouseId, this.status});

  final int? warehouseId;
  final BatchStatus? status;

  @override
  bool operator ==(Object other) =>
      other is BatchQuery &&
      other.warehouseId == warehouseId &&
      other.status == status;

  @override
  int get hashCode => Object.hash(warehouseId, status);
}

@immutable
class DocumentQuery {
  const DocumentQuery({this.warehouseId, this.status});

  final int? warehouseId;
  final DocumentStatus? status;

  @override
  bool operator ==(Object other) =>
      other is DocumentQuery &&
      other.warehouseId == warehouseId &&
      other.status == status;

  @override
  int get hashCode => Object.hash(warehouseId, status);
}
