import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/purchasing/application/expense_draft_controller.dart';
import 'package:sga_bojanini/features/purchasing/application/orders_providers.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/presentation/draft_widgets.dart';
import 'package:sga_bojanini/features/purchasing/presentation/expense_line_card.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Edita el borrador de gasto [orderId]: carga la orden y abre el formulario.
class ExpenseDraftEditPage extends ConsumerWidget {
  const ExpenseDraftEditPage({required this.orderId, super.key});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(expenseOrderDetailProvider(orderId));
    return order.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            OfflineBanner(),
            Expanded(child: SkeletonList()),
          ],
        ),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(
          error: error,
          onRetry: () => ref.invalidate(expenseOrderDetailProvider(orderId)),
        ),
      ),
      data: (data) => ExpenseDraftPage(order: data),
    );
  }
}

/// Borrador de una orden de gasto: proveedor habilitado para gastos y
/// conceptos libres (descripción, unidad, cantidad, valor e IVA).
class ExpenseDraftPage extends ConsumerStatefulWidget {
  const ExpenseDraftPage({super.key, this.order});

  static const newPath = '/purchasing/expenses/new';

  /// Borrador que se edita; `null` para uno nuevo.
  final ExpenseOrder? order;

  @override
  ConsumerState<ExpenseDraftPage> createState() => _ExpenseDraftPageState();
}

class _ExpenseDraftPageState extends ConsumerState<ExpenseDraftPage> {
  final _formKey = GlobalKey<FormState>();
  late final _notes = TextEditingController(text: widget.order?.notes ?? '');

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final id = await ref
        .read(expenseDraftProvider(widget.order).notifier)
        .submit();
    if (id == null || !mounted) return;
    AppSnackbar.show(context, AppLocalizations.of(context).draftSaved);
    if (widget.order == null) {
      context.pushReplacement('/purchasing/expenses/$id');
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = expenseDraftProvider(widget.order);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final busy = state.submission.isSubmitting;
    return Form(
      key: _formKey,
      child: DraftScaffold(
        title: widget.order == null
            ? l10n.draftExpenseTitle
            : l10n.draftExpenseEditTitle,
        submission: state.submission,
        canWrite: ref.watch(canWriteProvider),
        onSave: () => unawaited(_save()),
        onAcknowledge: notifier.acknowledgeNotSaved,
        children: [
          SupplierDropdown(
            use: SupplierUse.expense,
            value: state.supplierId,
            enabled: !busy,
            onChanged: notifier.setSupplier,
          ),
          const SizedBox(height: AppSpacing.md),
          DraftDateField(
            value: state.expectedDate,
            enabled: !busy,
            onChanged: notifier.setExpectedDate,
          ),
          const SizedBox(height: AppSpacing.md),
          BojaniTextField(
            label: l10n.draftNotes,
            controller: _notes,
            enabled: !busy,
            onChanged: notifier.setNotes,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.draftItems,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final line in state.lines) ...[
            ExpenseLineCard(
              key: ValueKey(line.key),
              line: line,
              enabled: !busy,
              provider: provider,
              canRemove: state.lines.length > 1,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          BojaniButton(
            label: l10n.draftAddExpenseLine,
            icon: Icons.add,
            kind: BojaniButtonKind.secondary,
            onPressed: busy ? null : notifier.addLine,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.draftTotal(AppFormat.cop(state.total)),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
