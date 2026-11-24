import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/features/inventory/application/lookup_providers.dart';
import 'package:sga_bojanini/features/inventory/application/movement_controller.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';
import 'package:sga_bojanini/features/inventory/data/product_presentation.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_fields.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class _EntryDraft {
  const _EntryDraft(this.item, this.productName);

  final EntryItem item;
  final String productName;

  String get summary {
    final quantity = item.quantityBase ?? item.quantityInPresentation ?? 0;
    final expiration = AppFormat.date(item.expirationDate.toIso8601String());
    return '${AppFormat.decimal(quantity, maxDecimals: 3)} · '
        '${item.lotNumber} · $expiration';
  }
}

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
  final _drafts = <_EntryDraft>[];
  bool _itemsError = false;

  @override
  void dispose() {
    _invoice.dispose();
    _temperature.dispose();
    _reason.dispose();
    super.dispose();
  }

  Future<void> _addItem(int warehouseId) async {
    final draft = await showModalBottomSheet<_EntryDraft>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _EntryItemSheet(warehouseId: warehouseId),
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

class _EntryItemSheet extends ConsumerStatefulWidget {
  const _EntryItemSheet({required this.warehouseId});

  final int warehouseId;

  @override
  ConsumerState<_EntryItemSheet> createState() => _EntryItemSheetState();
}

class _EntryItemSheetState extends ConsumerState<_EntryItemSheet> {
  final _formKey = GlobalKey<FormState>();
  final _lot = TextEditingController();
  final _quantity = TextEditingController();
  final _notes = TextEditingController();
  GenericProduct? _product;
  int? _variantId;
  LocationOption? _location;
  ProductPresentation? _presentation;
  DateTime? _expiration;
  DateTime? _manufacturing;
  bool _productError = false;

  @override
  void dispose() {
    _lot.dispose();
    _quantity.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _pickProduct(GenericProduct product) => setState(() {
    _product = product;
    _productError = false;
    _variantId = product.variants.length == 1
        ? product.variants.single.id
        : null;
    _presentation = null;
  });

  void _add() {
    final product = _product;
    setState(() => _productError = product == null);
    if (!(_formKey.currentState?.validate() ?? false) || product == null) {
      return;
    }
    final quantity = double.parse(_quantity.text.trim().replaceAll(',', '.'));
    final presentation = _presentation;
    Navigator.of(context).pop(
      _EntryDraft(
        EntryItem(
          productVariantId: _variantId!,
          locationId: _location!.id,
          lotNumber: _lot.text.trim(),
          expirationDate: _expiration!,
          manufacturingDate: _manufacturing,
          quantityBase: presentation == null ? quantity : null,
          presentationId: presentation?.id,
          quantityInPresentation: presentation == null ? null : quantity,
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        ),
        product.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final product = _product;
    final presentations = product == null
        ? null
        : ref.watch(presentationsProvider(product.id));

    return LineSheet(
      title: l10n.addItem,
      onAdd: _add,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductPickerField(
              product: product,
              onPicked: _pickProduct,
              errorText: _productError ? l10n.validationRequired : null,
            ),
            if (product != null) ...[
              const SizedBox(height: AppSpacing.md),
              OptionDropdown<int>(
                label: l10n.fieldVariant,
                options: {
                  for (final v in product.variants)
                    v.id: [
                      v.labBrand,
                      v.commercialPresentation,
                    ].whereType<String>().join(' · '),
                },
                value: _variantId,
                onChanged: (value) => setState(() => _variantId = value),
                validator: (value) =>
                    value == null ? l10n.validationRequired : null,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            AsyncOptionDropdown<LocationOption>(
              label: l10n.fieldLocation,
              options: ref.watch(locationOptionsProvider(widget.warehouseId)),
              labelOf: (option) => option.label,
              value: _location,
              emptyMessage: l10n.noLocations,
              onRetry: () =>
                  ref.invalidate(locationOptionsProvider(widget.warehouseId)),
              onChanged: (option) => setState(() => _location = option),
              validator: (option) =>
                  option == null ? l10n.validationRequired : null,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _lot,
              decoration: InputDecoration(labelText: l10n.fieldLot),
              validator: (value) =>
                  (value ?? '').trim().isEmpty ? l10n.validationRequired : null,
            ),
            const SizedBox(height: AppSpacing.md),
            DateField(
              label: l10n.fieldExpiration,
              required: true,
              value: _expiration,
              onChanged: (date) => setState(() => _expiration = date),
            ),
            const SizedBox(height: AppSpacing.md),
            DateField(
              label: l10n.fieldManufacturing,
              value: _manufacturing,
              lastDate: DateTime.now(),
              onChanged: (date) => setState(() => _manufacturing = date),
            ),
            if (presentations != null) ...[
              const SizedBox(height: AppSpacing.md),
              AsyncOptionDropdown<ProductPresentation>(
                label: l10n.fieldPresentation,
                options: presentations,
                labelOf: (p) => p.name,
                value: _presentation,
                nullLabel: l10n.fieldBaseUnitDirect,
                onRetry: () => ref.invalidate(presentationsProvider),
                onChanged: (value) => setState(() => _presentation = value),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _quantity,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.fieldQuantity,
                suffixText:
                    _presentation?.name ?? product?.baseUnit?.abbreviation,
              ),
              validator: (value) {
                final number = double.tryParse(
                  (value ?? '').trim().replaceAll(',', '.'),
                );
                if (number == null) return l10n.validationNumber;
                return number <= 0 ? l10n.validationPositive : null;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _notes,
              decoration: InputDecoration(labelText: l10n.fieldNotes),
            ),
          ],
        ),
      ),
    );
  }
}
