import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Opciones de los campos con valores fijos de la hoja de vida técnica
/// (`valor del servidor → texto`).
abstract final class TechnicalProfileOptions {
  static Map<String, String> acquisitionModes(AppLocalizations l10n) => {
    'purchase': l10n.techAcquisitionPurchase,
    'donation': l10n.techAcquisitionDonation,
    'comodato': l10n.techAcquisitionComodato,
    'leasing': l10n.techAcquisitionLeasing,
  };

  static Map<String, String> riskClasses(AppLocalizations l10n) => {
    'I': l10n.techRiskI,
    'IIa': l10n.techRiskIIa,
    'IIb': l10n.techRiskIIb,
    'III': l10n.techRiskIII,
  };

  static Map<String, String> biomedicalClasses(AppLocalizations l10n) => {
    'diagnosis': l10n.techClassDiagnosis,
    'treatment': l10n.techClassTreatment,
    'rehabilitation': l10n.techClassRehabilitation,
    'prevention': l10n.techClassPrevention,
    'laboratory': l10n.techClassLaboratory,
  };

  static Map<String, String> powerSources(AppLocalizations l10n) => {
    'electric': l10n.techPowerElectric,
    'battery': l10n.techPowerBattery,
    'pneumatic': l10n.techPowerPneumatic,
    'mechanical': l10n.techPowerMechanical,
    'other': l10n.techPowerOther,
  };

  /// Texto de un valor fijo guardado en el perfil; el mismo valor si no se
  /// conoce.
  static String? labelOf(AppLocalizations l10n, String field, Object? value) {
    final options = switch (field) {
      'acquisition_mode' => acquisitionModes(l10n),
      'risk_class' => riskClasses(l10n),
      'biomedical_class' => biomedicalClasses(l10n),
      'power_source' => powerSources(l10n),
      _ => null,
    };
    return options?[value];
  }
}
