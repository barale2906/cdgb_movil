import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/features/monitoring/presentation/alert_rule_form_sheet.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Reglas de alerta de un sensor: consulta y, con permiso, crear, activar o
/// desactivar y eliminar.
class AlertRulesPage extends ConsumerWidget {
  const AlertRulesPage({required this.sensorId, super.key});

  final int sensorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final rules = ref.watch(alertRulesProvider(sensorId));
    final canCreate = ref.watch(
      permissionServiceProvider.select((p) => p.can('reglas_alerta.crear')),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.alertRulesTitle)),
      floatingActionButton: canCreate
          ? FloatingActionButton.extended(
              onPressed: () =>
                  unawaited(showAlertRuleFormSheet(context, sensorId)),
              icon: const Icon(Icons.add),
              label: Text(l10n.alertRuleNew),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: rules.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(alertRulesProvider(sensorId)),
                ),
                data: (items) => items.isEmpty
                    ? EmptyState(
                        icon: Icons.rule,
                        message: l10n.alertRulesEmpty,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        itemCount: items.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) =>
                            _RuleTile(rule: items[index], sensorId: sensorId),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleTile extends ConsumerWidget {
  const _RuleTile({required this.rule, required this.sensorId});

  final AlertRule rule;
  final int sensorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final permissions = ref.watch(permissionServiceProvider);
    final busy = ref.watch(alertRuleActionsProvider).isSubmitting;
    final threshold = rule.threshold == null
        ? ''
        : AppFormat.decimal(rule.threshold!);
    final title = switch (rule.conditionType) {
      'above' => l10n.alertAbove(threshold),
      'below' => l10n.alertBelow(threshold),
      'out_of_range' => l10n.alertOutOfRange,
      'trend_up' => l10n.alertTrendUp,
      'trend_down' => l10n.alertTrendDown,
      _ => rule.conditionType,
    };
    final canToggle = permissions.can('reglas_alerta.editar');
    final canDelete = permissions.can('reglas_alerta.eliminar');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            if (rule.consecutiveReadings != null)
              Text(l10n.alertConsecutive(rule.consecutiveReadings!)),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                StatusChip(
                  label: rule.isActive
                      ? l10n.statusActive
                      : l10n.statusInactive,
                  kind: rule.isActive ? StatusKind.success : StatusKind.info,
                ),
                if (canToggle)
                  Switch(
                    value: rule.isActive,
                    onChanged: busy
                        ? null
                        : (on) => unawaited(
                            _toggle(context, ref, active: on),
                          ),
                  ),
                if (canDelete)
                  BojaniButton(
                    label: l10n.alertRuleDelete,
                    icon: Icons.delete_outline,
                    kind: BojaniButtonKind.tertiary,
                    expand: false,
                    onPressed: busy
                        ? null
                        : () => unawaited(_delete(context, ref)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggle(
    BuildContext context,
    WidgetRef ref, {
    required bool active,
  }) async {
    final done = await ref
        .read(alertRuleActionsProvider.notifier)
        .setActive(sensorId, rule.id, active: active);
    if (!done && context.mounted) _showError(context, ref);
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.alertRuleDelete,
      message: l10n.alertRuleDeleteConfirm,
      confirmLabel: l10n.alertRuleDelete,
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await ref
        .read(alertRuleActionsProvider.notifier)
        .delete(sensorId, rule.id);
    if (!context.mounted) return;
    if (done) {
      AppSnackbar.show(context, l10n.alertRuleDeleted);
    } else {
      _showError(context, ref);
    }
  }

  void _showError(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    AppSnackbar.show(
      context,
      ApiErrorMessage.ofWrite(
        l10n,
        ref.read(alertRuleActionsProvider).error,
        isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
        timeoutWarning: l10n.alertRuleTimeout,
      ),
      kind: AppSnackbarKind.error,
      closeLabel: l10n.actionClose,
    );
  }
}
