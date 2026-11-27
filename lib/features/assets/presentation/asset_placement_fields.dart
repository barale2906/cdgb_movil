import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Ubicación, responsable y estado iniciales de un activo nuevo. El estado
/// vive en el formulario que lo contiene.
class AssetPlacementFields extends StatelessWidget {
  const AssetPlacementFields({
    required this.filters,
    required this.site,
    required this.place,
    required this.responsible,
    required this.status,
    required this.comment,
    required this.required,
    required this.onSite,
    required this.onPlace,
    required this.onResponsible,
    required this.onStatus,
    super.key,
  });

  final AssetFilters filters;
  final AssetSite? site;
  final AssetPlace? place;
  final NamedRef? responsible;
  final AssetStatus? status;
  final TextEditingController comment;
  final String? Function(Object?) required;
  final ValueChanged<AssetSite?> onSite;
  final ValueChanged<AssetPlace?> onPlace;
  final ValueChanged<NamedRef?> onResponsible;
  final ValueChanged<AssetStatus?> onStatus;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const gap = SizedBox(height: AppSpacing.md);
    return Column(
      children: [
        OptionDropdown<AssetSite>(
          label: l10n.assetFormSite,
          options: {for (final s in filters.sites) s: s.name},
          value: site,
          validator: required,
          onChanged: onSite,
        ),
        gap,
        OptionDropdown<AssetPlace>(
          label: l10n.assetFormPlace,
          options: {
            for (final p in site?.places ?? const <AssetPlace>[]) p: p.name,
          },
          value: place,
          validator: required,
          onChanged: onPlace,
        ),
        gap,
        OptionDropdown<NamedRef>(
          label: l10n.assetResponsible,
          nullLabel: l10n.assetFormKeepResponsible,
          options: {for (final u in filters.users) u: u.name},
          value: responsible,
          onChanged: onResponsible,
        ),
        gap,
        OptionDropdown<AssetStatus>(
          label: l10n.assetFormInitialStatus,
          nullLabel: l10n.assetFormInitialStatusDefault,
          options: {
            for (final option in filters.settableStatuses)
              if (AssetStatus.parse(option.value) != AssetStatus.unknown)
                AssetStatus.parse(option.value): assetStatusLabel(
                  l10n,
                  AssetStatus.parse(option.value),
                ),
          },
          value: status,
          onChanged: onStatus,
        ),
        gap,
        LabeledTextField(
          label: l10n.assetFormInitialComment,
          controller: comment,
          maxLines: 2,
        ),
      ],
    );
  }
}
