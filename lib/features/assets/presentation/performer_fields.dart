import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/maintenance_requests.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Quién realizará un mantenimiento: personal propio (un técnico) o un
/// proveedor. Con [required] falso se admite dejarlo por definir.
class PerformerFields extends StatelessWidget {
  const PerformerFields({
    required this.filters,
    required this.performer,
    required this.technician,
    required this.supplier,
    required this.onPerformer,
    required this.onTechnician,
    required this.onSupplier,
    super.key,
    this.required = false,
  });

  final AssetFilters filters;
  final Performer? performer;
  final NamedRef? technician;
  final NamedRef? supplier;
  final ValueChanged<Performer?> onPerformer;
  final ValueChanged<NamedRef?> onTechnician;
  final ValueChanged<NamedRef?> onSupplier;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        OptionDropdown<Performer>(
          label: l10n.maintenancePerformer,
          nullLabel: required ? null : l10n.maintenancePerformerUndefined,
          options: {
            Performer.internal: l10n.maintenanceInternal,
            Performer.external: l10n.maintenanceExternal,
          },
          value: performer,
          validator: (value) =>
              required && value == null ? l10n.validationRequired : null,
          onChanged: onPerformer,
        ),
        if (performer == Performer.internal) ...[
          const SizedBox(height: AppSpacing.md),
          OptionDropdown<NamedRef>(
            label: l10n.maintenanceTechnician,
            nullLabel: l10n.optionUnset,
            options: {for (final u in filters.users) u: u.name},
            value: technician,
            onChanged: onTechnician,
          ),
        ],
        if (performer == Performer.external) ...[
          const SizedBox(height: AppSpacing.md),
          OptionDropdown<NamedRef>(
            label: l10n.assetSupplier,
            nullLabel: l10n.optionUnset,
            options: {for (final s in filters.suppliers) s: s.name},
            value: supplier,
            onChanged: onSupplier,
          ),
        ],
      ],
    );
  }
}
