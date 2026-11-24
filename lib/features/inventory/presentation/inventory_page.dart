import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/catalog/product_repository.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/features/inventory/application/movement_permissions.dart';
import 'package:sga_bojanini/features/inventory/presentation/batches_tab.dart';
import 'package:sga_bojanini/features/inventory/presentation/documents_tab.dart';
import 'package:sga_bojanini/features/inventory/presentation/history_tab.dart';
import 'package:sga_bojanini/features/inventory/presentation/new_movement_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/scan_page.dart';
import 'package:sga_bojanini/features/inventory/presentation/stock_tab.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

const _barcodePermission = 'generic-products.barcode';
const _batchesPermission = 'lotes.ver';

/// Inventario del almacén activo: existencias, lotes, comprobantes e
/// historial, con escáner y registro de movimientos.
class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final warehouse = ref.watch(activeWarehouseProvider);
    final permissions = ref.watch(permissionServiceProvider);
    if (warehouse == null) {
      return EmptyState(
        icon: Icons.warehouse_outlined,
        message: l10n.inventorySelectWarehouse,
      );
    }

    final tabs = [
      (l10n.inventoryTabStock, StockTab(warehouseId: warehouse.id)),
      if (permissions.can(_batchesPermission))
        (l10n.inventoryTabBatches, BatchesTab(warehouseId: warehouse.id)),
      (l10n.inventoryTabDocuments, DocumentsTab(warehouseId: warehouse.id)),
      (l10n.inventoryTabHistory, HistoryTab(warehouseId: warehouse.id)),
    ];
    final canMove = permissions.canAny(MovementKind.permissions);
    final canScan = permissions.can(_barcodePermission);

    return DefaultTabController(
      // La clave fuerza un controlador nuevo si cambia el número de pestañas.
      key: ValueKey(tabs.length),
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (canScan)
              FloatingActionButton.small(
                heroTag: 'scan',
                tooltip: l10n.scanAction,
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.dark,
                onPressed: () => _scan(context, ref),
                child: const Icon(Icons.qr_code_scanner),
              ),
            if (canScan && canMove) const SizedBox(height: AppSpacing.sm),
            if (canMove)
              FloatingActionButton.extended(
                heroTag: 'new-movement',
                onPressed: () => context.push(NewMovementPage.path),
                icon: const Icon(Icons.add),
                label: Text(l10n.newMovementAction),
              ),
          ],
        ),
        body: Column(
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
      ),
    );
  }

  /// Escanea un código y abre el producto correspondiente.
  Future<void> _scan(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final code = await context.push<String>(ScanPage.path);
    if (code == null || !context.mounted) return;
    try {
      final product = await ref.read(productRepositoryProvider).byBarcode(code);
      if (context.mounted) {
        unawaited(context.push('/catalog/products/${product.id}'));
      }
    } on NotFoundException {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          l10n.scanNotFound(code),
          kind: AppSnackbarKind.warning,
        );
      }
    } on ApiException catch (error) {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          error.message.isEmpty ? l10n.errorGeneric : error.message,
          kind: AppSnackbarKind.error,
          closeLabel: l10n.actionClose,
        );
      }
    }
  }
}
