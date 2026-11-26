import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/notifications/application/notification_target.dart';
import 'package:sga_bojanini/features/notifications/data/app_notification.dart';
import 'package:sga_bojanini/features/notifications/data/notifications_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<AppNotification> _parse() =>
    (fixture('notifications/list_response.json')['data'] as List<dynamic>)
        .map((e) => AppNotification.fromJson(e as Json))
        .toList();

void main() {
  group('AppNotification (contrato)', () {
    test('parsea id UUID, lectura, severidad y datos', () {
      final items = _parse();
      expect(items.first.id, 'a1b2-uuid-1');
      expect(items.first.isRead, isFalse);
      expect(items.first.severity, NotificationSeverity.warning);
      expect(items.first.data['product_id'], 5);
      expect(items[1].severity, NotificationSeverity.critical);
      expect(items[2].isRead, isTrue);
      expect(items[2].severity, NotificationSeverity.success);
    });

    test('una severidad desconocida cae en información', () {
      expect(_parse().last.severity, NotificationSeverity.info);
    });
  });

  group('destino de cada notificación', () {
    String? target(String type) =>
        notificationTargetPath(AppNotification(id: '1', type: type));

    test('rutas por tipo', () {
      expect(target('condition_out_of_range'), '/monitoring');
      expect(target('sensor_calibration_alert'), '/monitoring');
      expect(target('stock_below_reorder'), '/inventory');
      expect(target('batch_expiring_soon'), '/inventory');
      expect(target('report_ready'), '/reports/exports');
      expect(target('purchase_order_pending_approval'), '/purchasing');
      expect(target('service_order_discount_pending'), '/service-orders');
      expect(target('asset_maintenance_alert'), '/assets');
    });

    test('un tipo sin destino solo muestra el mensaje', () {
      expect(target('tipo_nuevo'), isNull);
      expect(target(''), isNull);
    });
  });

  group('NotificationsRepository', () {
    late FakeHttpAdapter adapter;
    late NotificationsRepository repository;

    setUp(() async {
      adapter = FakeHttpAdapter();
      final container = ProviderContainer(
        retry: noAutoRetry,
        overrides: await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 24)),
        ),
      );
      addTearDown(container.dispose);
      repository = container.read(notificationsRepositoryProvider);
    });

    test('list pagina y filtra sin leer', () async {
      adapter.on(
        'GET',
        '/notifications',
        body: fixture('notifications/list_response.json'),
      );
      final page = await repository.list(unreadOnly: true, page: 2);

      expect(page.items, hasLength(4));
      expect(adapter.callsTo('GET', '/notifications').single.queryParameters, {
        'unread_only': true,
        'page': 2,
        'per_page': 25,
      });
    });

    test('unreadCount, markAsRead y markAllAsRead', () async {
      adapter
        ..on('GET', '/notifications/unread-count', body: envelope({'count': 7}))
        ..on('PUT', '/notifications/a1b2-uuid-1/read', body: envelope(null))
        ..on('POST', '/notifications/read-all', body: envelope(null));

      expect(await repository.unreadCount(), 7);
      await repository.markAsRead('a1b2-uuid-1');
      await repository.markAllAsRead();
      expect(
        adapter.callsTo('PUT', '/notifications/a1b2-uuid-1/read'),
        hasLength(1),
      );
      expect(adapter.callsTo('POST', '/notifications/read-all'), hasLength(1));
    });
  });
}
