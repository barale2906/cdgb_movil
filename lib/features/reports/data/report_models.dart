import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_models.freezed.dart';
part 'report_models.g.dart';

enum ReportType {
  inventory('inventory'),
  movements('movements'),
  expiring('expiring'),
  purchases('purchases'),
  consumption('consumption'),
  conditions('conditions'),
  audit('audit')
  ;

  const ReportType(this.path);

  /// Segmento de `GET /reports/{path}` y de la ruta de la app.
  final String path;

  static ReportType? fromPath(String path) {
    for (final type in values) {
      if (type.path == path) return type;
    }
    return null;
  }

  /// Permiso adicional a `reportes.ver` (la auditoría es sensible).
  String? get extraPermission => this == audit ? 'auditoria.ver' : null;
}

enum ReportFormat {
  pdf('pdf', 'pdf'),
  excel('excel', 'xlsx'),
  csv('csv', 'csv')
  ;

  const ReportFormat(this.value, this.extension);

  final String value;
  final String extension;
}

/// Resultado de pedir un reporte: el archivo (reportes pequeños) o el
/// número de exportación (los grandes se generan en segundo plano, HTTP 202).
sealed class ReportResult {
  const ReportResult();
}

class ReportFile extends ReportResult {
  const ReportFile({
    required this.bytes,
    required this.fileName,
    required this.format,
  });

  final Uint8List bytes;
  final String fileName;
  final ReportFormat format;
}

class ReportQueued extends ReportResult {
  const ReportQueued(this.exportId);

  final String exportId;
}

enum ExportStatus { queued, processing, ready, failed, unknown }

class ExportStatusConverter implements JsonConverter<ExportStatus, Object?> {
  const ExportStatusConverter();

  @override
  ExportStatus fromJson(Object? json) => ExportStatus.values.firstWhere(
    (status) => status.name == json,
    orElse: () => ExportStatus.unknown,
  );

  @override
  Object toJson(ExportStatus object) => object.name;
}

/// El id puede llegar como número o como texto.
class IdAsStringConverter implements JsonConverter<String, Object?> {
  const IdAsStringConverter();

  @override
  String fromJson(Object? json) => '$json';

  @override
  Object toJson(String object) => object;
}

@freezed
abstract class ReportExport with _$ReportExport {
  const factory ReportExport({
    @IdAsStringConverter() required String id,
    @Default('') String type,
    @Default('') String format,
    @ExportStatusConverter() @Default(ExportStatus.unknown) ExportStatus status,
    @Default(false) bool isReady,
    @Default(false) bool isExpired,
    int? fileSize,
    String? errorMessage,
    String? expiresAt,
    String? createdAt,
    String? completedAt,
  }) = _ReportExport;

  const ReportExport._();

  factory ReportExport.fromJson(Map<String, dynamic> json) =>
      _$ReportExportFromJson(json);

  bool get isInProgress =>
      status == ExportStatus.queued || status == ExportStatus.processing;

  bool get canDownload => isReady && !isExpired;
}
