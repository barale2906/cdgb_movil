import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show FutureProviderFamily, NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_repository.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_requests.dart';

class MaintenanceListNotifier extends PagedNotifier<AssetMaintenance> {
  MaintenanceListNotifier(this.query);

  final MaintenanceQuery query;

  @override
  Future<PagedList<AssetMaintenance>> fetchPage(int page) =>
      ref.read(maintenanceRepositoryProvider).list(query, page: page);
}

final NotifierProviderFamily<
  MaintenanceListNotifier,
  PagedState<AssetMaintenance>,
  MaintenanceQuery
>
maintenanceListProvider = NotifierProvider.autoDispose
    .family<
      MaintenanceListNotifier,
      PagedState<AssetMaintenance>,
      MaintenanceQuery
    >(MaintenanceListNotifier.new);

final FutureProviderFamily<AssetMaintenance, int> maintenanceDetailProvider =
    FutureProvider.autoDispose.family<AssetMaintenance, int>(
      (ref, id) => ref.watch(maintenanceRepositoryProvider).get(id),
    );

final FutureProviderFamily<List<MaintenancePlan>, int>
maintenancePlansProvider = FutureProvider.autoDispose
    .family<List<MaintenancePlan>, int>(
      (ref, assetId) => ref.watch(maintenanceRepositoryProvider).plans(assetId),
    );

final FutureProviderFamily<Uint8List, int> maintenanceReportProvider =
    FutureProvider.autoDispose.family<Uint8List, int>(
      (ref, id) => ref.watch(maintenanceRepositoryProvider).report(id),
    );

/// Iniciar, completar o cancelar un mantenimiento. Escrituras: botón
/// bloqueado en vuelo, nunca se reintentan; tras un timeout se vuelve a
/// consultar el mantenimiento antes de repetir.
class MaintenanceActions extends SubmissionNotifier {
  MaintenanceRepository get _repository =>
      ref.read(maintenanceRepositoryProvider);

  Future<bool> start(int id) => _change(id, () => _repository.start(id));

  Future<bool> complete(int id, CompleteMaintenanceRequest request) =>
      _change(id, () => _repository.complete(id, request));

  Future<bool> cancel(int id, String reason) =>
      _change(id, () => _repository.cancel(id, reason));

  /// Programa un mantenimiento puntual; devuelve `true` si el servidor lo creó.
  Future<bool> schedule(int assetId, ScheduleMaintenanceRequest request) =>
      _change(
        null,
        () => _repository.schedule(assetId, request),
        assetId: assetId,
      );

  Future<bool> reschedule(int id, DateTime date, {String? reportedFailure}) =>
      _change(
        id,
        () =>
            _repository.reschedule(id, date, reportedFailure: reportedFailure),
      );

  Future<bool> createPlan(int assetId, MaintenancePlanRequest request) =>
      _savePlan(assetId, () => _repository.createPlan(assetId, request));

  Future<bool> updatePlan(
    int assetId,
    int planId,
    MaintenancePlanRequest request,
  ) => _savePlan(assetId, () => _repository.updatePlan(planId, request));

  Future<bool> _savePlan(
    int assetId,
    Future<MaintenancePlan> Function() action,
  ) async {
    final plan = await runValue(action);
    if (plan != null && ref.mounted) {
      ref
        ..invalidate(maintenancePlansProvider(assetId))
        ..invalidate(assetDetailProvider(assetId));
    }
    return plan != null;
  }

  Future<bool> _change(
    int? id,
    Future<AssetMaintenance> Function() action, {
    int? assetId,
  }) async {
    final maintenance = await runValue(action);
    if (!ref.mounted) return maintenance != null;
    if (id != null) ref.invalidate(maintenanceDetailProvider(id));
    ref
      ..invalidate(maintenanceListProvider)
      ..invalidate(assetListProvider)
      ..invalidate(assetStatisticsProvider);
    final affectedAsset = maintenance?.asset?.id ?? assetId;
    if (affectedAsset != null) {
      ref
        ..invalidate(assetDetailProvider(affectedAsset))
        ..invalidate(assetMovementsProvider(affectedAsset));
    }
    return maintenance != null;
  }
}

final NotifierProvider<MaintenanceActions, SubmissionState>
maintenanceActionsProvider =
    NotifierProvider.autoDispose<MaintenanceActions, SubmissionState>(
      MaintenanceActions.new,
    );
