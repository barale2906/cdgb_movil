import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';
import 'package:sga_bojanini/features/clinical/data/sale_request.dart';

/// Estado de una línea de la venta frente al servidor.
enum SaleLineStatus {
  /// Aún no se envía.
  draft,

  /// Registrada en el servidor: ya no se edita ni se vuelve a enviar.
  saved,

  /// El servidor la rechazó; se puede corregir y reenviar.
  failed,

  /// Sin respuesta (timeout): pudo haberse registrado. No se reenvía sola;
  /// el usuario revisa el historial y decide.
  unconfirmed,
}

/// Un servicio de la venta con su cantidad y precio.
@immutable
class SaleLine {
  const SaleLine({
    required this.key,
    required this.procedure,
    this.quantity = 1,
    this.unitPrice,
    this.status = SaleLineStatus.draft,
    this.error,
  });

  /// Identidad estable para la interfaz (las líneas se pueden quitar).
  final int key;
  final ProcedureMatch procedure;
  final int? quantity;
  final double? unitPrice;
  final SaleLineStatus status;
  final ApiException? error;

  bool get isSendable =>
      status == SaleLineStatus.draft || status == SaleLineStatus.failed;

  bool get isEditable => status != SaleLineStatus.saved;

  bool get isValid => (quantity ?? 0) >= 1 && (unitPrice ?? -1) >= 0;

  double get subtotal => (quantity ?? 0) * (unitPrice ?? 0);

  SaleLine copyWith({
    int? Function()? quantity,
    double? Function()? unitPrice,
    SaleLineStatus? status,
    ApiException? Function()? error,
  }) => SaleLine(
    key: key,
    procedure: procedure,
    quantity: quantity == null ? this.quantity : quantity(),
    unitPrice: unitPrice == null ? this.unitPrice : unitPrice(),
    status: status ?? this.status,
    error: error == null ? this.error : error(),
  );
}

@immutable
class SaleState {
  const SaleState({
    required this.serviceDate,
    this.patient,
    this.seller = '',
    this.referrer = '',
    this.lines = const [],
    this.isSubmitting = false,
  });

  final MedsysPatient? patient;
  final DateTime serviceDate;
  final String seller;
  final String referrer;
  final List<SaleLine> lines;
  final bool isSubmitting;

  bool get hasSaved => lines.any((l) => l.status == SaleLineStatus.saved);

  /// Todas las líneas quedaron registradas.
  bool get isComplete =>
      lines.isNotEmpty && lines.every((l) => l.status == SaleLineStatus.saved);

  double get total => lines.fold(0, (sum, line) => sum + line.subtotal);

  Iterable<SaleLine> get sendable => lines.where((l) => l.isSendable);

  /// Hay datos suficientes y válidos para enviar lo pendiente.
  bool canSubmit(DateTime today) =>
      !isSubmitting &&
      patient != null &&
      seller.trim().isNotEmpty &&
      referrer.trim().isNotEmpty &&
      !serviceDate.isAfter(today) &&
      sendable.isNotEmpty &&
      sendable.every((l) => l.isValid);

  SaleState copyWith({
    MedsysPatient? Function()? patient,
    DateTime? serviceDate,
    String? seller,
    String? referrer,
    List<SaleLine>? lines,
    bool? isSubmitting,
  }) => SaleState(
    patient: patient == null ? this.patient : patient(),
    serviceDate: serviceDate ?? this.serviceDate,
    seller: seller ?? this.seller,
    referrer: referrer ?? this.referrer,
    lines: lines ?? this.lines,
    isSubmitting: isSubmitting ?? this.isSubmitting,
  );
}

/// Venta de servicios a un paciente (equivale a `sale-dialog` del web): un
/// `POST patient-procedure-records` por servicio, sin movimiento de
/// inventario.
///
/// Las líneas se envían **una por una y sin reintentos automáticos** (la API
/// no tiene idempotencia). Al primer fallo se detiene: lo ya registrado
/// queda marcado y no se vuelve a enviar.
class SaleNotifier extends Notifier<SaleState> {
  int _nextKey = 0;

  @override
  SaleState build() => SaleState(serviceDate: _today());

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

  void addLine(ProcedureMatch procedure) {
    final line = SaleLine(
      key: _nextKey++,
      procedure: procedure,
      unitPrice: procedure.unitPrice,
    );
    state = state.copyWith(lines: [...state.lines, line]);
  }

  void setQuantity(int key, int? quantity) =>
      _update(key, (line) => line.copyWith(quantity: () => quantity));

  void setUnitPrice(int key, double? price) =>
      _update(key, (line) => line.copyWith(unitPrice: () => price));

  void removeLine(int key) => state = state.copyWith(
    lines: [
      for (final line in state.lines)
        if (line.key != key || !line.isEditable) line,
    ],
  );

  /// El usuario revisó el historial y confirma que la línea sin respuesta no
  /// se registró: vuelve a quedar lista para enviarse.
  void markAsNotRegistered(int key) => _update(
    key,
    (line) => line.status == SaleLineStatus.unconfirmed
        ? line.copyWith(status: SaleLineStatus.draft, error: () => null)
        : line,
  );

  void _update(int key, SaleLine Function(SaleLine) change) {
    state = state.copyWith(
      lines: [
        for (final line in state.lines)
          if (line.key == key && line.isEditable) change(line) else line,
      ],
    );
  }

  /// Envía las líneas pendientes. Devuelve `true` si toda la venta quedó
  /// registrada.
  Future<bool> submit() async {
    final patient = state.patient;
    if (patient == null || !state.canSubmit(_today())) return false;
    state = state.copyWith(isSubmitting: true);
    final repository = ref.read(clinicalRepositoryProvider);
    final names = patient.splitName;
    for (final line in state.sendable.toList()) {
      try {
        await repository.createRecord(
          SaleRecordRequest(
            medicalServiceId: line.procedure.id,
            patientExternalId: patient.code,
            patientDocument: patient.document,
            patientFirstName: names.first,
            patientLastName: names.last,
            quantity: line.quantity!,
            unitPrice: line.unitPrice!,
            serviceDate: ColombiaTime.formatDate(state.serviceDate),
            seller: state.seller.trim(),
            referrer: state.referrer.trim(),
          ),
        );
        if (!ref.mounted) return false;
        _mark(line.key, SaleLineStatus.saved, null);
      } on ApiException catch (error) {
        if (!ref.mounted) return false;
        final noReply =
            error is NetworkException &&
            error.kind == NetworkFailureKind.timeout;
        _mark(
          line.key,
          noReply ? SaleLineStatus.unconfirmed : SaleLineStatus.failed,
          error,
        );
        break;
      }
    }
    state = state.copyWith(isSubmitting: false);
    return state.isComplete;
  }

  void _mark(int key, SaleLineStatus status, ApiException? error) {
    state = state.copyWith(
      lines: [
        for (final line in state.lines)
          if (line.key == key)
            line.copyWith(status: status, error: () => error)
          else
            line,
      ],
    );
  }
}

final NotifierProvider<SaleNotifier, SaleState> saleProvider =
    NotifierProvider.autoDispose<SaleNotifier, SaleState>(SaleNotifier.new);
