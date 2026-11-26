// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicalTemplate _$ClinicalTemplateFromJson(Map<String, dynamic> json) =>
    _ClinicalTemplate(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      medicalServiceId: (json['medical_service_id'] as num?)?.toInt(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ClinicalTemplateToJson(_ClinicalTemplate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'medical_service_id': instance.medicalServiceId,
      'title': instance.title,
    };
