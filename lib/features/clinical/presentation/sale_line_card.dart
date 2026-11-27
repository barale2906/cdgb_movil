import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/clinical/application/sale_controller.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Un servicio de la venta: cantidad y valor editables mientras no esté
/// registrado, con su estado frente al servidor.
class SaleLineCard extends ConsumerStatefulWidget {
  const SaleLineCard({required this.line, super.key});

  final SaleLine line;

  @override
  ConsumerState<SaleLineCard> createState() => _SaleLineCardState();
}

class _SaleLineCardState extends ConsumerState<SaleLineCard> {
  late final TextEditingController _quantity = TextEditingController(
    text: widget.line.quantity?.toString() ?? '',
  );
  late final TextEditingController _price = TextEditingController(
    text: AppFormat.plain(widget.line.unitPrice),
  );

  @override
  void dispose() {
    _quantity.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final line = widget.line;
    final notifier = ref.read(saleProvider.notifier);
    final busy = ref.watch(saleProvider.select((s) => s.isSubmitting));
    final editable = line.isEditable && !busy;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(line.procedure.name, style: textTheme.titleSmall),
                      Text(line.procedure.code, style: textTheme.bodySmall),
                    ],
                  ),
                ),
                if (line.status == SaleLineStatus.draft && !busy)
                  IconButton(
                    tooltip: l10n.removeItem,
                    constraints: const BoxConstraints(
                      minWidth: AppSizes.minTouchTarget,
                      minHeight: AppSizes.minTouchTarget,
                    ),
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => notifier.removeLine(line.key),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BojaniTextField(
                    label: l10n.saleQuantity,
                    controller: _quantity,
                    enabled: editable,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => (int.tryParse(value ?? '') ?? 0) >= 1
                        ? null
                        : l10n.validationPositive,
                    onChanged: (value) =>
                        notifier.setQuantity(line.key, int.tryParse(value)),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: BojaniTextField(
                    label: l10n.saleUnitPrice,
                    controller: _price,
                    enabled: editable,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => double.tryParse(value ?? '') == null
                        ? l10n.validationRequired
                        : null,
                    onChanged: (value) =>
                        notifier.setUnitPrice(line.key, double.tryParse(value)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(AppFormat.cop(line.subtotal), style: textTheme.titleSmall),
            _Status(line: line),
          ],
        ),
      ),
    );
  }
}

class _Status extends ConsumerWidget {
  const _Status({required this.line});

  final SaleLine line;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final error = line.error;
    final message = error == null
        ? null
        : ApiErrorMessage.of(l10n, error, isProd: isProd);
    return switch (line.status) {
      SaleLineStatus.draft => const SizedBox.shrink(),
      SaleLineStatus.saved => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        child: StatusChip(
          label: l10n.saleLineSaved,
          kind: StatusKind.success,
          icon: Icons.check_circle_outline,
        ),
      ),
      SaleLineStatus.failed => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusChip(
              label: l10n.saleLineFailed,
              kind: StatusKind.error,
              icon: Icons.error_outline,
            ),
            if (message != null) Text(message),
          ],
        ),
      ),
      SaleLineStatus.unconfirmed => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusChip(
              label: l10n.saleLineUnconfirmed,
              kind: StatusKind.warning,
              icon: Icons.help_outline,
            ),
            Text(l10n.saleLineUnconfirmedHelp),
            BojaniButton(
              label: l10n.saleLineNotRegistered,
              kind: BojaniButtonKind.tertiary,
              expand: false,
              onPressed: () =>
                  ref.read(saleProvider.notifier).markAsNotRegistered(line.key),
            ),
          ],
        ),
      ),
    };
  }
}
