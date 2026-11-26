import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/clinical/procedure_record.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/billing_chip.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/service_orders/application/order_actions.dart';
import 'package:sga_bojanini/features/service_orders/application/service_order_permissions.dart';
import 'package:sga_bojanini/features/service_orders/application/service_orders_providers.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';
import 'package:sga_bojanini/features/service_orders/presentation/service_order_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Detalle de una orden de servicio, con aprobar descuento, facturar y anular
/// según permisos y estado.
class OrderDetailPage extends ConsumerWidget {
  const OrderDetailPage({required this.orderNumber, super.key});

  static String pathFor(String orderNumber) =>
      '/service-orders/${Uri.encodeComponent(orderNumber)}';

  final String orderNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(serviceOrderProvider(orderNumber));
    return Scaffold(
      appBar: AppBar(title: Text(orderNumber)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: order.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () =>
                      ref.invalidate(serviceOrderProvider(orderNumber)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(serviceOrderProvider(orderNumber).future),
                  child: _Content(order: data),
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
  const _Content({required this.order});

  final ServiceOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final date = order.serviceDate;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xs,
          children: [
            ServiceOrderStatusChip(status: order.orderStatus),
            BillingChip(status: order.billingStatus),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        InfoRow(label: l10n.serviceOrderPatient, value: order.patientName),
        InfoRow(
          label: l10n.clinicalRecordDocument,
          value: order.patientDocument,
        ),
        InfoRow(
          label: l10n.clinicalRecordDate,
          value: date == null ? null : AppFormat.date(date),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.serviceOrderProcedures,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final record in order.procedures) _ProcedureTile(record: record),
        const SizedBox(height: AppSpacing.sm),
        _Totals(order: order),
        const SizedBox(height: AppSpacing.lg),
        _Actions(order: order),
      ],
    );
  }
}

class _ProcedureTile extends StatelessWidget {
  const _ProcedureTile({required this.record});

  final ProcedureRecord record;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final quantity = record.quantity;
    final price = record.unitPrice;
    return Card(
      child: ListTile(
        title: Text(record.title(l10n)),
        subtitle: Text(
          [
            if (quantity != null && price != null)
              '${AppFormat.decimal(quantity)} × ${AppFormat.cop(price)}',
            if (record.hasDiscount)
              l10n.serviceOrderDiscountOf(
                AppFormat.cop(record.discountAmount!),
              ),
          ].join(' · '),
        ),
        trailing: Text(AppFormat.cop(record.netTotal ?? record.total ?? 0)),
      ),
    );
  }
}

extension on ProcedureRecord {
  String title(AppLocalizations l10n) =>
      medicalServiceName ?? l10n.clinicalRecordTitle;
}

class _Totals extends StatelessWidget {
  const _Totals({required this.order});

  final ServiceOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final gross = order.totalAmount;
    final discount = order.totalDiscount;
    final net = order.netTotal;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(
          label: l10n.serviceOrderTotal,
          value: gross == null ? null : AppFormat.cop(gross),
        ),
        if ((discount ?? 0) > 0)
          InfoRow(
            label: l10n.serviceOrderDiscount,
            value: AppFormat.cop(discount!),
          ),
        InfoRow(
          label: l10n.serviceOrderNetTotal,
          value: net == null ? null : AppFormat.cop(net),
        ),
      ],
    );
  }
}

class _Actions extends ConsumerWidget {
  const _Actions({required this.order});

  final ServiceOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final busy = ref.watch(serviceOrderActionsProvider).isSubmitting;
    final canApprove =
        ref.watch(canApproveDiscountProvider) && order.hasPendingDiscount;
    final canManage = ref.watch(canManageBillingProvider);
    final number = order.orderNumber;

    Future<void> run({
      required String title,
      required String message,
      required String confirmLabel,
      required String doneMessage,
      required Future<bool> Function(ServiceOrderActions actions) action,
      bool destructive = false,
    }) async {
      final confirmed = await ConfirmDialog.show(
        context,
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        destructive: destructive,
      );
      if (!confirmed || !context.mounted) return;
      final done = await action(ref.read(serviceOrderActionsProvider.notifier));
      if (!context.mounted) return;
      _report(context, ref, done: done, doneMessage: doneMessage);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (canApprove)
          BojaniButton(
            label: l10n.serviceOrderApproveDiscount,
            icon: Icons.verified_outlined,
            isLoading: busy,
            onPressed: () => unawaited(
              run(
                title: l10n.serviceOrderApproveDiscount,
                message: l10n.serviceOrderApproveConfirm(
                  AppFormat.cop(order.totalDiscount ?? 0),
                  number,
                ),
                confirmLabel: l10n.serviceOrderApproveDiscount,
                doneMessage: l10n.serviceOrderApproved,
                action: (actions) => actions.approveDiscount(number),
              ),
            ),
          ),
        if (canManage && order.billingStatus == null) ...[
          const SizedBox(height: AppSpacing.sm),
          if (order.hasPendingDiscount)
            Text(l10n.serviceOrderBillBlocked)
          else
            BojaniButton(
              label: l10n.serviceOrderBill,
              icon: Icons.receipt_long_outlined,
              kind: BojaniButtonKind.secondary,
              isLoading: busy,
              onPressed: () => unawaited(
                run(
                  title: l10n.serviceOrderBill,
                  message: l10n.serviceOrderBillConfirm(number),
                  confirmLabel: l10n.serviceOrderBill,
                  doneMessage: l10n.serviceOrderBilled,
                  action: (actions) => actions.bill(number),
                ),
              ),
            ),
        ],
        if (canManage && order.canCancel) ...[
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.serviceOrderCancel,
            icon: Icons.block,
            kind: BojaniButtonKind.destructive,
            isLoading: busy,
            onPressed: () => unawaited(
              run(
                title: l10n.serviceOrderCancel,
                message: l10n.serviceOrderCancelConfirm(number),
                confirmLabel: l10n.serviceOrderCancel,
                doneMessage: l10n.serviceOrderCancelled,
                action: (actions) => actions.cancel(number),
                destructive: true,
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _report(
    BuildContext context,
    WidgetRef ref, {
    required bool done,
    required String doneMessage,
  }) {
    final l10n = AppLocalizations.of(context);
    if (done) {
      AppSnackbar.show(context, doneMessage);
      return;
    }
    final state = ref.read(serviceOrderActionsProvider);
    AppSnackbar.show(
      context,
      ApiErrorMessage.ofWrite(
        l10n,
        state.error,
        isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
        timeoutWarning: l10n.serviceOrderActionTimeout,
      ),
      kind: AppSnackbarKind.error,
      closeLabel: l10n.actionClose,
    );
  }
}
