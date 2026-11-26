import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/features/purchasing/presentation/consolidated_orders_tab.dart';
import 'package:sga_bojanini/features/purchasing/presentation/orders_tabs.dart';
import 'package:sga_bojanini/features/purchasing/presentation/suggestions_tab.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Compras: órdenes de compra, órdenes de gasto, sugerencias de reorden y
/// órdenes consolidadas. Cada pestaña exige su propio permiso: el menú del
/// backend solo habilita la sección por `ordenes_compra.ver`.
class PurchasingPage extends ConsumerWidget {
  const PurchasingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final permissions = ref.watch(permissionServiceProvider);
    final canPurchase = permissions.can('ordenes_compra.ver');
    final tabs = [
      if (canPurchase) (l10n.purchasingTabOrders, const PurchaseOrdersTab()),
      if (permissions.can('ordenes_gasto.ver'))
        (l10n.purchasingTabExpenses, const ExpenseOrdersTab()),
      if (canPurchase) ...[
        (l10n.purchasingTabSuggestions, const SuggestionsTab()),
        (l10n.purchasingTabConsolidated, const ConsolidatedOrdersTab()),
      ],
    ];
    return DefaultTabController(
      // La clave fuerza un controlador nuevo si cambia el número de pestañas.
      key: ValueKey(tabs.length),
      length: tabs.length,
      child: Column(
        children: [
          Material(
            color: AppColors.surface,
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [for (final tab in tabs) Tab(text: tab.$1)],
            ),
          ),
          Expanded(
            child: TabBarView(children: [for (final tab in tabs) tab.$2]),
          ),
        ],
      ),
    );
  }
}
