import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/catalog/product_providers.dart';
import 'package:sga_bojanini/core/clinical/clinical_lookup.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/patient_search_list.dart';
import 'package:sga_bojanini/core/widgets/searchable_list.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Elegir un paciente de MedSys: devuelve el paciente tocado.
class PatientPickerPage extends StatelessWidget {
  const PatientPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.saleChoosePatient)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: PatientSearchList(
                onSelected: (patient) => context.pop(patient),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Elegir un procedimiento: devuelve el servicio tocado.
class ServicePickerPage extends StatelessWidget {
  const ServicePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.saleChooseService)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: SearchableList<ProcedureMatch>(
                provider: procedureSearchProvider,
                searchHint: l10n.saleServiceSearchHint,
                emptyMessage: l10n.saleServiceSearchPrompt(
                  ClinicalLookupRepository.minProcedureSearchLength,
                ),
                minQueryLength:
                    ClinicalLookupRepository.minProcedureSearchLength,
                itemBuilder: (context, match) => _ServiceTile(match: match),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.match});

  final ProcedureMatch match;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final price = match.unitPrice;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(match.name),
        subtitle: Text(match.code),
        trailing: Text(
          price == null ? l10n.saleNoPrice : AppFormat.cop(price),
        ),
        onTap: () => context.pop(match),
      ),
    );
  }
}

/// Elegir un producto del catálogo (por ejemplo, un insumo): devuelve el
/// producto tocado.
class ProductPickerPage extends StatelessWidget {
  const ProductPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceOrderChooseSupply)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
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
                    onTap: () => context.pop(product),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
