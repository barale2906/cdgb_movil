import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Estados que se ofrecen como filtro de los listados de órdenes.
const List<OrderStatus> _filterStatuses = [
  OrderStatus.pendingApproval,
  OrderStatus.approved,
  OrderStatus.sent,
  OrderStatus.partiallyReceived,
  OrderStatus.received,
  OrderStatus.cancelled,
];

class OrderStatusFilterBar extends StatelessWidget {
  const OrderStatusFilterBar({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final OrderStatus? selected;
  final ValueChanged<OrderStatus?> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ChoiceFilterBar<OrderStatus?>(
      options: {
        null: l10n.filterAll,
        for (final status in _filterStatuses)
          status: orderStatusLabel(l10n, status),
      },
      selected: selected,
      onSelected: onSelected,
    );
  }
}

/// Tarjeta de una orden en los listados: código, proveedor, total y estado.
class OrderTile extends StatelessWidget {
  const OrderTile({
    required this.code,
    required this.supplier,
    required this.total,
    required this.status,
    required this.onTap,
    super.key,
    this.date,
    this.trailing,
  });

  final String code;
  final String? supplier;
  final double? total;
  final OrderStatus status;
  final String? date;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.dialog),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(code, style: textTheme.titleSmall),
                    if ((supplier ?? '').isNotEmpty) Text(supplier!),
                    if (date != null) Text(AppFormat.date(date!)),
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        OrderStatusChip(status: status),
                        ?trailing,
                      ],
                    ),
                  ],
                ),
              ),
              Text(money(total), style: textTheme.titleSmall),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// Subtotal, impuestos y total de una orden.
class OrderTotals extends StatelessWidget {
  const OrderTotals({
    required this.subtotal,
    required this.tax,
    required this.total,
    super.key,
  });

  final double? subtotal;
  final double? tax;
  final double? total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    Widget row(String label, double? value, {bool strong = false}) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: strong ? textTheme.titleSmall : null),
        Text(
          money(value),
          style: strong ? textTheme.titleSmall : textTheme.bodyMedium,
        ),
      ],
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            row(l10n.orderSubtotal, subtotal),
            row(l10n.orderTax, tax),
            const Divider(),
            row(l10n.orderTotal, total, strong: true),
          ],
        ),
      ),
    );
  }
}
