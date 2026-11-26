import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/catalog/product_providers.dart';
import 'package:sga_bojanini/core/catalog/product_repository.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/searchable_list.dart';
import 'package:sga_bojanini/features/inventory/presentation/scan_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

const _barcodePermission = 'generic-products.barcode';

/// Abre el selector de producto (búsqueda y escáner) y devuelve el producto
/// con su detalle (variantes y unidad base), o `null` si se cancela.
Future<GenericProduct?> pickProduct(BuildContext context, WidgetRef ref) async {
  final picked = await showModalBottomSheet<GenericProduct>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _ProductPickerSheet(),
  );
  if (picked == null) return null;
  try {
    return await ref.read(productDetailProvider(picked.id).future);
  } on ApiException catch (error) {
    if (context.mounted) {
      AppSnackbar.show(
        context,
        error.message.isEmpty
            ? AppLocalizations.of(context).errorGeneric
            : error.message,
        kind: AppSnackbarKind.error,
        closeLabel: AppLocalizations.of(context).actionClose,
      );
    }
    return null;
  }
}

class _ProductPickerSheet extends ConsumerWidget {
  const _ProductPickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canScan = ref
        .watch(permissionServiceProvider)
        .can(_barcodePermission);
    return Column(
      children: [
        ListTile(
          title: Text(
            l10n.selectProduct,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: canScan
              ? IconButton(
                  tooltip: l10n.scanAction,
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () => _scan(context, ref),
                )
              : null,
        ),
        Expanded(
          child: SearchableList<GenericProduct>(
            provider: productSearchProvider,
            searchHint: l10n.catalogSearchProducts,
            emptyMessage: l10n.noProductsFound,
            itemBuilder: (context, product) => Card(
              child: ListTile(
                minTileHeight: AppSizes.minTouchTarget,
                title: Text(product.name),
                subtitle: product.barcode == null
                    ? null
                    : Text(product.barcode!),
                onTap: () => Navigator.of(context).pop(product),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _scan(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final code = await context.push<String>(ScanPage.path);
    if (code == null || !context.mounted) return;
    try {
      final product = await ref.read(productRepositoryProvider).byBarcode(code);
      navigator.pop(product);
    } on NotFoundException {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          l10n.scanNotFound(code),
          kind: AppSnackbarKind.warning,
        );
      }
    } on ApiException catch (error) {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          error.message.isEmpty ? l10n.errorGeneric : error.message,
          kind: AppSnackbarKind.error,
          closeLabel: l10n.actionClose,
        );
      }
    }
  }
}

/// Campo que muestra el producto elegido y abre el selector al tocarlo.
class ProductPickerField extends ConsumerWidget {
  const ProductPickerField({
    required this.product,
    required this.onPicked,
    super.key,
    this.errorText,
  });

  final GenericProduct? product;
  final ValueChanged<GenericProduct> onPicked;
  final String? errorText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.control),
      onTap: () async {
        final picked = await pickProduct(context, ref);
        if (picked != null) onPicked(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: l10n.fieldProduct,
          errorText: errorText,
          suffixIcon: const Icon(Icons.search),
        ),
        child: Text(
          product?.name ?? l10n.selectOption,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
