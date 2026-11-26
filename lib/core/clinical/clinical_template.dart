import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinical_template.freezed.dart';
part 'clinical_template.g.dart';

/// Plantilla de evolución clínica de un servicio o procedimiento. Su
/// `content` viene como HTML del web.
@freezed
abstract class ClinicalTemplate with _$ClinicalTemplate {
  const factory ClinicalTemplate({
    required int id,
    required String content,
    int? medicalServiceId,
    String? title,
  }) = _ClinicalTemplate;

  factory ClinicalTemplate.fromJson(Map<String, dynamic> json) =>
      _$ClinicalTemplateFromJson(json);
}
