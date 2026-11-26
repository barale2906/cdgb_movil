import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/service_orders/application/service_orders_providers.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';
import 'package:sga_bojanini/features/service_orders/data/service_orders_repository.dart';

/// Aprobar el descuento, facturar o anular una orden. Son escrituras: bloquean
/// el botón en vuelo y **nunca se reintentan** solas. Tras un cambio (o un
/// timeout, por si sí se aplicó) se vuelve a consultar la orden.
class ServiceOrderActions extends SubmissionNotifier {
  ServiceOrdersRepository get _repository =>
      ref.read(serviceOrdersRepositoryProvider);

  Future<bool> approveDiscount(String orderNumber) =>
      _change(orderNumber, () => _repository.approveDiscount(orderNumber));

  Future<bool> bill(String orderNumber) =>
      _change(orderNumber, () => _repository.bill(orderNumber));

  Future<bool> cancel(String orderNumber) =>
      _change(orderNumber, () => _repository.cancel(orderNumber));

  Future<bool> _change(
    String orderNumber,
    Future<ServiceOrder> Function() action,
  ) async {
    final result = await runValue(action);
    final error = state.error;
    final timedOut =
        error is NetworkException && error.kind == NetworkFailureKind.timeout;
    if (result != null || timedOut) {
      ref
        ..invalidate(serviceOrderProvider(orderNumber))
        ..invalidate(pendingDiscountsProvider);
    }
    return result != null;
  }
}

final NotifierProvider<ServiceOrderActions, SubmissionState>
serviceOrderActionsProvider =
    NotifierProvider.autoDispose<ServiceOrderActions, SubmissionState>(
      ServiceOrderActions.new,
    );
