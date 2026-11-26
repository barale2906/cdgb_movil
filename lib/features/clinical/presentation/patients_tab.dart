import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/widgets/patient_search_list.dart';
import 'package:sga_bojanini/features/clinical/presentation/patient_detail_page.dart';

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
