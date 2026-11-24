import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/features/inventory/application/movement_controller.dart';
import 'package:sga_bojanini/features/inventory/application/movement_permissions.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/features/inventory/presentation/product_line_fields.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Ajuste, devolución, baja por vencimiento y pérdida: operaciones de una
/// sola línea que se aplican de inmediato (sin firma).
class SingleMovementPage extends ConsumerStatefulWidget {
  const SingleMovementPage({required this.kind, super.key});

  final MovementKind kind;

  @override
  ConsumerState<SingleMovementPage> createState() => _SingleMovementPageState();
}

class _SingleMovementPageState extends ConsumerState<SingleMovementPage> {
  final _lineKey = GlobalKey<ProductLineFieldsState>();
  final _reasonKey = GlobalKey<FormFieldState<String>>();
  final _reason = TextEditingController();
  final _notes = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    _notes.dispose();
    super.dispose();
  }

  bool get _reasonRequired =>
      widget.kind == MovementKind.adjustment ||
      widget.kind == MovementKind.loss;

  ProductLineConfig _config(int warehouseId) => switch (widget.kind) {
    MovementKind.adjustment => ProductLineConfig(
      needsVariant: true,
      locationWarehouseId: warehouseId,
      locationRequired: true,
      batchMode: BatchMode.optional,
      batchWarehouseId: warehouseId,
      quantityMode: QuantityMode.nonZero,
    ),
    MovementKind.returnStock => ProductLineConfig(
      needsVariant: true,
      locationWarehouseId: warehouseId,
      batchMode: BatchMode.optional,
      batchWarehouseId: warehouseId,
    ),
    MovementKind.writeOff => ProductLineConfig(
      locationWarehouseId: warehouseId,
      batchMode: BatchMode.required,
      batchWarehouseId: warehouseId,
      quantityMode: QuantityMode.none,
    ),
    _ => ProductLineConfig(
      needsVariant: true,
      locationWarehouseId: warehouseId,
      locationRequired: true,
      batchMode: BatchMode.required,
      batchWarehouseId: warehouseId,
    ),
  };

  Future<void> _submit(int warehouseId) async {
    final l10n = AppLocalizations.of(context);
    final reasonValid = _reasonKey.currentState?.validate() ?? true;
    final line = _lineKey.currentState?.validate();
    if (line == null || !reasonValid) return;

    final reason = _reason.text.trim();
    final notes = _notes.text.trim().isEmpty ? null : _notes.text.trim();
    final controller = ref.read(movementControllerProvider.notifier);
    final result = switch (widget.kind) {
      MovementKind.adjustment => await controller.adjustment(
        AdjustmentRequest(
          productVariantId: line.variantId!,
          warehouseId: warehouseId,
          locationId: line.locationId!,
          batchId: line.batchId,
          quantity: line.quantity!,
          reason: reason,
          notes: notes,
        ),
      ),
      MovementKind.returnStock => await controller.returnStock(
        ReturnRequest(
          productVariantId: line.variantId!,
          warehouseId: warehouseId,
          locationId: line.locationId,
          batchId: line.batchId,
          quantity: line.quantity!,
          reason: reason.isEmpty ? null : reason,
          notes: notes,
        ),
      ),
      MovementKind.writeOff => await controller.writeOff(
        WriteOffRequest(
          batchId: line.batchId!,
          warehouseId: warehouseId,
          locationId: line.locationId,
          reason: reason.isEmpty ? null : reason,
          notes: notes,
        ),
      ),
      _ => await controller.loss(
        LossRequest(
          productVariantId: line.variantId!,
          warehouseId: warehouseId,
          locationId: line.locationId!,
          batchId: line.batchId!,
          quantity: line.quantity!,
          reason: reason,
          notes: notes,
        ),
      ),
    };
    if (result == null || !mounted) return;
    AppSnackbar.show(context, l10n.movementRegistered);
    context.pop();
  }

  String _title(AppLocalizations l10n) => switch (widget.kind) {
    MovementKind.adjustment => l10n.movementAdjustment,
    MovementKind.returnStock => l10n.movementReturn,
    MovementKind.writeOff => l10n.movementWriteOff,
    _ => l10n.movementLoss,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final warehouse = ref.watch(activeWarehouseProvider);
    final warehouseId = warehouse?.id;

    return MovementFormShell(
      title: _title(l10n),
      submission: ref.watch(movementControllerProvider),
      onSubmit: () {
        if (warehouseId != null) unawaited(_submit(warehouseId));
      },
      children: [
        InputDecorator(
          decoration: InputDecoration(labelText: l10n.fieldWarehouse),
          child: Text(warehouse?.name ?? l10n.warehouseNone),
        ),
        const SizedBox(height: AppSpacing.md),
        if (warehouseId != null)
          ProductLineFields(
            // Cambiar de tipo reconstruye los campos con su configuración.
            key: _lineKey,
            config: _config(warehouseId),
          ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          key: _reasonKey,
          controller: _reason,
          decoration: InputDecoration(
            labelText: _reasonRequired
                ? l10n.fieldReason
                : l10n.fieldReasonOptional,
          ),
          validator: (value) => _reasonRequired && (value ?? '').trim().isEmpty
              ? l10n.validationRequired
              : null,
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _notes,
          decoration: InputDecoration(labelText: l10n.fieldNotes),
        ),
      ],
    );
  }
}
