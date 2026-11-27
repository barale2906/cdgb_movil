import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/consumptions/application/consumption_actions.dart';
import 'package:sga_bojanini/features/consumptions/application/consumptions_providers.dart';
import 'package:sga_bojanini/features/consumptions/data/consumption_record.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Detalle de un consumo, con reintento de sincronización si falló.
class ConsumptionDetailPage extends ConsumerWidget {
  const ConsumptionDetailPage({required this.consumptionId, super.key});

  static String pathFor(int id) => '/consumptions/$id';

  final int consumptionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final record = ref.watch(consumptionDetailProvider(consumptionId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.consumptionDetailTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: record.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(consumptionDetailProvider(consumptionId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () => ref.refresh(
                    consumptionDetailProvider(consumptionId).future,
                  ),
                  child: _Content(record: data),
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
  const _Content({required this.record});

  final ConsumptionRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final busy = ref.watch(consumptionActionsProvider).isSubmitting;
    final canRetry =
        record.canRetrySync &&
        ref.watch(
          permissionServiceProvider.select((p) => p.can('consumos.crear')),
        );
    final consumedAt = record.consumedAt;
    final syncedAt = record.syncedToHcAt;

    Future<void> retry() async {
      final confirmed = await ConfirmDialog.show(
        context,
        title: l10n.consumptionRetrySync,
        message: l10n.consumptionRetryConfirm,
        confirmLabel: l10n.consumptionRetrySync,
      );
      if (!confirmed || !context.mounted) return;
      final done = await ref
          .read(consumptionActionsProvider.notifier)
          .retrySync(record.id);
      if (!context.mounted) return;
      if (done) {
        AppSnackbar.show(context, l10n.consumptionRetryQueued);
        return;
      }
      showWriteError(
        context,
        ref,
        error: ref.read(consumptionActionsProvider).error,
        timeoutWarning: l10n.consumptionRetryTimeout,
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          consumptionTitle(record, l10n),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: Alignment.centerLeft,
          child: SyncChip(status: record.syncStatus),
        ),
        const SizedBox(height: AppSpacing.md),
        InfoRow(label: l10n.consumptionLot, value: record.lotNumber),
        InfoRow(
          label: l10n.consumptionQuantity,
          value: record.quantity == null
              ? null
              : AppFormat.decimal(record.quantity!),
        ),
        InfoRow(
          label: l10n.consumptionDate,
          value: consumedAt == null ? null : AppFormat.dateTime(consumedAt),
        ),
        InfoRow(label: l10n.consumptionServiceType, value: record.serviceType),
        InfoRow(
          label: l10n.consumptionAppointment,
          value: record.appointmentId,
        ),
        InfoRow(
          label: l10n.consumptionPatient,
          value: record.patientIdentifier,
        ),
        InfoRow(
          label: l10n.consumptionSyncedAt,
          value: syncedAt == null ? null : AppFormat.dateTime(syncedAt),
        ),
        if (canRetry) ...[
          const SizedBox(height: AppSpacing.md),
          BojaniButton(
            label: l10n.consumptionRetrySync,
            icon: Icons.sync,
            isLoading: busy,
            onPressed: () => unawaited(retry()),
          ),
        ],
      ],
    );
  }
}
