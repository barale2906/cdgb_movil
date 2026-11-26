import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/catalog/product_repository.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Acción rápida "Escanear": abre la cámara y, con el código leído, abre el
/// detalle del producto. Si no existe avisa y no cambia de pantalla.
Future<void> scanAndOpenProduct(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final code = await context.push<String>(Routes.scan);
  if (code == null || !context.mounted) return;
  try {
    final product = await ref.read(productRepositoryProvider).byBarcode(code);
    if (context.mounted) {
      unawaited(context.push('/catalog/products/${product.id}'));
    }
  } on NotFoundException {
    if (context.mounted) {
      AppSnackbar.show(
        context,
        l10n.scanNotFound(code),
        kind: AppSnackbarKind.warning,
      );
    }
  } on ApiException catch (error) {
    if (context.mounted) {
      AppSnackbar.show(
        context,
        error.message.isEmpty ? l10n.errorGeneric : error.message,
        kind: AppSnackbarKind.error,
        closeLabel: l10n.actionClose,
      );
    }
  }
}
