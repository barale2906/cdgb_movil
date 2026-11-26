// MedSys usa los nombres de columna de su base (`codcontrol`, `fecha`…), que
// la conversión automática a snake_case no produce.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'medsys_patient.freezed.dart';
part 'medsys_patient.g.dart';

/// Cita de un paciente en MedSys. Los nombres de campo del servidor son los
/// de la base de MedSys (`codcontrol`, `fecha`, `hora`…).
@freezed
abstract class MedsysAppointment with _$MedsysAppointment {
  const factory MedsysAppointment({
    @JsonKey(name: 'codcontrol') required String controlCode,
    @JsonKey(name: 'fecha') String? date,
    @JsonKey(name: 'hora') String? time,
    @JsonKey(name: 'servicio') String? serviceName,
    @JsonKey(name: 'estado') String? status,
  }) = _MedsysAppointment;

  factory MedsysAppointment.fromJson(Map<String, dynamic> json) =>
      _$MedsysAppointmentFromJson(json);
}

/// Paciente de MedSys. Solo se leen los datos que la app muestra (mínimo
/// necesario, Ley 1581): código, documento, nombre y últimas citas.
@freezed
abstract class MedsysPatient with _$MedsysPatient {
  const factory MedsysPatient({
    @JsonKey(name: 'codigo') required String code,
    @JsonKey(name: 'documento') required String document,
    @JsonKey(name: 'nombre') required String name,
    @JsonKey(name: 'tipodoc') String? documentType,
    @Default([]) List<MedsysAppointment> recentAppointments,
  }) = _MedsysPatient;

  const MedsysPatient._();

  factory MedsysPatient.fromJson(Map<String, dynamic> json) =>
      _$MedsysPatientFromJson(json);

  /// Nombre sin espacios dobles (MedSys concatena campos que pueden venir
  /// vacíos).
  String get displayName => name.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Nombres y apellidos por separado, como los pide el servidor. MedSys
  /// entrega `nombre1 nombre2 apellido1 apellido2` en un solo texto: con 4 o
  /// más palabras los dos primeros son los nombres; con 3, un nombre y dos
  /// apellidos (la misma regla del web).
  ({String first, String last}) get splitName {
    final parts = displayName.split(' ');
    return switch (parts.length) {
      >= 4 => (first: parts.take(2).join(' '), last: parts.skip(2).join(' ')),
      3 => (first: parts.first, last: parts.skip(1).join(' ')),
      2 => (first: parts.first, last: parts.last),
      _ => (first: displayName, last: ''),
    };
  }
}
