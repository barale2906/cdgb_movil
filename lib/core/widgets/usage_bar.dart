import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Barra de ocupación. El nivel nunca depende solo del color: se muestra el
/// porcentaje y una etiqueta (Disponible / Moderado / Casi lleno).
class UsageBar extends StatelessWidget {
  const UsageBar({
    required this.label,
    required this.detail,
    required this.percent,
    super.key,
  });

  /// Magnitud medida (p. ej. "Volumen").
  final String label;

  /// Texto de valores (p. ej. "500 de 2.000 L").
  final String detail;

  /// 0–100; `null` si el espacio no tiene límite definido.
  final double? percent;

  static const moderateFrom = 70.0;
  static const highFrom = 90.0;
  static const _barHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final pct = percent;
    final palette = _palette(context, pct);
    final levelText = pct == null ? null : _levelLabel(l10n, pct);
    final valueText = pct == null ? null : AppFormat.percent(pct);

    return Semantics(
      container: true,
      label:
          '$label. $detail${valueText == null ? '' : '. $valueText'}'
          '${levelText == null ? '' : '. $levelText'}',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(label, style: textTheme.labelMedium)),
                if (valueText != null)
                  Text(
                    '$valueText · $levelText',
                    style: textTheme.labelMedium?.copyWith(
                      color: palette?.text,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: pct == null ? 0 : (pct / 100).clamp(0, 1),
                minHeight: _barHeight,
                backgroundColor: AppColors.surfaceAlt,
                color: palette?.icon ?? AppColors.textDisabled,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(detail, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  StatusPalette? _palette(BuildContext context, double? pct) {
    if (pct == null) return null;
    final colors = context.statusColors;
    if (pct >= highFrom) return colors.error;
    return pct >= moderateFrom ? colors.warning : colors.success;
  }

  String _levelLabel(AppLocalizations l10n, double pct) {
    if (pct >= highFrom) return l10n.capacityLevelHigh;
    return pct >= moderateFrom
        ? l10n.capacityLevelMedium
        : l10n.capacityLevelLow;
  }
}
