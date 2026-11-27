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

  /// Escala de texto a partir de la cual la acción pasa debajo del mensaje.
  static const _stackScale = 1.3;

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
    // Con texto muy grande el botón no cabe al lado del mensaje: va debajo.
    final stacked = MediaQuery.textScalerOf(context).scale(1) > _stackScale;
    final text = Text(
      message,
      style: textTheme.bodyMedium?.copyWith(color: palette.text),
    );
    final action = actionLabel != null && onAction != null
        ? TextButton(onPressed: onAction, child: Text(actionLabel!))
        : null;

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
            crossAxisAlignment: stacked
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Icon(icon ?? Icons.info_outline, color: palette.icon),
              const SizedBox(width: AppSpacing.sm + AppSpacing.xs),
              Expanded(
                child: stacked
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [text, ?action],
                      )
                    : text,
              ),
              if (!stacked) ?action,
            ],
          ),
        ),
      ),
    );
  }
}
