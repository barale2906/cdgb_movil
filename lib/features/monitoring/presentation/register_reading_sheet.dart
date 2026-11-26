import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Registro de una lectura manual de un sensor (fecha y hora de Colombia).
Future<void> showRegisterReadingSheet(BuildContext context, Sensor sensor) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _RegisterReadingSheet(sensor: sensor),
    );

class _RegisterReadingSheet extends ConsumerStatefulWidget {
  const _RegisterReadingSheet({required this.sensor});

  final Sensor sensor;

  @override
  ConsumerState<_RegisterReadingSheet> createState() =>
      _RegisterReadingSheetState();
}

class _RegisterReadingSheetState extends ConsumerState<_RegisterReadingSheet> {
  final _formKey = GlobalKey<FormState>();
  final _value = TextEditingController();
  late DateTime _when = ColombiaTime.now(ref.read(clockProvider));

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_when),
    );
    if (picked != null) {
      setState(() {
        _when = DateTime(
          _when.year,
          _when.month,
          _when.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final value = double.parse(_value.text.trim().replaceAll(',', '.'));
    final result = await ref
        .read(registerReadingControllerProvider.notifier)
        .submit(sensorId: widget.sensor.id, value: value, recordedAt: _when);
    if (result == null || !mounted) return;
    Navigator.of(context).pop();
    AppSnackbar.show(
      context,
      result.alertCount > 0
          ? '${l10n.readingSaved} ${l10n.readingAlerts(result.alertCount)}'
          : l10n.readingSaved,
      kind: result.alertCount > 0
          ? AppSnackbarKind.warning
          : AppSnackbarKind.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(registerReadingControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final canWrite = ref.watch(canWriteProvider);
    final error = submission.error;
    final now = ColombiaTime.now(ref.read(clockProvider));

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.sensor.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _value,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  labelText: l10n.readingValue(widget.sensor.unit),
                  suffixText: widget.sensor.unit,
                ),
                validator: (v) =>
                    double.tryParse((v ?? '').trim().replaceAll(',', '.')) ==
                        null
                    ? l10n.validationNumber
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),
              DateField(
                label: l10n.readingWhen,
                required: true,
                value: _when,
                lastDate: now,
                onChanged: (date) {
                  if (date != null) {
                    setState(
                      () => _when = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        _when.hour,
                        _when.minute,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => unawaited(_pickTime()),
                  icon: const Icon(Icons.schedule),
                  label: Text(AppFormat.time(_when)),
                ),
              ),
              if (error != null) ...[
                const SizedBox(height: AppSpacing.md),
                AlertBanner(
                  message: ApiErrorMessage.of(l10n, error, isProd: isProd),
                  kind: StatusKind.error,
                  icon: Icons.error_outline,
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              BojaniButton(
                label: l10n.readingRegister,
                isLoading: submission.isSubmitting,
                onPressed: canWrite ? () => unawaited(_submit()) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
