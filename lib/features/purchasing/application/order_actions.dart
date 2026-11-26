import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_orders_repository.dart';

/// Acciones del flujo de una orden (aprobar, enviar, recibir…). Son
/// escrituras: bloquean el botón en vuelo y **nunca se reintentan** solas;
/// tras un timeout se vuelve a consultar la orden antes de repetir.
abstract class OrderActions extends SubmissionNotifier {
  OrdersRepository<Object> get repository;

  /// Refresca detalle y listados tras un cambio.
  void invalidateAfterChange(int id);

  Future<bool> submit(int id) => _done(id, () => repository.submit(id));

  Future<bool> approve(int id, {String? comments}) =>
      _done(id, () => repository.approve(id, comments: comments));

  Future<bool> reject(int id, {String? comments}) =>
      _done(id, () => repository.reject(id, comments: comments));

  Future<bool> send(int id) => _done(id, () => repository.send(id));

  Future<bool> cancel(int id) => _done(id, () => repository.cancel(id));

  Future<bool> receive(int id, List<Map<String, Object?>> items) =>
      _done(id, () => repository.receive(id, items));

  /// Ejecuta [action] y refresca lo que muestra la orden: si resultó, por el
  /// cambio; si venció el tiempo, para que el usuario vea el estado real.
  @protected
  Future<R?> change<R extends Object>(
    int id,
    Future<R> Function() action,
  ) async {
    final result = await runValue(action);
    final error = state.error;
    final timedOut =
        error is NetworkException && error.kind == NetworkFailureKind.timeout;
    if (result != null || timedOut) invalidateAfterChange(id);
    return result;
  }

  Future<bool> _done(int id, Future<Object> Function() action) async =>
      await change(id, action) != null;
}

class PurchaseOrderActions extends OrderActions {
  @override
  OrdersRepository<Object> get repository =>
      ref.read(purchaseOrdersRepositoryProvider);

  @override
  void invalidateAfterChange(int id) {
    ref
      ..invalidate(purchaseOrderDetailProvider(id))
      ..invalidate(purchaseOrderListProvider)
      ..invalidate(consolidableSuppliersProvider);
  }
}

final NotifierProvider<PurchaseOrderActions, SubmissionState>
purchaseOrderActionsProvider =
    NotifierProvider.autoDispose<PurchaseOrderActions, SubmissionState>(
      PurchaseOrderActions.new,
    );

class ExpenseOrderActions extends OrderActions {
  ExpenseOrdersRepository get _expenses =>
      ref.read(expenseOrdersRepositoryProvider);

  @override
  OrdersRepository<Object> get repository => _expenses;

  @override
  void invalidateAfterChange(int id) {
    ref
      ..invalidate(expenseOrderDetailProvider(id))
      ..invalidate(expenseOrderListProvider);
  }

  Future<bool> registerInvoice(
    int id, {
    required String invoiceNumber,
    required String invoiceDate,
  }) async =>
      await change(
        id,
        () => _expenses.registerInvoice(
          id,
          invoiceNumber: invoiceNumber,
          invoiceDate: invoiceDate,
        ),
      ) !=
      null;

  Future<bool> sendToAccounting(int id, List<String> recipients) async =>
      await change(id, () => _expenses.sendToAccounting(id, recipients)) !=
      null;

  Future<bool> addPayment(int id, PaymentRequest request) async =>
      await change(id, () => _expenses.addPayment(id, request)) != null;

  Future<bool> deletePayment(int id, int paymentId) async {
    final done = await run(() => _expenses.deletePayment(id, paymentId));
    if (done) invalidateAfterChange(id);
    return done;
  }
}

final NotifierProvider<ExpenseOrderActions, SubmissionState>
expenseOrderActionsProvider =
    NotifierProvider.autoDispose<ExpenseOrderActions, SubmissionState>(
      ExpenseOrderActions.new,
    );

/// Crea la orden consolidada y refresca los listados que cambian.
class ConsolidateController extends SubmissionNotifier {
  Future<ConsolidatedOrder?> consolidate(List<int> ids, {String? notes}) async {
    final result = await runValue(
      () => ref
          .read(purchaseOrdersRepositoryProvider)
          .consolidate(ids, notes: notes),
    );
    if (result != null) {
      ref
        ..invalidate(consolidatedListProvider)
        ..invalidate(consolidableSuppliersProvider)
        ..invalidate(consolidableOrdersProvider);
    }
    return result;
  }
}

final NotifierProvider<ConsolidateController, SubmissionState>
consolidateControllerProvider =
    NotifierProvider.autoDispose<ConsolidateController, SubmissionState>(
      ConsolidateController.new,
    );

/// Calcula la vista previa de una consolidación (no guarda nada, pero es un
/// POST: se bloquea en vuelo y no se reintenta solo).
class ConsolidationPreviewController extends SubmissionNotifier {
  Future<ConsolidationPreview?> preview(List<int> ids) => runValue(
    () => ref.read(purchaseOrdersRepositoryProvider).preview(ids),
  );
}

final NotifierProvider<ConsolidationPreviewController, SubmissionState>
consolidationPreviewControllerProvider =
    NotifierProvider.autoDispose<
      ConsolidationPreviewController,
      SubmissionState
    >(
      ConsolidationPreviewController.new,
    );
