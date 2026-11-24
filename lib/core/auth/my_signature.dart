import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/network/api_error_mapper.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/dio_client.dart';

part 'my_signature.freezed.dart';
part 'my_signature.g.dart';

/// Firma registrada del usuario (nunca incluye el PIN).
@freezed
abstract class MySignature with _$MySignature {
  const factory MySignature({
    required String signerName,
    required String documentType,
    required String documentNumber,
    String? documentTypeLabel,
    String? signatureData,
    @Default(false) bool hasPin,
    String? pinGeneratedAt,
    String? registeredAt,
  }) = _MySignature;

  factory MySignature.fromJson(Map<String, dynamic> json) =>
      _$MySignatureFromJson(json);
}

/// Respuesta de guardar firma / regenerar PIN. [pin] solo viene la primera
/// vez y al regenerarlo: se muestra una única vez.
class SignatureSaveResult {
  const SignatureSaveResult({required this.signature, this.pin});

  final MySignature signature;
  final String? pin;
}

/// Tipos de documento admitidos por el backend (`in:CC,CE,TI,PA,PPT`).
const identityDocumentTypes = ['CC', 'CE', 'TI', 'PA', 'PPT'];

class MySignatureRepository {
  const MySignatureRepository(this._dio);

  final Dio _dio;

  /// `null` si todavía no la ha registrado.
  Future<MySignature?> fetch() => apiCall(() async {
    final response = await _dio.get<dynamic>('/auth/me/signature');
    final signature = ApiResponse.object(response)['signature'];
    return signature is Json ? MySignature.fromJson(signature) : null;
  });

  Future<SignatureSaveResult> save({
    required String currentPassword,
    required String documentType,
    required String documentNumber,
    required String signature,
  }) => apiCall(() async {
    final response = await _dio.put<dynamic>(
      '/auth/me/signature',
      data: {
        'current_password': currentPassword,
        'document_type': documentType,
        'document_number': documentNumber,
        'signature': signature,
      },
    );
    return _result(response);
  });

  Future<SignatureSaveResult> regeneratePin(String currentPassword) =>
      apiCall(() async {
        final response = await _dio.post<dynamic>(
          '/auth/me/signature/pin',
          data: {'current_password': currentPassword},
        );
        return _result(response);
      });

  SignatureSaveResult _result(Response<dynamic> response) {
    final data = ApiResponse.object(response);
    return SignatureSaveResult(
      signature: MySignature.fromJson(data['signature'] as Json),
      pin: data['pin'] as String?,
    );
  }
}

final mySignatureRepositoryProvider = Provider<MySignatureRepository>(
  (ref) => MySignatureRepository(ref.watch(dioProvider)),
);

/// Firma del usuario actual. Depende del usuario para no mostrar la de otro
/// en un teléfono compartido.
final FutureProvider<MySignature?> mySignatureProvider =
    FutureProvider.autoDispose<MySignature?>((ref) {
      final userId = ref.watch(currentUserProvider.select((u) => u?.id));
      if (userId == null) return null;
      return ref.watch(mySignatureRepositoryProvider).fetch();
    });
