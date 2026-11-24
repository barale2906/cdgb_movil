import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';

enum StatusKind { success, error, warning, info, special }

/// Chip de estado. El estado nunca depende solo del color: siempre lleva
/// texto (y opcionalmente icono). El rosa de marca no es un estado.
class StatusChip extends StatelessWidget {
  const StatusChip({
    required this.label,
    required this.kind,
    super.key,
    this.icon,
  });

  final String label;
  final StatusKind kind;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.statusColors;
    final palette = switch (kind) {
      StatusKind.success => colors.success,
      StatusKind.error => colors.error,
      StatusKind.warning => colors.warning,
      StatusKind.info => colors.info,
      StatusKind.special => colors.special,
    };
    final style = Theme.of(
      context,
    ).textTheme.labelSmall?.copyWith(color: palette.chipText);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.chip,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm + AppSpacing.xs,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: AppSizes.iconCompact - 4,
                color: palette.chipText,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Flexible(child: Text(label.toUpperCase(), style: style)),
          ],
        ),
      ),
    );
  }
}
