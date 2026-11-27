import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/text_prompt_dialog.dart';
import 'package:sga_bojanini/features/assets/application/maintenance_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Mantenimiento: datos, ejecución y acciones (iniciar, completar, cancelar,
/// reporte).
class MaintenanceDetailPage extends ConsumerWidget {
  const MaintenanceDetailPage({required this.maintenanceId, super.key});

  final int maintenanceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final item = ref.watch(maintenanceDetailProvider(maintenanceId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.maintenanceDetailTitle)),
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
                data: (data) => RefreshIndicator(
                  onRefresh: () => ref.refresh(
                    maintenanceDetailProvider(maintenanceId).future,
                  ),
                  child: _Content(item: data),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.item});

  final AssetMaintenance item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final permissions = ref.watch(permissionServiceProvider);
    final canExecute = permissions.can('activos_mantenimientos.ejecutar');
    final canCancel = permissions.can('activos_mantenimientos.cancelar');
    final canReschedule = permissions.can('activos_mantenimientos.programar');
    final busy = ref.watch(maintenanceActionsProvider).isSubmitting;
    String? date(String? raw) => raw == null ? null : AppFormat.date(raw);
    String? dateTime(String? raw) =>
        raw == null ? null : AppFormat.dateTime(raw);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                maintenanceTypeLabel(l10n, item.type),
                style: textTheme.titleMedium,
              ),
            ),
            MaintenanceStatusChip(maintenance: item),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (item.asset != null)
          Card(
            child: ListTile(
              title: Text(item.asset!.name ?? l10n.notAvailable),
              subtitle: Text(
                [item.asset!.code, item.asset!.location].nonNulls.join(' · '),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/assets/${item.asset!.id}'),
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        InfoRow(
          label: l10n.maintenanceScheduledDate,
          value: date(item.scheduledDate),
        ),
        InfoRow(
          label: l10n.maintenanceStartedAt,
          value: dateTime(item.startedAt),
        ),
        InfoRow(
          label: l10n.maintenancePerformedAt,
          value: dateTime(item.performedAt),
        ),
        InfoRow(
          label: l10n.maintenanceReportedFailure,
          value: item.reportedFailure,
        ),
        InfoRow(
          label: l10n.maintenanceTechnician,
          value: item.technician?.name ?? item.externalTechnicianName,
        ),
        InfoRow(label: l10n.assetSupplier, value: item.supplier?.name),
        InfoRow(
          label: l10n.maintenanceActivities,
          value: item.activitiesPerformed,
        ),
        InfoRow(label: l10n.maintenanceFindings, value: item.findings),
        InfoRow(
          label: l10n.maintenanceRecommendations,
          value: item.recommendations,
        ),
        InfoRow(
          label: l10n.maintenanceResult,
          value: item.result == null
              ? null
              : maintenanceResultLabel(l10n, item.resultType),
        ),
        InfoRow(
          label: l10n.maintenanceCost,
          value: item.cost == null ? null : AppFormat.cop(item.cost!),
        ),
        InfoRow(label: l10n.transferCancelReason, value: item.cancelReason),
        if (item.partsReplaced.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.maintenanceParts, style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final part in item.partsReplaced)
            Card(
              child: ListTile(
                title: Text(part.name),
                subtitle: Text(
                  l10n.orderQuantity(AppFormat.decimal(part.quantity ?? 0)),
                ),
                trailing: part.cost == null
                    ? null
                    : Text(AppFormat.cop(part.cost!)),
              ),
            ),
        ],
        const SizedBox(height: AppSpacing.lg),
        if (item.canStart && canExecute) ...[
          BojaniButton(
            label: l10n.maintenanceStart,
            icon: Icons.play_arrow,
            isLoading: busy,
            onPressed: () => unawaited(_start(context, ref)),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (item.canComplete && canExecute) ...[
          BojaniButton(
            label: l10n.maintenanceComplete,
            icon: Icons.task_alt,
            onPressed: busy
                ? null
                : () => context.push('/maintenance/${item.id}/complete'),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (item.canStart && canReschedule) ...[
          BojaniButton(
            label: l10n.maintenanceRescheduleAction,
            icon: Icons.event_repeat_outlined,
            kind: BojaniButtonKind.secondary,
            onPressed: busy
                ? null
                : () => context.push('/maintenance/${item.id}/reschedule'),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        BojaniButton(
          label: l10n.maintenanceReport,
          icon: Icons.picture_as_pdf_outlined,
          kind: BojaniButtonKind.secondary,
          onPressed: () => context.push('/maintenance/${item.id}/report'),
        ),
        if (item.canCancel && canCancel) ...[
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.maintenanceCancel,
            icon: Icons.delete_outline,
            kind: BojaniButtonKind.tertiary,
            onPressed: busy ? null : () => unawaited(_cancel(context, ref)),
          ),
        ],
      ],
    );
  }

  Future<void> _start(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.maintenanceStartTitle,
      message: l10n.maintenanceStartBody,
      confirmLabel: l10n.maintenanceStart,
    );
    if (!confirmed || !context.mounted) return;
    final done = await ref
        .read(maintenanceActionsProvider.notifier)
        .start(item.id);
    if (context.mounted) _report(context, ref, done, l10n.maintenanceStarted);
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final reason = await promptText(
      context,
      title: l10n.maintenanceCancelTitle,
      confirmLabel: l10n.maintenanceCancel,
      fieldLabel: l10n.transferCancelReason,
      destructive: true,
      required: true,
    );
    if (reason == null || !context.mounted) return;
    final done = await ref
        .read(maintenanceActionsProvider.notifier)
        .cancel(item.id, reason);
    if (context.mounted) _report(context, ref, done, l10n.maintenanceCancelled);
  }

  void _report(
    BuildContext context,
    WidgetRef ref,
    bool done,
    String successMessage,
  ) {
    final l10n = AppLocalizations.of(context);
    if (done) {
      AppSnackbar.show(context, successMessage);
      return;
    }
    AppSnackbar.show(
      context,
      ApiErrorMessage.ofWrite(
        l10n,
        ref.read(maintenanceActionsProvider).error,
        isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
        timeoutWarning: l10n.maintenanceTimeoutWarning,
      ),
      kind: AppSnackbarKind.error,
      closeLabel: l10n.actionClose,
    );
  }
}
