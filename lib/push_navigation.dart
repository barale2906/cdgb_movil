import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/app_router.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/push/device_registrar.dart';
import 'package:sga_bojanini/core/push/push_gateway.dart';
import 'package:sga_bojanini/features/notifications/application/notification_target.dart';
import 'package:sga_bojanini/features/notifications/application/notifications_providers.dart';

/// Conecta los avisos push con la app: al tocar uno abre la sección que
/// corresponde, con la app abierta actualiza el contador y registra los
/// tokens que renueva el servicio de push.
///
/// Vive en la raíz (como `app_router.dart`) porque une `core/` con
/// notificaciones sin que una feature importe de otra. Si el aviso llega con
/// la sesión bloqueada o sin iniciar, el destino espera al desbloqueo.
final Provider<void> pushNavigationProvider = Provider<void>((ref) {
  final gateway = ref.watch(pushGatewayProvider);
  String? pendingPath;

  bool canNavigate() {
    final session = ref.read(sessionControllerProvider);
    return session is SessionAuthenticated && !session.locked;
  }

  void openPending() {
    final path = pendingPath;
    if (path == null || !canNavigate()) return;
    pendingPath = null;
    ref.read(routerProvider).go(path);
  }

  void onOpened(PushMessage message) {
    pendingPath = notificationTargetForType(message.type) ?? pendingPath;
    openPending();
  }

  ref.listen(sessionControllerProvider, (_, _) => openPending());

  final subscriptions = [
    gateway.onOpened.listen(onOpened),
    gateway.onForegroundMessage.listen(
      (_) => ref.invalidate(unreadCountProvider),
    ),
    gateway.onTokenRefresh.listen((token) {
      if (ref.read(sessionControllerProvider) is SessionAuthenticated) {
        unawaited(ref.read(deviceRegistrarProvider).registerToken(token));
      }
    }),
  ];
  ref.onDispose(() {
    for (final subscription in subscriptions) {
      unawaited(subscription.cancel());
    }
  });

  unawaited(
    gateway.initialMessage().then((message) {
      if (message != null) onOpened(message);
    }),
  );
});
