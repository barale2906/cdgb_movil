import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/features/inventory/application/movement_controller.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';
import 'package:sga_bojanini/features/inventory/presentation/entry_item_sheet.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Entrada de mercancía: se confirma sola (no lleva firma).
class EntryFormPage extends ConsumerStatefulWidget {
  const EntryFormPage({super.key});

  @override
  ConsumerState<EntryFormPage> createState() => _EntryFormPageState();
}

class _EntryFormPageState extends ConsumerState<EntryFormPage> {
  final _invoice = TextEditingController();
  final _temperature = TextEditingController();
  final _reason = TextEditingController();
  final _drafts = <EntryDraft>[];
  bool _itemsError = false;

  @override
  void dispose() {
    _invoice.dispose();
    _temperature.dispose();
    _reason.dispose();
    super.dispose();
  }

  Future<void> _addItem(int warehouseId) async {
    final draft = await showModalBottomSheet<EntryDraft>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => EntryItemSheet(warehouseId: warehouseId),
    );
    if (draft != null) {
      setState(() {
        _drafts.add(draft);
        _itemsError = false;
      });
    }
  }

  Future<void> _submit(int warehouseId) async {
    final l10n = AppLocalizations.of(context);
    if (_drafts.isEmpty) {
      setState(() => _itemsError = true);
      return;
    }
    final temperature = double.tryParse(
      _temperature.text.trim().replaceAll(',', '.'),
    );
    final document = await ref
        .read(movementControllerProvider.notifier)
        .entry(
          EntryRequest(
            warehouseId: warehouseId,
            invoiceNumber: _invoice.text.trim().isEmpty
                ? null
                : _invoice.text.trim(),
            entryTemperature: temperature,
            reason: _reason.text.trim().isEmpty ? null : _reason.text.trim(),
            items: [for (final draft in _drafts) draft.item],
          ),
        );
    if (document == null || !mounted) return;
    AppSnackbar.show(
      context,
      l10n.movementRegisteredDoc(document.documentNumber),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final warehouse = ref.watch(activeWarehouseProvider);
    final submission = ref.watch(movementControllerProvider);
    final warehouseId = warehouse?.id;

    return MovementFormShell(
      title: l10n.movementEntry,
      submission: submission,
      onSubmit: () {
        if (warehouseId != null) unawaited(_submit(warehouseId));
      },
      children: [
        InputDecorator(
          decoration: InputDecoration(labelText: l10n.fieldWarehouse),
          child: Text(warehouse?.name ?? l10n.warehouseNone),
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _invoice,
          decoration: InputDecoration(labelText: l10n.fieldInvoice),
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _temperature,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          decoration: InputDecoration(labelText: l10n.fieldTemperature),
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _reason,
          decoration: InputDecoration(labelText: l10n.fieldReasonOptional),
        ),
        const SizedBox(height: AppSpacing.lg),
        LinesHeader(
          enabled: warehouseId != null,
          errorText: _itemsError ? l10n.itemsRequired : null,
          onAdd: () => _addItem(warehouseId!),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final (index, draft) in _drafts.indexed)
          LineDraftCard(
            title: draft.productName,
            subtitle: draft.summary,
            onRemove: () => setState(() => _drafts.removeAt(index)),
          ),
      ],
    );
  }
}
