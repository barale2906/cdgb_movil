// Los campos del servidor llegan como número o texto, o como `[]` (PHP) si
// están vacíos: se leen con conversores propios.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_log.freezed.dart';
part 'audit_log.g.dart';

/// Registro de la bitácora de auditoría (`AuditLogResource`).
@freezed
abstract class AuditLog with _$AuditLog {
  const factory AuditLog({
    required int id,
    required String action,
    int? userId,
    String? userName,
    String? auditableType,
    @JsonKey(fromJson: _idToString) String? auditableId,
    @JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? oldValues,
    @JsonKey(fromJson: _valuesOrNull) Map<String, dynamic>? newValues,
    String? ipAddress,
    String? userAgent,
    String? createdAt,
  }) = _AuditLog;

  factory AuditLog.fromJson(Map<String, dynamic> json) =>
      _$AuditLogFromJson(json);
}

/// El servidor manda el id como número o como texto.
String? _idToString(Object? value) => value?.toString();

/// PHP serializa un arreglo vacío como `[]`: se trata como «sin valores».
Map<String, dynamic>? _valuesOrNull(Object? value) =>
    value is Map<String, dynamic> && value.isNotEmpty ? value : null;

/// Totales de la bitácora en un periodo.
class AuditSummary {
  const AuditSummary({
    required this.total,
    required this.byAction,
    required this.byType,
  });

  factory AuditSummary.fromJson(Map<String, dynamic> json) => AuditSummary(
    total: (json['total'] as num?)?.toInt() ?? 0,
    byAction: _counts(json['by_action']),
    byType: _counts(json['by_type']),
  );

  final int total;
  final Map<String, int> byAction;
  final Map<String, int> byType;

  /// Un objeto `{clave: total}`; un arreglo vacío `[]` (PHP) es «sin datos».
  static Map<String, int> _counts(Object? value) =>
      value is Map<String, dynamic>
      ? {
          for (final entry in value.entries)
            entry.key: (entry.value as num).toInt(),
        }
      : const {};
}
