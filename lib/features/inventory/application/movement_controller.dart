import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/idempotency.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_repository.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';

/// Registra movimientos. Un solo envío en vuelo y nunca reintenta solo; cada
/// envío lleva una clave de idempotencia para no duplicar el comprobante si el
/// usuario lo repite. Al terminar, refresca stock, lotes y comprobantes.
class MovementController extends SubmissionNotifier {
  InventoryRepository get _repository => ref.read(inventoryRepositoryProvider);

  final _keys = IdempotencyKeyHolder();

  Future<MovementDocument?> entry(EntryRequest request) => _send(
    request.toJson(),
    (key) => _repository.registerEntry(request, idempotencyKey: key),
  );

  Future<MovementDocument?> exit(ExitRequest request) => _send(
    request.toJson(),
    (key) => _repository.registerExit(request, idempotencyKey: key),
  );

  Future<MovementDocument?> transfer(TransferRequest request) => _send(
    request.toJson(),
    (key) => _repository.registerTransfer(request, idempotencyKey: key),
  );

  Future<MovementLine?> adjustment(AdjustmentRequest request) => _send(
    request.toJson(),
    (key) => _repository.registerAdjustment(request, idempotencyKey: key),
  );

  Future<MovementLine?> returnStock(ReturnRequest request) => _send(
    request.toJson(),
    (key) => _repository.registerReturn(request, idempotencyKey: key),
  );

  Future<MovementLine?> writeOff(WriteOffRequest request) => _send(
    request.toJson(),
    (key) => _repository.registerWriteOff(request, idempotencyKey: key),
  );

  Future<MovementLine?> loss(LossRequest request) => _send(
    request.toJson(),
    (key) => _repository.registerLoss(request, idempotencyKey: key),
  );

  /// Envía con una clave de idempotencia estable mientras el contenido no
  /// cambie; tras un tiempo de espera agotado se conserva para el reenvío.
  Future<T?> _send<T extends Object>(
    Map<String, dynamic> body,
    Future<T> Function(String key) call,
  ) async {
    final key = _keys.keyFor(body);
    final result = await runValue(() => call(key));
    _keys.settle(succeeded: result != null, error: state.error);
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
