import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';

/// Contador rosa de la marca sobre un icono (notificaciones sin leer).
/// El rosa no es un color de estado: solo indica "hay algo pendiente".
class NotificationBadge extends StatelessWidget {
  const NotificationBadge({
    required this.count,
    required this.child,
    super.key,
  });

  final int count;
  final Widget child;

  static const maxShown = 99;
  static const _size = 18.0;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return child;
    final text = count > maxShown ? '$maxShown+' : '$count';
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -AppSpacing.xs,
          top: -AppSpacing.xs,
          child: ExcludeSemantics(
            child: Container(
              constraints: const BoxConstraints(
                minWidth: _size,
                minHeight: _size,
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.onDark,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
