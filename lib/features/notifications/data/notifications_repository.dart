import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/notifications/data/app_notification.dart';

class NotificationsRepository {
  const NotificationsRepository(this._dio);

  final Dio _dio;

  Future<PagedList<AppNotification>> list({
    bool unreadOnly = false,
    int page = 1,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/notifications',
      queryParameters: {
        if (unreadOnly) 'unread_only': true,
        'page': page,
        'per_page': ApiResponse.defaultPageSize,
      },
    );
    return ApiResponse.page(response, AppNotification.fromJson);
  });

  Future<int> unreadCount() => apiCall(() async {
    final response = await _dio.get<dynamic>('/notifications/unread-count');
    final count = ApiResponse.object(response)['count'];
    return count is num ? count.toInt() : 0;
  });

  Future<void> markAsRead(String id) =>
      apiCall(() => _dio.put<dynamic>('/notifications/$id/read'));

  Future<void> markAllAsRead() =>
      apiCall(() => _dio.post<dynamic>('/notifications/read-all'));
}

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepository(ref.watch(dioProvider)),
);
