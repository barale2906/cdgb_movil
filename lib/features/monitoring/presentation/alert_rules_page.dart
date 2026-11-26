import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Reglas de alerta de un sensor (consulta; crear/editar es del escritorio).
class AlertRulesPage extends ConsumerWidget {
  const AlertRulesPage({required this.sensorId, super.key});

  final int sensorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final rules = ref.watch(alertRulesProvider(sensorId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.alertRulesTitle)),
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
                            _RuleTile(rule: items[index]),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({required this.rule});

  final AlertRule rule;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: rule.consecutiveReadings == null
            ? null
            : Text(l10n.alertConsecutive(rule.consecutiveReadings!)),
        trailing: StatusChip(
          label: rule.isActive ? l10n.statusActive : l10n.statusInactive,
          kind: rule.isActive ? StatusKind.success : StatusKind.info,
        ),
      ),
    );
  }
}
