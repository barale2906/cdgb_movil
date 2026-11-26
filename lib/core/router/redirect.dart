import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';

abstract final class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const locked = '/locked';
  static const profile = '/profile';
  static const changePassword = '/profile/password';
  static const about = '/about';
  static const home = '/home';
  static const scan = '/scan';
}

/// Guarda de rutas (sin I/O, para poder probarla). Devuelve la ruta a la que
/// hay que ir, o `null` para dejar pasar.
///
/// Control por permiso: además del menú del backend, cada sección exige su
/// permiso de entrada (`AppSection.permission`).
String? resolveRedirect({
  required SessionState session,
  required PermissionService permissions,
  required String location,
}) {
  String? goTo(String target) => location == target ? null : target;

  return switch (session) {
    SessionRestoring() || SessionRestoreFailed() => goTo(Routes.splash),
    SessionUnauthenticated() => goTo(Routes.login),
    SessionAuthenticated(locked: true) => goTo(Routes.locked),
    SessionAuthenticated() => _authenticatedRedirect(location, permissions),
  };
}

String? _authenticatedRedirect(String location, PermissionService permissions) {
  const authScreens = {Routes.splash, Routes.login, Routes.locked};
  if (authScreens.contains(location)) return Routes.home;

  final section = AppSection.fromLocation(location);
  if (section != null &&
      section != AppSection.dashboard &&
      !permissions.can(section.permission)) {
    return Routes.home;
  }
  return null;
}
