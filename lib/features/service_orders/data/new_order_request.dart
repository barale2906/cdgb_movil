import 'package:flutter/foundation.dart';

/// Un insumo que sale del inventario al crear la orden. El servidor elige el
/// lote (FEFO) y usa el almacén del primer insumo de la línea para toda la
/// salida.
@immutable
class SupplyRequest {
  const SupplyRequest({
    required this.warehouseId,
    required this.genericProductId,
    required this.quantity,
  });

  final int warehouseId;
  final int genericProductId;
  final double quantity;

  Map<String, Object> toJson() => {
    'warehouse_id': warehouseId,
    'generic_product_id': genericProductId,
    'quantity': quantity,
  };
}

/// Un procedimiento de la orden, con descuento e insumos opcionales.
@immutable
class OrderLineRequest {
  const OrderLineRequest({
    required this.medicalServiceId,
    required this.quantity,
    required this.unitPrice,
    this.discountType,
    this.discountValue,
    this.supplies = const [],
  });

  final int medicalServiceId;
  final double quantity;
  final double unitPrice;

  /// `percentage` o `fixed`; sin descuento, ambos `null`.
  final String? discountType;
  final double? discountValue;
  final List<SupplyRequest> supplies;

  Map<String, Object> toJson() => {
    'medical_service_id': medicalServiceId,
    'quantity': quantity,
    'unit_price': unitPrice,
    if (discountType != null && discountValue != null) ...{
      'discount_type': discountType!,
      'discount_value': discountValue!,
    },
    if (supplies.isNotEmpty) 'supplies': [for (final s in supplies) s.toJson()],
  };
}

/// Cuerpo de `POST /service-orders`.
@immutable
class NewOrderRequest {
  const NewOrderRequest({
    required this.patientExternalId,
    required this.patientDocument,
    required this.patientFirstName,
    required this.patientLastName,
    required this.serviceDate,
    required this.lines,
    this.patientEmail,
    this.patientAddress,
    this.patientPhone,
    this.seller,
    this.referrer,
    this.notes,
  });

  final String patientExternalId;
  final String patientDocument;
  final String patientFirstName;
  final String patientLastName;
  final String? patientEmail;
  final String? patientAddress;
  final String? patientPhone;

  /// `AAAA-MM-DD`.
  final String serviceDate;
  final String? seller;
  final String? referrer;
  final String? notes;
  final List<OrderLineRequest> lines;

  Map<String, Object> toJson() => {
    'patient_external_id': patientExternalId,
    'patient_document': patientDocument,
    'patient_first_name': patientFirstName,
    'patient_last_name': patientLastName,
    'service_date': serviceDate,
    'procedures': [for (final line in lines) line.toJson()],
    ...?_optional('patient_email', patientEmail),
    ...?_optional('patient_address', patientAddress),
    ...?_optional('patient_phone', patientPhone),
    ...?_optional('seller', seller),
    ...?_optional('referrer', referrer),
    ...?_optional('notes', notes),
  };

  static Map<String, Object>? _optional(String key, String? value) =>
      value == null || value.trim().isEmpty ? null : {key: value.trim()};
}
