import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/audit/application/audit_providers.dart';
import 'package:sga_bojanini/features/audit/data/audit_log.dart';
import 'package:sga_bojanini/features/audit/presentation/audit_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Detalle de un registro de la bitácora, con los cambios de cada campo.
class AuditDetailPage extends ConsumerWidget {
  const AuditDetailPage({required this.logId, super.key});

  static String pathFor(int id) => '/audit/$id';

  final int logId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final log = ref.watch(auditDetailProvider(logId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.auditDetailTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: log.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(auditDetailProvider(logId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(auditDetailProvider(logId).future),
                  child: _Content(log: data),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.log});

  final AuditLog log;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final createdAt = log.createdAt;
    final changes = auditChanges(log, l10n);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AuditActionChip(action: log.action),
        ),
        const SizedBox(height: AppSpacing.md),
        InfoRow(
          label: l10n.auditUser,
          value: log.userName ?? l10n.auditSystemUser,
        ),
        InfoRow(
          label: l10n.auditDate,
          value: createdAt == null ? null : AppFormat.dateTime(createdAt),
        ),
        InfoRow(
          label: l10n.auditEntity,
          value: auditEntityName(log.auditableType, l10n),
        ),
        InfoRow(label: l10n.auditEntityId, value: log.auditableId),
        InfoRow(label: l10n.auditIp, value: log.ipAddress),
        InfoRow(label: l10n.auditDevice, value: log.userAgent),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.auditChanges, style: textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        if (changes.isEmpty)
          Text(l10n.auditNoChanges)
        else
          for (final change in changes) _ChangeTile(change: change),
      ],
    );
  }
}

class _ChangeTile extends StatelessWidget {
  const _ChangeTile({required this.change});

  final AuditChange change;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(change.field, style: textTheme.titleSmall),
            if (change.before != null)
              Text('${l10n.auditValueOld}: ${change.before}'),
            if (change.after != null)
              Text('${l10n.auditValueNew}: ${change.after}'),
          ],
        ),
      ),
    );
  }
}
