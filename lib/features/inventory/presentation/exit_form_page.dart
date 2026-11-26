import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/inventory/application/lookup_providers.dart';
import 'package:sga_bojanini/features/inventory/application/movement_controller.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/features/inventory/presentation/product_line_fields.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

const _costCentersPermission = 'centros_costo.ver';

class _ExitDraft {
  const _ExitDraft(this.item, this.name, this.summary);

  final ExitItem item;
  final String name;
  final String summary;
}

/// Salida de stock a un centro de costo (y paciente si es externo). Las
/// salidas a paciente se confirman solas; las demás quedan pendientes de firma.
class ExitFormPage extends ConsumerStatefulWidget {
  const ExitFormPage({super.key});

  @override
  ConsumerState<ExitFormPage> createState() => _ExitFormPageState();
}

class _ExitFormPageState extends ConsumerState<ExitFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _patient = TextEditingController();
  final _reason = TextEditingController();
  final _drafts = <_ExitDraft>[];
  CostCenterRef? _costCenter;
  bool _itemsError = false;

  @override
  void dispose() {
    _patient.dispose();
    _reason.dispose();
    super.dispose();
  }

  Future<void> _addItem(int warehouseId) async {
    final draft = await showModalBottomSheet<_ExitDraft>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _ExitItemSheet(warehouseId: warehouseId),
    );
    if (draft != null) {
      setState(() {
        _drafts.add(draft);
        _itemsError = false;
      });
    }
  }

  Future<void> _submit(int warehouseId) async {
    final l10n = AppLocalizations.of(context);
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() => _itemsError = _drafts.isEmpty);
    if (!valid || _drafts.isEmpty) return;
    final patient = _patient.text.trim();
    final document = await ref
        .read(movementControllerProvider.notifier)
        .exit(
          ExitRequest(
            warehouseId: warehouseId,
            costCenterId: _costCenter!.id,
            patientDocument: _costCenter!.isExternal && patient.isNotEmpty
                ? patient
                : null,
            reason: _reason.text.trim().isEmpty ? null : _reason.text.trim(),
            items: [for (final draft in _drafts) draft.item],
          ),
        );
    if (document == null || !mounted) return;
    AppSnackbar.show(
      context,
      document.isPending
          ? '${l10n.movementRegisteredDoc(document.documentNumber)} '
                '${l10n.movementPendingSignNote}'
          : l10n.movementRegisteredDoc(document.documentNumber),
    );
    if (document.isPending) {
      context.pushReplacement('/inventory/documents/${document.id}');
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final warehouse = ref.watch(activeWarehouseProvider);
    final canListCostCenters = ref
        .watch(permissionServiceProvider)
        .can(_costCentersPermission);
    final warehouseId = warehouse?.id;

    return MovementFormShell(
      title: l10n.movementExit,
      submission: ref.watch(movementControllerProvider),
      onSubmit: () {
        if (warehouseId != null) unawaited(_submit(warehouseId));
      },
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputDecorator(
                decoration: InputDecoration(labelText: l10n.fieldWarehouse),
                child: Text(warehouse?.name ?? l10n.warehouseNone),
              ),
              const SizedBox(height: AppSpacing.md),
              if (!canListCostCenters)
                Text(l10n.movementNeedsCostCenters)
              else
                AsyncOptionDropdown<CostCenterRef>(
                  label: l10n.fieldCostCenter,
                  options: ref.watch(costCentersProvider),
                  labelOf: (c) =>
                      c.code == null ? c.name : '${c.code} · ${c.name}',
                  value: _costCenter,
                  onRetry: () => ref.invalidate(costCentersProvider),
                  onChanged: (value) => setState(() => _costCenter = value),
                  validator: (value) =>
                      value == null ? l10n.validationRequired : null,
                ),
              if (_costCenter?.isExternal ?? false) ...[
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _patient,
                  decoration: InputDecoration(
                    labelText: l10n.fieldPatientDocument,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _reason,
                decoration: InputDecoration(
                  labelText: l10n.fieldReasonOptional,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        LinesHeader(
          enabled: warehouseId != null,
          errorText: _itemsError ? l10n.itemsRequired : null,
          onAdd: () => unawaited(_addItem(warehouseId!)),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final (index, draft) in _drafts.indexed)
          LineDraftCard(
            title: draft.name,
            subtitle: draft.summary,
            onRemove: () => setState(() => _drafts.removeAt(index)),
          ),
      ],
    );
  }
}

class _ExitItemSheet extends StatefulWidget {
  const _ExitItemSheet({required this.warehouseId});

  final int warehouseId;

  @override
  State<_ExitItemSheet> createState() => _ExitItemSheetState();
}

class _ExitItemSheetState extends State<_ExitItemSheet> {
  final _key = GlobalKey<ProductLineFieldsState>();

  void _add() {
    final value = _key.currentState?.validate();
    if (value == null) return;
    Navigator.of(context).pop(
      _ExitDraft(
        ExitItem(
          genericProductId: value.product.id,
          quantity: value.quantity!,
          batchId: value.batchId,
        ),
        value.product.name,
        value.summary(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return LineSheet(
      title: l10n.addItem,
      onAdd: _add,
      child: ProductLineFields(
        key: _key,
        config: ProductLineConfig(
          batchMode: BatchMode.optional,
          batchWarehouseId: widget.warehouseId,
          batchAvailableForExit: true,
        ),
      ),
    );
  }
}
