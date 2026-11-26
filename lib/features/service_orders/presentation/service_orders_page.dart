import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/features/service_orders/application/service_order_permissions.dart';
import 'package:sga_bojanini/features/service_orders/presentation/discounts_tab.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_detail_page.dart';
import 'package:sga_bojanini/features/service_orders/presentation/order_paths.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Órdenes de servicio: búsqueda por número, descuentos por aprobar (con
/// permiso) y creación de una nueva orden (con permiso).
class ServiceOrdersPage extends ConsumerWidget {
  const ServiceOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canCreate = ref.watch(canCreateOrderProvider);
    final canApprove = ref.watch(canApproveDiscountProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: canCreate
          ? FloatingActionButton.extended(
              onPressed: () => context.push(OrderPaths.newOrder),
              icon: const Icon(Icons.add),
              label: Text(l10n.serviceOrderNew),
            )
          : null,
      body: canApprove
          ? DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Material(
                    color: AppColors.surface,
                    child: TabBar(
                      tabs: [
                        Tab(text: l10n.serviceOrderTabOrders),
                        Tab(text: l10n.serviceOrderTabDiscounts),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [_LookupTab(), DiscountsTab()],
                    ),
                  ),
                ],
              ),
            )
          : const _LookupTab(),
    );
  }
}

/// Busca una orden por su número (el servidor no tiene listado de órdenes).
class _LookupTab extends StatefulWidget {
  const _LookupTab();

  @override
  State<_LookupTab> createState() => _LookupTabState();
}

class _LookupTabState extends State<_LookupTab> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _open() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    unawaited(
      context.push(
        OrderDetailPage.pathFor(_controller.text.trim().toUpperCase()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          BojaniTextField(
            label: l10n.serviceOrderLookupHint,
            helperText: l10n.serviceOrderLookupHelp,
            controller: _controller,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (_) => _open(),
            validator: (value) =>
                (value ?? '').trim().isEmpty ? l10n.validationRequired : null,
          ),
          const SizedBox(height: AppSpacing.md),
          BojaniButton(
            label: l10n.serviceOrderLookupAction,
            icon: Icons.search,
            kind: BojaniButtonKind.secondary,
            onPressed: _open,
          ),
        ],
      ),
    );
  }
}
