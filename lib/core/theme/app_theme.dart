import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/app_typography.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';

/// Tema claro de la app (Material 3) construido solo con tokens.
abstract final class AppTheme {
  static final _controlShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadius.control),
  );
  static const _buttonMinSize = Size(64, AppSizes.minTouchTarget);
  static final Color _errorText = StatusColors.light.error.text;

  static ThemeData light() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      // Sobre amarillo, siempre texto oscuro (guía §2.5).
      onPrimary: AppColors.dark,
      primaryContainer: AppColors.primary20,
      onPrimaryContainer: AppColors.dark,
      secondary: AppColors.dark,
      onSecondary: AppColors.onDark,
      tertiary: AppColors.accent,
      onTertiary: AppColors.onDark,
      error: Color(0xFFC53030),
      onError: AppColors.onDark,
      surface: AppColors.surface,
      onSurface: AppColors.textStrong,
      onSurfaceVariant: AppColors.textSecondary,
      surfaceContainerLowest: AppColors.surface,
      surfaceContainerLow: AppColors.background,
      surfaceContainer: AppColors.background,
      surfaceContainerHigh: AppColors.surfaceAlt,
      surfaceContainerHighest: AppColors.surfaceAlt,
      outline: AppColors.borderStrong,
      outlineVariant: AppColors.border,
      shadow: AppColors.black,
      scrim: AppColors.black,
      inverseSurface: AppColors.dark,
      onInverseSurface: AppColors.onDark,
      inversePrimary: AppColors.primary,
    );
    final textTheme = AppTypography.textTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: AppTypography.family,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.background,
      extensions: const [StatusColors.light],
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textStrong,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: AppSizes.appBarHeight,
        titleTextStyle: textTheme.titleMedium,
        shape: const Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.dark,
          disabledBackgroundColor: AppColors.surfaceAlt,
          disabledForegroundColor: AppColors.textDisabled,
          minimumSize: _buttonMinSize,
          shape: _controlShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.dark,
          minimumSize: _buttonMinSize,
          shape: _controlShape,
          side: const BorderSide(color: AppColors.borderStrong),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          minimumSize: _buttonMinSize,
          shape: _controlShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: _inputBorder(AppColors.borderStrong),
        enabledBorder: _inputBorder(AppColors.borderStrong),
        focusedBorder: _inputBorder(
          AppColors.dark,
          width: AppSizes.focusBorderWidth,
        ),
        errorBorder: _inputBorder(_errorText),
        focusedErrorBorder: _inputBorder(
          _errorText,
          width: AppSizes.focusBorderWidth,
        ),
        disabledBorder: _inputBorder(AppColors.border),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textDisabled,
        ),
        helperStyle: textTheme.bodySmall,
        errorStyle: textTheme.bodySmall?.copyWith(color: _errorText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        barrierColor: const Color(0x66000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.dialog),
        ),
        titleTextStyle: textTheme.titleMedium,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.dialog),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.primary,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.dark
                : AppColors.textSecondary,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? AppColors.dark
                : AppColors.textSecondary,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceAlt,
        labelStyle: textTheme.labelSmall,
        side: BorderSide.none,
        shape: const StadiumBorder(),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.dark,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.onDark,
        ),
        behavior: SnackBarBehavior.floating,
        shape: _controlShape,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: AppSizes.borderWidth,
        space: AppSizes.borderWidth,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: AppSizes.icon,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.dark,
      ),
    );
  }

  static OutlineInputBorder _inputBorder(
    Color color, {
    double width = AppSizes.borderWidth,
  }) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.control),
    borderSide: BorderSide(color: color, width: width),
  );
}
