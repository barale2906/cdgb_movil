import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/purchasing/data/consolidation.dart';
import 'package:sga_bojanini/features/purchasing/data/orders_repository.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';

/// Línea de recepción de una orden de compra: cada recepción crea un lote.
class PurchaseReceiveLine {
  const PurchaseReceiveLine({
    required this.itemId,
    required this.quantityReceived,
    required this.lotNumber,
    required this.expirationDate,
    required this.locationId,
  });

  final int itemId;
  final int quantityReceived;
  final String lotNumber;

  /// `AAAA-MM-DD`.
  final String expirationDate;
  final int locationId;

  Map<String, Object?> toJson() => {
    'item_id': itemId,
    'quantity_received': quantityReceived,
    'lot_number': lotNumber,
    'expiration_date': expirationDate,
    'location_id': locationId,
  };
}

/// Órdenes de compra, sugerencias de reorden y consolidación
/// (`docs/app-movil/06-purchasing.md`).
class PurchaseOrdersRepository extends OrdersRepository<PurchaseOrder> {
  PurchaseOrdersRepository(Dio dio)
    : super(dio, 'purchase-orders', PurchaseOrder.fromJson);

  Future<List<ReorderSuggestion>> suggestions() => apiCall(() async {
    final response = await dio.get<dynamic>('/$path/suggestions');
    return ApiResponse.list(response, ReorderSuggestion.fromJson);
  });

  Future<List<ConsolidableSupplier>> consolidableSuppliers() => apiCall(
    () async {
      final response = await dio.get<dynamic>('/$path/consolidable-suppliers');
      return ApiResponse.list(response, ConsolidableSupplier.fromJson);
    },
  );

  Future<ConsolidableOrders> consolidable(int supplierId) => apiCall(() async {
    final response = await dio.get<dynamic>(
      '/$path/consolidable',
      queryParameters: {'supplier_id': supplierId},
    );
    return ConsolidableOrders.fromJson(ApiResponse.object(response));
  });

  Future<ConsolidationPreview> preview(List<int> orderIds) => apiCall(() async {
    final response = await dio.post<dynamic>(
      '/$path/consolidation-preview',
      data: {'purchase_order_ids': orderIds},
    );
    return ConsolidationPreview.fromJson(ApiResponse.object(response));
  });

  Future<PagedList<ConsolidatedOrder>> consolidatedOrders({int page = 1}) =>
      apiCall(() async {
        final response = await dio.get<dynamic>(
          '/consolidated-orders',
          queryParameters: {
            'page': page,
            'per_page': ApiResponse.defaultPageSize,
          },
        );
        return ApiResponse.page(response, ConsolidatedOrder.fromJson);
      });

  Future<ConsolidatedOrder> consolidatedOrder(int id) => apiCall(() async {
    final response = await dio.get<dynamic>('/consolidated-orders/$id');
    return ConsolidatedOrder.fromJson(ApiResponse.object(response));
  });

  /// Crea la orden consolidada. Escritura: nunca se reintenta sola.
  Future<ConsolidatedOrder> consolidate(List<int> orderIds, {String? notes}) =>
      apiCall(() async {
        final response = await dio.post<dynamic>(
          '/consolidated-orders',
          data: {
            'purchase_order_ids': orderIds,
            if ((notes ?? '').trim().isNotEmpty) 'notes': notes!.trim(),
          },
        );
        return ConsolidatedOrder.fromJson(ApiResponse.object(response));
      });
}

final purchaseOrdersRepositoryProvider = Provider<PurchaseOrdersRepository>(
  (ref) => PurchaseOrdersRepository(ref.watch(dioProvider)),
);
