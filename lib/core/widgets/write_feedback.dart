import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Aviso de una escritura que falló: explica qué pasó y, tras un tiempo de
/// espera agotado, pide revisar antes de repetir (la API no es idempotente).
void showWriteError(
  BuildContext context,
  WidgetRef ref, {
  required ApiException? error,
  required String timeoutWarning,
}) {
  final l10n = AppLocalizations.of(context);
  AppSnackbar.show(
    context,
    ApiErrorMessage.ofWrite(
      l10n,
      error,
      isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
      timeoutWarning: timeoutWarning,
    ),
    kind: AppSnackbarKind.error,
    closeLabel: l10n.actionClose,
  );
}
