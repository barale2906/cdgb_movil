import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/catalog/product_presentation.dart';
import 'package:sga_bojanini/core/catalog/product_providers.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/warehouse/location_options.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_fields.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class EntryDraft {
  const EntryDraft(this.item, this.productName);

  final EntryItem item;
  final String productName;

  String get summary {
    final quantity = item.quantityBase ?? item.quantityInPresentation ?? 0;
    final expiration = AppFormat.date(item.expirationDate.toIso8601String());
    return '${AppFormat.decimal(quantity, maxDecimals: 3)} · '
        '${item.lotNumber} · $expiration';
  }
}

class EntryItemSheet extends ConsumerStatefulWidget {
  const EntryItemSheet({required this.warehouseId, super.key});

  final int warehouseId;

  @override
  ConsumerState<EntryItemSheet> createState() => _EntryItemSheetState();
}

class _EntryItemSheetState extends ConsumerState<EntryItemSheet> {
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
      EntryDraft(
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
