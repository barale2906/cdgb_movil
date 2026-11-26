import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/catalog/cost_center.dart';
import 'package:sga_bojanini/core/catalog/cost_center_providers.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/searchable_list.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/cost_centers/presentation/services_tab.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Centros de costo y, con `servicios_medicos.ver`, el árbol de servicios y
/// procedimientos con sus tarifas. Todo de solo lectura.
class CostCentersPage extends ConsumerWidget {
  const CostCentersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canSeeServices = ref.watch(
      permissionServiceProvider.select((p) => p.can('servicios_medicos.ver')),
    );
    if (!canSeeServices) return const _CentersTab();
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Material(
            color: AppColors.surface,
            child: TabBar(
              tabs: [
                Tab(text: l10n.costCentersTabCenters),
                Tab(text: l10n.costCentersTabServices),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(children: [_CentersTab(), ServicesTab()]),
          ),
        ],
      ),
    );
  }
}

class _CentersTab extends StatelessWidget {
  const _CentersTab();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SearchableList<CostCenter>(
      provider: costCenterListProvider,
      searchHint: l10n.costCentersSearchHint,
      emptyMessage: l10n.costCentersEmpty,
      itemBuilder: (context, center) => _CenterTile(center: center),
    );
  }
}

class _CenterTile extends StatelessWidget {
  const _CenterTile({required this.center});

  final CostCenter center;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(center.name),
        subtitle: center.code == null ? null : Text(center.code!),
        trailing: StatusChip(
          label: center.isExternal
              ? l10n.costCenterExternal
              : l10n.costCenterInternal,
          kind: center.isExternal ? StatusKind.info : StatusKind.special,
        ),
      ),
    );
  }
}
