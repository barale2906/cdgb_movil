import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_repository.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';

/// Registra movimientos. Un solo envío en vuelo; nunca reintenta (la API no
/// tiene idempotencia). Al terminar, refresca stock, lotes y comprobantes.
class MovementController extends SubmissionNotifier {
  InventoryRepository get _repository => ref.read(inventoryRepositoryProvider);

  Future<MovementDocument?> entry(EntryRequest request) =>
      _document(() => _repository.registerEntry(request));

  Future<MovementDocument?> exit(ExitRequest request) =>
      _document(() => _repository.registerExit(request));

  Future<MovementDocument?> transfer(TransferRequest request) =>
      _document(() => _repository.registerTransfer(request));

  Future<MovementLine?> adjustment(AdjustmentRequest request) =>
      _line(() => _repository.registerAdjustment(request));

  Future<MovementLine?> returnStock(ReturnRequest request) =>
      _line(() => _repository.registerReturn(request));

  Future<MovementLine?> writeOff(WriteOffRequest request) =>
      _line(() => _repository.registerWriteOff(request));

  Future<MovementLine?> loss(LossRequest request) =>
      _line(() => _repository.registerLoss(request));

  Future<MovementDocument?> _document(
    Future<MovementDocument> Function() call,
  ) async {
    final result = await runValue(call);
    if (result != null) _refreshLists();
    return result;
  }

  Future<MovementLine?> _line(Future<MovementLine> Function() call) async {
    final result = await runValue(call);
    if (result != null) _refreshLists();
    return result;
  }

  void _refreshLists() {
    ref
      ..invalidate(stockListProvider)
      ..invalidate(lowStockProvider)
      ..invalidate(batchListProvider)
      ..invalidate(expiringBatchesProvider)
      ..invalidate(expiredBatchesProvider)
      ..invalidate(documentListProvider)
      ..invalidate(movementListProvider);
  }
}

final NotifierProvider<MovementController, SubmissionState>
movementControllerProvider =
    NotifierProvider.autoDispose<MovementController, SubmissionState>(
      MovementController.new,
    );
