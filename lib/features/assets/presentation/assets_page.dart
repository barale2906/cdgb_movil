import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/features/assets/presentation/assets_list_tab.dart';
import 'package:sga_bojanini/features/assets/presentation/transfers_tab.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Activos: la lista del parque y los traslados.
class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Material(
            color: AppColors.surface,
            child: TabBar(
              tabs: [
                Tab(text: l10n.assetsTabAssets),
                Tab(text: l10n.assetsTabTransfers),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(children: [AssetsListTab(), TransfersTab()]),
          ),
        ],
      ),
    );
  }
}
