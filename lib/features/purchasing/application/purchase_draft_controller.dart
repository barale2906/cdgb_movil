import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/features/purchasing/application/draft_state.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/order_drafts.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_orders_repository.dart';

/// Una línea del borrador de compra: variante y presentación de un producto.
@immutable
class PurchaseLine {
  const PurchaseLine({
    required this.key,
    required this.productName,
    required this.variantId,
    required this.presentationId,
    required this.presentationName,
    this.variantLabel,
    this.quantity = 1,
    this.unitPrice,
    this.taxRate,
  });

  final int key;
  final String productName;

  /// Marca o laboratorio de la variante, para distinguirla.
  final String? variantLabel;
  final int variantId;
  final int presentationId;
  final String presentationName;

  /// Unidades de la presentación (entero).
  final int? quantity;
  final double? unitPrice;
  final double? taxRate;

  double get subtotal => (quantity ?? 0) * (unitPrice ?? 0);

  bool get isValid =>
      (quantity ?? 0) >= 1 && (unitPrice ?? -1) >= 0 && isValidTaxRate(taxRate);

  PurchaseLine copyWith({
    int? Function()? quantity,
    double? Function()? unitPrice,
    double? Function()? taxRate,
  }) => PurchaseLine(
    key: key,
    productName: productName,
    variantLabel: variantLabel,
    variantId: variantId,
    presentationId: presentationId,
    presentationName: presentationName,
    quantity: quantity == null ? this.quantity : quantity(),
    unitPrice: unitPrice == null ? this.unitPrice : unitPrice(),
    taxRate: taxRate == null ? this.taxRate : taxRate(),
  );
}

@immutable
class PurchaseDraftState {
  const PurchaseDraftState({
    this.editingId,
    this.supplierId,
    this.warehouseId,
    this.costCenterId,
    this.expectedDate,
    this.notes = '',
    this.lines = const [],
    this.submission = const DraftSubmission(),
  });

  final int? editingId;
  final int? supplierId;
  final int? warehouseId;
  final int? costCenterId;
  final DateTime? expectedDate;
  final String notes;
  final List<PurchaseLine> lines;
  final DraftSubmission submission;

  double get total => lines.fold(0, (sum, line) => sum + line.subtotal);

  bool get canSubmit =>
      !submission.isSubmitting &&
      !submission.isUnconfirmed &&
      submission.savedId == null &&
      supplierId != null &&
      warehouseId != null &&
      lines.isNotEmpty &&
      lines.every((line) => line.isValid);

  PurchaseDraftState copyWith({
    int? Function()? supplierId,
    int? Function()? warehouseId,
    int? Function()? costCenterId,
    DateTime? Function()? expectedDate,
    String? notes,
    List<PurchaseLine>? lines,
    DraftSubmission? submission,
  }) => PurchaseDraftState(
    editingId: editingId,
    supplierId: supplierId == null ? this.supplierId : supplierId(),
    warehouseId: warehouseId == null ? this.warehouseId : warehouseId(),
    costCenterId: costCenterId == null ? this.costCenterId : costCenterId(),
    expectedDate: expectedDate == null ? this.expectedDate : expectedDate(),
    notes: notes ?? this.notes,
    lines: lines ?? this.lines,
    submission: submission ?? this.submission,
  );
}

/// Borrador de una orden de compra (nuevo o el que se edita). Se guarda con un
/// solo envío y sin reintentos automáticos.
class PurchaseDraftNotifier extends Notifier<PurchaseDraftState> {
  PurchaseDraftNotifier(this.initial);

  /// Orden que se edita; `null` para una nueva.
  final PurchaseOrder? initial;

  int _nextKey = 0;

  @override
  PurchaseDraftState build() {
    final order = initial;
    // Un borrador nuevo propone el almacén activo del usuario.
    if (order == null) {
      return PurchaseDraftState(
        warehouseId: ref.read(activeWarehouseProvider)?.id,
      );
    }
    return PurchaseDraftState(
      editingId: order.id,
      supplierId: order.supplierId,
      warehouseId: order.warehouseId,
      costCenterId: order.costCenter?.id,
      expectedDate: parseDraftDate(order.expectedDeliveryDate),
      notes: order.notes ?? '',
      lines: [
        for (final item in order.items)
          if (item.productVariantId != null &&
              item.productPresentationId != null)
            PurchaseLine(
              key: _nextKey++,
              productName: item.productName ?? '',
              variantLabel: item.variant?.labBrand,
              variantId: item.productVariantId!,
              presentationId: item.productPresentationId!,
              presentationName: item.presentation?.name ?? '',
              quantity: item.quantityRequested?.round(),
              unitPrice: item.unitPrice,
              taxRate: item.taxRate,
            ),
      ],
    );
  }

  void setSupplier(int? id) => state = state.copyWith(supplierId: () => id);

  void setWarehouse(int? id) => state = state.copyWith(warehouseId: () => id);

  void setCostCenter(int? id) => state = state.copyWith(costCenterId: () => id);

  void setExpectedDate(DateTime? date) =>
      state = state.copyWith(expectedDate: () => date);

  void setNotes(String value) => state = state.copyWith(notes: value);

  void addLine({
    required String productName,
    required int variantId,
    required int presentationId,
    required String presentationName,
    String? variantLabel,
  }) => state = state.copyWith(
    lines: [
      ...state.lines,
      PurchaseLine(
        key: _nextKey++,
        productName: productName,
        variantLabel: variantLabel,
        variantId: variantId,
        presentationId: presentationId,
        presentationName: presentationName,
      ),
    ],
  );

  void removeLine(int key) => state = state.copyWith(
    lines: [
      for (final line in state.lines)
        if (line.key != key) line,
    ],
  );

  void update(int key, PurchaseLine Function(PurchaseLine) change) =>
      state = state.copyWith(
        lines: [
          for (final line in state.lines)
            if (line.key == key) change(line) else line,
        ],
      );

  void acknowledgeNotSaved() {
    if (state.submission.isUnconfirmed) {
      state = state.copyWith(submission: const DraftSubmission());
    }
  }

  /// Guarda el borrador. Devuelve el id de la orden o `null` si falló.
  Future<int?> submit() async {
    final supplierId = state.supplierId;
    final warehouseId = state.warehouseId;
    if (supplierId == null || warehouseId == null || !state.canSubmit) {
      return null;
    }
    state = state.copyWith(
      submission: const DraftSubmission(isSubmitting: true),
    );
    final request = PurchaseDraftRequest(
      supplierId: supplierId,
      warehouseId: warehouseId,
      costCenterId: state.costCenterId,
      expectedDeliveryDate: state.expectedDate == null
          ? null
          : ColombiaTime.formatDate(state.expectedDate!),
      notes: state.notes,
      items: [
        for (final line in state.lines)
          PurchaseItemRequest(
            productVariantId: line.variantId,
            productPresentationId: line.presentationId,
            quantity: line.quantity!,
            unitPrice: line.unitPrice!,
            taxRate: line.taxRate,
          ),
      ],
    );
    final repository = ref.read(purchaseOrdersRepositoryProvider);
    try {
      final order = state.editingId == null
          ? await repository.create(request.toJson())
          : await repository.update(state.editingId!, request.toJson());
      if (!ref.mounted) return null;
      ref
        ..invalidate(purchaseOrderListProvider)
        ..invalidate(purchaseOrderDetailProvider(order.id));
      state = state.copyWith(submission: DraftSubmission(savedId: order.id));
      return order.id;
    } on ApiException catch (error) {
      if (!ref.mounted) return null;
      state = state.copyWith(submission: DraftSubmission(error: error));
      return null;
    }
  }
}

final NotifierProviderFamily<
  PurchaseDraftNotifier,
  PurchaseDraftState,
  PurchaseOrder?
>
purchaseDraftProvider = NotifierProvider.autoDispose
    .family<PurchaseDraftNotifier, PurchaseDraftState, PurchaseOrder?>(
      PurchaseDraftNotifier.new,
    );
