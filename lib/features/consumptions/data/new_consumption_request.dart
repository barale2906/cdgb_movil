import 'package:flutter/foundation.dart';

/// Un insumo consumido.
@immutable
class ConsumptionItemRequest {
  const ConsumptionItemRequest({
    required this.genericProductId,
    required this.quantity,
  });

  final int genericProductId;
  final int quantity;

  Map<String, Object> toJson() => {
    'generic_product_id': genericProductId,
    'quantity': quantity,
  };
}

/// Cuerpo de `POST /consumptions`. Con cita **y** paciente el servidor además
/// sincroniza el consumo con la historia clínica.
@immutable
class NewConsumptionRequest {
  const NewConsumptionRequest({
    required this.warehouseId,
    required this.costCenterId,
    required this.items,
    this.appointmentId,
    this.patientIdentifier,
    this.serviceType,
  });

  final int warehouseId;
  final int costCenterId;
  final List<ConsumptionItemRequest> items;
  final String? appointmentId;
  final String? patientIdentifier;
  final String? serviceType;

  Map<String, Object> toJson() => {
    'warehouse_id': warehouseId,
    'cost_center_id': costCenterId,
    'items': [for (final item in items) item.toJson()],
    ...?_optional('appointment_id', appointmentId),
    ...?_optional('patient_identifier', patientIdentifier),
    ...?_optional('service_type', serviceType),
  };

  static Map<String, Object>? _optional(String key, String? value) =>
      value == null || value.trim().isEmpty ? null : {key: value.trim()};
}
