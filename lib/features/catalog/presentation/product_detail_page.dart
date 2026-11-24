import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/catalog/application/catalog_providers.dart';
import 'package:sga_bojanini/features/catalog/data/generic_product.dart';
import 'package:sga_bojanini/features/catalog/presentation/product_widgets.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Detalle de un producto: datos, niveles de stock, variantes con registro
/// sanitario y componentes del kit.
class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({required this.productId, super.key});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final product = ref.watch(productDetailProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: Text(product.value?.name ?? l10n.productDetailTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: product.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(productDetailProvider(productId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(productDetailProvider(productId).future),
                  child: _Content(product: data),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.product});

  final GenericProduct product;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final unit = product.baseUnit?.abbreviation ?? '';
    String? level(double? value) =>
        value == null ? null : '${AppFormat.decimal(value)} $unit'.trim();
    final hasLevels = [
      product.minStock,
      product.maxStock,
      product.reorderPoint,
      product.reorderQuantity,
    ].any((value) => value != null);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        ProductChips(product: product),
        if (product.requiresColdChain || product.productType == ProductType.kit)
          const SizedBox(height: AppSpacing.md),
        InfoRow(label: l10n.productBarcode, value: product.barcode, mono: true),
        InfoRow(label: l10n.warehouseDescription, value: product.description),
        InfoRow(label: l10n.productCategory, value: product.category?.name),
        InfoRow(
          label: l10n.productClassification,
          value: product.classification?.name,
        ),
        InfoRow(
          label: l10n.productBaseUnit,
          value: _unitLabel(product.baseUnit),
        ),
        InfoRow(
          label: l10n.productPharmaceuticalForm,
          value: product.pharmaceuticalForm,
        ),
        InfoRow(label: l10n.productConcentration, value: product.concentration),
        if (hasLevels) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.productStockLevels, style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          InfoRow(label: l10n.productMinStock, value: level(product.minStock)),
          InfoRow(label: l10n.productMaxStock, value: level(product.maxStock)),
          InfoRow(
            label: l10n.productReorderPoint,
            value: level(product.reorderPoint),
          ),
          InfoRow(
            label: l10n.productReorderQuantity,
            value: level(product.reorderQuantity),
          ),
        ],
        if (product.components.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(l10n.productKitComponents, style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final component in product.components)
            Card(
              child: ListTile(
                title: Text(component.component?.name ?? l10n.notAvailable),
                subtitle: component.component?.barcode == null
                    ? null
                    : Text(component.component!.barcode!),
                trailing: Text(
                  l10n.productKitQuantity(
                    AppFormat.decimal(component.quantityPerKit ?? 0),
                  ),
                ),
              ),
            ),
        ],
        const SizedBox(height: AppSpacing.md),
        Text(l10n.productVariants, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        if (product.variants.isEmpty)
          Text(l10n.productNoVariants, style: textTheme.bodyMedium)
        else
          for (final variant in product.variants)
            _VariantCard(variant: variant),
      ],
    );
  }
}

String? _unitLabel(UnitRef? unit) {
  if (unit == null) return null;
  final abbreviation = unit.abbreviation;
  return abbreviation == null ? unit.name : '${unit.name} ($abbreviation)';
}

class _VariantCard extends StatelessWidget {
  const _VariantCard({required this.variant});

  final ProductVariant variant;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoRow(label: l10n.variantBrand, value: variant.labBrand),
              InfoRow(
                label: l10n.variantSku,
                value: variant.brandSku,
                mono: true,
              ),
              InfoRow(
                label: l10n.variantPresentation,
                value: variant.commercialPresentation,
              ),
              InfoRow(label: l10n.variantRisk, value: variant.riskLevel),
              for (final registration in variant.sanitaryRegistrations)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '${l10n.variantSanitaryRegistration}: '
                        '${registration.registrationNumber}',
                      ),
                      if (registration.isExpired)
                        StatusChip(
                          label: l10n.sanitaryExpired,
                          kind: StatusKind.error,
                          icon: Icons.error_outline,
                        )
                      else if (registration.expiryDate != null)
                        StatusChip(
                          label: l10n.sanitaryExpiresOn(
                            AppFormat.date(registration.expiryDate!),
                          ),
                          kind: StatusKind.success,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
