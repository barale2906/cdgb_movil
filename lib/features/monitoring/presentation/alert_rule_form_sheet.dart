import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/alert_rule_request.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Nombre de una condición para elegirla en el formulario.
String alertConditionLabel(AppLocalizations l10n, AlertCondition condition) =>
    switch (condition) {
      AlertCondition.above => l10n.alertConditionAbove,
      AlertCondition.below => l10n.alertConditionBelow,
      AlertCondition.outOfRange => l10n.alertOutOfRange,
      AlertCondition.trendUp => l10n.alertTrendUp,
      AlertCondition.trendDown => l10n.alertTrendDown,
    };

String _channelLabel(AppLocalizations l10n, AlertChannel channel) =>
    switch (channel) {
      AlertChannel.internal => l10n.alertRuleChannelInternal,
      AlertChannel.email => l10n.alertRuleChannelEmail,
      AlertChannel.push => l10n.alertRuleChannelPush,
    };

/// Formulario para crear una regla de alerta de un sensor.
Future<void> showAlertRuleFormSheet(BuildContext context, int sensorId) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AlertRuleFormSheet(sensorId: sensorId),
    );

class _AlertRuleFormSheet extends ConsumerStatefulWidget {
  const _AlertRuleFormSheet({required this.sensorId});

  final int sensorId;

  @override
  ConsumerState<_AlertRuleFormSheet> createState() =>
      _AlertRuleFormSheetState();
}

class _AlertRuleFormSheetState extends ConsumerState<_AlertRuleFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _threshold = TextEditingController();
  final _consecutive = TextEditingController(text: '1');
  AlertCondition _condition = AlertCondition.above;
  final Set<AlertChannel> _channels = {AlertChannel.internal};
  bool _attempted = false;

  @override
  void dispose() {
    _threshold.dispose();
    _consecutive.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _attempted = true);
    if (!(_formKey.currentState?.validate() ?? false) || _channels.isEmpty) {
      return;
    }
    final done = await ref
        .read(alertRuleActionsProvider.notifier)
        .create(
          widget.sensorId,
          AlertRuleRequest(
            condition: _condition,
            threshold: _condition.needsThreshold
                ? AppFormat.parseDecimal(_threshold.text)
                : null,
            consecutiveReadings: int.parse(_consecutive.text.trim()),
            channels: _channels,
          ),
        );
    if (!done || !mounted) return;
    Navigator.of(context).pop();
    AppSnackbar.show(context, AppLocalizations.of(context).alertRuleCreated);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(alertRuleActionsProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final canWrite = ref.watch(canWriteProvider);
    final unit = ref.watch(sensorProvider(widget.sensorId)).value?.unit;
    final error = submission.error;

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
                l10n.alertRuleFormTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              OptionDropdown<AlertCondition>(
                label: l10n.alertRuleCondition,
                options: {
                  for (final c in AlertCondition.values)
                    c: alertConditionLabel(l10n, c),
                },
                value: _condition,
                onChanged: (value) {
                  if (value != null) setState(() => _condition = value);
                },
              ),
              if (_condition.needsThreshold) ...[
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _threshold,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,-]')),
                  ],
                  decoration: InputDecoration(
                    labelText: l10n.alertRuleThreshold,
                    suffixText: unit,
                  ),
                  validator: (value) => AppFormat.parseDecimal(value) == null
                      ? l10n.validationNumber
                      : null,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _consecutive,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: l10n.alertRuleConsecutive,
                  helperText: l10n.alertRuleConsecutiveHelp,
                ),
                validator: (value) {
                  final count = int.tryParse((value ?? '').trim());
                  return count != null && count >= 1 && count <= 100
                      ? null
                      : l10n.alertRuleConsecutiveHelp;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.alertRuleChannels,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              for (final channel in AlertChannel.values)
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_channelLabel(l10n, channel)),
                  value: _channels.contains(channel),
                  onChanged: submission.isSubmitting
                      ? null
                      : (on) => setState(() {
                          if (on ?? false) {
                            _channels.add(channel);
                          } else {
                            _channels.remove(channel);
                          }
                        }),
                ),
              if (_attempted && _channels.isEmpty)
                Text(
                  l10n.alertRuleChannelRequired,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              if (error != null) ...[
                const SizedBox(height: AppSpacing.md),
                AlertBanner(
                  message: ApiErrorMessage.ofWrite(
                    l10n,
                    error,
                    isProd: isProd,
                    timeoutWarning: l10n.alertRuleTimeout,
                  ),
                  kind: StatusKind.error,
                  icon: Icons.error_outline,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              BojaniButton(
                label: l10n.alertRuleSave,
                isLoading: submission.isSubmitting,
                onPressed: canWrite ? () => unawaited(_save()) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
