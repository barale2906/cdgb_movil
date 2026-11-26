import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';

part 'asset_document.freezed.dart';
part 'asset_document.g.dart';

/// Documento adjunto a un activo (`AssetDocumentResource`).
@freezed
abstract class AssetDocument with _$AssetDocument {
  const factory AssetDocument({
    required int id,
    String? documentType,
    String? documentTypeLabel,
    String? title,
    String? originalName,
    String? mimeType,
    int? size,
    int? maintenanceId,
    String? issuedAt,
    String? expiresAt,
    NamedRef? uploadedBy,
    String? createdAt,
  }) = _AssetDocument;

  const AssetDocument._();

  factory AssetDocument.fromJson(Map<String, dynamic> json) =>
      _$AssetDocumentFromJson(json);

  bool get isImage => (mimeType ?? '').startsWith('image/');

  /// Vencido a la fecha dada (`AAAA-MM-DD`); sin vencimiento nunca vence.
  bool isExpiredAt(DateTime today) {
    final expiry = DateTime.tryParse(expiresAt ?? '');
    if (expiry == null) return false;
    return DateTime(expiry.year, expiry.month, expiry.day).isBefore(
      DateTime(today.year, today.month, today.day),
    );
  }
}
