import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show NotifierProviderFamily;
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/features/notifications/data/app_notification.dart';
import 'package:sga_bojanini/features/notifications/data/notifications_repository.dart';

const notificationsPermission = 'notificaciones.ver';

/// Cada cuánto se consulta el contador con la app en primer plano (respaldo
/// mientras no haya notificaciones push, `docs/plan/02` §10).
const notificationsPollInterval = Duration(seconds: 60);

/// Contador de notificaciones sin leer. Se actualiza solo (sondeo cada 60 s
/// en primer plano) y al marcar como leídas. Un fallo de red no molesta: se
/// conserva el último valor y se reintenta en el siguiente ciclo.
class UnreadCountNotifier extends Notifier<int> {
  @override
  int build() {
    final allowed = ref.watch(
      permissionServiceProvider.select((p) => p.can(notificationsPermission)),
    );
    if (!allowed) return 0;
    final timer = Timer.periodic(notificationsPollInterval, (_) {
      final lifecycle = WidgetsBinding.instance.lifecycleState;
      if (lifecycle == null || lifecycle == AppLifecycleState.resumed) {
        unawaited(refresh());
      }
    });
    ref.onDispose(timer.cancel);
    unawaited(Future.microtask(refresh));
    return 0;
  }

  Future<void> refresh() async {
    try {
      final count = await ref
          .read(notificationsRepositoryProvider)
          .unreadCount();
      if (ref.mounted) state = count;
    } on ApiException {
      // Se conserva el valor anterior.
    }
  }

  /// Marca una como leída (optimista: baja el contador de inmediato).
  Future<void> markRead(String id) async {
    await ref.read(notificationsRepositoryProvider).markAsRead(id);
    if (ref.mounted && state > 0) state = state - 1;
  }

  Future<void> markAllRead() async {
    await ref.read(notificationsRepositoryProvider).markAllAsRead();
    if (ref.mounted) state = 0;
  }
}

final NotifierProvider<UnreadCountNotifier, int> unreadCountProvider =
    NotifierProvider.autoDispose<UnreadCountNotifier, int>(
      UnreadCountNotifier.new,
    );

enum NotificationFilter { all, unread }

class NotificationListNotifier extends PagedNotifier<AppNotification> {
  NotificationListNotifier(this.filter);

  final NotificationFilter filter;

  @override
  Future<PagedList<AppNotification>> fetchPage(int page) => ref
      .read(notificationsRepositoryProvider)
      .list(unreadOnly: filter == NotificationFilter.unread, page: page);
}

final NotifierProviderFamily<
  NotificationListNotifier,
  PagedState<AppNotification>,
  NotificationFilter
>
notificationListProvider = NotifierProvider.autoDispose
    .family<
      NotificationListNotifier,
      PagedState<AppNotification>,
      NotificationFilter
    >(
      NotificationListNotifier.new,
    );
