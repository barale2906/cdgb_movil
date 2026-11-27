import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/navigation/app_section_label.dart';
import 'package:sga_bojanini/core/navigation/menu_provider.dart';
import 'package:sga_bojanini/core/navigation/navigation_planner.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/update/update_widgets.dart';
import 'package:sga_bojanini/core/widgets/notification_badge.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/warehouse_selector.dart';
import 'package:sga_bojanini/features/home/presentation/more_page.dart';
import 'package:sga_bojanini/features/notifications/application/notifications_providers.dart';
import 'package:sga_bojanini/features/notifications/presentation/notifications_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Estructura de la app autenticada: barra superior (almacén activo y
/// perfil), aviso sin conexión y barra inferior con máximo 5 destinos.
class AppShell extends ConsumerWidget {
  const AppShell({required this.location, required this.child, super.key});

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final plan = ref.watch(navigationPlanProvider).value;
    final destinations = _destinations(l10n, plan);
    final selected = _selectedIndex(plan);

    return Scaffold(
      appBar: AppBar(
        title: Text(_title(l10n)),
        actions: const [
          WarehouseSelector(),
          _NotificationBell(),
          _ProfileAvatar(),
        ],
      ),
      body: Column(
        children: [
          const UpdateAvailableBanner(),
          const OfflineBanner(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: destinations.length < 2
          ? null
          : NavigationBar(
              selectedIndex: selected,
              onDestinationSelected: (index) =>
                  context.go(destinations[index].path),
              destinations: [
                for (final destination in destinations)
                  NavigationDestination(
                    icon: Icon(destination.icon),
                    label: destination.label,
                  ),
              ],
            ),
    );
  }

  String _title(AppLocalizations l10n) {
    if (location == MorePage.path) return l10n.moreTitle;
    return AppSection.fromLocation(location)?.label(l10n) ?? l10n.appTitle;
  }

  List<_Destination> _destinations(
    AppLocalizations l10n,
    NavigationPlan? plan,
  ) {
    final bottomBar = plan?.bottomBar ?? const [AppSection.dashboard];
    return [
      for (final section in bottomBar)
        _Destination(section.path, section.icon, section.label(l10n)),
      if (plan?.hasMore ?? false)
        _Destination(MorePage.path, Icons.more_horiz, l10n.navMore),
    ];
  }

  int _selectedIndex(NavigationPlan? plan) {
    final bottomBar = plan?.bottomBar ?? const [AppSection.dashboard];
    final index = bottomBar.indexOf(
      AppSection.fromLocation(location) ?? AppSection.dashboard,
    );
    // Cualquier sección fuera de la barra cuelga de "Más".
    return index >= 0 ? index : bottomBar.length;
  }
}

class _Destination {
  const _Destination(this.path, this.icon, this.label);

  final String path;
  final IconData icon;
  final String label;
}

class _ProfileAvatar extends ConsumerWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final name = ref.watch(currentUserProvider.select((user) => user?.name));
    final initial = (name == null || name.isEmpty)
        ? '?'
        : name[0].toUpperCase();

    return IconButton(
      tooltip: l10n.openProfile,
      constraints: const BoxConstraints(
        minWidth: AppSizes.minTouchTarget,
        minHeight: AppSizes.minTouchTarget,
      ),
      onPressed: () => context.push(Routes.profile),
      icon: CircleAvatar(
        radius: AppSizes.iconCompact,
        backgroundColor: AppColors.dark,
        child: Text(
          initial,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: AppColors.onDark),
        ),
      ),
    );
  }
}

class _NotificationBell extends ConsumerWidget {
  const _NotificationBell();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowed = ref.watch(
      permissionServiceProvider.select((p) => p.can(notificationsPermission)),
    );
    if (!allowed) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final unread = ref.watch(unreadCountProvider);

    return IconButton(
      tooltip: l10n.notificationsOpen,
      constraints: const BoxConstraints(
        minWidth: AppSizes.minTouchTarget,
        minHeight: AppSizes.minTouchTarget,
      ),
      onPressed: () => context.push(NotificationsPage.path),
      icon: Semantics(
        label: l10n.notificationsUnreadCount(unread),
        child: NotificationBadge(
          count: unread,
          child: const Icon(Icons.notifications_outlined),
        ),
      ),
    );
  }
}
