import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_requests.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_labels.dart';
import 'package:sga_bojanini/features/assets/presentation/performer_fields.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Programar un mantenimiento puntual de un activo.
class ScheduleMaintenancePage extends ConsumerWidget {
  const ScheduleMaintenancePage({required this.assetId, super.key});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asset = ref.watch(assetDetailProvider(assetId));
    final filters = ref.watch(assetFiltersProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.maintenanceScheduleTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: switch ((asset, filters)) {
                (AsyncData(value: final a), AsyncData(value: final f)) => _Form(
                  asset: a,
                  filters: f,
                ),
                (AsyncError(:final error), _) ||
                (_, AsyncError(:final error)) => ErrorState(
                  error: error,
                  onRetry: () {
                    ref
                      ..invalidate(assetDetailProvider(assetId))
                      ..invalidate(assetFiltersProvider);
                  },
                ),
                _ => const SkeletonList(),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.asset, required this.filters});

  final Asset asset;
  final AssetFilters filters;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  static const List<MaintenanceType> _types = [
    MaintenanceType.preventive,
    MaintenanceType.calibration,
    MaintenanceType.metrologicalVerification,
    MaintenanceType.inspection,
    MaintenanceType.corrective,
  ];

  final _formKey = GlobalKey<FormState>();
  final _failure = TextEditingController();
  MaintenanceType? _type;
  DateTime? _date;
  Performer? _performer;
  NamedRef? _technician;
  NamedRef? _supplier;

  @override
  void dispose() {
    _failure.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final l10n = AppLocalizations.of(context);
    final done = await ref
        .read(maintenanceActionsProvider.notifier)
        .schedule(
          widget.asset.id,
          ScheduleMaintenanceRequest(
            type: _type!,
            scheduledDate: _date!,
            reportedFailure: _failure.text,
            performer: _performer,
            technicianId: _technician?.id,
            supplierId: _supplier?.id,
          ),
        );
    if (!mounted) return;
    if (!done) {
      showWriteError(
        context,
        ref,
        error: ref.read(maintenanceActionsProvider).error,
        timeoutWarning: l10n.maintenanceScheduleTimeoutWarning,
      );
      return;
    }
    AppSnackbar.show(context, l10n.maintenanceScheduled);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submitting = ref.watch(maintenanceActionsProvider).isSubmitting;
    final isCorrective = _type == MaintenanceType.corrective;
    String? required(Object? value) =>
        value == null || value == '' ? l10n.validationRequired : null;
    const gap = SizedBox(height: AppSpacing.md);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text(
                  widget.asset.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(widget.asset.code),
                gap,
                OptionDropdown<MaintenanceType>(
                  label: l10n.maintenanceType,
                  options: {
                    for (final type in _types)
                      type: maintenanceTypeLabel(l10n, type),
                  },
                  value: _type,
                  validator: required,
                  onChanged: (value) => setState(() => _type = value),
                ),
                gap,
                DateField(
                  label: l10n.maintenanceScheduledOn,
                  required: true,
                  value: _date,
                  firstDate: DateTime.now(),
                  onChanged: (value) => setState(() => _date = value),
                ),
                if (isCorrective) ...[
                  gap,
                  LabeledTextField(
                    label: l10n.maintenanceReportedFailure,
                    controller: _failure,
                    maxLines: 3,
                    validator: (value) => (value ?? '').trim().isEmpty
                        ? l10n.maintenanceReportedFailureRequired
                        : null,
                  ),
                ],
                gap,
                PerformerFields(
                  filters: widget.filters,
                  performer: _performer,
                  technician: _technician,
                  supplier: _supplier,
                  onPerformer: (value) => setState(() {
                    _performer = value;
                    _technician = null;
                    _supplier = null;
                  }),
                  onTechnician: (value) => setState(() => _technician = value),
                  onSupplier: (value) => setState(() => _supplier = value),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.maintenanceScheduleAction,
              isLoading: submitting,
              onPressed: () => unawaited(_submit()),
            ),
          ),
        ],
      ),
    );
  }
}
