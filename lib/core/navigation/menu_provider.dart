import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/auth_repository.dart';
import 'package:sga_bojanini/core/auth/menu_item.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/navigation/navigation_planner.dart';

/// Menú del usuario (`GET /auth/menu`). Se vuelve a pedir al cambiar de
/// usuario; falla con el error de red para que la UI ofrezca reintentar.
final menuProvider = FutureProvider<List<MenuItem>>((ref) {
  final userId = ref.watch(currentUserProvider.select((user) => user?.id));
  if (userId == null) return const [];
  return ref.watch(authRepositoryProvider).menu();
});

/// Secciones accesibles según menú + permisos.
final navigationPlanProvider = Provider<AsyncValue<NavigationPlan>>((ref) {
  final permissions = ref.watch(permissionServiceProvider);
  return ref
      .watch(menuProvider)
      .whenData(
        (menu) => NavigationPlanner.plan(
          menu: menu,
          permissions: permissions,
          onUnknownRoute: (route) => developer.log(
            'Clave de menú sin pantalla móvil: $route',
            name: 'menu',
          ),
        ),
      );
});
