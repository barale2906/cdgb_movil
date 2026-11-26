import 'package:flutter/material.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

extension ReportTypeLabels on ReportType {
  String label(AppLocalizations l10n) => switch (this) {
    ReportType.inventory => l10n.reportInventory,
    ReportType.movements => l10n.reportMovements,
    ReportType.expiring => l10n.reportExpiring,
    ReportType.purchases => l10n.reportPurchases,
    ReportType.consumption => l10n.reportConsumption,
    ReportType.conditions => l10n.reportConditions,
    ReportType.audit => l10n.reportAudit,
  };

  String hint(AppLocalizations l10n) => switch (this) {
    ReportType.inventory => l10n.reportInventoryHint,
    ReportType.movements => l10n.reportMovementsHint,
    ReportType.expiring => l10n.reportExpiringHint,
    ReportType.purchases => l10n.reportPurchasesHint,
    ReportType.consumption => l10n.reportConsumptionHint,
    ReportType.conditions => l10n.reportConditionsHint,
    ReportType.audit => l10n.reportAuditHint,
  };

  IconData get icon => switch (this) {
    ReportType.inventory => Icons.inventory_2_outlined,
    ReportType.movements => Icons.swap_horiz,
    ReportType.expiring => Icons.event_busy,
    ReportType.purchases => Icons.shopping_cart_outlined,
    ReportType.consumption => Icons.trending_down,
    ReportType.conditions => Icons.thermostat,
    ReportType.audit => Icons.verified_user_outlined,
  };
}

extension ReportFormatLabels on ReportFormat {
  String label(AppLocalizations l10n) => switch (this) {
    ReportFormat.pdf => l10n.formatPdf,
    ReportFormat.excel => l10n.formatExcel,
    ReportFormat.csv => l10n.formatCsv,
  };
}
