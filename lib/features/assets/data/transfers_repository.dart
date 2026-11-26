import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/core/signing/signoff.dart';
import 'package:sga_bojanini/features/assets/data/asset_transfer.dart';

/// Solicitud de traslado: según el tipo se usan unos campos u otros.
@immutable
class TransferRequest {
  const TransferRequest({
    required this.type,
    this.toPlaceId,
    this.toResponsibleId,
    this.externalDestination,
    this.expectedReturnDate,
    this.reason,
  });

  final TransferType type;
  final int? toPlaceId;
  final int? toResponsibleId;
  final String? externalDestination;

  /// `AAAA-MM-DD`.
  final String? expectedReturnDate;
  final String? reason;

  Map<String, Object> toJson() => {
    'type': type.value,
    'to_place_id': ?toPlaceId,
    'to_responsible_id': ?toResponsibleId,
    if ((externalDestination ?? '').trim().isNotEmpty)
      'external_destination': externalDestination!.trim(),
    'expected_return_date': ?expectedReturnDate,
    if ((reason ?? '').trim().isNotEmpty) 'reason': reason!.trim(),
  };
}

/// Traslados de activos (`docs/app-movil/15-assets.md`). Las acciones son
/// escrituras: nunca se reintentan solas.
class TransfersRepository {
  const TransfersRepository(this._dio);

  final Dio _dio;

  Future<PagedList<AssetTransfer>> list({
    TransferStatus? status,
    int page = 1,
  }) => apiCall(() async {
    final response = await _dio.get<dynamic>(
      '/assets/transfers',
      queryParameters: {
        if (status != null) 'status': status.value,
        'page': page,
        'per_page': ApiResponse.defaultPageSize,
      },
    );
    return ApiResponse.page(response, AssetTransfer.fromJson);
  });

  Future<AssetTransfer> get(int id) => apiCall(() async {
    final response = await _dio.get<dynamic>('/assets/transfers/$id');
    return AssetTransfer.fromJson(ApiResponse.object(response));
  });

  Future<AssetTransfer> request(int assetId, TransferRequest request) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/assets/$assetId/transfers',
          data: request.toJson(),
        );
        return AssetTransfer.fromJson(ApiResponse.object(response));
      });

  Future<AssetTransfer> confirm(int id, ConfirmRequest request) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/assets/transfers/$id/confirm',
          data: request.toJson(),
        );
        return AssetTransfer.fromJson(ApiResponse.object(response));
      });

  Future<AssetTransfer> cancel(int id, String reason) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/assets/transfers/$id/cancel',
      data: {'reason': reason.trim()},
    );
    return AssetTransfer.fromJson(ApiResponse.object(response));
  });

  /// Acta del traslado en PDF (binario).
  Future<Uint8List> act(int id) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/assets/transfers/$id/act',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? const []);
  });
}

final transfersRepositoryProvider = Provider<TransfersRepository>(
  (ref) => TransfersRepository(ref.watch(dioProvider)),
);
