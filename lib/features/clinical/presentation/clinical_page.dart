import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_permissions.dart';
import 'package:sga_bojanini/features/clinical/presentation/patients_tab.dart';
import 'package:sga_bojanini/features/clinical/presentation/records_tab.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Registros clínicos: registros de procedimientos y, con permiso para buscar
/// pacientes de MedSys, la búsqueda de pacientes.
class ClinicalPage extends ConsumerWidget {
  const ClinicalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (!ref.watch(canLookUpPatientsProvider)) return const RecordsTab();
    return DefaultTabController(
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
    );
  }
}
