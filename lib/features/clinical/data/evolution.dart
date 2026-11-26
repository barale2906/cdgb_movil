import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/utils/clinical_text.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'evolution.freezed.dart';
part 'evolution.g.dart';

/// Evolución clínica de un registro de procedimiento. `content` viene como
/// HTML (el web usa un editor de texto enriquecido).
@freezed
abstract class Evolution with _$Evolution {
  const factory Evolution({
    required int id,
    required String content,
    int? patientProcedureRecordId,
    int? userId,
    String? userName,
    String? recordedAt,
  }) = _Evolution;

  const Evolution._();

  factory Evolution.fromJson(Map<String, dynamic> json) =>
      _$EvolutionFromJson(json);

  /// Contenido como texto simple, para mostrarlo y editarlo en la app.
  String get text => ClinicalText.fromHtml(content);
}

/// Medicamento (clasificación MED) despachado con el procedimiento.
@freezed
abstract class ProcedureMedication with _$ProcedureMedication {
  const factory ProcedureMedication({
    required String productName,
    String? lotNumber,
    String? expirationDate,
    @DoubleConverter() double? quantity,
  }) = _ProcedureMedication;

  factory ProcedureMedication.fromJson(Map<String, dynamic> json) =>
      _$ProcedureMedicationFromJson(json);
}
