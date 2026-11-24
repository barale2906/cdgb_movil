import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/config/server_override.dart';
import 'package:sga_bojanini/core/utils/preferences.dart';

final serverOverrideProvider = Provider<ServerOverride>(
  (ref) => ServerOverride(ref.watch(sharedPreferencesProvider)),
);

/// Guarda (o quita, con `null`) el servidor alternativo y cierra la sesión:
/// el token pertenece al servidor anterior. Quien llama reinicia la app.
Future<void> changeServer(WidgetRef ref, Uri? url) async {
  final override = ref.read(serverOverrideProvider);
  if (url == null) {
    await override.clear();
  } else {
    await override.save(url);
  }
  await ref.read(sessionControllerProvider.notifier).logout();
}
