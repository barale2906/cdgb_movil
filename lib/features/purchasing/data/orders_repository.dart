import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/features/purchasing/data/order_status.dart';

/// Filtros del listado de órdenes (compra o gasto).
@immutable
class OrderQuery {
  const OrderQuery({this.status, this.paymentStatus});

  final OrderStatus? status;

  /// Solo aplica a órdenes de gasto.
  final PaymentStatus? paymentStatus;

  Map<String, Object> toParams() => {
    if (status != null) 'status': status!.value,
    if (paymentStatus != null) 'payment_status': paymentStatus!.value,
  };

  @override
  bool operator ==(Object other) =>
      other is OrderQuery &&
      other.status == status &&
      other.paymentStatus == paymentStatus;

  @override
  int get hashCode => Object.hash(status, paymentStatus);
}

/// Flujo común de las órdenes de compra y de gasto: ambas comparten rutas
/// (`submit`, `approve`, `reject`, `send`, `receive`, `cancel`) y estados.
///
/// Todas las acciones son escrituras: nunca se reintentan solas.
class OrdersRepository<T> {
  const OrdersRepository(this.dio, this.path, this._parse);

  @protected
  final Dio dio;

  /// Recurso del backend: `purchase-orders` o `expense-orders`.
  @protected
  final String path;

  final T Function(Map<String, dynamic>) _parse;

  Future<PagedList<T>> list(OrderQuery query, {int page = 1}) =>
      apiCall(() async {
        final response = await dio.get<dynamic>(
          '/$path',
          queryParameters: {
            ...query.toParams(),
            'page': page,
            'per_page': ApiResponse.defaultPageSize,
          },
        );
        return ApiResponse.page(response, _parse);
      });

  Future<T> get(int id) => apiCall(() async {
    final response = await dio.get<dynamic>('/$path/$id');
    return _parse(ApiResponse.object(response));
  });

  /// Crea un borrador (escritura: nunca se reintenta sola).
  Future<T> create(Map<String, Object> body) => apiCall(() async {
    final response = await dio.post<dynamic>('/$path', data: body);
    return _parse(ApiResponse.object(response));
  });

  /// Reemplaza los datos de un borrador.
  Future<T> update(int id, Map<String, Object> body) => apiCall(() async {
    final response = await dio.put<dynamic>('/$path/$id', data: body);
    return _parse(ApiResponse.object(response));
  });

  Future<void> delete(int id) => apiCall(() async {
    final response = await dio.delete<dynamic>('/$path/$id');
    ApiResponse.message(response);
  });

  Future<T> submit(int id) => _action(id, 'submit');

  Future<T> approve(int id, {String? comments}) =>
      _action(id, 'approve', body: _comments(comments));

  Future<T> reject(int id, {String? comments}) =>
      _action(id, 'reject', body: _comments(comments));

  Future<T> send(int id) => _action(id, 'send');

  Future<T> cancel(int id) => _action(id, 'cancel');

  Future<T> receive(int id, List<Map<String, Object?>> items) =>
      _action(id, 'receive', body: {'items': items});

  static Map<String, Object?>? _comments(String? comments) =>
      (comments ?? '').trim().isEmpty ? null : {'comments': comments!.trim()};

  Future<T> _action(int id, String action, {Map<String, Object?>? body}) =>
      apiCall(() async {
        final response = await dio.post<dynamic>(
          '/$path/$id/$action',
          data: body,
        );
        return _parse(ApiResponse.object(response));
      });
}
