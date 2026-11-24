import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/features/about/presentation/about_page.dart';
import 'package:sga_bojanini/features/auth/presentation/change_password_page.dart';
import 'package:sga_bojanini/features/auth/presentation/locked_page.dart';
import 'package:sga_bojanini/features/auth/presentation/login_page.dart';
import 'package:sga_bojanini/features/auth/presentation/profile_page.dart';
import 'package:sga_bojanini/features/auth/presentation/splash_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/catalog_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/product_detail_page.dart';
import 'package:sga_bojanini/features/catalog/presentation/supplier_detail_page.dart';
import 'package:sga_bojanini/features/home/presentation/app_shell.dart';
import 'package:sga_bojanini/features/home/presentation/home_page.dart';
import 'package:sga_bojanini/features/home/presentation/more_page.dart';
import 'package:sga_bojanini/features/home/presentation/section_placeholder_page.dart';
import 'package:sga_bojanini/features/warehouse/presentation/warehouse_detail_page.dart';
import 'package:sga_bojanini/features/warehouse/presentation/warehouses_page.dart';

/// Mapa de rutas y guardas. Vive en la raíz (no en `core/`) porque es el
/// único lugar que compone pantallas de varias features.
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref
    // Fuera de la fase de construcción: el listener corre durante el flush
    // de Riverpod, que ocurre dentro de `build`.
    ..listen(
      sessionControllerProvider,
      (_, _) => scheduleMicrotask(() => refresh.value++),
    )
    ..onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) => resolveRedirect(
      session: ref.read(sessionControllerProvider),
      permissions: ref.read(permissionServiceProvider),
      location: state.matchedLocation,
    ),
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashPage()),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginPage()),
      GoRoute(path: Routes.locked, builder: (_, _) => const LockedPage()),
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(path: Routes.home, builder: (_, _) => const HomePage()),
          GoRoute(path: MorePage.path, builder: (_, _) => const MorePage()),
          for (final section in AppSection.values)
            if (section != AppSection.dashboard)
              GoRoute(
                path: section.path,
                builder: (_, _) => _sectionPage(section),
              ),
        ],
      ),
      GoRoute(
        path: '${AppSection.warehouses.path}/:id',
        builder: (_, state) => WarehouseDetailPage(
          warehouseId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '${AppSection.catalog.path}/products/:id',
        builder: (_, state) => ProductDetailPage(
          productId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '${AppSection.catalog.path}/suppliers/:id',
        builder: (_, state) => SupplierDetailPage(
          supplierId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: Routes.profile,
        builder: (_, _) => const ProfilePage(),
        routes: [
          GoRoute(
            path: 'password',
            builder: (_, _) => const ChangePasswordPage(),
          ),
        ],
      ),
      GoRoute(path: Routes.about, builder: (_, _) => const AboutPage()),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Pantalla de cada sección; las de fases futuras muestran "Próximamente".
Widget _sectionPage(AppSection section) => switch (section) {
  AppSection.warehouses => const WarehousesPage(),
  AppSection.catalog => const CatalogPage(),
  _ => SectionPlaceholderPage(section: section),
};
