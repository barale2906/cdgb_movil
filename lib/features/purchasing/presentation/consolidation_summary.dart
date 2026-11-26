import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/features/purchasing/presentation/order_widgets.dart';
import 'package:sga_bojanini/features/purchasing/presentation/purchasing_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Líneas agrupadas y totales de una consolidación (vista previa o creada).
class ConsolidationSummary extends StatelessWidget {
  const ConsolidationSummary({
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
    super.key,
  });

  final List<ConsolidatedItem> items;
  final double? subtotal;
  final double? tax;
  final double? total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.orderLines, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        for (final item in items)
          Card(
            child: ListTile(
              title: Text(
                item.variant?.generic?.name ??
                    item.variant?.labBrand ??
                    l10n.notAvailable,
              ),
              subtitle: Text(
                [
                  if (item.presentation != null) item.presentation!.name,
                  l10n.orderQuantity(AppFormat.decimal(item.quantity ?? 0)),
                  l10n.orderUnitPrice(money(item.unitPrice)),
                  if (item.sourceOrderCodes.isNotEmpty)
                    item.sourceOrderCodes.join(', '),
                ].join(' · '),
              ),
              trailing: Text(money(item.totalPrice)),
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        OrderTotals(subtotal: subtotal, tax: tax, total: total),
      ],
    );
  }
}
