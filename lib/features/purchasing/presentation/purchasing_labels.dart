import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

String orderStatusLabel(AppLocalizations l10n, OrderStatus status) =>
    switch (status) {
      OrderStatus.draft => l10n.orderStatusDraft,
      OrderStatus.pendingApproval => l10n.orderStatusPendingApproval,
      OrderStatus.approved => l10n.orderStatusApproved,
      OrderStatus.rejected => l10n.orderStatusRejected,
      OrderStatus.sent => l10n.orderStatusSent,
      OrderStatus.partiallyReceived => l10n.orderStatusPartiallyReceived,
      OrderStatus.received => l10n.orderStatusReceived,
      OrderStatus.cancelled => l10n.orderStatusCancelled,
      OrderStatus.unknown => l10n.statusUnknown,
    };

StatusKind orderStatusKind(OrderStatus status) => switch (status) {
  OrderStatus.approved || OrderStatus.received => StatusKind.success,
  OrderStatus.pendingApproval ||
  OrderStatus.partiallyReceived => StatusKind.warning,
  OrderStatus.rejected || OrderStatus.cancelled => StatusKind.error,
  OrderStatus.sent => StatusKind.info,
  OrderStatus.draft || OrderStatus.unknown => StatusKind.special,
};

IconData orderStatusIcon(OrderStatus status) => switch (status) {
  OrderStatus.approved || OrderStatus.received => Icons.check_circle_outline,
  OrderStatus.pendingApproval => Icons.hourglass_empty,
  OrderStatus.partiallyReceived => Icons.inventory_2_outlined,
  OrderStatus.rejected || OrderStatus.cancelled => Icons.block,
  OrderStatus.sent => Icons.send_outlined,
  OrderStatus.draft || OrderStatus.unknown => Icons.edit_outlined,
};

String paymentStatusLabel(AppLocalizations l10n, PaymentStatus status) =>
    switch (status) {
      PaymentStatus.unpaid => l10n.paymentUnpaid,
      PaymentStatus.partial => l10n.paymentPartial,
      PaymentStatus.paid => l10n.paymentPaid,
      PaymentStatus.unknown => l10n.statusUnknown,
    };

StatusKind paymentStatusKind(PaymentStatus status) => switch (status) {
  PaymentStatus.paid => StatusKind.success,
  PaymentStatus.partial => StatusKind.warning,
  PaymentStatus.unpaid => StatusKind.error,
  PaymentStatus.unknown => StatusKind.special,
};

String paymentMethodLabel(AppLocalizations l10n, String? method) =>
    switch (PaymentMethod.parse(method)) {
      PaymentMethod.cash => l10n.paymentMethodCash,
      PaymentMethod.transfer => l10n.paymentMethodTransfer,
      PaymentMethod.check => l10n.paymentMethodCheck,
      PaymentMethod.other => l10n.paymentMethodOther,
    };

/// Importe en pesos; vacío si el servidor no lo envió.
String money(num? value) => value == null ? '' : AppFormat.cop(value);

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({required this.status, super.key});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) => StatusChip(
    label: orderStatusLabel(AppLocalizations.of(context), status),
    kind: orderStatusKind(status),
    icon: orderStatusIcon(status),
  );
}

class PaymentStatusChip extends StatelessWidget {
  const PaymentStatusChip({required this.status, super.key});

  final PaymentStatus status;

  @override
  Widget build(BuildContext context) => StatusChip(
    label: paymentStatusLabel(AppLocalizations.of(context), status),
    kind: paymentStatusKind(status),
  );
}
