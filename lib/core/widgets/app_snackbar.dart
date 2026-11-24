import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';

enum AppSnackbarKind { success, warning, error }

/// Avisos breves. Los de error persisten hasta que el usuario los cierre.
abstract final class AppSnackbar {
  static void show(
    BuildContext context,
    String message, {
    AppSnackbarKind kind = AppSnackbarKind.success,
    String? closeLabel,
  }) {
    final colors = context.statusColors;
    final background = switch (kind) {
      AppSnackbarKind.success => AppColors.dark,
      AppSnackbarKind.warning => colors.warning.icon,
      AppSnackbarKind.error => colors.error.text,
    };
    final persistent = kind == AppSnackbarKind.error;
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: background,
          duration: persistent
              ? const Duration(days: 1)
              : AppDurations.snackbar,
          action: persistent && closeLabel != null
              ? SnackBarAction(
                  label: closeLabel,
                  textColor: AppColors.onDark,
                  onPressed: messenger.hideCurrentSnackBar,
                )
              : null,
        ),
      );
  }
}
