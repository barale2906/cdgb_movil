import 'package:flutter/foundation.dart';
import 'package:sga_bojanini/core/auth/menu_item.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';

/// Secciones que el usuario puede abrir y cómo se reparten en la barra
/// inferior (`docs/plan/03` §5): Inicio + hasta 3 módulos + "Más".
@immutable
class NavigationPlan {
  const NavigationPlan({required this.bottomBar, required this.more});

  /// Destinos de la barra, sin "Más". Siempre empieza con Inicio.
  final List<AppSection> bottomBar;

  /// Secciones restantes; si no hay, la barra no muestra "Más".
  final List<AppSection> more;

  bool get hasMore => more.isNotEmpty;

  /// Secciones accesibles, en orden de la barra y luego de "Más".
  List<AppSection> get all => [...bottomBar, ...more];
}

abstract final class NavigationPlanner {
  /// Módulos que ocupan la barra, en este orden, si el usuario los tiene.
  static const List<AppSection> bottomBarModules = [
    AppSection.inventory,
    AppSection.purchasing,
    AppSection.assets,
  ];

  /// Doble control: la sección debe venir en el menú del backend **y** el
  /// usuario debe tener el permiso de entrada (el menú tiene inconsistencias).
  /// Una clave de menú desconocida se ignora sin romper la app.
  static NavigationPlan plan({
    required List<MenuItem> menu,
    required PermissionService permissions,
    void Function(String unknownRoute)? onUnknownRoute,
  }) {
    final fromMenu = <AppSection>{};
    for (final item in menu.expand((root) => root.flattened)) {
      final route = item.route;
      if (route == null) continue;
      final section = AppSection.fromMenuRoute(route);
      if (section != null) {
        fromMenu.add(section);
      } else if (!_hiddenRoutes.contains(route) && !_isHiddenPrefix(route)) {
        onUnknownRoute?.call(route);
      }
    }

    final accessible = [
      for (final section in AppSection.values)
        if (section != AppSection.dashboard &&
            fromMenu.contains(section) &&
            permissions.can(section.permission))
          section,
    ];
    final inBar = [
      for (final section in bottomBarModules)
        if (accessible.contains(section)) section,
    ];
    return NavigationPlan(
      bottomBar: [AppSection.dashboard, ...inBar],
      more: [
        for (final section in accessible)
          if (!inBar.contains(section)) section,
      ],
    );
  }

  /// Claves del menú que existen pero la app móvil oculta a propósito.
  static const _hiddenRoutes = {
    'integrations.index',
    'asset-catalogs.index',
    'users.index',
    'roles.index',
  };

  static bool _isHiddenPrefix(String route) => route.startsWith('price-lists.');
}
