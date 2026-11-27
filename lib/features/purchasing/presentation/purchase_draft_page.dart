import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/catalog/cost_center_providers.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/application/purchase_draft_controller.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';
import 'package:sga_bojanini/features/purchasing/presentation/draft_widgets.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchase_line_card.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchase_line_sheet.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Edita el borrador de compra [orderId]: carga la orden y abre el formulario.
class PurchaseDraftEditPage extends ConsumerWidget {
  const PurchaseDraftEditPage({required this.orderId, super.key});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(purchaseOrderDetailProvider(orderId));
    return order.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            OfflineBanner(),
            Expanded(child: SkeletonList()),
          ],
        ),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(
          error: error,
          onRetry: () => ref.invalidate(purchaseOrderDetailProvider(orderId)),
        ),
      ),
      data: (data) => PurchaseDraftPage(order: data),
    );
  }
}

/// Borrador de una orden de compra: proveedor, almacén, centro de costo
/// opcional y líneas de producto (variante + presentación).
class PurchaseDraftPage extends ConsumerStatefulWidget {
  const PurchaseDraftPage({super.key, this.order});

  static const newPath = '/purchasing/orders/new';
  static const productPath = '$newPath/product';

  /// Borrador que se edita; `null` para uno nuevo.
  final PurchaseOrder? order;

  @override
  ConsumerState<PurchaseDraftPage> createState() => _PurchaseDraftPageState();
}

class _PurchaseDraftPageState extends ConsumerState<PurchaseDraftPage> {
  final _formKey = GlobalKey<FormState>();
  late final _notes = TextEditingController(text: widget.order?.notes ?? '');
  bool _attempted = false;

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Future<void> _addProduct() async {
    final product = await context.push<GenericProduct>(
      PurchaseDraftPage.productPath,
    );
    if (product == null || !mounted) return;
    final line = await showPurchaseLineSheet(context, product);
    if (line == null) return;
    ref
        .read(purchaseDraftProvider(widget.order).notifier)
        .addLine(
          productName: product.name,
          variantId: line.variantId,
          variantLabel: line.variantLabel,
          presentationId: line.presentationId,
          presentationName: line.presentationName,
        );
  }

  Future<void> _save() async {
    setState(() => _attempted = true);
    final state = ref.read(purchaseDraftProvider(widget.order));
    if (!(_formKey.currentState?.validate() ?? false) || state.lines.isEmpty) {
      return;
    }
    final id = await ref
        .read(purchaseDraftProvider(widget.order).notifier)
        .submit();
    if (id == null || !mounted) return;
    AppSnackbar.show(context, AppLocalizations.of(context).draftSaved);
    if (widget.order == null) {
      context.pushReplacement('/purchasing/orders/$id');
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = purchaseDraftProvider(widget.order);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final busy = state.submission.isSubmitting;
    final warehouses = ref.watch(warehousesProvider);
    final costCenters = ref.watch(costCenterListProvider(''));
    return Form(
      key: _formKey,
      child: DraftScaffold(
        title: widget.order == null
            ? l10n.draftPurchaseTitle
            : l10n.draftPurchaseEditTitle,
        submission: state.submission,
        canWrite: ref.watch(canWriteProvider),
        onSave: () => unawaited(_save()),
        onAcknowledge: notifier.acknowledgeNotSaved,
        children: [
          SupplierDropdown(
            use: SupplierUse.purchase,
            value: state.supplierId,
            enabled: !busy,
            onChanged: notifier.setSupplier,
          ),
          const SizedBox(height: AppSpacing.md),
          AsyncOptionDropdown<int>(
            label: l10n.draftWarehouse,
            options: warehouses.whenData(
              (items) => [for (final w in items) w.id],
            ),
            labelOf: (id) =>
                warehouses.value
                    ?.where((w) => w.id == id)
                    .map((w) => w.name)
                    .firstOrNull ??
                '$id',
            value: state.warehouseId,
            onChanged: notifier.setWarehouse,
            onRetry: () => ref.invalidate(warehousesProvider),
            validator: (id) => id == null ? l10n.validationRequired : null,
          ),
          const SizedBox(height: AppSpacing.md),
          AsyncOptionDropdown<int>(
            label: l10n.draftCostCenter,
            nullLabel: '—',
            options: costCenters.whenData(
              (items) => [for (final c in items) c.id],
            ),
            labelOf: (id) =>
                costCenters.value
                    ?.where((c) => c.id == id)
                    .map((c) => c.name)
                    .firstOrNull ??
                '$id',
            value: state.costCenterId,
            onChanged: notifier.setCostCenter,
            onRetry: () => ref.invalidate(costCenterListProvider('')),
          ),
          const SizedBox(height: AppSpacing.md),
          DraftDateField(
            value: state.expectedDate,
            enabled: !busy,
            onChanged: notifier.setExpectedDate,
          ),
          const SizedBox(height: AppSpacing.md),
          BojaniTextField(
            label: l10n.draftNotes,
            controller: _notes,
            enabled: !busy,
            onChanged: notifier.setNotes,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.draftItems,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final line in state.lines) ...[
            PurchaseLineCard(
              key: ValueKey(line.key),
              line: line,
              enabled: !busy,
              provider: provider,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (_attempted && state.lines.isEmpty)
            Text(
              l10n.draftItemsRequired,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          BojaniButton(
            label: l10n.draftAddProduct,
            icon: Icons.add,
            kind: BojaniButtonKind.secondary,
            onPressed: busy ? null : () => unawaited(_addProduct()),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.draftTotal(AppFormat.cop(state.total)),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
