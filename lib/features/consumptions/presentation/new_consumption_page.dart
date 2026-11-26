import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/catalog/cost_center_providers.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/consumptions/application/consumptions_providers.dart';
import 'package:sga_bojanini/features/consumptions/application/new_consumption_controller.dart';
import 'package:sga_bojanini/features/consumptions/presentation/consumption_paths.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Registrar el consumo de insumos de un procedimiento.
class NewConsumptionPage extends ConsumerStatefulWidget {
  const NewConsumptionPage({super.key});

  @override
  ConsumerState<NewConsumptionPage> createState() => _NewConsumptionPageState();
}

class _NewConsumptionPageState extends ConsumerState<NewConsumptionPage> {
  final _formKey = GlobalKey<FormState>();
  bool _attempted = false;

  Future<void> _addProduct() async {
    final product = await context.push<GenericProduct>(
      ConsumptionPaths.product,
    );
    if (product != null) {
      ref.read(newConsumptionProvider.notifier).addLine(product);
    }
  }

  Future<void> _submit() async {
    setState(() => _attempted = true);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid || ref.read(newConsumptionProvider).lines.isEmpty) return;
    final done = await ref.read(newConsumptionProvider.notifier).submit();
    if (!mounted || !done) return;
    ref.invalidate(consumptionListProvider);
    AppSnackbar.show(context, AppLocalizations.of(context).consumptionSaved);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(newConsumptionProvider);
    final notifier = ref.read(newConsumptionProvider.notifier);
    final warehouses = ref.watch(warehousesProvider);
    final costCenters = ref.watch(costCenterListProvider(''));
    final canWrite = ref.watch(canWriteProvider);
    final enabled = !state.isSubmitting;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.consumptionFormTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    AsyncOptionDropdown<int>(
                      label: l10n.consumptionWarehouse,
                      options: warehouses.whenData(
                        (items) => [for (final w in items) w.id],
                      ),
                      labelOf: (id) =>
                          warehouses.value
                              ?.where((w) => w.id == id)
                              .map((w) => w.name)
                              .firstOrNull ??
                          '$id',
                      value: state.warehouseId,
                      onChanged: notifier.setWarehouse,
                      onRetry: () => ref.invalidate(warehousesProvider),
                      validator: (id) =>
                          id == null ? l10n.validationRequired : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AsyncOptionDropdown<int>(
                      label: l10n.consumptionCostCenter,
                      options: costCenters.whenData(
                        (items) => [for (final c in items) c.id],
                      ),
                      labelOf: (id) =>
                          costCenters.value
                              ?.where((c) => c.id == id)
                              .map((c) => c.name)
                              .firstOrNull ??
                          '$id',
                      value: state.costCenterId,
                      onChanged: notifier.setCostCenter,
                      onRetry: () => ref.invalidate(costCenterListProvider('')),
                      validator: (id) =>
                          id == null ? l10n.validationRequired : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BojaniTextField(
                      label: l10n.consumptionServiceField,
                      enabled: enabled,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setServiceType,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BojaniTextField(
                      label: l10n.consumptionAppointmentField,
                      enabled: enabled,
                      textInputAction: TextInputAction.next,
                      onChanged: notifier.setAppointment,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    BojaniTextField(
                      label: l10n.consumptionPatientField,
                      enabled: enabled,
                      helperText: l10n.consumptionSyncNote,
                      onChanged: notifier.setPatient,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.consumptionItemsTitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final line in state.lines)
                      _LineRow(
                        key: ValueKey(line.key),
                        line: line,
                        enabled: enabled,
                      ),
                    if (_attempted && state.lines.isEmpty)
                      Text(
                        l10n.consumptionItemsRequired,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    BojaniButton(
                      label: l10n.serviceOrderAddSupply,
                      icon: Icons.add,
                      kind: BojaniButtonKind.secondary,
                      onPressed: enabled
                          ? () => unawaited(_addProduct())
                          : null,
                    ),
                    if (state.error != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      _SubmitError(error: state.error!),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: BojaniButton(
                label: l10n.consumptionSubmit,
                isLoading: state.isSubmitting,
                onPressed: canWrite && !state.isUnconfirmed
                    ? () => unawaited(_submit())
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LineRow extends ConsumerStatefulWidget {
  const _LineRow({required this.line, required this.enabled, super.key});

  final ConsumptionLine line;
  final bool enabled;

  @override
  ConsumerState<_LineRow> createState() => _LineRowState();
}

class _LineRowState extends ConsumerState<_LineRow> {
  late final TextEditingController _quantity = TextEditingController(
    text: widget.line.quantity?.toString() ?? '',
  );

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(newConsumptionProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Text(widget.line.product.name),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: BojaniTextField(
              label: l10n.consumptionQuantity,
              controller: _quantity,
              enabled: widget.enabled,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) => (int.tryParse(value ?? '') ?? 0) >= 1
                  ? null
                  : l10n.validationPositive,
              onChanged: (value) =>
                  notifier.setQuantity(widget.line.key, int.tryParse(value)),
            ),
          ),
          IconButton(
            tooltip: l10n.removeItem,
            constraints: const BoxConstraints(
              minWidth: AppSizes.minTouchTarget,
              minHeight: AppSizes.minTouchTarget,
            ),
            icon: const Icon(Icons.delete_outline),
            onPressed: widget.enabled
                ? () => notifier.removeLine(widget.line.key)
                : null,
          ),
        ],
      ),
    );
  }
}

class _SubmitError extends ConsumerWidget {
  const _SubmitError({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final unconfirmed = ref.watch(
      newConsumptionProvider.select((s) => s.isUnconfirmed),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AlertBanner(
          message: ApiErrorMessage.ofWrite(
            l10n,
            ref.watch(newConsumptionProvider).error,
            isProd: isProd,
            timeoutWarning: l10n.consumptionUnconfirmed,
          ),
          kind: StatusKind.error,
          icon: Icons.error_outline,
        ),
        if (unconfirmed)
          BojaniButton(
            label: l10n.consumptionNotSaved,
            kind: BojaniButtonKind.tertiary,
            onPressed: ref
                .read(newConsumptionProvider.notifier)
                .acknowledgeNotSaved,
          ),
      ],
    );
  }
}
