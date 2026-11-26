import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/searchable_list.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/data/procedure_record.dart';
import 'package:sga_bojanini/features/clinical/presentation/clinical_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Registros de procedimientos de los últimos días, filtrables por documento.
class RecordsTab extends StatelessWidget {
  const RecordsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SearchableList<ProcedureRecord>(
      provider: procedureRecordsProvider,
      searchHint: l10n.clinicalRecordsSearchHint,
      emptyMessage: l10n.clinicalRecordsEmpty(recordsWindowDays),
      itemBuilder: (context, record) => RecordTile(record: record),
    );
  }
}

class RecordTile extends StatelessWidget {
  const RecordTile({required this.record, super.key});

  final ProcedureRecord record;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = record.serviceDate;
    final total = record.netTotal ?? record.total;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(record.title(l10n)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(record.patientName),
            if (date != null) Text(AppFormat.date(date)),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [BillingChip(status: record.billingStatus)],
            ),
          ],
        ),
        trailing: total == null ? null : Text(AppFormat.cop(total)),
        onTap: () => context.push('/clinical-records/records/${record.id}'),
      ),
    );
  }
}
