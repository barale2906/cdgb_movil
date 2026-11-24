import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/catalog/product_providers.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/searchable_list.dart';
import 'package:sga_bojanini/features/catalog/application/catalog_providers.dart';
import 'package:sga_bojanini/features/catalog/data/supplier.dart';
import 'package:sga_bojanini/features/catalog/presentation/product_widgets.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

const _suppliersPermission = 'proveedores.ver';

/// Consulta del catálogo: productos y, con permiso, proveedores.
class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final showSuppliers = ref
        .watch(permissionServiceProvider)
        .can(_suppliersPermission);

    if (!showSuppliers) return const _ProductsTab();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Material(
            color: AppColors.surface,
            child: TabBar(
              tabs: [
                Tab(text: l10n.catalogTabProducts),
                Tab(text: l10n.catalogTabSuppliers),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(children: [_ProductsTab(), _SuppliersTab()]),
          ),
        ],
      ),
    );
  }
}

class _ProductsTab extends StatelessWidget {
  const _ProductsTab();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SearchableList<GenericProduct>(
      provider: productSearchProvider,
      searchHint: l10n.catalogSearchProducts,
      emptyMessage: l10n.catalogEmptyProducts,
      itemBuilder: (context, product) => Card(
        child: ListTile(
          minTileHeight: AppSizes.minTouchTarget,
          title: Text(product.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.barcode != null) Text(product.barcode!),
              ProductChips(product: product),
            ],
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/catalog/products/${product.id}'),
        ),
      ),
    );
  }
}

class _SuppliersTab extends StatelessWidget {
  const _SuppliersTab();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SearchableList<Supplier>(
      provider: supplierSearchProvider,
      searchHint: l10n.catalogSearchSuppliers,
      emptyMessage: l10n.catalogEmptySuppliers,
      itemBuilder: (context, supplier) => Card(
        child: ListTile(
          minTileHeight: AppSizes.minTouchTarget,
          title: Text(supplier.name),
          subtitle: supplier.taxId == null ? null : Text(supplier.taxId!),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/catalog/suppliers/${supplier.id}'),
        ),
      ),
    );
  }
}
