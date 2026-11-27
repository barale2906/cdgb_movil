import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/my_signature.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/signoff_form.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_repository.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_labels.dart';
import 'package:sga_bojanini/features/assets/presentation/replaced_parts_field.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class CompleteMaintenanceForm extends ConsumerStatefulWidget {
  const CompleteMaintenanceForm({
    required this.maintenanceId,
    required this.filters,
    super.key,
  });

  final int maintenanceId;
  final AssetFilters filters;

  @override
  ConsumerState<CompleteMaintenanceForm> createState() => _FormState();
}

class _FormState extends ConsumerState<CompleteMaintenanceForm> {
  final _formKey = GlobalKey<FormState>();
  final _activities = TextEditingController();
  final _findings = TextEditingController();
  final _recommendations = TextEditingController();
  final _externalName = TextEditingController();
  final _cost = TextEditingController();
  final _signoff = SignoffController();
  bool _withSignatures = false;
  bool _internal = true;
  DateTime? _date;
  NamedRef? _technician;
  NamedRef? _supplier;
  MaintenanceResult? _result;
  List<ReplacedPart> _parts = const [];

  @override
  void dispose() {
    for (final controller in [
      _activities,
      _findings,
      _recommendations,
      _externalName,
      _cost,
    ]) {
      controller.dispose();
    }
    _signoff.dispose();
    super.dispose();
  }

  /// Hoy: hasta ahora (no puede ser futura); otro día: a mediodía.
  DateTime _performedAt(DateTime date, DateTime now) {
    final sameDay =
        date.year == now.year && date.month == now.month && date.day == now.day;
    return sameDay ? now : DateTime(date.year, date.month, date.day, 12);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final signoff = _withSignatures
        ? await _signoff.collect(
            hasRegisteredSignature: ref.read(mySignatureProvider).value != null,
          )
        : null;
    if (_withSignatures && signoff == null) return;
    if (!mounted) return;
    final now = ColombiaTime.now(ref.read(clockProvider));
    final done = await ref
        .read(maintenanceActionsProvider.notifier)
        .complete(
          widget.maintenanceId,
          CompleteMaintenanceRequest(
            performedAt: _performedAt(_date ?? now, now),
            internal: _internal,
            activities: _activities.text,
            result: _result!,
            technicianId: _technician?.id,
            supplierId: _supplier?.id,
            externalTechnicianName: _externalName.text,
            findings: _findings.text,
            recommendations: _recommendations.text,
            parts: _parts,
            cost: AppFormat.parseDecimal(_cost.text),
            signoff: signoff,
          ),
        );
    if (!done || !mounted) return;
    AppSnackbar.show(
      context,
      AppLocalizations.of(context).maintenanceCompleted,
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(maintenanceActionsProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final error = submission.error;
    final today = ColombiaTime.now(ref.read(clockProvider));
    final pinError = error is ValidationException
        ? error.firstErrorFor('received_by.pin')
        : null;
    String? required(Object? value) =>
        value == null || value == '' ? l10n.validationRequired : null;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                DateField(
                  label: l10n.maintenancePerformedAt,
                  required: true,
                  value: _date ?? today,
                  lastDate: today,
                  onChanged: (value) => setState(() => _date = value),
                ),
                const SizedBox(height: AppSpacing.md),
                SegmentedButton<bool>(
                  segments: [
                    ButtonSegment(
                      value: true,
                      label: Text(l10n.maintenanceInternal),
                    ),
                    ButtonSegment(
                      value: false,
                      label: Text(l10n.maintenanceExternal),
                    ),
                  ],
                  selected: {_internal},
                  onSelectionChanged: (s) =>
                      setState(() => _internal = s.first),
                ),
                const SizedBox(height: AppSpacing.md),
                if (_internal)
                  OptionDropdown<NamedRef>(
                    label: l10n.maintenanceTechnician,
                    options: {for (final u in widget.filters.users) u: u.name},
                    value: _technician,
                    validator: required,
                    onChanged: (value) => setState(() => _technician = value),
                  )
                else ...[
                  OptionDropdown<NamedRef>(
                    label: l10n.assetSupplier,
                    options: {
                      for (final s in widget.filters.suppliers) s: s.name,
                    },
                    value: _supplier,
                    validator: required,
                    onChanged: (value) => setState(() => _supplier = value),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _externalName,
                    decoration: InputDecoration(
                      labelText: l10n.maintenanceExternalTechnician,
                    ),
                    validator: required,
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _activities,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.maintenanceActivities,
                  ),
                  validator: required,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _findings,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: l10n.maintenanceFindings,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _recommendations,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: l10n.maintenanceRecommendations,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                OptionDropdown<MaintenanceResult>(
                  label: l10n.maintenanceResult,
                  options: {
                    for (final r in MaintenanceResult.values)
                      if (r != MaintenanceResult.unknown)
                        r: maintenanceResultLabel(l10n, r),
                  },
                  value: _result,
                  validator: required,
                  onChanged: (value) => setState(() => _result = value),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _cost,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                  ],
                  decoration: InputDecoration(labelText: l10n.maintenanceCost),
                ),
                const SizedBox(height: AppSpacing.md),
                ReplacedPartsField(
                  parts: _parts,
                  onChanged: (parts) => setState(() => _parts = parts),
                ),
                const SizedBox(height: AppSpacing.md),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.maintenanceSignatures),
                  subtitle: Text(l10n.maintenanceSignaturesHelp),
                  value: _withSignatures,
                  onChanged: submission.isSubmitting
                      ? null
                      : (on) => setState(() => _withSignatures = on),
                ),
                if (_withSignatures)
                  SignoffForm(controller: _signoff, pinError: pinError),
                if (error != null && pinError == null) ...[
                  const SizedBox(height: AppSpacing.md),
                  AlertBanner(
                    message: ApiErrorMessage.ofWrite(
                      l10n,
                      error,
                      isProd: isProd,
                      timeoutWarning: l10n.maintenanceTimeoutWarning,
                    ),
                    kind: StatusKind.error,
                    icon: Icons.error_outline,
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.maintenanceCompleteAction,
              isLoading: submission.isSubmitting,
              onPressed: () => unawaited(_submit()),
            ),
          ),
        ],
      ),
    );
  }
}
