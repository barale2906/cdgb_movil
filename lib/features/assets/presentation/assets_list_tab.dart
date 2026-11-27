import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/core/widgets/search_field.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/data/assets_repository.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_form_page.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_labels.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_scan.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_stats_header.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Activos: indicadores, búsqueda por nombre o código, filtros y escáner de
/// la etiqueta.
class AssetsListTab extends ConsumerStatefulWidget {
  const AssetsListTab({super.key});

  @override
  ConsumerState<AssetsListTab> createState() => _AssetsListTabState();
}

class _AssetsListTabState extends ConsumerState<AssetsListTab> {
  String _search = '';
  AssetStatus? _status;
  bool _overdue = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = AssetQuery(
      search: _search,
      status: _status,
      maintenanceOverdue: _overdue,
    );
    final provider = assetListProvider(query);
    final notifier = ref.read(provider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => unawaited(scanAndOpenAsset(context, ref)),
        icon: const Icon(Icons.qr_code_scanner),
        label: Text(l10n.assetScanAction),
      ),
      body: Column(
        children: [
          const AssetStatsHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    hint: l10n.assetSearchHint,
                    onChanged: (value) => setState(() => _search = value),
                  ),
                ),
                if (ref.watch(permissionServiceProvider).can('activos.crear'))
                  IconButton.filledTonal(
                    tooltip: l10n.assetNewAction,
                    icon: const Icon(Icons.add),
                    onPressed: () =>
                        unawaited(context.push(AssetFormPage.newPath)),
                  ),
              ],
            ),
          ),
          ChoiceFilterBar<_Filter>(
            options: {
              _Filter.all: l10n.filterAll,
              for (final status in const [
                AssetStatus.operational,
                AssetStatus.maintenance,
                AssetStatus.outOfService,
                AssetStatus.available,
              ])
                _Filter.status(status): assetStatusLabel(l10n, status),
              _Filter.overdue: l10n.assetFilterOverdue,
            },
            selected: _overdue ? _Filter.overdue : _Filter.status(_status),
            onSelected: (filter) => setState(() {
              _status = filter.status;
              _overdue = filter == _Filter.overdue;
            }),
          ),
          Expanded(
            child: PagedListView<Asset>(
              state: ref.watch(provider),
              onRefresh: notifier.refresh,
              onLoadMore: notifier.loadMore,
              onRetry: notifier.retry,
              emptyMessage: l10n.assetsEmpty,
              emptyIcon: Icons.devices_other_outlined,
              itemBuilder: (context, asset) => AssetTile(asset: asset),
            ),
          ),
        ],
      ),
    );
  }
}

/// Filtro excluyente de la lista: estado o "mantenimiento vencido".
@immutable
class _Filter {
  const _Filter._(this.status, this.key);

  factory _Filter.status(AssetStatus? status) =>
      _Filter._(status, status?.value ?? 'all');

  static const all = _Filter._(null, 'all');
  static const overdue = _Filter._(null, 'overdue');

  final AssetStatus? status;
  final String key;

  @override
  bool operator ==(Object other) => other is _Filter && other.key == key;

  @override
  int get hashCode => key.hashCode;
}

class AssetTile extends StatelessWidget {
  const AssetTile({required this.asset, super.key});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final next = asset.nextMaintenance;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(asset.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(asset.code),
            if (asset.locationLabel != null) Text(asset.locationLabel!),
            if (next != null && next.isOverdue && next.scheduledDate != null)
              Text(
                l10n.assetMaintenanceOverdueOn(
                  AppFormat.date(next.scheduledDate!),
                ),
              ),
            const SizedBox(height: AppSpacing.xs),
            AssetStatusChip(status: asset.status),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/assets/${asset.id}'),
      ),
    );
  }
}
