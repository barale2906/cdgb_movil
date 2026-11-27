import 'package:flutter/foundation.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/assets/data/asset_maintenance.dart';

/// Quién ejecuta el mantenimiento: personal propio o un proveedor.
enum Performer {
  internal('internal'),
  external('external')
  ;

  const Performer(this.value);

  final String value;

  static Performer parse(Object? raw) =>
      raw == 'external' ? Performer.external : Performer.internal;
}

/// Unidad de la frecuencia de un plan.
enum FrequencyUnit {
  days('days'),
  months('months')
  ;

  const FrequencyUnit(this.value);

  final String value;

  static FrequencyUnit parse(Object? raw) =>
      raw == 'months' ? FrequencyUnit.months : FrequencyUnit.days;
}

/// Tipos que admiten un plan periódico (el correctivo surge de una falla).
const List<MaintenanceType> plannableMaintenanceTypes = [
  MaintenanceType.preventive,
  MaintenanceType.calibration,
  MaintenanceType.metrologicalVerification,
  MaintenanceType.inspection,
];

/// Programación puntual de un mantenimiento (`POST /assets/{id}/maintenances`).
@immutable
class ScheduleMaintenanceRequest {
  const ScheduleMaintenanceRequest({
    required this.type,
    required this.scheduledDate,
    this.reportedFailure,
    this.performer,
    this.technicianId,
    this.supplierId,
  });

  final MaintenanceType type;
  final DateTime scheduledDate;

  /// Obligatoria en el mantenimiento correctivo.
  final String? reportedFailure;
  final Performer? performer;
  final int? technicianId;
  final int? supplierId;

  Map<String, Object> toJson() => {
    'maintenance_type': type.value,
    'scheduled_date': ColombiaTime.formatDate(scheduledDate),
    if ((reportedFailure ?? '').trim().isNotEmpty)
      'reported_failure': reportedFailure!.trim(),
    if (performer != null) 'performed_by_type': performer!.value,
    'technician_id': ?(performer == Performer.internal ? technicianId : null),
    'supplier_id': ?(performer == Performer.external ? supplierId : null),
  };
}

/// Plan periódico (`POST /assets/{id}/maintenance-plans` y `PUT …/{id}`).
@immutable
class MaintenancePlanRequest {
  const MaintenancePlanRequest({
    required this.type,
    required this.frequencyValue,
    required this.frequencyUnit,
    required this.startDate,
    required this.performer,
    this.technicianId,
    this.supplierId,
    this.notes,
    this.isActive = true,
  });

  final MaintenanceType type;
  final int frequencyValue;
  final FrequencyUnit frequencyUnit;
  final DateTime startDate;
  final Performer performer;
  final int? technicianId;
  final int? supplierId;
  final String? notes;
  final bool isActive;

  /// Los campos opcionales viajan como `null` cuando no aplican para que, al
  /// editar, el servidor borre el valor anterior (p. ej. al pasar de técnico
  /// propio a proveedor).
  Map<String, Object?> toJson() => {
    'maintenance_type': type.value,
    'frequency_value': frequencyValue,
    'frequency_unit': frequencyUnit.value,
    'start_date': ColombiaTime.formatDate(startDate),
    'performed_by_type': performer.value,
    'technician_id': performer == Performer.internal ? technicianId : null,
    'supplier_id': performer == Performer.external ? supplierId : null,
    'notes': (notes ?? '').trim().isEmpty ? null : notes!.trim(),
    'is_active': isActive,
  };
}
