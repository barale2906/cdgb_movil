import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/core/widgets/search_field.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_repository.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Filtros de la lista: por estado o "vencidos".
enum _Filter { scheduled, overdue, inProgress, completed, all }

/// Mantenimientos de activos: programados, vencidos, en curso y realizados.
class MaintenancePage extends ConsumerStatefulWidget {
  const MaintenancePage({super.key});

  @override
  ConsumerState<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends ConsumerState<MaintenancePage> {
  _Filter _filter = _Filter.scheduled;
  String _search = '';

  MaintenanceQuery get _query => MaintenanceQuery(
    search: _search,
    overdue: _filter == _Filter.overdue,
    status: switch (_filter) {
      _Filter.scheduled => MaintenanceStatus.scheduled,
      _Filter.inProgress => MaintenanceStatus.inProgress,
      _Filter.completed => MaintenanceStatus.completed,
      _Filter.overdue || _Filter.all => null,
    },
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = maintenanceListProvider(_query);
    final notifier = ref.read(provider.notifier);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SearchField(
            hint: l10n.assetSearchHint,
            onChanged: (value) => setState(() => _search = value),
          ),
        ),
        ChoiceFilterBar<_Filter>(
          options: {
            _Filter.scheduled: l10n.maintenanceStatusScheduled,
            _Filter.overdue: l10n.maintenanceStatusOverdue,
            _Filter.inProgress: l10n.maintenanceStatusInProgress,
            _Filter.completed: l10n.maintenanceStatusCompleted,
            _Filter.all: l10n.filterAll,
          },
          selected: _filter,
          onSelected: (value) => setState(() => _filter = value),
        ),
        Expanded(
          child: PagedListView<AssetMaintenance>(
            state: ref.watch(provider),
            onRefresh: notifier.refresh,
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.maintenanceEmpty,
            emptyIcon: Icons.build_outlined,
            itemBuilder: (context, item) => _Tile(item),
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.item);

  final AssetMaintenance item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(item.asset?.name ?? l10n.notAvailable),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              [
                maintenanceTypeLabel(l10n, item.type),
                if (item.asset?.code != null) item.asset!.code!,
              ].join(' · '),
            ),
            if (item.scheduledDate != null)
              Text(
                l10n.maintenanceScheduledFor(
                  AppFormat.date(item.scheduledDate!),
                ),
              ),
            const SizedBox(height: AppSpacing.xs),
            MaintenanceStatusChip(maintenance: item),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/maintenance/${item.id}'),
      ),
    );
  }
}
