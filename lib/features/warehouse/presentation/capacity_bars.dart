import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/usage_bar.dart';
import 'package:sga_bojanini/features/warehouse/data/warehouse_capacity.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Barras de volumen y peso de un almacén, zona o ubicación.
class CapacityBars extends StatelessWidget {
  const CapacityBars({
    required this.volume,
    required this.weight,
    super.key,
  });

  final VolumeUsage volume;
  final WeightUsage weight;

  /// Los volúmenes llegan en cm³; se muestran en litros (1 L = 1.000 cm³).
  static const _cm3PerLiter = 1000;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        UsageBar(
          label: l10n.capacityVolume,
          detail: _detail(
            l10n,
            used: volume.usedCm3 / _cm3PerLiter,
            max: volume.maxCm3 == null ? null : volume.maxCm3! / _cm3PerLiter,
            unit: l10n.unitLiters,
          ),
          percent: volume.usagePct,
        ),
        const SizedBox(height: 12),
        UsageBar(
          label: l10n.capacityWeight,
          detail: _detail(
            l10n,
            used: weight.usedKg,
            max: weight.maxKg,
            unit: l10n.unitKg,
          ),
          percent: weight.usagePct,
        ),
      ],
    );
  }

  String _detail(
    AppLocalizations l10n, {
    required double used,
    required double? max,
    required String unit,
  }) => max == null
      ? l10n.capacityUsedOnly(AppFormat.decimal(used), unit)
      : l10n.capacityUsedOfMax(
          AppFormat.decimal(used),
          AppFormat.decimal(max),
          unit,
        );
}
