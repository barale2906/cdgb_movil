import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_record.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/inline_error.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_permissions.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Paciente: resumen y historial de procedimientos; con permiso para buscar
/// pacientes de MedSys, también sus citas. [patient] viene de la búsqueda;
/// sin él (se llega desde un registro) solo se muestran los datos del
/// historial.
class PatientDetailPage extends ConsumerWidget {
  const PatientDetailPage({
    required this.externalId,
    super.key,
    this.patient,
  });

  static String pathFor(String externalId) =>
      '/clinical-records/patients/${Uri.encodeComponent(externalId)}';

  final String externalId;
  final MedsysPatient? patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(patientHistoryProvider(externalId));
    final canSeeAppointments = ref.watch(canLookUpPatientsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.clinicalPatientTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  ref.invalidate(patientAppointmentsProvider(externalId));
                  return ref.refresh(patientHistoryProvider(externalId).future);
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    if (patient != null) _Header(patient: patient!),
                    if (canSeeAppointments)
                      _Appointments(patientCode: externalId),
                    _History(
                      history: history,
                      onRetry: () =>
                          ref.invalidate(patientHistoryProvider(externalId)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.patient});

  final MedsysPatient patient;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patient.displayName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(l10n.clinicalPatientDocument(patient.document)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
    child: Text(text, style: Theme.of(context).textTheme.titleMedium),
  );
}

class _Appointments extends ConsumerWidget {
  const _Appointments({required this.patientCode});

  final String patientCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final appointments = ref.watch(patientAppointmentsProvider(patientCode));
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(l10n.clinicalAppointmentsTitle),
          appointments.when(
            loading: () => const Skeleton(height: AppSizes.minTouchTarget),
            error: (error, _) => InlineError(
              error: error,
              onRetry: () =>
                  ref.invalidate(patientAppointmentsProvider(patientCode)),
            ),
            data: (items) => items.isEmpty
                ? Text(l10n.clinicalAppointmentsEmpty)
                : Column(
                    children: [
                      for (final item in items) _AppointmentTile(item: item),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  const _AppointmentTile({required this.item});

  final MedsysAppointment item;

  @override
  Widget build(BuildContext context) {
    final date = item.date;
    final time = item.time;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(item.serviceName ?? item.controlCode),
        subtitle: Text(
          [
            if (date != null) AppFormat.date(date),
            if (time != null) AppFormat.clock(time),
            ?item.status,
          ].join(' · '),
        ),
      ),
    );
  }
}

class _History extends StatelessWidget {
  const _History({required this.history, required this.onRetry});

  final AsyncValue<PatientHistory> history;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(l10n.clinicalHistoryTitle),
        history.when(
          loading: () => const Skeleton(height: AppSizes.minTouchTarget),
          error: (error, _) => InlineError(error: error, onRetry: onRetry),
          data: (data) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Summary(summary: data.summary),
              if (data.records.isEmpty)
                Text(l10n.clinicalHistoryEmpty)
              else
                for (final record in data.records) _HistoryTile(record: record),
            ],
          ),
        ),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.summary});

  final HistorySummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final first = summary.firstServiceDate;
    final last = summary.lastServiceDate;
    final amount = summary.totalAmount;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            label: l10n.clinicalSummaryRecords,
            value: '${summary.totalRecords}',
          ),
          InfoRow(
            label: l10n.clinicalSummaryAmount,
            value: amount == null ? null : AppFormat.cop(amount),
          ),
          InfoRow(
            label: l10n.clinicalSummaryFirst,
            value: first == null ? null : AppFormat.date(first),
          ),
          InfoRow(
            label: l10n.clinicalSummaryLast,
            value: last == null ? null : AppFormat.date(last),
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.record});

  final HistoryRecord record;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = record.serviceDate;
    final total = record.total;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(
          record.procedureName ??
              record.serviceName ??
              l10n.clinicalRecordTitle,
        ),
        subtitle: Text(
          [
            if (date != null) AppFormat.date(date),
            ?record.serviceName,
          ].join(' · '),
        ),
        trailing: total == null ? null : Text(AppFormat.cop(total)),
        onTap: () => context.push('/clinical-records/records/${record.id}'),
      ),
    );
  }
}
