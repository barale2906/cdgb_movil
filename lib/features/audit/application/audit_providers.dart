import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'
    show FutureProviderFamily, NotifierProviderFamily;
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/audit/data/audit_log.dart';
import 'package:sga_bojanini/features/audit/data/audit_repository.dart';

/// Periodos que se pueden consultar, en días hacia atrás desde hoy.
enum AuditPeriod {
  today(0),
  week(6),
  month(29)
  ;

  const AuditPeriod(this.daysBack);

  final int daysBack;
}

/// Filtros de la bitácora: acción y tipo de elemento (`null` = todos) y
/// periodo.
@immutable
class AuditFilter {
  const AuditFilter({
    this.action,
    this.auditableType,
    this.period = AuditPeriod.week,
  });

  final String? action;

  /// Clase PHP completa del elemento, tal como la guarda el servidor.
  final String? auditableType;
  final AuditPeriod period;

  @override
  bool operator ==(Object other) =>
      other is AuditFilter &&
      other.action == action &&
      other.auditableType == auditableType &&
      other.period == period;

  @override
  int get hashCode => Object.hash(action, auditableType, period);
}

/// Fechas `AAAA-MM-DD` del periodo según el día de hoy en Colombia.
({String from, String to}) auditRange(AuditPeriod period, Clock clock) {
  final today = ColombiaTime.now(clock);
  return (
    from: ColombiaTime.formatDate(
      today.subtract(Duration(days: period.daysBack)),
    ),
    to: ColombiaTime.formatDate(today),
  );
}

class AuditListNotifier extends PagedNotifier<AuditLog> {
  AuditListNotifier(this.filter);

  final AuditFilter filter;

  @override
  Future<PagedList<AuditLog>> fetchPage(int page) {
    final range = auditRange(filter.period, ref.read(clockProvider));
    return ref
        .read(auditRepositoryProvider)
        .list(
          action: filter.action,
          auditableType: filter.auditableType,
          dateFrom: range.from,
          dateTo: range.to,
          page: page,
        );
  }
}

final NotifierProviderFamily<
  AuditListNotifier,
  PagedState<AuditLog>,
  AuditFilter
>
auditListProvider = NotifierProvider.autoDispose
    .family<AuditListNotifier, PagedState<AuditLog>, AuditFilter>(
      AuditListNotifier.new,
    );

final FutureProviderFamily<AuditLog, int> auditDetailProvider = FutureProvider
    .autoDispose
    .family<AuditLog, int>(
      (ref, id) => ref.watch(auditRepositoryProvider).detail(id),
    );

final FutureProviderFamily<AuditSummary, AuditPeriod> auditSummaryProvider =
    FutureProvider.autoDispose.family<AuditSummary, AuditPeriod>((ref, period) {
      final range = auditRange(period, ref.watch(clockProvider));
      return ref
          .watch(auditRepositoryProvider)
          .summary(dateFrom: range.from, dateTo: range.to);
    });
