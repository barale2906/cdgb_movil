import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/router/redirect.dart';

/// Redirección que exige un permiso concreto además del de la sección
/// (cada ruta y acción valida el suyo, CLAUDE.md §5).
GoRouterRedirect requires(Ref ref, String permission) =>
    (context, state) => ref.read(permissionServiceProvider).can(permission)
    ? null
    : Routes.home;

/// Como [requires], exigiendo todos los permisos.
GoRouterRedirect requiresAll(Ref ref, List<String> permissions) =>
    (context, state) => ref.read(permissionServiceProvider).canAll(permissions)
    ? null
    : Routes.home;

/// Como [requires], con cualquiera de los permisos.
GoRouterRedirect requiresAny(Ref ref, List<String> permissions) =>
    (context, state) => ref.read(permissionServiceProvider).canAny(permissions)
    ? null
    : Routes.home;

int routeId(GoRouterState state) => int.parse(state.pathParameters['id']!);
