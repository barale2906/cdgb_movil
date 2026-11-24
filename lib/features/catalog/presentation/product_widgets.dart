import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Etiquetas de un producto: kit y cadena de frío.
class ProductChips extends StatelessWidget {
  const ProductChips({required this.product, super.key});

  final GenericProduct product;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: [
        if (product.productType == ProductType.kit)
          StatusChip(
            label: l10n.productTypeKit,
            kind: StatusKind.special,
            icon: Icons.inventory_2_outlined,
          ),
        if (product.requiresColdChain)
          StatusChip(
            label: l10n.productColdChain,
            kind: StatusKind.info,
            icon: Icons.ac_unit,
          ),
      ],
    );
  }
}
