import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show FutureProviderFamily, NotifierProviderFamily;
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/features/consumptions/data/consumption_record.dart';
import 'package:sga_bojanini/features/consumptions/data/consumptions_repository.dart';

/// Consumos paginados; [status] `null` = todos.
class ConsumptionListNotifier extends PagedNotifier<ConsumptionRecord> {
  ConsumptionListNotifier(this.status);

  final SyncStatus? status;

  @override
  Future<PagedList<ConsumptionRecord>> fetchPage(int page) =>
      ref.read(consumptionsRepositoryProvider).list(status: status, page: page);
}

final NotifierProviderFamily<
  ConsumptionListNotifier,
  PagedState<ConsumptionRecord>,
  SyncStatus?
>
consumptionListProvider = NotifierProvider.autoDispose
    .family<
      ConsumptionListNotifier,
      PagedState<ConsumptionRecord>,
      SyncStatus?
    >(ConsumptionListNotifier.new);

final FutureProviderFamily<ConsumptionRecord, int> consumptionDetailProvider =
    FutureProvider.autoDispose.family<ConsumptionRecord, int>(
      (ref, id) => ref.watch(consumptionsRepositoryProvider).detail(id),
    );

/// Proyección de consumo para los próximos `days` días.
final FutureProviderFamily<List<ServiceProjection>, int> projectionProvider =
    FutureProvider.autoDispose.family<List<ServiceProjection>, int>(
      (ref, days) =>
          ref.watch(consumptionsRepositoryProvider).projection(days: days),
    );
