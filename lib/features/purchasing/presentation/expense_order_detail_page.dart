import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/purchasing/application/order_actions.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/presentation/expense_dialogs.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_widgets.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_workflow.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Orden de gasto: datos, líneas, totales, flujo, factura y pagos.
class ExpenseOrderDetailPage extends ConsumerWidget {
  const ExpenseOrderDetailPage({required this.orderId, super.key});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final order = ref.watch(expenseOrderDetailProvider(orderId));
    return Scaffold(
      appBar: AppBar(title: Text(order.value?.code ?? l10n.orderDetailTitle)),
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
                      ref.invalidate(expenseOrderDetailProvider(orderId)),
                ),
                data: (data) => RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(expenseOrderDetailProvider(orderId).future),
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

  final ExpenseOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final permissions = ref.watch(permissionServiceProvider);
    final busy = ref.watch(expenseOrderActionsProvider).isSubmitting;

    Future<void> run(Future<bool> done, String message) async {
      final ok = await done;
      if (!context.mounted) return;
      showOrderResult(
        context,
        ref,
        done: ok,
        successMessage: message,
        error: ref.read(expenseOrderActionsProvider).error,
      );
    }

    final actions = ref.read(expenseOrderActionsProvider.notifier);
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                order.supplier?.name ?? order.code,
                style: textTheme.titleMedium,
              ),
            ),
            OrderStatusChip(status: order.status),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        PaymentStatusChip(status: order.paymentStatus),
        const SizedBox(height: AppSpacing.md),
        InfoRow(
          label: l10n.orderExpectedDate,
          value: order.expectedDeliveryDate == null
              ? null
              : AppFormat.date(order.expectedDeliveryDate!),
        ),
        InfoRow(
          label: l10n.orderCreatedAt,
          value: order.createdAt == null
              ? null
              : AppFormat.dateTime(order.createdAt),
        ),
        InfoRow(label: l10n.orderNotes, value: order.notes),
        InfoRow(label: l10n.fieldInvoiceNumber, value: order.invoiceNumber),
        InfoRow(
          label: l10n.fieldInvoiceDate,
          value: order.invoiceDate == null
              ? null
              : AppFormat.date(order.invoiceDate!),
        ),
        InfoRow(
          label: l10n.expenseAccountingSentAt,
          value: order.accountingSentAt == null
              ? null
              : AppFormat.dateTime(order.accountingSentAt),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.orderLines, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        for (final item in order.items) _ItemCard(item: item),
        const SizedBox(height: AppSpacing.sm),
        OrderTotals(
          subtotal: order.subtotal,
          tax: order.taxAmount,
          total: order.totalAmount,
        ),
        const SizedBox(height: AppSpacing.md),
        _PaymentsSection(order: order),
        const SizedBox(height: AppSpacing.lg),
        OrderWorkflowButtons(
          orderId: order.id,
          status: order.status,
          permissionPrefix: 'ordenes_gasto',
          actions: expenseOrderActionsProvider,
          onReceive: () =>
              context.push('/purchasing/expenses/${order.id}/receive'),
        ),
        if (permissions.can('ordenes_gasto.pagos') && order.balance > 0)
          BojaniButton(
            label: l10n.expenseAddPayment,
            icon: Icons.payments_outlined,
            kind: BojaniButtonKind.secondary,
            onPressed: busy
                ? null
                : () => unawaited(() async {
                    final request = await askPayment(context, order.balance);
                    if (request == null) return;
                    await run(
                      actions.addPayment(order.id, request),
                      l10n.expensePaymentSaved,
                    );
                  }()),
          ),
        if (permissions.can('ordenes_gasto.factura')) ...[
          const SizedBox(height: AppSpacing.sm),
          BojaniButton(
            label: l10n.expenseRegisterInvoice,
            icon: Icons.receipt_long_outlined,
            kind: BojaniButtonKind.secondary,
            onPressed: busy
                ? null
                : () => unawaited(() async {
                    final invoice = await askInvoice(context);
                    if (invoice == null) return;
                    await run(
                      actions.registerInvoice(
                        order.id,
                        invoiceNumber: invoice.number,
                        invoiceDate: invoice.date,
                      ),
                      l10n.expenseInvoiceSaved,
                    );
                  }()),
          ),
          if (order.hasInvoice) ...[
            const SizedBox(height: AppSpacing.sm),
            BojaniButton(
              label: l10n.expenseSendAccounting,
              icon: Icons.forward_to_inbox_outlined,
              kind: BojaniButtonKind.secondary,
              onPressed: busy
                  ? null
                  : () => unawaited(() async {
                      final recipients = await askAccountingRecipients(context);
                      if (recipients == null) return;
                      await run(
                        actions.sendToAccounting(order.id, recipients),
                        l10n.expenseAccountingSent,
                      );
                    }()),
            ),
          ],
        ],
      ],
    );
  }
}

class _PaymentsSection extends ConsumerWidget {
  const _PaymentsSection({required this.order});

  final ExpenseOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final canDelete = ref
        .watch(permissionServiceProvider)
        .can('ordenes_gasto.pagos');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.expensePayments, style: textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                _AmountRow(l10n.expensePaid, order.amountPaid),
                _AmountRow(l10n.expenseBalance, order.balance),
              ],
            ),
          ),
        ),
        if (order.payments.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(l10n.expensePaymentsEmpty),
          ),
        for (final payment in order.payments)
          Card(
            child: ListTile(
              title: Text(money(payment.amount)),
              subtitle: Text(
                [
                  paymentMethodLabel(l10n, payment.paymentMethod),
                  if (payment.paymentDate != null)
                    AppFormat.date(payment.paymentDate!),
                  if ((payment.reference ?? '').isNotEmpty) payment.reference!,
                  if (payment.registeredBy != null) payment.registeredBy!.name,
                ].join(' · '),
              ),
              trailing: canDelete
                  ? IconButton(
                      tooltip: l10n.expenseDeletePayment,
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () =>
                          unawaited(_delete(context, ref, payment.id)),
                    )
                  : null,
            ),
          ),
      ],
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, int id) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.expenseDeletePayment,
      message: l10n.expenseDeletePaymentBody,
      confirmLabel: l10n.expenseDeletePayment,
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await ref
        .read(expenseOrderActionsProvider.notifier)
        .deletePayment(order.id, id);
    if (!context.mounted) return;
    showOrderResult(
      context,
      ref,
      done: done,
      successMessage: l10n.expensePaymentDeleted,
      error: ref.read(expenseOrderActionsProvider).error,
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow(this.label, this.value);

  final String label;
  final double? value;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Text(label), Text(money(value))],
  );
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item});

  final ExpenseItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detail = [
      if ((item.unit ?? '').isNotEmpty) item.unit!,
      l10n.orderQuantities(
        AppFormat.decimal(item.quantityRequested ?? 0, maxDecimals: 3),
        AppFormat.decimal(item.quantityReceived ?? 0, maxDecimals: 3),
      ),
      l10n.orderUnitPrice(money(item.unitPrice)),
    ].join(' · ');
    return Card(
      child: ListTile(
        title: Text(item.description),
        subtitle: Text(detail),
        trailing: Text(money(item.totalPrice)),
      ),
    );
  }
}
