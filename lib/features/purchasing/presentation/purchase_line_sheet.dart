import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/catalog/product_presentation.dart';
import 'package:sga_bojanini/core/catalog/product_providers.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Variante y presentación elegidas para una línea de compra.
class PurchaseLineChoice {
  const PurchaseLineChoice({
    required this.variantId,
    required this.presentationId,
    required this.presentationName,
    this.variantLabel,
  });

  final int variantId;
  final int presentationId;
  final String presentationName;
  final String? variantLabel;
}

/// Pide la variante (marca) y la presentación de [product]. Devuelve `null` si
/// se cierra sin elegir.
Future<PurchaseLineChoice?> showPurchaseLineSheet(
  BuildContext context,
  GenericProduct product,
) => showModalBottomSheet<PurchaseLineChoice>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => _PurchaseLineSheet(productId: product.id),
);

String _variantLabel(ProductVariant variant) =>
    variant.labBrand ??
    variant.brandSku ??
    variant.commercialPresentation ??
    '#${variant.id}';

class _PurchaseLineSheet extends ConsumerStatefulWidget {
  const _PurchaseLineSheet({required this.productId});

  final int productId;

  @override
  ConsumerState<_PurchaseLineSheet> createState() => _PurchaseLineSheetState();
}

class _PurchaseLineSheetState extends ConsumerState<_PurchaseLineSheet> {
  ProductVariant? _variant;
  ProductPresentation? _presentation;
  bool _attempted = false;

  void _add() {
    final variant = _variant;
    final presentation = _presentation;
    setState(() => _attempted = true);
    if (variant == null || presentation == null) return;
    Navigator.of(context).pop(
      PurchaseLineChoice(
        variantId: variant.id,
        variantLabel: _variantLabel(variant),
        presentationId: presentation.id,
        presentationName: presentation.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final product = ref.watch(productDetailProvider(widget.productId));
    final presentations = ref.watch(presentationsProvider(widget.productId));
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: product.when(
          loading: () => const Skeleton(height: AppSizes.minTouchTarget),
          error: (error, _) => Text(l10n.errorGeneric),
          data: (data) {
            final variants = data.variants.where((v) => v.isActive).toList();
            // Con una sola variante no hay nada que elegir.
            if (_variant == null && variants.length == 1) {
              _variant = variants.single;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(data.name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                if (variants.isEmpty)
                  Text(l10n.draftNoVariants)
                else ...[
                  OptionDropdown<ProductVariant>(
                    label: l10n.draftVariant,
                    options: {for (final v in variants) v: _variantLabel(v)},
                    value: _variant,
                    onChanged: (value) => setState(() => _variant = value),
                    validator: (v) =>
                        v == null ? l10n.validationRequired : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AsyncOptionDropdown<ProductPresentation>(
                    label: l10n.draftPresentation,
                    options: presentations.whenData(
                      (items) => items.where((p) => p.isActive).toList(),
                    ),
                    labelOf: (p) => p.name,
                    value: _presentation,
                    onChanged: (value) => setState(() => _presentation = value),
                    onRetry: () =>
                        ref.invalidate(presentationsProvider(widget.productId)),
                  ),
                  if (_attempted && _presentation == null)
                    Text(
                      l10n.draftPresentationRequired,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  const SizedBox(height: AppSpacing.md),
                  BojaniButton(
                    label: l10n.draftAddProduct,
                    onPressed: _add,
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
