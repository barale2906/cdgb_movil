import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/features/purchasing/application/order_actions.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/features/purchasing/presentation/consolidation_summary.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_workflow.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Consolidar órdenes recibidas de un proveedor: elegir proveedor y órdenes,
/// revisar la vista previa y crear la orden consolidada.
class ConsolidatePage extends ConsumerStatefulWidget {
  const ConsolidatePage({super.key});

  @override
  ConsumerState<ConsolidatePage> createState() => _ConsolidatePageState();
}

class _ConsolidatePageState extends ConsumerState<ConsolidatePage> {
  ConsolidableSupplier? _supplier;
  final Set<int> _selected = {};
  ConsolidationPreview? _preview;
  final _notes = TextEditingController();

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  void _reset() => setState(() {
    _selected.clear();
    _preview = null;
  });

  Future<void> _loadPreview() async {
    final preview = await ref
        .read(consolidationPreviewControllerProvider.notifier)
        .preview(_selected.toList());
    if (!mounted) return;
    if (preview == null) {
      showOrderResult(
        context,
        ref,
        done: false,
        successMessage: '',
        error: ref.read(consolidationPreviewControllerProvider).error,
      );
      return;
    }
    setState(() => _preview = preview);
  }

  Future<void> _create() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.consolidateConfirmTitle,
      message: l10n.consolidateConfirmBody(_selected.length),
      confirmLabel: l10n.consolidateAction,
    );
    if (!confirmed || !mounted) return;
    final created = await ref
        .read(consolidateControllerProvider.notifier)
        .consolidate(_selected.toList(), notes: _notes.text);
    if (!mounted) return;
    showOrderResult(
      context,
      ref,
      done: created != null,
      successMessage: l10n.consolidateCreated,
      error: ref.read(consolidateControllerProvider).error,
    );
    if (created != null) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final suppliers = ref.watch(consolidableSuppliersProvider);
    final creating = ref.watch(consolidateControllerProvider).isSubmitting;
    final previewing = ref
        .watch(consolidationPreviewControllerProvider)
        .isSubmitting;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.consolidateTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  AsyncOptionDropdown<ConsolidableSupplier>(
                    label: l10n.fieldSupplier,
                    options: suppliers,
                    labelOf: (supplier) => supplier.name,
                    value: _supplier,
                    emptyMessage: l10n.consolidateNoSuppliers,
                    onChanged: (value) {
                      setState(() => _supplier = value);
                      _reset();
                    },
                    onRetry: () =>
                        ref.invalidate(consolidableSuppliersProvider),
                  ),
                  if (_supplier != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    _OrdersPicker(
                      supplierId: _supplier!.id,
                      selected: _selected,
                      onChanged: (id, {required selected}) => setState(() {
                        selected ? _selected.add(id) : _selected.remove(id);
                        _preview = null;
                      }),
                    ),
                  ],
                  if (_preview != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    ConsolidationSummary(
                      items: _preview!.items,
                      subtotal: _preview!.subtotal,
                      tax: _preview!.taxAmount,
                      total: _preview!.totalAmount,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _notes,
                      maxLines: 2,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        labelText: l10n.fieldNotes,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: _preview == null
                  ? BojaniButton(
                      label: l10n.consolidatePreview,
                      icon: Icons.visibility_outlined,
                      isLoading: previewing,
                      onPressed: _selected.isEmpty
                          ? null
                          : () => unawaited(_loadPreview()),
                    )
                  : BojaniButton(
                      label: l10n.consolidateAction,
                      icon: Icons.merge_type,
                      isLoading: creating,
                      onPressed: () => unawaited(_create()),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrdersPicker extends ConsumerWidget {
  const _OrdersPicker({
    required this.supplierId,
    required this.selected,
    required this.onChanged,
  });

  final int supplierId;
  final Set<int> selected;
  final void Function(int id, {required bool selected}) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final orders = ref.watch(consolidableOrdersProvider(supplierId));
    return orders.when(
      loading: () => const LinearProgressIndicator(),
      error: (_, _) => Row(
        children: [
          Expanded(child: Text(l10n.errorGeneric)),
          TextButton(
            onPressed: () =>
                ref.invalidate(consolidableOrdersProvider(supplierId)),
            child: Text(l10n.actionRetry),
          ),
        ],
      ),
      data: (data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.consolidateOrders,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          for (final order in data.inRange)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: selected.contains(order.id),
              onChanged: (value) =>
                  onChanged(order.id, selected: value ?? false),
              title: Text(order.code),
              subtitle: Text(
                [
                  if (order.warehouse != null) order.warehouse!.name,
                  if (order.receivedAt != null)
                    AppFormat.date(order.receivedAt!),
                ].join(' · '),
              ),
              secondary: Text(money(order.totalAmount)),
            ),
        ],
      ),
    );
  }
}
