import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/catalog/application/catalog_providers.dart';
import 'package:sga_bojanini/features/catalog/data/supplier.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class SupplierDetailPage extends ConsumerWidget {
  const SupplierDetailPage({required this.supplierId, super.key});

  final int supplierId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final supplier = ref.watch(supplierDetailProvider(supplierId));

    return Scaffold(
      appBar: AppBar(
        title: Text(supplier.value?.name ?? l10n.supplierDetailTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: supplier.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(supplierDetailProvider(supplierId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(supplierDetailProvider(supplierId).future),
                  child: _Content(supplier: data),
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
  const _Content({required this.supplier});

  final Supplier supplier;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isExpense = supplier.supplierType == 'expense';
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            label: isExpense
                ? l10n.supplierTypeExpense
                : l10n.supplierTypeInventory,
            kind: isExpense ? StatusKind.special : StatusKind.info,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        InfoRow(label: l10n.supplierTaxId, value: supplier.taxId, mono: true),
        InfoRow(label: l10n.supplierContact, value: supplier.contactName),
        InfoRow(label: l10n.supplierPhone, value: supplier.phone),
        InfoRow(label: l10n.supplierEmail, value: supplier.email),
        InfoRow(label: l10n.supplierAddress, value: supplier.address),
        InfoRow(label: l10n.supplierNotes, value: supplier.notes),
      ],
    );
  }
}
