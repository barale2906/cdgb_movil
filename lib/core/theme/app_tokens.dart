import 'package:flutter/material.dart';

/// Tokens de diseño — única fuente de colores, medidas y tiempos.
/// Valores tomados de la guía de marca (front/docs/app.md); ver
/// docs/plan/03-sistema-de-diseno.md. Prohibido hardcodearlos en pantallas.
abstract final class AppColors {
  // Marca
  static const primary = Color(0xFFFFCF01);
  static const primary80 = Color(0xFFFFD934);
  static const primary60 = Color(0xFFFFE267);
  static const primary40 = Color(0xFFFFEC99);
  static const primary20 = Color(0xFFFFF5CC);
  static const accent = Color(0xFFC02F86);
  static const accent60 = Color(0xFFD982B6);
  static const accent20 = Color(0xFFF2D5E7);
  static const dark = Color(0xFF1E2A3B);
  static const dark2 = Color(0xFF2D3E54);
  static const black = Color(0xFF000000);

  // Neutros (nombrados por rol)
  static const textStrong = Color(0xFF1A202C);
  static const text = Color(0xFF2D3748);
  static const textSecondary = Color(0xFF4A5568);
  static const textMuted = Color(0xFF718096);
  static const textDisabled = Color(0xFFA0AEC0);
  static const borderStrong = Color(0xFFCBD5E0);
  static const border = Color(0xFFE2E8F0);
  static const surfaceAlt = Color(0xFFEDF2F7);
  static const background = Color(0xFFF7FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const onDark = Color(0xFFFFFFFF);
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

abstract final class AppRadius {
  static const double code = 4;
  static const double control = 8;
  static const double dialog = 12;
  static const double sheet = 16;
  static const double pill = 9999;
}

abstract final class AppSizes {
  /// Altura táctil mínima (guía §6.1 y §7).
  static const double minTouchTarget = 48;
  static const double appBarHeight = 56;
  static const double icon = 24;
  static const double iconCompact = 18;
  static const double emptyStateIcon = 48;
  static const double borderWidth = 1;
  static const double focusBorderWidth = 2;

  /// Ancho máximo de la tarjeta de login (guía §6.9).
  static const double loginCardMaxWidth = 420;
}

abstract final class AppShadows {
  static const xs = [
    BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 2),
  ];
  static const sm = [
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 1), blurRadius: 3),
  ];
  static const md = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
  ];
  static const lg = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
  ];
  static const xl = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
  ];
  static const brand = [
    BoxShadow(color: Color(0x66FFCF01), offset: Offset(0, 4), blurRadius: 15),
  ];
}

abstract final class AppDurations {
  static const fast = Duration(milliseconds: 150);
  static const standard = Duration(milliseconds: 200);
  static const panel = Duration(milliseconds: 300);
  static const pulse = Duration(milliseconds: 1500);
  static const snackbar = Duration(seconds: 4);
  static const Curve curve = Curves.easeInOut;
}

abstract final class AppGradients {
  /// Fondo oscuro de login y splash (135°).
  static const dark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.dark, AppColors.dark2, AppColors.dark],
  );
}
