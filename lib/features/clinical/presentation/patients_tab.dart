import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/searchable_list.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';
import 'package:sga_bojanini/features/clinical/data/medsys_patient.dart';
import 'package:sga_bojanini/features/clinical/presentation/patient_detail_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Búsqueda de pacientes en MedSys por documento o nombre; al tocar uno se
/// abre su ficha.
class PatientsTab extends StatelessWidget {
  const PatientsTab({super.key});

  @override
  Widget build(BuildContext context) => PatientSearchList(
    onSelected: (patient) => context.push(
      PatientDetailPage.pathFor(patient.code),
      extra: patient,
    ),
  );
}

/// Lista de búsqueda de pacientes; [onSelected] decide qué hacer con el
/// elegido (abrir la ficha o devolverlo a quien lo pidió).
class PatientSearchList extends StatelessWidget {
  const PatientSearchList({required this.onSelected, super.key});

  final ValueChanged<MedsysPatient> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SearchableList<MedsysPatient>(
      provider: patientSearchProvider,
      searchHint: l10n.clinicalPatientSearchHint,
      emptyMessage: l10n.clinicalPatientSearchPrompt(
        ClinicalRepository.minSearchLength,
      ),
      minQueryLength: ClinicalRepository.minSearchLength,
      itemBuilder: (context, patient) =>
          PatientTile(patient: patient, onTap: () => onSelected(patient)),
    );
  }
}

class PatientTile extends StatelessWidget {
  const PatientTile({required this.patient, required this.onTap, super.key});

  final MedsysPatient patient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(patient.displayName),
        subtitle: Text(l10n.clinicalPatientDocument(patient.document)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
