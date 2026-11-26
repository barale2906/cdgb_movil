// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medsys_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MedsysAppointment _$MedsysAppointmentFromJson(Map<String, dynamic> json) =>
    _MedsysAppointment(
      controlCode: json['codcontrol'] as String,
      date: json['fecha'] as String?,
      time: json['hora'] as String?,
      serviceName: json['servicio'] as String?,
      status: json['estado'] as String?,
    );

Map<String, dynamic> _$MedsysAppointmentToJson(_MedsysAppointment instance) =>
    <String, dynamic>{
      'codcontrol': instance.controlCode,
      'fecha': instance.date,
      'hora': instance.time,
      'servicio': instance.serviceName,
      'estado': instance.status,
    };

_MedsysPatient _$MedsysPatientFromJson(Map<String, dynamic> json) =>
    _MedsysPatient(
      code: json['codigo'] as String,
      document: json['documento'] as String,
      name: json['nombre'] as String,
      documentType: json['tipodoc'] as String?,
      recentAppointments:
          (json['recent_appointments'] as List<dynamic>?)
              ?.map(
                (e) => MedsysAppointment.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MedsysPatientToJson(_MedsysPatient instance) =>
    <String, dynamic>{
      'codigo': instance.code,
      'documento': instance.document,
      'nombre': instance.name,
      'tipodoc': instance.documentType,
      'recent_appointments': instance.recentAppointments
          .map((e) => e.toJson())
          .toList(),
    };
