import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/features/consumptions/application/consumption_permissions.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_paths.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumptions_list_tab.dart';
import 'package:sga_bojanini/features/consumptions/presentation/projection_tab.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Consumos de insumos y, con `integraciones.ver`, la proyección de consumo.
class ConsumptionsPage extends ConsumerWidget {
  const ConsumptionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canCreate = ref.watch(canCreateConsumptionProvider);
    final canSeeProjection = ref.watch(canSeeProjectionProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: canCreate
          ? FloatingActionButton.extended(
              onPressed: () => context.push(ConsumptionPaths.newConsumption),
              icon: const Icon(Icons.add),
              label: Text(l10n.consumptionNew),
            )
          : null,
      body: canSeeProjection
          ? DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Material(
                    color: AppColors.surface,
                    child: TabBar(
                      tabs: [
                        Tab(text: l10n.consumptionsTabList),
                        Tab(text: l10n.consumptionsTabProjection),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [ConsumptionsListTab(), ProjectionTab()],
                    ),
                  ),
                ],
              ),
            )
          : const ConsumptionsListTab(),
    );
  }
}
