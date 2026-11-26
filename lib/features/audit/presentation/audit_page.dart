import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/features/audit/application/audit_providers.dart';
import 'package:sga_bojanini/features/audit/data/audit_log.dart';
import 'package:sga_bojanini/features/audit/presentation/audit_detail_page.dart';
import 'package:sga_bojanini/features/audit/presentation/audit_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Bitácora de auditoría (solo consulta): totales del periodo, filtros por
/// periodo y acción, y la lista de registros.
class AuditPage extends ConsumerStatefulWidget {
  const AuditPage({super.key});

  @override
  ConsumerState<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends ConsumerState<AuditPage> {
  AuditFilter _filter = const AuditFilter();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = auditListProvider(_filter);
    final notifier = ref.read(provider.notifier);
    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        ChoiceFilterBar<AuditPeriod>(
          options: {
            AuditPeriod.today: l10n.auditPeriodToday,
            AuditPeriod.week: l10n.auditPeriodWeek,
            AuditPeriod.month: l10n.auditPeriodMonth,
          },
          selected: _filter.period,
          onSelected: (period) => setState(
            () => _filter = AuditFilter(
              action: _filter.action,
              auditableType: _filter.auditableType,
              period: period,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ChoiceFilterBar<String?>(
          options: {
            null: l10n.filterAll,
            for (final action in AuditActions.filterable)
              action: auditActionLabel(l10n, action),
          },
          selected: _filter.action,
          onSelected: (action) => setState(
            () => _filter = AuditFilter(
              action: action,
              auditableType: _filter.auditableType,
              period: _filter.period,
            ),
          ),
        ),
        _TypeFilter(
          period: _filter.period,
          selected: _filter.auditableType,
          onChanged: (type) => setState(
            () => _filter = AuditFilter(
              action: _filter.action,
              auditableType: type,
              period: _filter.period,
            ),
          ),
        ),
        _SummaryLine(period: _filter.period),
        Expanded(
          child: PagedListView<AuditLog>(
            state: ref.watch(provider),
            onRefresh: () async {
              ref.invalidate(auditSummaryProvider(_filter.period));
              await notifier.refresh();
            },
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.auditEmpty,
            emptyIcon: Icons.verified_user_outlined,
            itemBuilder: (context, log) => _AuditTile(log: log),
          ),
        ),
      ],
    );
  }
}

/// Filtro por tipo de elemento: las opciones salen del resumen del periodo
/// (los tipos que sí tienen registros). Sin resumen, no se muestra.
class _TypeFilter extends ConsumerWidget {
  const _TypeFilter({
    required this.period,
    required this.selected,
    required this.onChanged,
  });

  final AuditPeriod period;
  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ref.watch(auditSummaryProvider(period)).value?.byType.keys;
    if (types == null || types.isEmpty) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: OptionDropdown<String>(
        label: l10n.auditEntityFilter,
        nullLabel: l10n.auditAllEntities,
        options: {
          for (final type in types) type: auditEntityName(type, l10n),
        },
        value: selected,
        onChanged: onChanged,
      ),
    );
  }
}

/// Total de registros del periodo; si no carga, no se muestra (es un apoyo).
class _SummaryLine extends ConsumerWidget {
  const _SummaryLine({required this.period});

  final AuditPeriod period;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(auditSummaryProvider(period)).value;
    if (summary == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppLocalizations.of(context).auditSummaryTotal(summary.total),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}

class _AuditTile extends StatelessWidget {
  const _AuditTile({required this.log});

  final AuditLog log;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final createdAt = log.createdAt;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(auditEntityName(log.auditableType, l10n)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(log.userName ?? l10n.auditSystemUser),
            if (createdAt != null) Text(AppFormat.dateTime(createdAt)),
            const SizedBox(height: AppSpacing.xs),
            AuditActionChip(action: log.action),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(AuditDetailPage.pathFor(log.id)),
      ),
    );
  }
}
