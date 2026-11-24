import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';
import 'package:sga_bojanini/features/inventory/data/product_presentation.dart';
import 'package:sga_bojanini/features/inventory/data/stock_item.dart';

/// Filtros de lotes del listado paginado.
@immutable
class BatchQuery {
  const BatchQuery({this.warehouseId, this.status});

  final int? warehouseId;
  final BatchStatus? status;

  @override
  bool operator ==(Object other) =>
      other is BatchQuery &&
      other.warehouseId == warehouseId &&
      other.status == status;

  @override
  int get hashCode => Object.hash(warehouseId, status);
}

@immutable
class DocumentQuery {
  const DocumentQuery({this.warehouseId, this.status});

  final int? warehouseId;
  final DocumentStatus? status;

  @override
  bool operator ==(Object other) =>
      other is DocumentQuery &&
      other.warehouseId == warehouseId &&
      other.status == status;

  @override
  int get hashCode => Object.hash(warehouseId, status);
}

/// Stock, lotes, movimientos y comprobantes
/// (`docs/app-movil/05-inventory.md` del backend).
class InventoryRepository {
  const InventoryRepository(this._dio);

  final Dio _dio;

  // ---- Stock ----

  Future<PagedList<StockItem>> stock({
    required int warehouseId,
    int page = 1,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/stock',
      queryParameters: {
        'warehouse_id': warehouseId,
        'page': page,
        'per_page': ApiResponse.defaultPageSize,
      },
    );
    return ApiResponse.page(response, StockItem.fromJson);
  });

  /// Productos por debajo del punto de reorden (sin paginar).
  Future<List<StockItem>> lowStock({required int warehouseId}) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/stock/low',
          queryParameters: {'warehouse_id': warehouseId},
        );
        return ApiResponse.list(response, StockItem.fromJson);
      });

  /// Unidades de kit que se pueden armar con el stock de componentes.
  Future<double> kitAvailability({
    required int genericProductId,
    required int warehouseId,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/generic-products/$genericProductId/kit-availability',
      queryParameters: {'warehouse_id': warehouseId},
    );
    final value = ApiResponse.object(response)['available_kits'];
    return value is num ? value.toDouble() : 0;
  });

  // ---- Lotes ----

  Future<PagedList<Batch>> batches(BatchQuery query, {int page = 1}) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/batches',
          queryParameters: {
            'warehouse_id': ?query.warehouseId,
            'status': ?query.status?.name,
            'page': page,
            'per_page': ApiResponse.defaultPageSize,
          },
        );
        return ApiResponse.page(response, Batch.fromJson);
      });

  Future<List<Batch>> expiringBatches({int days = 30}) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/batches/expiring',
      queryParameters: {'days': days},
    );
    return ApiResponse.list(response, Batch.fromJson);
  });

  Future<List<Batch>> expiredBatches() => apiCall(() async {
    final response = await _dio.get<dynamic>('/batches/expired');
    return ApiResponse.list(response, Batch.fromJson);
  });

  Future<Batch> batch(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/batches/$id');
    return Batch.fromJson(ApiResponse.object(response));
  });

  /// Lotes de un producto; con [availableForExit] solo los que se pueden
  /// despachar (no vencidos y con saldo).
  Future<List<Batch>> productBatches(
    int genericProductId, {
    int? warehouseId,
    bool availableForExit = false,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/generic-products/$genericProductId/batches',
      queryParameters: {
        'warehouse_id': ?warehouseId,
        if (availableForExit) 'available_for_exit': true,
      },
    );
    return ApiResponse.list(response, Batch.fromJson);
  });

  // ---- Datos de apoyo para los formularios ----

  /// Centros de costo activos (`centros_costo.ver`).
  Future<List<CostCenterRef>> costCenters() => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/cost-centers',
      queryParameters: {'is_active': true},
    );
    return ApiResponse.list(response, CostCenterRef.fromJson);
  });

  Future<List<ProductPresentation>> presentations(int genericProductId) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/generic-products/$genericProductId/presentations',
        );
        return ApiResponse.list(response, ProductPresentation.fromJson);
      });

  // ---- Comprobantes y movimientos ----

  Future<PagedList<MovementDocument>> documents(
    DocumentQuery query, {
    int page = 1,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/movement-documents',
      queryParameters: {
        'warehouse_id': ?query.warehouseId,
        if (query.status case final status?)
          'status': const DocumentStatusConverter().toJson(status),
        'page': page,
        'per_page': ApiResponse.defaultPageSize,
      },
    );
    return ApiResponse.page(response, MovementDocument.fromJson);
  });

  Future<MovementDocument> document(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/movement-documents/$id');
    return MovementDocument.fromJson(ApiResponse.object(response));
  });

  Future<PagedList<MovementLine>> movements({
    required int warehouseId,
    int page = 1,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/movements',
      queryParameters: {
        'warehouse_id': warehouseId,
        'page': page,
        'per_page': ApiResponse.defaultPageSize,
      },
    );
    return ApiResponse.page(response, MovementLine.fromJson);
  });

  // ---- Registro de operaciones (escrituras: nunca se reintentan) ----

  Future<MovementDocument> registerEntry(EntryRequest request) =>
      _postDocument('/movements/entry', request.toJson());

  Future<MovementDocument> registerExit(ExitRequest request) =>
      _postDocument('/movements/exit', request.toJson());

  Future<MovementDocument> registerTransfer(TransferRequest request) =>
      _postDocument('/movements/transfer', request.toJson());

  Future<MovementLine> registerAdjustment(AdjustmentRequest request) =>
      _postLine('/movements/adjustment', request.toJson());

  Future<MovementLine> registerReturn(ReturnRequest request) =>
      _postLine('/movements/return', request.toJson());

  Future<MovementLine> registerWriteOff(WriteOffRequest request) =>
      _postLine('/movements/write-off', request.toJson());

  Future<MovementLine> registerLoss(LossRequest request) =>
      _postLine('/movements/loss', request.toJson());

  Future<MovementDocument> confirm(int documentId, ConfirmRequest request) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/movement-documents/$documentId/confirm',
          data: request.toJson(),
        );
        return MovementDocument.fromJson(ApiResponse.object(response));
      });

  Future<void> cancelPending(int documentId) => apiCall(
    () => _dio.delete<dynamic>('/movement-documents/$documentId/pending'),
  );

  Future<void> sendEmail(int documentId, List<String> recipients) => apiCall(
    () => _dio.post<dynamic>(
      '/movement-documents/$documentId/send-email',
      data: {'recipients': recipients},
    ),
  );

  /// PDF del comprobante (binario; el enlace directo respondería 401).
  Future<Uint8List> pdf(int documentId) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/movement-documents/$documentId/pdf',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? const []);
  });

  /// Imagen (data URL) de la firma de un rol: `delivered_by` | `received_by`.
  Future<String?> signatureImage(int documentId, String role) =>
      apiCall(() async {
        final response = await _dio.get<dynamic>(
          '/movement-documents/$documentId/signature/$role',
        );
        return ApiResponse.object(response)['signature_data'] as String?;
      });

  Future<MovementDocument> _postDocument(String path, Json body) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(path, data: body);
        return MovementDocument.fromJson(ApiResponse.object(response));
      });

  Future<MovementLine> _postLine(String path, Json body) => apiCall(() async {
    final response = await _dio.post<dynamic>(path, data: body);
    return MovementLine.fromJson(ApiResponse.object(response));
  });
}

final inventoryRepositoryProvider = Provider<InventoryRepository>(
  (ref) => InventoryRepository(ref.watch(dioProvider)),
);
