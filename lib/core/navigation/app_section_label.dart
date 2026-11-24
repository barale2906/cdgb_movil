import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

extension AppSectionLabel on AppSection {
  /// Nombre visible de la sección (cadenas centralizadas en l10n).
  String label(AppLocalizations l10n) => switch (this) {
    AppSection.dashboard => l10n.navHome,
    AppSection.inventory => l10n.navInventory,
    AppSection.purchasing => l10n.navPurchasing,
    AppSection.assets => l10n.navAssets,
    AppSection.maintenance => l10n.navMaintenance,
    AppSection.warehouses => l10n.navWarehouses,
    AppSection.catalog => l10n.navCatalog,
    AppSection.serviceOrders => l10n.navServiceOrders,
    AppSection.clinicalRecords => l10n.navClinicalRecords,
    AppSection.costCenters => l10n.navCostCenters,
    AppSection.monitoring => l10n.navMonitoring,
    AppSection.consumptions => l10n.navConsumptions,
    AppSection.reports => l10n.navReports,
    AppSection.audit => l10n.navAudit,
  };
}
