import 'package:flutter/foundation.dart';

/// Cuerpo de `POST /patient-procedure-records`: un servicio vendido a un
/// paciente, sin movimiento de inventario.
@immutable
class SaleRecordRequest {
  const SaleRecordRequest({
    required this.medicalServiceId,
    required this.patientExternalId,
    required this.patientDocument,
    required this.patientFirstName,
    required this.patientLastName,
    required this.quantity,
    required this.unitPrice,
    required this.serviceDate,
    required this.seller,
    required this.referrer,
  });

  final int medicalServiceId;
  final String patientExternalId;
  final String patientDocument;
  final String patientFirstName;
  final String patientLastName;
  final int quantity;
  final double unitPrice;

  /// `AAAA-MM-DD`.
  final String serviceDate;
  final String seller;
  final String referrer;

  Map<String, Object> toJson() => {
    'medical_service_id': medicalServiceId,
    'patient_external_id': patientExternalId,
    'patient_document': patientDocument,
    'patient_first_name': patientFirstName,
    'patient_last_name': patientLastName,
    'quantity': quantity,
    'unit_price': unitPrice,
    'service_date': serviceDate,
    'seller': seller,
    'referrer': referrer,
  };
}
