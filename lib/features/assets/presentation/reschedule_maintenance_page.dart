import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Cambiar la fecha (y, si es correctivo, la falla reportada) de un
/// mantenimiento programado.
class RescheduleMaintenancePage extends ConsumerWidget {
  const RescheduleMaintenancePage({required this.maintenanceId, super.key});

  final int maintenanceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final item = ref.watch(maintenanceDetailProvider(maintenanceId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.maintenanceRescheduleTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: item.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(maintenanceDetailProvider(maintenanceId)),
                ),
                data: (data) => _Form(item: data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.item});

  final AssetMaintenance item;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  late final _failure = TextEditingController(
    text: widget.item.reportedFailure,
  );
  late DateTime? _date = ColombiaTime.parse(widget.item.scheduledDate);

  bool get _isCorrective => widget.item.type == MaintenanceType.corrective;

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
        .reschedule(
          widget.item.id,
          _date!,
          reportedFailure: _isCorrective ? _failure.text : null,
        );
    if (!mounted) return;
    if (!done) {
      showWriteError(
        context,
        ref,
        error: ref.read(maintenanceActionsProvider).error,
        timeoutWarning: l10n.maintenanceRescheduleTimeoutWarning,
      );
      return;
    }
    AppSnackbar.show(context, l10n.maintenanceRescheduled);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submitting = ref.watch(maintenanceActionsProvider).isSubmitting;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text(
                  maintenanceTypeLabel(l10n, widget.item.type),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (widget.item.asset?.name != null)
                  Text(widget.item.asset!.name!),
                const SizedBox(height: AppSpacing.md),
                DateField(
                  label: l10n.maintenanceScheduledOn,
                  required: true,
                  value: _date,
                  firstDate: DateTime.now(),
                  onChanged: (value) => setState(() => _date = value),
                ),
                if (_isCorrective) ...[
                  const SizedBox(height: AppSpacing.md),
                  LabeledTextField(
                    label: l10n.maintenanceReportedFailure,
                    controller: _failure,
                    maxLines: 3,
                    validator: (value) => (value ?? '').trim().isEmpty
                        ? l10n.maintenanceReportedFailureRequired
                        : null,
                  ),
                ],
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
