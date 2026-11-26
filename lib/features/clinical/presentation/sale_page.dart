import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/application/sale_controller.dart';
import 'package:sga_bojanini/features/clinical/data/medsys_patient.dart';
import 'package:sga_bojanini/features/clinical/data/procedure_match.dart';
import 'package:sga_bojanini/features/clinical/presentation/sale_line_card.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Registrar venta: paciente de MedSys + uno o más servicios. Cada servicio es
/// un registro propio, sin movimiento de inventario.
class SalePage extends ConsumerStatefulWidget {
  const SalePage({super.key});

  static const path = '/clinical-records/sale';
  static const patientPath = '$path/patient';
  static const servicePath = '$path/service';

  @override
  ConsumerState<SalePage> createState() => _SalePageState();
}

class _SalePageState extends ConsumerState<SalePage> {
  final _formKey = GlobalKey<FormState>();
  final _seller = TextEditingController();
  final _referrer = TextEditingController();
  bool _attempted = false;

  @override
  void dispose() {
    _seller.dispose();
    _referrer.dispose();
    super.dispose();
  }

  Future<void> _pickPatient() async {
    final patient = await context.push<MedsysPatient>(SalePage.patientPath);
    if (patient != null) ref.read(saleProvider.notifier).setPatient(patient);
  }

  Future<void> _addService() async {
    final service = await context.push<ProcedureMatch>(SalePage.servicePath);
    if (service != null) ref.read(saleProvider.notifier).addLine(service);
  }

  Future<void> _submit() async {
    setState(() => _attempted = true);
    final formValid = _formKey.currentState?.validate() ?? false;
    final state = ref.read(saleProvider);
    if (!formValid || state.patient == null || state.sendable.isEmpty) return;
    final done = await ref.read(saleProvider.notifier).submit();
    if (!mounted || !done) return;
    ref.invalidate(procedureRecordsProvider);
    AppSnackbar.show(context, AppLocalizations.of(context).saleDone);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(saleProvider);
    final notifier = ref.read(saleProvider.notifier);
    final locked = state.hasSaved || state.isSubmitting;
    final today = DateTime.now();
    final canWrite = ref.watch(canWriteProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.saleTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    _PatientSection(
                      patient: state.patient,
                      locked: locked,
                      showError: _attempted && state.patient == null,
                      onPick: _pickPatient,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    IgnorePointer(
                      ignoring: locked,
                      child: DateField(
                        label: l10n.saleServiceDate,
                        value: state.serviceDate,
                        required: true,
                        lastDate: DateTime(today.year, today.month, today.day),
                        onChanged: (date) {
                          if (date != null) notifier.setServiceDate(date);
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BojaniTextField(
                      label: l10n.saleSeller,
                      controller: _seller,
                      enabled: !locked,
                      textInputAction: TextInputAction.next,
                      validator: _required(l10n),
                      onChanged: notifier.setSeller,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BojaniTextField(
                      label: l10n.saleReferrer,
                      controller: _referrer,
                      enabled: !locked,
                      validator: _required(l10n),
                      onChanged: notifier.setReferrer,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.saleServicesTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final line in state.lines) ...[
                      SaleLineCard(key: ValueKey(line.key), line: line),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                    if (_attempted && state.lines.isEmpty)
                      Text(
                        l10n.saleServicesRequired,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    BojaniButton(
                      label: l10n.saleAddService,
                      icon: Icons.add,
                      kind: BojaniButtonKind.secondary,
                      onPressed: state.isSubmitting
                          ? null
                          : () => unawaited(_addService()),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      '${l10n.saleTotal}: ${AppFormat.cop(state.total)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (state.hasSaved && !state.isComplete) ...[
                      const SizedBox(height: AppSpacing.md),
                      AlertBanner(
                        message: l10n.salePartialWarning,
                        kind: StatusKind.warning,
                        icon: Icons.info_outline,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: BojaniButton(
                label: l10n.saleSubmit,
                isLoading: state.isSubmitting,
                onPressed: canWrite ? () => unawaited(_submit()) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FormFieldValidator<String> _required(AppLocalizations l10n) =>
      (value) => (value ?? '').trim().isEmpty ? l10n.validationRequired : null;
}

class _PatientSection extends StatelessWidget {
  const _PatientSection({
    required this.patient,
    required this.locked,
    required this.showError,
    required this.onPick,
  });

  final MedsysPatient? patient;
  final bool locked;
  final bool showError;
  final VoidCallback onPick;

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
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(current.displayName),
        subtitle: Text(l10n.clinicalPatientDocument(current.document)),
        trailing: locked
            ? null
            : TextButton(
                onPressed: onPick,
                child: Text(l10n.saleChangePatient),
              ),
      ),
    );
  }
}
