import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/theme/app_theme.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/app_typography.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';

double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final hi = la > lb ? la : lb;
  final lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

void main() {
  final theme = AppTheme.light();

  group('AppTheme.light', () {
    test('usa Material 3, Montserrat y los colores de marca', () {
      expect(theme.useMaterial3, isTrue);
      expect(theme.textTheme.bodyLarge?.fontFamily, AppTypography.family);
      expect(theme.colorScheme.primary, AppColors.primary);
      expect(theme.colorScheme.tertiary, AppColors.accent);
      expect(theme.scaffoldBackgroundColor, AppColors.background);
    });

    test('sobre amarillo el texto es oscuro y cumple contraste AA', () {
      expect(theme.colorScheme.onPrimary, AppColors.dark);
      expect(
        _contrast(theme.colorScheme.primary, theme.colorScheme.onPrimary),
        greaterThanOrEqualTo(4.5),
      );
    });

    test(
      'blanco sobre amarillo no cumple contraste (prohibido por la guía)',
      () {
        expect(_contrast(AppColors.primary, AppColors.onDark), lessThan(3));
      },
    );

    test('registra los colores de estado y el rosa no es un estado', () {
      final status = theme.extension<StatusColors>();
      expect(status, isNotNull);
      final icons = [
        status!.success.icon,
        status.error.icon,
        status.warning.icon,
        status.info.icon,
        status.special.icon,
      ];
      expect(icons, isNot(contains(AppColors.accent)));
    });

    test('los botones tienen altura táctil mínima', () {
      final style = theme.filledButtonTheme.style!;
      final size = style.minimumSize!.resolve({});
      expect(size!.height, greaterThanOrEqualTo(AppSizes.minTouchTarget));
    });

    test('textos de estado cumplen contraste AA en fondo suave y chip', () {
      const s = StatusColors.light;
      final palettes = {
        'éxito': s.success,
        'error': s.error,
        'advertencia': s.warning,
        'información': s.info,
        'especial': s.special,
      };
      for (final MapEntry(key: name, value: p) in palettes.entries) {
        expect(
          _contrast(p.text, p.background),
          greaterThanOrEqualTo(4.5),
          reason: '$name: texto sobre fondo suave',
        );
        expect(
          _contrast(p.chipText, p.chip),
          greaterThanOrEqualTo(4.5),
          reason: '$name: texto sobre chip',
        );
      }
    });
  });

  group('StatusColors', () {
    test('lerp en t=0 y t=1 devuelve los extremos', () {
      const a = StatusColors.light;
      final b = a.copyWith(success: a.error);
      expect(a.lerp(b, 0).success.icon, a.success.icon);
      expect(a.lerp(b, 1).success.icon, a.error.icon);
    });

    test('lerp con otro tipo devuelve la misma instancia', () {
      expect(StatusColors.light.lerp(null, 0.5), same(StatusColors.light));
    });
  });
}
