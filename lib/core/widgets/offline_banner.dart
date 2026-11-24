import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/connectivity/connectivity_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Aviso "sin conexión"; no ocupa espacio mientras hay red.
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final online = ref.watch(isOnlineProvider).value ?? true;
    if (online) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: AlertBanner(
        message: AppLocalizations.of(context).offlineBanner,
        kind: StatusKind.warning,
        icon: Icons.cloud_off_outlined,
      ),
    );
  }
}

/// ¿Se pueden enviar escrituras? Las pantallas deshabilitan sus acciones
/// de guardado cuando es `false` (escrituras siempre online).
final canWriteProvider = Provider<bool>(
  (ref) => ref.watch(isOnlineProvider).value ?? true,
);
