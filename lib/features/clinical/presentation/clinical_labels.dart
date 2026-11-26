import 'package:sga_bojanini/core/clinical/procedure_record.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

extension ProcedureRecordLabels on ProcedureRecord {
  /// Servicio o, si no viene el nombre, un texto genérico del registro.
  String title(AppLocalizations l10n) =>
      medicalServiceName ?? l10n.clinicalRecordTitle;
}
