import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sga_bojanini/core/clinical/procedure_record.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

part 'service_order.freezed.dart';
part 'service_order.g.dart';

/// Estado de una orden según sus descuentos.
enum ServiceOrderStatus {
  approved('approved'),
  discountPending('discount_pending'),
  unknown('')
  ;

  const ServiceOrderStatus(this.value);

  final String value;

  static ServiceOrderStatus parse(Object? value) =>
      ServiceOrderStatus.values.firstWhere(
        (status) => status.value == value,
        orElse: () => ServiceOrderStatus.unknown,
      );
}

/// Un estado nuevo del backend no debe romper la pantalla.
class ServiceOrderStatusConverter
    implements JsonConverter<ServiceOrderStatus, Object?> {
  const ServiceOrderStatusConverter();

  @override
  ServiceOrderStatus fromJson(Object? json) => ServiceOrderStatus.parse(json);

  @override
  Object toJson(ServiceOrderStatus object) => object.value;
}

/// Orden de servicio (`ServiceOrderResource`): un paciente y uno o más
/// procedimientos bajo un mismo número.
@freezed
abstract class ServiceOrder with _$ServiceOrder {
  const factory ServiceOrder({
    required String orderNumber,
    required String patientExternalId,
    required String patientDocument,
    required String patientFirstName,
    required String patientLastName,
    @ServiceOrderStatusConverter()
    @Default(ServiceOrderStatus.unknown)
    ServiceOrderStatus orderStatus,
    String? serviceDate,
    String? billingStatus,
    @DoubleConverter() double? totalAmount,
    @DoubleConverter() double? totalDiscount,
    @DoubleConverter() double? netTotal,
    @Default([]) List<ProcedureRecord> procedures,
  }) = _ServiceOrder;

  const ServiceOrder._();

  factory ServiceOrder.fromJson(Map<String, dynamic> json) =>
      _$ServiceOrderFromJson(json);

  String get patientName => '$patientFirstName $patientLastName'.trim();

  bool get hasPendingDiscount =>
      orderStatus == ServiceOrderStatus.discountPending;

  bool get isBilled => billingStatus == 'billed';

  bool get isCancelled => billingStatus == 'cancelled';

  /// Facturar solo desde "sin facturar" y con los descuentos resueltos (el
  /// servidor permite más; la app es más estricta para no facturar un valor
  /// que todavía puede cambiar).
  bool get canBill => billingStatus == null && !hasPendingDiscount;

  /// Solo se anula una orden sin facturar: la facturada ya corresponde a la
  /// atención del paciente y el servidor la rechaza.
  bool get canCancel => billingStatus == null;
}

/// Orden con descuentos por aprobar (`GET /service-orders/discounts`).
@freezed
abstract class DiscountOrder with _$DiscountOrder {
  const factory DiscountOrder({
    required String orderNumber,
    required String patientDocument,
    required String patientFirstName,
    required String patientLastName,
    String? serviceDate,
    @Default([]) List<ProcedureRecord> records,
  }) = _DiscountOrder;

  const DiscountOrder._();

  factory DiscountOrder.fromJson(Map<String, dynamic> json) =>
      _$DiscountOrderFromJson(json);

  String get patientName => '$patientFirstName $patientLastName'.trim();

  double get totalDiscount =>
      records.fold(0, (sum, record) => sum + (record.discountAmount ?? 0));
}
