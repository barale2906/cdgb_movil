import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/catalog/supplier.dart';
import 'package:sga_bojanini/core/catalog/supplier_providers.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/purchasing/application/draft_state.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Proveedores que se pueden elegir según el tipo de orden.
enum SupplierUse {
  /// Órdenes de gasto: tipo `expense` o `both`.
  expense,

  /// Órdenes de compra de inventario: cualquiera menos solo-gasto.
  purchase
  ;

  bool accepts(Supplier supplier) => switch (this) {
    SupplierUse.expense =>
      supplier.supplierType == 'expense' || supplier.supplierType == 'both',
    SupplierUse.purchase => supplier.supplierType != 'expense',
  };
}

/// Selector de proveedor del borrador.
class SupplierDropdown extends ConsumerWidget {
  const SupplierDropdown({
    required this.use,
    required this.value,
    required this.onChanged,
    super.key,
    this.enabled = true,
  });

  final SupplierUse use;
  final int? value;
  final ValueChanged<int?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final suppliers = ref.watch(supplierSearchProvider(''));
    return IgnorePointer(
      ignoring: !enabled,
      child: AsyncOptionDropdown<int>(
        label: l10n.draftSupplier,
        options: suppliers.whenData(
          (items) => [
            for (final supplier in items)
              if (use.accepts(supplier)) supplier.id,
          ],
        ),
        labelOf: (id) =>
            suppliers.value
                ?.where((s) => s.id == id)
                .map((s) => s.name)
                .firstOrNull ??
            '$id',
        value: value,
        onChanged: onChanged,
        onRetry: () => ref.invalidate(supplierSearchProvider('')),
        validator: (id) => id == null ? l10n.draftSupplierRequired : null,
      ),
    );
  }
}

/// Fecha esperada de entrega (opcional, desde hoy).
class DraftDateField extends StatelessWidget {
  const DraftDateField({
    required this.value,
    required this.onChanged,
    super.key,
    this.enabled = true,
  });

  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    return IgnorePointer(
      ignoring: !enabled,
      child: DateField(
        label: l10n.draftExpectedDate,
        value: value,
        firstDate: DateTime(now.year, now.month, now.day),
        onChanged: onChanged,
      ),
    );
  }
}

/// Estructura de los formularios de borrador: aviso sin conexión, contenido
/// con scroll, error del envío y el botón de guardar anclado abajo.
class DraftScaffold extends ConsumerWidget {
  const DraftScaffold({
    required this.title,
    required this.children,
    required this.submission,
    required this.canWrite,
    required this.onSave,
    required this.onAcknowledge,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final DraftSubmission submission;
  final bool canWrite;
  final VoidCallback onSave;
  final VoidCallback onAcknowledge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final error = submission.error;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  ...children,
                  if (error != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    AlertBanner(
                      message: ApiErrorMessage.ofWrite(
                        l10n,
                        error,
                        isProd: isProd,
                        timeoutWarning: l10n.draftTimeout,
                      ),
                      kind: StatusKind.error,
                      icon: Icons.error_outline,
                    ),
                    if (submission.isUnconfirmed)
                      BojaniButton(
                        label: l10n.draftNotSaved,
                        kind: BojaniButtonKind.tertiary,
                        onPressed: onAcknowledge,
                      ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: BojaniButton(
                label: l10n.draftSave,
                isLoading: submission.isSubmitting,
                onPressed: canWrite && !submission.isUnconfirmed
                    ? () => unawaited(Future.sync(onSave))
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
