import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/purchasing/application/draft_state.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/order_drafts.dart';

/// Una línea del borrador de gasto.
@immutable
class ExpenseLine {
  const ExpenseLine({
    required this.key,
    this.description = '',
    this.unit = '',
    this.quantity = 1,
    this.unitPrice,
    this.taxRate,
  });

  final int key;
  final String description;
  final String unit;
  final double? quantity;
  final double? unitPrice;
  final double? taxRate;

  double get subtotal => (quantity ?? 0) * (unitPrice ?? 0);

  bool get isValid =>
      description.trim().isNotEmpty &&
      description.trim().length <= 255 &&
      unit.trim().isNotEmpty &&
      unit.trim().length <= 50 &&
      (quantity ?? 0) >= 0.001 &&
      (unitPrice ?? -1) >= 0 &&
      isValidTaxRate(taxRate);

  ExpenseLine copyWith({
    String? description,
    String? unit,
    double? Function()? quantity,
    double? Function()? unitPrice,
    double? Function()? taxRate,
  }) => ExpenseLine(
    key: key,
    description: description ?? this.description,
    unit: unit ?? this.unit,
    quantity: quantity == null ? this.quantity : quantity(),
    unitPrice: unitPrice == null ? this.unitPrice : unitPrice(),
    taxRate: taxRate == null ? this.taxRate : taxRate(),
  );
}

@immutable
class ExpenseDraftState {
  const ExpenseDraftState({
    this.editingId,
    this.supplierId,
    this.expectedDate,
    this.notes = '',
    this.lines = const [],
    this.submission = const DraftSubmission(),
  });

  /// Id del borrador que se modifica; `null` si es nuevo.
  final int? editingId;
  final int? supplierId;
  final DateTime? expectedDate;
  final String notes;
  final List<ExpenseLine> lines;
  final DraftSubmission submission;

  double get total => lines.fold(0, (sum, line) => sum + line.subtotal);

  bool get canSubmit =>
      !submission.isSubmitting &&
      !submission.isUnconfirmed &&
      submission.savedId == null &&
      supplierId != null &&
      notes.trim().length <= 500 &&
      lines.isNotEmpty &&
      lines.every((line) => line.isValid);

  ExpenseDraftState copyWith({
    int? Function()? supplierId,
    DateTime? Function()? expectedDate,
    String? notes,
    List<ExpenseLine>? lines,
    DraftSubmission? submission,
  }) => ExpenseDraftState(
    editingId: editingId,
    supplierId: supplierId == null ? this.supplierId : supplierId(),
    expectedDate: expectedDate == null ? this.expectedDate : expectedDate(),
    notes: notes ?? this.notes,
    lines: lines ?? this.lines,
    submission: submission ?? this.submission,
  );
}

/// Borrador de una orden de gasto (nuevo o el que se edita). Se guarda con un
/// solo envío y sin reintentos automáticos.
class ExpenseDraftNotifier extends Notifier<ExpenseDraftState> {
  ExpenseDraftNotifier(this.initial);

  /// Orden que se edita; `null` para una nueva.
  final ExpenseOrder? initial;

  int _nextKey = 0;

  @override
  ExpenseDraftState build() {
    final order = initial;
    if (order == null) return ExpenseDraftState(lines: [_blankLine()]);
    return ExpenseDraftState(
      editingId: order.id,
      supplierId: order.supplierId,
      expectedDate: parseDraftDate(order.expectedDeliveryDate),
      notes: order.notes ?? '',
      lines: [
        for (final item in order.items)
          ExpenseLine(
            key: _nextKey++,
            description: item.description,
            unit: item.unit ?? '',
            quantity: item.quantityRequested,
            unitPrice: item.unitPrice,
            taxRate: item.taxRate,
          ),
      ],
    );
  }

  ExpenseLine _blankLine() => ExpenseLine(key: _nextKey++);

  void setSupplier(int? id) => state = state.copyWith(supplierId: () => id);

  void setExpectedDate(DateTime? date) =>
      state = state.copyWith(expectedDate: () => date);

  void setNotes(String value) => state = state.copyWith(notes: value);

  void addLine() =>
      state = state.copyWith(lines: [...state.lines, _blankLine()]);

  void removeLine(int key) => state = state.copyWith(
    lines: [
      for (final line in state.lines)
        if (line.key != key) line,
    ],
  );

  void update(int key, ExpenseLine Function(ExpenseLine) change) =>
      state = state.copyWith(
        lines: [
          for (final line in state.lines)
            if (line.key == key) change(line) else line,
        ],
      );

  /// El usuario revisó la lista y confirma que el envío sin respuesta no se
  /// guardó.
  void acknowledgeNotSaved() {
    if (state.submission.isUnconfirmed) {
      state = state.copyWith(submission: const DraftSubmission());
    }
  }

  /// Guarda el borrador. Devuelve el id de la orden o `null` si falló.
  Future<int?> submit() async {
    final supplierId = state.supplierId;
    if (supplierId == null || !state.canSubmit) return null;
    state = state.copyWith(
      submission: const DraftSubmission(isSubmitting: true),
    );
    final request = ExpenseDraftRequest(
      supplierId: supplierId,
      expectedDeliveryDate: state.expectedDate == null
          ? null
          : ColombiaTime.formatDate(state.expectedDate!),
      notes: state.notes,
      items: [
        for (final line in state.lines)
          ExpenseItemRequest(
            description: line.description,
            unit: line.unit,
            quantity: line.quantity!,
            unitPrice: line.unitPrice!,
            taxRate: line.taxRate,
          ),
      ],
    );
    final repository = ref.read(expenseOrdersRepositoryProvider);
    try {
      final order = state.editingId == null
          ? await repository.create(request.toJson())
          : await repository.update(state.editingId!, request.toJson());
      if (!ref.mounted) return null;
      ref
        ..invalidate(expenseOrderListProvider)
        ..invalidate(expenseOrderDetailProvider(order.id));
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
  ExpenseDraftNotifier,
  ExpenseDraftState,
  ExpenseOrder?
>
expenseDraftProvider = NotifierProvider.autoDispose
    .family<ExpenseDraftNotifier, ExpenseDraftState, ExpenseOrder?>(
      ExpenseDraftNotifier.new,
    );
