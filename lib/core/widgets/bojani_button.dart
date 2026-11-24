import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';

enum BojaniButtonKind { primary, secondary, tertiary, destructive }

/// Botón de la app. Una sola acción principal (amarilla) por pantalla.
/// Con [isLoading] se bloquea y muestra progreso sin cambiar su ancho, lo que
/// evita envíos dobles (la API no tiene idempotencia).
class BojaniButton extends StatelessWidget {
  const BojaniButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.kind = BojaniButtonKind.primary,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final BojaniButtonKind kind;
  final IconData? icon;
  final bool isLoading;

  /// Ocupa todo el ancho disponible (formularios).
  final bool expand;

  static const _spinnerSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final handler = enabled ? onPressed : null;
    final content = _Content(
      label: label,
      icon: icon,
      isLoading: isLoading,
      spinnerColor: _spinnerColor(context),
    );

    final button = switch (kind) {
      BojaniButtonKind.primary => FilledButton(
        onPressed: handler,
        child: content,
      ),
      BojaniButtonKind.secondary => OutlinedButton(
        onPressed: handler,
        child: content,
      ),
      BojaniButtonKind.tertiary => TextButton(
        onPressed: handler,
        child: content,
      ),
      BojaniButtonKind.destructive => FilledButton(
        onPressed: handler,
        style: FilledButton.styleFrom(
          backgroundColor: context.statusColors.error.text,
          foregroundColor: AppColors.onDark,
        ),
        child: content,
      ),
    };

    return Semantics(
      button: true,
      enabled: enabled,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }

  Color _spinnerColor(BuildContext context) => switch (kind) {
    BojaniButtonKind.destructive => AppColors.onDark,
    _ => AppColors.dark,
  };
}

class _Content extends StatelessWidget {
  const _Content({
    required this.label,
    required this.icon,
    required this.isLoading,
    required this.spinnerColor,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final Color spinnerColor;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: AppSizes.iconCompact),
          const SizedBox(width: AppSpacing.sm),
        ],
        Flexible(child: Text(label, textAlign: TextAlign.center)),
      ],
    );
    if (!isLoading) return row;

    // El texto se conserva (invisible) para que el botón no cambie de ancho.
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: 0, child: row),
        SizedBox(
          width: BojaniButton._spinnerSize,
          height: BojaniButton._spinnerSize,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: spinnerColor,
            semanticsLabel: label,
          ),
        ),
      ],
    );
  }
}
