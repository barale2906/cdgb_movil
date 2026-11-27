import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/network/idempotency.dart';
import 'package:sga_bojanini/features/service_orders/data/new_order_request.dart';
import 'package:sga_bojanini/features/service_orders/data/order_query.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';

/// Órdenes de servicio (`docs/app-movil/14-service-orders.md` del backend).
/// Las escrituras no se reintentan solas; la creación envía una clave de
/// idempotencia para no duplicar la orden si el usuario repite el envío.
class ServiceOrdersRepository {
  const ServiceOrdersRepository(this._dio);

  final Dio _dio;

  Future<ServiceOrder> create(
    NewOrderRequest request, {
    String? idempotencyKey,
  }) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/service-orders',
      data: request.toJson(),
      options: Options(headers: IdempotencyKey.headers(idempotencyKey)),
    );
    return ServiceOrder.fromJson(ApiResponse.object(response));
  });

  /// Órdenes, la más reciente primero (paginado).
  Future<PagedList<ServiceOrder>> list(OrderQuery query, {int page = 1}) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/service-orders',
          queryParameters: {
            ...query.toParams(),
            'page': page,
            'per_page': ApiResponse.defaultPageSize,
          },
        );
        return ApiResponse.page(response, ServiceOrder.fromJson);
      });

  Future<ServiceOrder> order(String orderNumber) => apiCall(() async {
    final response = await _dio.get<dynamic>(_path(orderNumber));
    return ServiceOrder.fromJson(ApiResponse.object(response));
  });

  Future<List<DiscountOrder>> pendingDiscounts() => apiCall(() async {
    final response = await _dio.get<dynamic>('/service-orders/discounts');
    return ApiResponse.list(response, DiscountOrder.fromJson);
  });

  Future<ServiceOrder> approveDiscount(String orderNumber) =>
      _action(orderNumber, 'approve');

  Future<ServiceOrder> bill(String orderNumber) => _action(orderNumber, 'bill');

  Future<ServiceOrder> cancel(String orderNumber) =>
      _action(orderNumber, 'cancel');

  Future<ServiceOrder> _action(String orderNumber, String action) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '${_path(orderNumber)}/$action',
        );
        return ServiceOrder.fromJson(ApiResponse.object(response));
      });

  static String _path(String orderNumber) =>
      '/service-orders/${Uri.encodeComponent(orderNumber)}';
}

final serviceOrdersRepositoryProvider = Provider<ServiceOrdersRepository>(
  (ref) => ServiceOrdersRepository(ref.watch(dioProvider)),
);
