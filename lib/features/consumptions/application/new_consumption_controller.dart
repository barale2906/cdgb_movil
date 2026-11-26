import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/features/consumptions/data/consumptions_repository.dart';
import 'package:sga_bojanini/features/consumptions/data/new_consumption_request.dart';

/// Un insumo del consumo con su cantidad (entera, como pide el servidor).
@immutable
class ConsumptionLine {
  const ConsumptionLine({
    required this.key,
    required this.product,
    this.quantity = 1,
  });

  final int key;
  final GenericProduct product;
  final int? quantity;

  bool get isValid => (quantity ?? 0) >= 1;
}

@immutable
class NewConsumptionState {
  const NewConsumptionState({
    this.warehouseId,
    this.costCenterId,
    this.appointmentId = '',
    this.patientIdentifier = '',
    this.serviceType = '',
    this.lines = const [],
    this.isSubmitting = false,
    this.error,
    this.saved = false,
  });

  final int? warehouseId;
  final int? costCenterId;
  final String appointmentId;
  final String patientIdentifier;
  final String serviceType;
  final List<ConsumptionLine> lines;
  final bool isSubmitting;
  final ApiException? error;

  /// Ya se registró: no se vuelve a enviar.
  final bool saved;

  /// El envío anterior no tuvo respuesta: el consumo pudo haberse registrado.
  bool get isUnconfirmed =>
      error is NetworkException &&
      (error! as NetworkException).kind == NetworkFailureKind.timeout;

  bool get canSubmit =>
      !isSubmitting &&
      !isUnconfirmed &&
      !saved &&
      warehouseId != null &&
      costCenterId != null &&
      lines.isNotEmpty &&
      lines.every((line) => line.isValid);

  NewConsumptionState copyWith({
    int? Function()? warehouseId,
    int? Function()? costCenterId,
    String? appointmentId,
    String? patientIdentifier,
    String? serviceType,
    List<ConsumptionLine>? lines,
    bool? isSubmitting,
    ApiException? Function()? error,
    bool? saved,
  }) => NewConsumptionState(
    warehouseId: warehouseId == null ? this.warehouseId : warehouseId(),
    costCenterId: costCenterId == null ? this.costCenterId : costCenterId(),
    appointmentId: appointmentId ?? this.appointmentId,
    patientIdentifier: patientIdentifier ?? this.patientIdentifier,
    serviceType: serviceType ?? this.serviceType,
    lines: lines ?? this.lines,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    error: error == null ? this.error : error(),
    saved: saved ?? this.saved,
  );
}

/// Registrar el consumo de insumos de un procedimiento. Se envía una sola vez
/// y sin reintentos; el servidor lo guarda todo o nada.
class NewConsumptionNotifier extends Notifier<NewConsumptionState> {
  int _nextKey = 0;

  @override
  NewConsumptionState build() =>
      // Propone el almacén activo del usuario.
      NewConsumptionState(warehouseId: ref.read(activeWarehouseProvider)?.id);

  void setWarehouse(int? id) => state = state.copyWith(warehouseId: () => id);

  void setCostCenter(int? id) => state = state.copyWith(costCenterId: () => id);

  void setAppointment(String value) =>
      state = state.copyWith(appointmentId: value);

  void setPatient(String value) =>
      state = state.copyWith(patientIdentifier: value);

  void setServiceType(String value) =>
      state = state.copyWith(serviceType: value);

  void addLine(GenericProduct product) => state = state.copyWith(
    lines: [
      ...state.lines,
      ConsumptionLine(key: _nextKey++, product: product),
    ],
  );

  void setQuantity(int key, int? quantity) => state = state.copyWith(
    lines: [
      for (final line in state.lines)
        if (line.key == key)
          ConsumptionLine(key: key, product: line.product, quantity: quantity)
        else
          line,
    ],
  );

  void removeLine(int key) => state = state.copyWith(
    lines: [
      for (final line in state.lines)
        if (line.key != key) line,
    ],
  );

  /// El usuario revisó la lista de consumos y confirma que el envío sin
  /// respuesta no se registró.
  void acknowledgeNotSaved() {
    if (state.isUnconfirmed) state = state.copyWith(error: () => null);
  }

  /// Envía el consumo. Devuelve `true` si el servidor lo registró.
  Future<bool> submit() async {
    final warehouseId = state.warehouseId;
    final costCenterId = state.costCenterId;
    if (warehouseId == null || costCenterId == null || !state.canSubmit) {
      return false;
    }
    state = state.copyWith(isSubmitting: true, error: () => null);
    try {
      await ref
          .read(consumptionsRepositoryProvider)
          .create(
            NewConsumptionRequest(
              warehouseId: warehouseId,
              costCenterId: costCenterId,
              appointmentId: state.appointmentId,
              patientIdentifier: state.patientIdentifier,
              serviceType: state.serviceType,
              items: [
                for (final line in state.lines)
                  ConsumptionItemRequest(
                    genericProductId: line.product.id,
                    quantity: line.quantity!,
                  ),
              ],
            ),
          );
      if (!ref.mounted) return false;
      state = state.copyWith(isSubmitting: false, saved: true);
      return true;
    } on ApiException catch (error) {
      if (!ref.mounted) return false;
      state = state.copyWith(isSubmitting: false, error: () => error);
      return false;
    }
  }
}

final NotifierProvider<NewConsumptionNotifier, NewConsumptionState>
newConsumptionProvider =
    NotifierProvider.autoDispose<NewConsumptionNotifier, NewConsumptionState>(
      NewConsumptionNotifier.new,
    );
