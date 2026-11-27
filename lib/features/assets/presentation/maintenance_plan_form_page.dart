import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_requests.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_labels.dart';
import 'package:sga_bojanini/features/assets/presentation/performer_fields.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Crear (sin [planId]) o editar un plan de mantenimiento periódico. Los
/// planes no se eliminan: se desactivan.
class MaintenancePlanFormPage extends ConsumerWidget {
  const MaintenancePlanFormPage({
    required this.assetId,
    super.key,
    this.planId,
  });

  final int assetId;
  final int? planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = planId;
    final filters = ref.watch(assetFiltersProvider);
    final plans = id == null
        ? null
        : ref.watch(maintenancePlansProvider(assetId));
    return Scaffold(
      appBar: AppBar(
        title: Text(id == null ? l10n.planNewTitle : l10n.planEditTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: switch ((filters, plans)) {
                (AsyncData(value: final f), null) => _Form(
                  assetId: assetId,
                  filters: f,
                ),
                (AsyncData(value: final f), AsyncData(value: final list)) =>
                  _formFor(l10n, f, list, id),
                (AsyncError(:final error), _) ||
                (_, AsyncError(:final error)) => ErrorState(
                  error: error,
                  onRetry: () {
                    ref
                      ..invalidate(assetFiltersProvider)
                      ..invalidate(maintenancePlansProvider(assetId));
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

  Widget _formFor(
    AppLocalizations l10n,
    AssetFilters filters,
    List<MaintenancePlan> plans,
    int? id,
  ) {
    final plan = plans.where((p) => p.id == id).firstOrNull;
    if (plan == null) {
      return EmptyState(
        icon: Icons.event_busy_outlined,
        message: l10n.planNotFound,
      );
    }
    return _Form(assetId: assetId, filters: filters, plan: plan);
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.assetId, required this.filters, this.plan});

  final int assetId;
  final AssetFilters filters;
  final MaintenancePlan? plan;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  late final _frequency = TextEditingController(
    text: widget.plan?.frequencyValue?.toString(),
  );
  late final _notes = TextEditingController(text: widget.plan?.notes);
  late MaintenanceType? _type = widget.plan?.type;
  late FrequencyUnit _unit = FrequencyUnit.parse(widget.plan?.frequencyUnit);
  late DateTime? _start = ColombiaTime.parse(widget.plan?.startDate);
  late Performer? _performer = widget.plan == null
      ? null
      : Performer.parse(widget.plan!.performedByType);
  late NamedRef? _technician = widget.filters.users
      .where((u) => u.id == widget.plan?.technician?.id)
      .firstOrNull;
  late NamedRef? _supplier = widget.filters.suppliers
      .where((s) => s.id == widget.plan?.supplier?.id)
      .firstOrNull;
  late bool _active = widget.plan?.isActive ?? true;

  @override
  void dispose() {
    _frequency.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final l10n = AppLocalizations.of(context);
    final request = MaintenancePlanRequest(
      type: _type!,
      frequencyValue: int.parse(_frequency.text.trim()),
      frequencyUnit: _unit,
      startDate: _start!,
      performer: _performer!,
      technicianId: _technician?.id,
      supplierId: _supplier?.id,
      notes: _notes.text,
      isActive: _active,
    );
    final actions = ref.read(maintenanceActionsProvider.notifier);
    final plan = widget.plan;
    final done = plan == null
        ? await actions.createPlan(widget.assetId, request)
        : await actions.updatePlan(widget.assetId, plan.id, request);
    if (!mounted) return;
    if (!done) {
      showWriteError(
        context,
        ref,
        error: ref.read(maintenanceActionsProvider).error,
        timeoutWarning: l10n.planTimeoutWarning,
      );
      return;
    }
    AppSnackbar.show(context, l10n.planSaved);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submitting = ref.watch(maintenanceActionsProvider).isSubmitting;
    String? required(Object? value) =>
        value == null || value == '' ? l10n.validationRequired : null;
    String? frequency(String? value) {
      final number = int.tryParse((value ?? '').trim());
      return number == null || number < 1 || number > 3650
          ? l10n.planFrequencyInvalid
          : null;
    }

    const gap = SizedBox(height: AppSpacing.md);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                OptionDropdown<MaintenanceType>(
                  label: l10n.maintenanceType,
                  options: {
                    for (final type in plannableMaintenanceTypes)
                      type: maintenanceTypeLabel(l10n, type),
                  },
                  value: _type,
                  validator: required,
                  onChanged: (value) => setState(() => _type = value),
                ),
                gap,
                LabeledTextField(
                  label: l10n.planFrequencyValue,
                  controller: _frequency,
                  keyboardType: TextInputType.number,
                  validator: frequency,
                ),
                gap,
                OptionDropdown<FrequencyUnit>(
                  label: l10n.planFrequencyUnit,
                  options: {
                    FrequencyUnit.days: l10n.planUnitDays,
                    FrequencyUnit.months: l10n.planUnitMonths,
                  },
                  value: _unit,
                  onChanged: (value) => setState(() => _unit = value ?? _unit),
                ),
                gap,
                DateField(
                  label: l10n.planStartDate,
                  required: true,
                  value: _start,
                  onChanged: (value) => setState(() => _start = value),
                ),
                gap,
                PerformerFields(
                  filters: widget.filters,
                  performer: _performer,
                  technician: _technician,
                  supplier: _supplier,
                  required: true,
                  onPerformer: (value) => setState(() {
                    _performer = value;
                    _technician = null;
                    _supplier = null;
                  }),
                  onTechnician: (value) => setState(() => _technician = value),
                  onSupplier: (value) => setState(() => _supplier = value),
                ),
                gap,
                LabeledTextField(
                  label: l10n.fieldNotes,
                  controller: _notes,
                  maxLines: 3,
                ),
                if (widget.plan != null)
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.planActive),
                    subtitle: Text(l10n.planActiveHelp),
                    value: _active,
                    onChanged: (value) => setState(() => _active = value),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.actionSave,
              isLoading: submitting,
              onPressed: () => unawaited(_submit()),
            ),
          ),
        ],
      ),
    );
  }
}
