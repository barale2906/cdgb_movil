import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/data/procedure_record.dart';
import 'package:sga_bojanini/features/clinical/presentation/clinical_labels.dart';
import 'package:sga_bojanini/features/clinical/presentation/patient_detail_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Detalle de un registro de procedimiento (solo lectura).
class RecordDetailPage extends ConsumerWidget {
  const RecordDetailPage({required this.recordId, super.key});

  final int recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final record = ref.watch(procedureRecordProvider(recordId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.clinicalRecordTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: record.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(procedureRecordProvider(recordId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(procedureRecordProvider(recordId).future),
                  child: _Content(record: data),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.record});

  final ProcedureRecord record;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final date = record.serviceDate;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(record.title(l10n), style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xs,
          children: [
            BillingChip(status: record.billingStatus),
            if (!record.isActive)
              StatusChip(
                label: l10n.clinicalRecordInactive,
                kind: StatusKind.info,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        InfoRow(label: l10n.clinicalRecordPatient, value: record.patientName),
        InfoRow(
          label: l10n.clinicalRecordDocument,
          value: record.patientDocument,
        ),
        InfoRow(
          label: l10n.clinicalRecordDate,
          value: date == null ? null : AppFormat.date(date),
        ),
        InfoRow(
          label: l10n.clinicalRecordQuantity,
          value: _decimal(record.quantity),
        ),
        InfoRow(
          label: l10n.clinicalRecordUnitPrice,
          value: _cop(record.unitPrice),
        ),
        InfoRow(label: l10n.clinicalRecordTotal, value: _cop(record.total)),
        if (record.hasDiscount) ...[
          InfoRow(
            label: l10n.clinicalRecordDiscount,
            value: _cop(record.discountAmount),
          ),
          InfoRow(
            label: l10n.clinicalRecordNetTotal,
            value: _cop(record.netTotal),
          ),
        ],
        InfoRow(label: l10n.clinicalRecordOrder, value: record.orderNumber),
        InfoRow(label: l10n.clinicalRecordSeller, value: record.seller),
        InfoRow(label: l10n.clinicalRecordReferrer, value: record.referrer),
        const SizedBox(height: AppSpacing.md),
        BojaniButton(
          label: l10n.clinicalViewHistory,
          kind: BojaniButtonKind.secondary,
          icon: Icons.history,
          onPressed: () => context.push(
            PatientDetailPage.pathFor(record.patientExternalId),
          ),
        ),
      ],
    );
  }

  static String? _decimal(double? value) =>
      value == null ? null : AppFormat.decimal(value);

  static String? _cop(double? value) =>
      value == null ? null : AppFormat.cop(value);
}
