import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';

/// Marca PROVISIONAL (círculo amarillo con "SGA"), igual a la del web.
/// No hay logo oficial (decisión H): cuando exista, se reemplaza solo aquí y
/// en assets/brand/. Ninguna pantalla debe dibujar la marca por su cuenta.
class AppBrandMark extends StatelessWidget {
  const AppBrandMark({
    super.key,
    this.size = AppBrandMarkSize.medium,
    this.showName = false,
    this.onDark = false,
  });

  final AppBrandMarkSize size;

  /// Muestra "SGA Bojanini" junto al círculo.
  final bool showName;

  /// Usa texto claro para el nombre (fondos oscuros).
  final bool onDark;

  static const semanticLabel = 'SGA Bojanini';

  @override
  Widget build(BuildContext context) {
    final diameter = size.diameter;
    final circle = Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: AppShadows.brand,
      ),
      child: Text(
        'SGA',
        style: TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.w700,
          fontSize: diameter * 0.32,
          height: 1,
        ),
      ),
    );

    return Semantics(
      label: semanticLabel,
      image: true,
      child: ExcludeSemantics(
        child: showName
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  circle,
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    semanticLabel,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: onDark ? AppColors.onDark : AppColors.textStrong,
                    ),
                  ),
                ],
              )
            : circle,
      ),
    );
  }
}

enum AppBrandMarkSize {
  small(32),
  medium(48),
  large(96)
  ;

  const AppBrandMarkSize(this.diameter);

  final double diameter;
}
