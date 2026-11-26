import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/inventory/application/lookup_providers.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_fields.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

enum BatchMode { none, optional, required }

enum QuantityMode { none, positive, nonZero }

/// Qué campos pide una línea de producto según el tipo de movimiento.
class ProductLineConfig {
  const ProductLineConfig({
    this.needsVariant = false,
    this.locationWarehouseId,
    this.locationRequired = false,
    this.locationLabelOverride,
    this.batchMode = BatchMode.none,
    this.batchWarehouseId,
    this.batchAvailableForExit = false,
    this.quantityMode = QuantityMode.positive,
  });

  final bool needsVariant;

  /// Almacén del que salen las ubicaciones; `null` = sin campo de ubicación.
  final int? locationWarehouseId;
  final bool locationRequired;
  final String? locationLabelOverride;
  final BatchMode batchMode;
  final int? batchWarehouseId;
  final bool batchAvailableForExit;
  final QuantityMode quantityMode;
}

/// Valores capturados de una línea.
class ProductLineValue {
  const ProductLineValue({
    required this.product,
    this.variantId,
    this.locationId,
    this.batchId,
    this.quantity,
    this.batchLabel,
  });

  final GenericProduct product;
  final int? variantId;
  final int? locationId;
  final int? batchId;
  final double? quantity;
  final String? batchLabel;

  /// Resumen para la lista de líneas ya agregadas.
  String summary() {
    final parts = [
      if (quantity != null) AppFormat.decimal(quantity!, maxDecimals: 3),
      ?batchLabel,
    ];
    return parts.join(' · ');
  }
}

/// Campos de una línea de producto (producto, variante, ubicación, lote y
/// cantidad). Se usa dentro de una hoja o directamente en una pantalla.
class ProductLineFields extends ConsumerStatefulWidget {
  const ProductLineFields({required this.config, super.key});

  final ProductLineConfig config;

  @override
  ConsumerState<ProductLineFields> createState() => ProductLineFieldsState();
}

class ProductLineFieldsState extends ConsumerState<ProductLineFields> {
  final _formKey = GlobalKey<FormState>();
  final _quantity = TextEditingController();
  GenericProduct? _product;
  int? _variantId;
  LocationOption? _location;
  Batch? _batch;
  bool _productError = false;

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  /// Valida el formulario; devuelve los valores o `null` si hay errores.
  ProductLineValue? validate() {
    final product = _product;
    setState(() => _productError = product == null);
    if (!(_formKey.currentState?.validate() ?? false) || product == null) {
      return null;
    }
    final text = _quantity.text.trim().replaceAll(',', '.');
    return ProductLineValue(
      product: product,
      variantId: _variantId,
      locationId: _location?.id,
      batchId: _batch?.id,
      batchLabel: _batch?.lotNumber,
      quantity: widget.config.quantityMode == QuantityMode.none
          ? null
          : double.tryParse(text),
    );
  }

  void _onProductPicked(GenericProduct product) {
    setState(() {
      _product = product;
      _productError = false;
      _variantId = product.variants.length == 1
          ? product.variants.single.id
          : null;
      _batch = null;
    });
  }

  static String _batchLabel(Batch batch) {
    final quantity = AppFormat.decimal(
      batch.quantityAvailable ?? 0,
      maxDecimals: 3,
    );
    return '${batch.lotNumber} · $quantity';
  }

  String? _quantityValidator(AppLocalizations l10n, String? value) {
    final number = double.tryParse((value ?? '').trim().replaceAll(',', '.'));
    if (number == null) return l10n.validationNumber;
    return switch (widget.config.quantityMode) {
      QuantityMode.positive when number <= 0 => l10n.validationPositive,
      QuantityMode.nonZero when number == 0 => l10n.validationNonZero,
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final config = widget.config;
    final product = _product;
    final warehouseId = config.locationWarehouseId;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductPickerField(
            product: product,
            onPicked: _onProductPicked,
            errorText: _productError ? l10n.validationRequired : null,
          ),
          if (product != null && config.needsVariant) ...[
            const SizedBox(height: AppSpacing.md),
            if (product.variants.isEmpty)
              Text(l10n.noVariants)
            else
              OptionDropdown<int>(
                label: l10n.fieldVariant,
                options: {
                  for (final variant in product.variants)
                    variant.id: [
                      variant.labBrand,
                      variant.commercialPresentation,
                    ].whereType<String>().join(' · '),
                },
                value: _variantId,
                onChanged: (value) => setState(() => _variantId = value),
                validator: (value) =>
                    value == null ? l10n.validationRequired : null,
              ),
          ],
          if (warehouseId != null) ...[
            const SizedBox(height: AppSpacing.md),
            AsyncOptionDropdown<LocationOption>(
              label: config.locationRequired
                  ? l10n.fieldLocation
                  : l10n.fieldLocationOptional,
              options: ref.watch(locationOptionsProvider(warehouseId)),
              labelOf: (option) => option.label,
              value: _location,
              nullLabel: config.locationRequired ? null : l10n.selectOption,
              emptyMessage: l10n.noLocations,
              onRetry: () =>
                  ref.invalidate(locationOptionsProvider(warehouseId)),
              onChanged: (option) => setState(() => _location = option),
              validator: (option) => config.locationRequired && option == null
                  ? l10n.validationRequired
                  : null,
            ),
          ],
          if (product != null && config.batchMode != BatchMode.none) ...[
            const SizedBox(height: AppSpacing.md),
            AsyncOptionDropdown<Batch>(
              label: l10n.fieldBatch,
              options: ref.watch(
                productBatchesProvider(
                  ProductBatchQuery(
                    genericProductId: product.id,
                    warehouseId: config.batchWarehouseId,
                    availableForExit: config.batchAvailableForExit,
                  ),
                ),
              ),
              labelOf: _batchLabel,
              value: _batch,
              nullLabel: config.batchMode == BatchMode.optional
                  ? l10n.fieldBatchFefo
                  : null,
              emptyMessage: l10n.noBatchesAvailable,
              onRetry: () => ref.invalidate(productBatchesProvider),
              onChanged: (batch) => setState(() => _batch = batch),
              validator: (batch) =>
                  config.batchMode == BatchMode.required && batch == null
                  ? l10n.validationRequired
                  : null,
            ),
          ],
          if (config.quantityMode != QuantityMode.none) ...[
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _quantity,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(
                labelText: config.quantityMode == QuantityMode.nonZero
                    ? l10n.fieldSignedQuantity
                    : l10n.fieldQuantity,
                suffixText: product?.baseUnit?.abbreviation,
              ),
              validator: (value) => _quantityValidator(l10n, value),
            ),
          ],
        ],
      ),
    );
  }
}
