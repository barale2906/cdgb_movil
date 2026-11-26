import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Paciente de un formulario: botón para buscarlo y, una vez elegido, su
/// nombre y documento con la opción de cambiarlo. [canChange] `false` lo
/// bloquea (envío en curso o ya hay algo registrado).
///
/// El botón de cambiar va debajo y no como `trailing` de un `ListTile`: con
/// el texto al 200 % no cabe a un lado.
class PatientSelector extends StatelessWidget {
  const PatientSelector({
    required this.patient,
    required this.onPick,
    super.key,
    this.canChange = true,
    this.showError = false,
  });

  final MedsysPatient? patient;
  final VoidCallback onPick;
  final bool canChange;

  /// Muestra que falta elegir el paciente (tras un intento de envío).
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = patient;
    if (current == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BojaniButton(
            label: l10n.saleSearchPatient,
            icon: Icons.person_search_outlined,
            kind: BojaniButtonKind.secondary,
            onPressed: onPick,
          ),
          if (showError)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Text(
                l10n.salePatientRequired,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              current.displayName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(l10n.clinicalPatientDocument(current.document)),
            if (canChange)
              BojaniButton(
                label: l10n.saleChangePatient,
                kind: BojaniButtonKind.tertiary,
                expand: false,
                onPressed: onPick,
              ),
          ],
        ),
      ),
    );
  }
}
