import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'procedure_record.freezed.dart';
part 'procedure_record.g.dart';

/// Registro de un procedimiento de un paciente
/// (`PatientProcedureRecordResource`).
@freezed
abstract class ProcedureRecord with _$ProcedureRecord {
  const factory ProcedureRecord({
    required int id,
    required String patientExternalId,
    required String patientDocument,
    required String patientFirstName,
    required String patientLastName,
    int? medicalServiceId,
    String? medicalServiceName,
    int? movementDocumentId,
    @DoubleConverter() double? quantity,
    @DoubleConverter() double? unitPrice,
    @DoubleConverter() double? total,
    String? discountType,
    @DoubleConverter() double? discountValue,
    @DoubleConverter() double? discountAmount,
    @DoubleConverter() double? netTotal,
    String? discountStatus,
    String? orderNumber,
    String? billingStatus,
    String? serviceDate,
    String? seller,
    String? referrer,
    @Default(true) bool isActive,
  }) = _ProcedureRecord;

  const ProcedureRecord._();

  factory ProcedureRecord.fromJson(Map<String, dynamic> json) =>
      _$ProcedureRecordFromJson(json);

  String get patientName => '$patientFirstName $patientLastName'.trim();

  bool get hasDiscount => (discountAmount ?? 0) > 0;
}

/// Una línea del historial de un paciente.
@freezed
abstract class HistoryRecord with _$HistoryRecord {
  const factory HistoryRecord({
    required int id,
    String? serviceDate,
    String? serviceName,
    String? procedureCode,
    String? procedureName,
    @DoubleConverter() double? quantity,
    @DoubleConverter() double? unitPrice,
    @DoubleConverter() double? total,
    @Default(true) bool isActive,
  }) = _HistoryRecord;

  factory HistoryRecord.fromJson(Map<String, dynamic> json) =>
      _$HistoryRecordFromJson(json);
}

@freezed
abstract class HistorySummary with _$HistorySummary {
  const factory HistorySummary({
    @Default(0) int totalRecords,
    @DoubleConverter() double? totalAmount,
    String? firstServiceDate,
    String? lastServiceDate,
  }) = _HistorySummary;

  factory HistorySummary.fromJson(Map<String, dynamic> json) =>
      _$HistorySummaryFromJson(json);
}

/// Historial de procedimientos de un paciente
/// (`PatientProcedureHistoryResource`).
@freezed
abstract class PatientHistory with _$PatientHistory {
  const factory PatientHistory({
    required String patientExternalId,
    required String patientDocument,
    required String patientFirstName,
    required String patientLastName,
    required HistorySummary summary,
    @Default([]) List<HistoryRecord> records,
  }) = _PatientHistory;

  const PatientHistory._();

  factory PatientHistory.fromJson(Map<String, dynamic> json) =>
      _$PatientHistoryFromJson(json);

  String get patientName => '$patientFirstName $patientLastName'.trim();
}
