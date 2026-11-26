import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/purchasing/application/order_actions.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_workflow.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Recepción de una orden de gasto: cantidad recibida por línea (admite
/// decimales). Las líneas sin cantidad se omiten.
class ReceiveExpensePage extends ConsumerWidget {
  const ReceiveExpensePage({required this.orderId, super.key});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final order = ref.watch(expenseOrderDetailProvider(orderId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.orderReceiveTitle)),
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
                data: (data) => _ReceiveForm(order: data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiveForm extends ConsumerStatefulWidget {
  const _ReceiveForm({required this.order});

  final ExpenseOrder order;

  @override
  ConsumerState<_ReceiveForm> createState() => _ReceiveFormState();
}

class _ReceiveFormState extends ConsumerState<_ReceiveForm> {
  final _formKey = GlobalKey<FormState>();
  late final Map<int, TextEditingController> _quantities = {
    for (final item in _pending) item.id: TextEditingController(),
  };

  List<ExpenseItem> get _pending =>
      widget.order.items.where((item) => item.pendingQuantity > 0).toList();

  @override
  void dispose() {
    for (final controller in _quantities.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final lines = [
      for (final entry in _quantities.entries)
        if ((AppFormat.parseDecimal(entry.value.text) ?? 0) > 0)
          ExpenseReceiveLine(
            itemId: entry.key,
            quantity: AppFormat.parseDecimal(entry.value.text)!,
          ).toJson(),
    ];
    if (lines.isEmpty) {
      showOrderResult(
        context,
        ref,
        done: false,
        successMessage: '',
        error: null,
        message: l10n.orderReceiveNothing,
      );
      return;
    }
    final done = await ref
        .read(expenseOrderActionsProvider.notifier)
        .receive(widget.order.id, lines);
    if (!mounted) return;
    showOrderResult(
      context,
      ref,
      done: done,
      successMessage: l10n.orderReceived,
      error: ref.read(expenseOrderActionsProvider).error,
    );
    if (done) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submitting = ref.watch(expenseOrderActionsProvider).isSubmitting;
    if (_pending.isEmpty) {
      return Center(child: Text(l10n.orderNothingPending));
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                for (final item in _pending)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.description,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            l10n.orderPendingQuantity(
                              AppFormat.decimal(
                                item.pendingQuantity,
                                maxDecimals: 3,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          TextFormField(
                            controller: _quantities[item.id],
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]'),
                              ),
                            ],
                            decoration: InputDecoration(
                              labelText: l10n.fieldQuantityReceived,
                            ),
                            validator: (value) {
                              if ((value ?? '').trim().isEmpty) return null;
                              final number = AppFormat.parseDecimal(value);
                              if (number == null || number <= 0) {
                                return l10n.validationPositive;
                              }
                              return number > item.pendingQuantity
                                  ? l10n.orderQuantityExceedsPending
                                  : null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.orderReceiveConfirm,
              isLoading: submitting,
              onPressed: () => unawaited(_submit()),
            ),
          ),
        ],
      ),
    );
  }
}
