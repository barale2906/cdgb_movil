import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/files/file_picker_gateway.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';
import 'package:sga_bojanini/features/assets/data/asset_document.dart';

/// Tamaño máximo de un adjunto (el servidor rechaza más de 10 MB).
const int maxDocumentBytes = 10 * 1024 * 1024;

/// Documentos de un activo: manuales, facturas, certificados, fotos…
class DocumentsRepository {
  const DocumentsRepository(this._dio);

  final Dio _dio;

  Future<List<AssetDocument>> list(int assetId) => apiCall(() async {
    final response = await _dio.get<dynamic>('/assets/$assetId/documents');
    return ApiResponse.list(response, AssetDocument.fromJson);
  });

  Future<Uint8List> download(int id) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '/assets/documents/$id/download',
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data ?? const []);
  });

  /// Sube el documento (multipart). Escritura: nunca se reintenta sola.
  Future<AssetDocument> upload(
    int assetId, {
    required PickedFile file,
    required String documentType,
    required String title,
    String? issuedAt,
    String? expiresAt,
  }) => apiCall(() async {
    final response = await _dio.post<dynamic>(
      '/assets/$assetId/documents',
      data: FormData.fromMap({
        'file': MultipartFile.fromBytes(file.bytes, filename: file.name),
        'document_type': documentType,
        'title': title.trim(),
        'issued_at': ?issuedAt,
        'expires_at': ?expiresAt,
      }),
    );
    return AssetDocument.fromJson(ApiResponse.object(response));
  });

  Future<void> delete(int id) =>
      apiCall(() => _dio.delete<dynamic>('/assets/documents/$id'));
}

final documentsRepositoryProvider = Provider<DocumentsRepository>(
  (ref) => DocumentsRepository(ref.watch(dioProvider)),
);
