import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/warehouse/location_options.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/purchasing/application/order_actions.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_workflow.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Recepción de una orden de compra, total o parcial. Cada línea recibida
/// crea un lote (número, vencimiento y ubicación). Las líneas sin cantidad
/// se omiten.
class ReceivePurchasePage extends ConsumerWidget {
  const ReceivePurchasePage({required this.orderId, super.key});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final order = ref.watch(purchaseOrderDetailProvider(orderId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.orderReceiveTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: order.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(purchaseOrderDetailProvider(orderId)),
                ),
                data: (data) => _ReceiveForm(order: data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Borrador de lo que se recibe de una línea.
class _LineDraft {
  final quantity = TextEditingController();
  final lot = TextEditingController();
  DateTime? expiration;
  LocationOption? location;

  int? get quantityValue => int.tryParse(quantity.text.trim());

  bool get isFilled => (quantityValue ?? 0) > 0;

  void dispose() {
    quantity.dispose();
    lot.dispose();
  }
}

class _ReceiveForm extends ConsumerStatefulWidget {
  const _ReceiveForm({required this.order});

  final PurchaseOrder order;

  @override
  ConsumerState<_ReceiveForm> createState() => _ReceiveFormState();
}

class _ReceiveFormState extends ConsumerState<_ReceiveForm> {
  final _formKey = GlobalKey<FormState>();
  late final Map<int, _LineDraft> _drafts = {
    for (final item in _pending) item.id: _LineDraft(),
  };

  List<PurchaseOrderItem> get _pending =>
      widget.order.items.where((item) => item.pendingQuantity > 0).toList();

  @override
  void dispose() {
    for (final draft in _drafts.values) {
      draft.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final lines = [
      for (final entry in _drafts.entries)
        if (entry.value.isFilled)
          PurchaseReceiveLine(
            itemId: entry.key,
            quantityReceived: entry.value.quantityValue!,
            lotNumber: entry.value.lot.text.trim(),
            expirationDate: ColombiaTime.formatDate(entry.value.expiration!),
            locationId: entry.value.location!.id,
          ).toJson(),
    ];
    if (lines.isEmpty) {
      showOrderResult(
        context,
        ref,
        done: false,
        successMessage: '',
        error: null,
        message: l10n.orderReceiveNothing,
      );
      return;
    }
    final done = await ref
        .read(purchaseOrderActionsProvider.notifier)
        .receive(widget.order.id, lines);
    if (!mounted) return;
    showOrderResult(
      context,
      ref,
      done: done,
      successMessage: l10n.orderReceived,
      error: ref.read(purchaseOrderActionsProvider).error,
    );
    if (done) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submitting = ref.watch(purchaseOrderActionsProvider).isSubmitting;
    final pending = _pending;
    if (pending.isEmpty) {
      return Center(child: Text(l10n.orderNothingPending));
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text(
                  l10n.orderReceiveHint,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                for (final item in pending)
                  _LineFields(
                    item: item,
                    draft: _drafts[item.id]!,
                    warehouseId: widget.order.warehouseId,
                    onChanged: () => setState(() {}),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.orderReceiveConfirm,
              isLoading: submitting,
              onPressed: () => unawaited(_submit()),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineFields extends ConsumerWidget {
  const _LineFields({
    required this.item,
    required this.draft,
    required this.warehouseId,
    required this.onChanged,
  });

  final PurchaseOrderItem item;
  final _LineDraft draft;
  final int? warehouseId;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final filled = draft.isFilled;
    final locations = warehouseId == null
        ? null
        : ref.watch(locationOptionsProvider(warehouseId!));
    String? required(Object? value) =>
        filled && (value == null || (value is String && value.trim().isEmpty))
        ? l10n.validationRequired
        : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.productName ?? '', style: textTheme.titleSmall),
            Text(
              l10n.orderPendingQuantity(
                AppFormat.decimal(item.pendingQuantity),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              controller: draft.quantity,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: l10n.fieldQuantityReceived,
              ),
              onChanged: (_) => onChanged(),
              validator: (value) {
                final number = int.tryParse((value ?? '').trim());
                if ((value ?? '').trim().isEmpty) return null;
                if (number == null || number <= 0) {
                  return l10n.validationPositive;
                }
                return number > item.pendingQuantity
                    ? l10n.orderQuantityExceedsPending
                    : null;
              },
            ),
            if (filled) ...[
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: draft.lot,
                decoration: InputDecoration(labelText: l10n.fieldLot),
                validator: required,
              ),
              const SizedBox(height: AppSpacing.sm),
              DateField(
                label: l10n.fieldExpiration,
                required: true,
                value: draft.expiration,
                firstDate: DateTime(2000),
                lastDate: DateTime(2099, 12, 31),
                onChanged: (value) {
                  draft.expiration = value;
                  onChanged();
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              if (locations == null)
                Text(l10n.orderNoWarehouse)
              else
                AsyncOptionDropdown<LocationOption>(
                  label: l10n.fieldLocation,
                  options: locations,
                  labelOf: (option) => option.label,
                  value: draft.location,
                  validator: required,
                  onChanged: (value) {
                    draft.location = value;
                    onChanged();
                  },
                  onRetry: () =>
                      ref.invalidate(locationOptionsProvider(warehouseId!)),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
