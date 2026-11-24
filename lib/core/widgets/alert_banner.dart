import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';

/// Aviso en línea (sin conexión, sesión terminada, actualización…).
class AlertBanner extends StatelessWidget {
  const AlertBanner({
    required this.message,
    required this.kind,
    super.key,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final StatusKind kind;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

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
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      container: true,
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.background,
          border: Border.all(color: palette.border),
          borderRadius: BorderRadius.circular(AppRadius.control),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(icon ?? Icons.info_outline, color: palette.icon),
              const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
              Expanded(
                child: Text(
                  message,
                  style: textTheme.bodyMedium?.copyWith(color: palette.text),
                ),
              ),
              if (actionLabel != null && onAction != null)
                TextButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ),
        ),
      ),
    );
  }
}
