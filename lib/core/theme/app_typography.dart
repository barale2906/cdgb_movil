import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';

/// Escala tipográfica (guía §3.1) con Montserrat (decisión E).
abstract final class AppTypography {
  static const family = 'Montserrat';
  static const monoFamilyFallback = ['monospace'];

  static TextTheme textTheme() => const TextTheme(
    // Título de pantalla: 24 / Bold
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.textStrong,
      height: 1.25,
    ),
    // Título de sección o tarjeta: 18–20 / SemiBold
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.textStrong,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textStrong,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textStrong,
    ),
    // Cuerpo: 16 / interlineado 1,5
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.text, height: 1.5),
    // Cuerpo denso (listas)
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.text, height: 1.45),
    // Ayudas y metadatos
    bodySmall: TextStyle(fontSize: 12, color: AppColors.textMuted),
    // Botones: 14 / SemiBold
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    // Etiquetas
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    // Chips y badges: 11–12 / Bold
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.33,
    ),
  );

  /// Subtítulo de marca: MAYÚSCULAS, tracking +0,08 em.
  static const brandSubtitle = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.96,
    color: AppColors.textMuted,
  );

  /// Códigos, SKU, lotes y números de comprobante.
  static const code = TextStyle(
    fontFamily: 'monospace',
    fontFamilyFallback: monoFamilyFallback,
    fontSize: 13,
    color: AppColors.text,
  );
}
