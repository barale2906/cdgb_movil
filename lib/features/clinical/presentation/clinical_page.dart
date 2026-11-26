import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_permissions.dart';
import 'package:sga_bojanini/features/clinical/presentation/patients_tab.dart';
import 'package:sga_bojanini/features/clinical/presentation/records_tab.dart';
import 'package:sga_bojanini/features/clinical/presentation/sale_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Registros clínicos: registros de procedimientos y, con permiso para buscar
/// pacientes de MedSys, la búsqueda de pacientes.
class ClinicalPage extends ConsumerWidget {
  const ClinicalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canSell = ref.watch(canSellProvider);
    final canSearchPatients = ref.watch(canLookUpPatientsProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: canSell
          ? FloatingActionButton.extended(
              onPressed: () => context.push(SalePage.path),
              icon: const Icon(Icons.point_of_sale),
              label: Text(l10n.saleAction),
            )
          : null,
      body: canSearchPatients
          ? DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Material(
                    color: AppColors.surface,
                    child: TabBar(
                      tabs: [
                        Tab(text: l10n.clinicalTabRecords),
                        Tab(text: l10n.clinicalTabPatients),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(children: [RecordsTab(), PatientsTab()]),
                  ),
                ],
              ),
            )
          : const RecordsTab(),
    );
  }
}
