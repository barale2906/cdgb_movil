import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/features/assets/data/assets_repository.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Escanea la etiqueta (código de barras del `code` del activo) y abre su
/// ficha. Si no existe avisa y no cambia de pantalla.
Future<void> scanAndOpenAsset(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final code = await context.push<String>(Routes.scan);
  if (code == null || !context.mounted) return;
  try {
    final asset = await ref.read(assetsRepositoryProvider).byCode(code);
    if (!context.mounted) return;
    if (asset == null) {
      AppSnackbar.show(
        context,
        l10n.assetScanNotFound(code),
        kind: AppSnackbarKind.warning,
      );
      return;
    }
    await context.push('/assets/${asset.id}');
  } on ApiException catch (error) {
    if (!context.mounted) return;
    AppSnackbar.show(
      context,
      ApiErrorMessage.of(
        l10n,
        error,
        isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
      ),
      kind: AppSnackbarKind.error,
      closeLabel: l10n.actionClose,
    );
  }
}
