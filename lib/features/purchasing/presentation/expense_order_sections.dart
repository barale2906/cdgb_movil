import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/features/purchasing/application/order_actions.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_workflow.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

class ExpensePaymentsSection extends ConsumerWidget {
  const ExpensePaymentsSection({required this.order, super.key});

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
                ExpenseAmountRow(l10n.expensePaid, order.amountPaid),
                ExpenseAmountRow(l10n.expenseBalance, order.balance),
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

class ExpenseAmountRow extends StatelessWidget {
  const ExpenseAmountRow(this.label, this.value, {super.key});

  final String label;
  final double? value;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Text(label), Text(money(value))],
  );
}

class ExpenseItemCard extends StatelessWidget {
  const ExpenseItemCard({required this.item, super.key});

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
