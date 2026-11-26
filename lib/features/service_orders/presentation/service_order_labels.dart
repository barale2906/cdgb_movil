import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Estado de la orden según sus descuentos (nunca solo por color).
class ServiceOrderStatusChip extends StatelessWidget {
  const ServiceOrderStatusChip({required this.status, super.key});

  final ServiceOrderStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (status) {
      ServiceOrderStatus.approved => StatusChip(
        label: l10n.serviceOrderStatusApproved,
        kind: StatusKind.success,
        icon: Icons.check_circle_outline,
      ),
      ServiceOrderStatus.discountPending => StatusChip(
        label: l10n.serviceOrderStatusDiscountPending,
        kind: StatusKind.warning,
        icon: Icons.hourglass_empty,
      ),
      ServiceOrderStatus.unknown => const SizedBox.shrink(),
    };
  }
}
