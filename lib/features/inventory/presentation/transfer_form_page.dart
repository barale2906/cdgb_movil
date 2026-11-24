import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_summary.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/features/inventory/application/movement_controller.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_fields.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/features/inventory/presentation/product_line_fields.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class _TransferDraft {
  const _TransferDraft(this.item, this.name, this.summary);

  final TransferItem item;
  final String name;
  final String summary;
}

/// Traslado del almacén activo a otro; queda pendiente de firma.
class TransferFormPage extends ConsumerStatefulWidget {
  const TransferFormPage({super.key});

  @override
  ConsumerState<TransferFormPage> createState() => _TransferFormPageState();
}

class _TransferFormPageState extends ConsumerState<TransferFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _reason = TextEditingController();
  final _drafts = <_TransferDraft>[];
  WarehouseSummary? _destination;
  bool _itemsError = false;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _addItem(int fromId, int toId) async {
    final draft = await showModalBottomSheet<_TransferDraft>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _TransferItemSheet(fromId: fromId, toId: toId),
    );
    if (draft != null) {
      setState(() {
        _drafts.add(draft);
        _itemsError = false;
      });
    }
  }

  Future<void> _submit(int fromId) async {
    final l10n = AppLocalizations.of(context);
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() => _itemsError = _drafts.isEmpty);
    if (!valid || _drafts.isEmpty) return;
    final document = await ref
        .read(movementControllerProvider.notifier)
        .transfer(
          TransferRequest(
            warehouseFromId: fromId,
            warehouseToId: _destination!.id,
            reason: _reason.text.trim().isEmpty ? null : _reason.text.trim(),
            items: [for (final draft in _drafts) draft.item],
          ),
        );
    if (document == null || !mounted) return;
    AppSnackbar.show(
      context,
      '${l10n.movementRegisteredDoc(document.documentNumber)} '
      '${l10n.movementPendingSignNote}',
    );
    context.pushReplacement('/inventory/documents/${document.id}');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final origin = ref.watch(activeWarehouseProvider);
    final destinations = ref.watch(warehousesProvider);
    final fromId = origin?.id;
    final destination = _destination;

    return MovementFormShell(
      title: l10n.movementTransfer,
      submission: ref.watch(movementControllerProvider),
      onSubmit: () {
        if (fromId != null) unawaited(_submit(fromId));
      },
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputDecorator(
                decoration: InputDecoration(labelText: l10n.fieldWarehouse),
                child: Text(origin?.name ?? l10n.warehouseNone),
              ),
              const SizedBox(height: AppSpacing.md),
              AsyncOptionDropdown<WarehouseSummary>(
                label: l10n.fieldDestinationWarehouse,
                options: destinations.whenData(
                  (list) => [
                    for (final w in list)
                      if (w.id != fromId) w,
                  ],
                ),
                labelOf: (w) => w.name,
                value: destination,
                onRetry: () => ref.invalidate(warehousesProvider),
                onChanged: (value) => setState(() {
                  _destination = value;
                  _drafts.clear();
                }),
                validator: (value) =>
                    value == null ? l10n.validationRequired : null,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _reason,
                decoration: InputDecoration(
                  labelText: l10n.fieldReasonOptional,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        LinesHeader(
          enabled: fromId != null && destination != null,
          errorText: _itemsError ? l10n.itemsRequired : null,
          onAdd: () => unawaited(_addItem(fromId!, destination!.id)),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final (index, draft) in _drafts.indexed)
          LineDraftCard(
            title: draft.name,
            subtitle: draft.summary,
            onRemove: () => setState(() => _drafts.removeAt(index)),
          ),
      ],
    );
  }
}

class _TransferItemSheet extends StatefulWidget {
  const _TransferItemSheet({required this.fromId, required this.toId});

  final int fromId;
  final int toId;

  @override
  State<_TransferItemSheet> createState() => _TransferItemSheetState();
}

class _TransferItemSheetState extends State<_TransferItemSheet> {
  final _key = GlobalKey<ProductLineFieldsState>();

  void _add() {
    final value = _key.currentState?.validate();
    if (value == null) return;
    Navigator.of(context).pop(
      _TransferDraft(
        TransferItem(
          productVariantId: value.variantId!,
          locationToId: value.locationId!,
          quantity: value.quantity!,
          batchId: value.batchId,
        ),
        value.product.name,
        value.summary(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return LineSheet(
      title: l10n.addItem,
      onAdd: _add,
      child: ProductLineFields(
        key: _key,
        config: ProductLineConfig(
          needsVariant: true,
          // Las ubicaciones son las del almacén destino.
          locationWarehouseId: widget.toId,
          locationRequired: true,
          batchMode: BatchMode.optional,
          batchWarehouseId: widget.fromId,
          batchAvailableForExit: true,
        ),
      ),
    );
  }
}
