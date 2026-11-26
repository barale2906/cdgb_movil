import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/notifications/application/notification_target.dart';
import 'package:sga_bojanini/features/notifications/application/notifications_providers.dart';
import 'package:sga_bojanini/features/notifications/data/app_notification.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Centro de notificaciones: lista, filtro "sin leer", marcar leídas y abrir
/// el detalle (módulo relacionado).
class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  static const path = '/notifications';

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  NotificationFilter _filter = NotificationFilter.all;

  Future<void> _markAllRead() async {
    final l10n = AppLocalizations.of(context);
    try {
      await ref.read(unreadCountProvider.notifier).markAllRead();
      ref.invalidate(notificationListProvider);
      if (mounted) AppSnackbar.show(context, l10n.notificationsAllRead);
    } on ApiException catch (error) {
      if (mounted) {
        AppSnackbar.show(
          context,
          error.message.isEmpty ? l10n.errorGeneric : error.message,
          kind: AppSnackbarKind.error,
          closeLabel: l10n.actionClose,
        );
      }
    }
  }

  Future<void> _open(AppNotification notification) async {
    final target = notificationTargetPath(notification);
    if (!notification.isRead) {
      try {
        await ref.read(unreadCountProvider.notifier).markRead(notification.id);
        ref.invalidate(notificationListProvider);
      } on ApiException {
        // Abrir el destino no depende de poder marcarla.
      }
    }
    if (target != null && mounted) context.go(target);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = notificationListProvider(_filter);
    final notifier = ref.read(provider.notifier);
    final unread = ref.watch(unreadCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notificationsTitle),
        actions: [
          if (unread > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text(l10n.notificationsMarkAllRead),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            const SizedBox(height: AppSpacing.sm),
            ChoiceFilterBar<NotificationFilter>(
              options: {
                NotificationFilter.all: l10n.notificationsFilterAll,
                NotificationFilter.unread: l10n.notificationsFilterUnread,
              },
              selected: _filter,
              onSelected: (value) => setState(() => _filter = value),
            ),
            Expanded(
              child: PagedListView<AppNotification>(
                state: ref.watch(provider),
                onRefresh: () async {
                  await notifier.refresh();
                  await ref.read(unreadCountProvider.notifier).refresh();
                },
                onLoadMore: notifier.loadMore,
                onRetry: notifier.retry,
                emptyIcon: Icons.notifications_none,
                emptyMessage: _filter == NotificationFilter.unread
                    ? l10n.notificationsEmptyUnread
                    : l10n.notificationsEmpty,
                itemBuilder: (context, item) => _NotificationTile(
                  notification: item,
                  onTap: () => unawaited(_open(item)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.onTap});

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final (kind, label, icon) = switch (notification.severity) {
      NotificationSeverity.critical => (
        StatusKind.error,
        l10n.severityCritical,
        Icons.error_outline,
      ),
      NotificationSeverity.warning => (
        StatusKind.warning,
        l10n.severityWarning,
        Icons.warning_amber_outlined,
      ),
      NotificationSeverity.success => (
        StatusKind.success,
        l10n.severitySuccess,
        Icons.check_circle_outline,
      ),
      NotificationSeverity.info => (
        StatusKind.info,
        l10n.severityInfo,
        Icons.info_outline,
      ),
    };
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        onTap: onTap,
        title: Text(
          notification.title,
          style: notification.isRead
              ? textTheme.bodyLarge
              : textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.message.isNotEmpty) Text(notification.message),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                StatusChip(label: label, kind: kind, icon: icon),
                if (!notification.isRead)
                  StatusChip(
                    label: l10n.notificationUnread,
                    kind: StatusKind.special,
                  ),
                Text(
                  AppFormat.dateTime(notification.createdAt),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
