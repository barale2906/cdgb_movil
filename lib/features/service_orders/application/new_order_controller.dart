import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/clinical/clinical_lookup.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/idempotency.dart';
import 'package:sga_bojanini/core/utils/clinical_text.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/service_orders/application/order_draft.dart';
import 'package:sga_bojanini/features/service_orders/data/new_order_request.dart';
import 'package:sga_bojanini/features/service_orders/data/service_order.dart';
import 'package:sga_bojanini/features/service_orders/data/service_orders_repository.dart';

@immutable
class NewOrderState {
  const NewOrderState({
    required this.serviceDate,
    this.patient,
    this.seller = '',
    this.referrer = '',
    this.notes = '',
    this.lines = const [],
    this.isSubmitting = false,
    this.error,
    this.created,
  });

  final MedsysPatient? patient;
  final DateTime serviceDate;
  final String seller;
  final String referrer;
  final String notes;
  final List<OrderLine> lines;
  final bool isSubmitting;
  final ApiException? error;

  /// Orden ya creada: no se vuelve a enviar.
  final ServiceOrder? created;

  double get total => lines.fold(0, (sum, line) => sum + line.total);

  double get totalDiscount =>
      lines.fold(0, (sum, line) => sum + line.discountAmount);

  double get netTotal => total - totalDiscount;

  bool get hasDiscount => lines.any((line) => line.hasDiscount);

  /// El envío anterior no tuvo respuesta: la orden pudo haberse creado.
  bool get isUnconfirmed =>
      error is NetworkException &&
      (error! as NetworkException).kind == NetworkFailureKind.timeout;

  bool canSubmit(DateTime today) =>
      !isSubmitting &&
      !isUnconfirmed &&
      created == null &&
      patient != null &&
      !serviceDate.isAfter(today) &&
      lines.isNotEmpty &&
      lines.every((line) => line.isValid);

  NewOrderState copyWith({
    MedsysPatient? Function()? patient,
    DateTime? serviceDate,
    String? seller,
    String? referrer,
    String? notes,
    List<OrderLine>? lines,
    bool? isSubmitting,
    ApiException? Function()? error,
    ServiceOrder? created,
  }) => NewOrderState(
    patient: patient == null ? this.patient : patient(),
    serviceDate: serviceDate ?? this.serviceDate,
    seller: seller ?? this.seller,
    referrer: referrer ?? this.referrer,
    notes: notes ?? this.notes,
    lines: lines ?? this.lines,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    error: error == null ? this.error : error(),
    created: created ?? this.created,
  );
}

/// Nueva orden de servicio: paciente de MedSys y uno o más procedimientos con
/// descuento e insumos opcionales. Se envía **sin reintentos automáticos**:
/// tras un timeout el usuario revisa si la orden se creó antes de repetir, y
/// el reenvío lleva la misma clave de idempotencia.
class NewOrderNotifier extends Notifier<NewOrderState> {
  int _nextKey = 0;
  final _keys = IdempotencyKeyHolder();

  @override
  NewOrderState build() => NewOrderState(serviceDate: _today());

  DateTime _today() {
    final now = ColombiaTime.now(ref.read(clockProvider));
    return DateTime(now.year, now.month, now.day);
  }

  void setPatient(MedsysPatient patient) =>
      state = state.copyWith(patient: () => patient);

  void setServiceDate(DateTime date) =>
      state = state.copyWith(serviceDate: date);

  void setSeller(String value) => state = state.copyWith(seller: value);

  void setReferrer(String value) => state = state.copyWith(referrer: value);

  void setNotes(String value) => state = state.copyWith(notes: value);

  void addLine(ProcedureMatch procedure) {
    final line = OrderLine(
      key: _nextKey++,
      procedure: procedure,
      unitPrice: procedure.unitPrice,
    );
    state = state.copyWith(lines: [...state.lines, line]);
    unawaited(_loadTemplate(line.key, procedure.id));
  }

  /// Precarga la plantilla de evolución del procedimiento si el usuario puede
  /// verla. Es una ayuda: si falla o no hay plantilla, no pasa nada.
  Future<void> _loadTemplate(int key, int serviceId) async {
    if (!ref.read(permissionServiceProvider).can('plantillas_clinicas.ver')) {
      return;
    }
    try {
      final template = await ref
          .read(clinicalLookupRepositoryProvider)
          .template(serviceId);
      if (template == null || !ref.mounted) return;
      _update(
        key,
        (line) => line.evolution.trim().isEmpty
            ? line.copyWith(evolution: ClinicalText.fromHtml(template.content))
            : line,
      );
    } on ApiException {
      return;
    }
  }

  void setEvolution(int key, String text) =>
      _update(key, (line) => line.copyWith(evolution: text));

  void removeLine(int key) => state = state.copyWith(
    lines: [
      for (final line in state.lines)
        if (line.key != key) line,
    ],
  );

  void setQuantity(int key, int? value) =>
      _update(key, (line) => line.copyWith(quantity: () => value));

  void setUnitPrice(int key, double? value) =>
      _update(key, (line) => line.copyWith(unitPrice: () => value));

  /// Sin tipo no hay descuento: se quita también su valor.
  void setDiscountKind(int key, DiscountKind? kind) => _update(
    key,
    (line) => line.copyWith(
      discountKind: () => kind,
      discountValue: () => kind == null ? null : line.discountValue,
    ),
  );

  void setDiscountValue(int key, double? value) =>
      _update(key, (line) => line.copyWith(discountValue: () => value));

  void setWarehouse(int key, int? warehouseId) =>
      _update(key, (line) => line.copyWith(warehouseId: () => warehouseId));

  void addSupply(int lineKey, GenericProduct product) => _update(
    lineKey,
    (line) => line.copyWith(
      supplies: [
        ...line.supplies,
        SupplyDraft(key: _nextKey++, product: product),
      ],
    ),
  );

  void setSupplyQuantity(int lineKey, int supplyKey, double? quantity) =>
      _update(
        lineKey,
        (line) => line.copyWith(
          supplies: [
            for (final supply in line.supplies)
              if (supply.key == supplyKey)
                supply.withQuantity(quantity)
              else
                supply,
          ],
        ),
      );

  void removeSupply(int lineKey, int supplyKey) => _update(
    lineKey,
    (line) => line.copyWith(
      supplies: [
        for (final supply in line.supplies)
          if (supply.key != supplyKey) supply,
      ],
      // Sin insumos ya no hace falta almacén.
      warehouseId: line.supplies.length > 1 ? null : () => null,
    ),
  );

  /// El usuario revisó los registros del paciente y confirma que la orden sin
  /// respuesta no se creó: se puede volver a enviar.
  void acknowledgeNotCreated() {
    if (state.isUnconfirmed) state = state.copyWith(error: () => null);
  }

  void _update(int key, OrderLine Function(OrderLine) change) {
    state = state.copyWith(
      lines: [
        for (final line in state.lines)
          if (line.key == key) change(line) else line,
      ],
    );
  }

  /// Envía la orden. Devuelve la orden creada o `null` si falló (el error
  /// queda en el estado).
  Future<ServiceOrder?> submit() async {
    final patient = state.patient;
    if (patient == null || !state.canSubmit(_today())) return null;
    state = state.copyWith(isSubmitting: true, error: () => null);
    final names = patient.splitName;
    final request = NewOrderRequest(
      patientExternalId: patient.code,
      patientDocument: patient.document,
      patientFirstName: names.first,
      patientLastName: names.last,
      patientEmail: patient.email,
      patientAddress: patient.address,
      patientPhone: patient.phone,
      serviceDate: ColombiaTime.formatDate(state.serviceDate),
      seller: state.seller,
      referrer: state.referrer,
      notes: state.notes,
      lines: [for (final line in state.lines) _request(line)],
    );
    // La misma clave mientras la orden no cambie: si tras un tiempo de espera
    // el usuario confirma que no se creó y repite, un envío ya guardado no se
    // duplica.
    final key = _keys.keyFor(request.toJson());
    try {
      final order = await ref
          .read(serviceOrdersRepositoryProvider)
          .create(request, idempotencyKey: key);
      _keys.release();
      if (!ref.mounted) return null;
      state = state.copyWith(isSubmitting: false, created: order);
      return order;
    } on ApiException catch (error) {
      _keys.settle(succeeded: false, error: error);
      if (!ref.mounted) return null;
      state = state.copyWith(isSubmitting: false, error: () => error);
      return null;
    }
  }

  OrderLineRequest _request(OrderLine line) => OrderLineRequest(
    medicalServiceId: line.procedure.id,
    quantity: line.quantity!.toDouble(),
    unitPrice: line.unitPrice!,
    discountType: line.discountKind?.value,
    discountValue: line.discountValue,
    notes: line.evolutionHtml,
    supplies: [
      for (final supply in line.supplies)
        SupplyRequest(
          warehouseId: line.warehouseId!,
          genericProductId: supply.product.id,
          quantity: supply.quantity!,
        ),
    ],
  );
}

final NotifierProvider<NewOrderNotifier, NewOrderState> newOrderProvider =
    NotifierProvider.autoDispose<NewOrderNotifier, NewOrderState>(
      NewOrderNotifier.new,
    );
