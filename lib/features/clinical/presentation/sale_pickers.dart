import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/searchable_list.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';
import 'package:sga_bojanini/features/clinical/data/procedure_match.dart';
import 'package:sga_bojanini/features/clinical/presentation/patients_tab.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Elegir el paciente de la venta: devuelve el paciente tocado.
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

/// Elegir un servicio o procedimiento: devuelve el servicio tocado.
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
                  ClinicalRepository.minProcedureSearchLength,
                ),
                minQueryLength: ClinicalRepository.minProcedureSearchLength,
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
