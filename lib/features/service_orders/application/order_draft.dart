import 'package:flutter/foundation.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/utils/clinical_text.dart';

/// Largo máximo de la evolución de un procedimiento ya convertida a HTML (el
/// servidor valida `procedures.*.notes` con `max:500`).
const maxEvolutionLength = 500;

/// Tipo de descuento de una línea.
enum DiscountKind {
  percentage('percentage'),
  fixed('fixed')
  ;

  const DiscountKind(this.value);

  final String value;
}

/// Insumo que sale del inventario con el procedimiento.
@immutable
class SupplyDraft {
  const SupplyDraft({required this.key, required this.product, this.quantity});

  final int key;
  final GenericProduct product;
  final double? quantity;

  bool get isValid => (quantity ?? 0) > 0;

  SupplyDraft withQuantity(double? value) =>
      SupplyDraft(key: key, product: product, quantity: value);
}

/// Un procedimiento de la orden con su descuento e insumos opcionales.
@immutable
class OrderLine {
  const OrderLine({
    required this.key,
    required this.procedure,
    this.quantity = 1,
    this.unitPrice,
    this.discountKind,
    this.discountValue,
    this.warehouseId,
    this.evolution = '',
    this.supplies = const [],
  });

  final int key;
  final ProcedureMatch procedure;
  final int? quantity;
  final double? unitPrice;
  final DiscountKind? discountKind;
  final double? discountValue;

  /// Almacén de donde salen todos los insumos de la línea (el servidor usa
  /// el del primero para toda la salida).
  final int? warehouseId;

  /// Evolución clínica del procedimiento, en texto simple (obligatoria, como
  /// en el web).
  final String evolution;
  final List<SupplyDraft> supplies;

  /// Lo que se envía: párrafos HTML.
  String get evolutionHtml => ClinicalText.toHtml(evolution);

  bool get isEvolutionValid =>
      evolutionHtml.isNotEmpty && evolutionHtml.length <= maxEvolutionLength;

  double get total => (quantity ?? 0) * (unitPrice ?? 0);

  double get discountAmount {
    final value = discountValue ?? 0;
    return switch (discountKind) {
      null => 0,
      DiscountKind.percentage => total * value / 100,
      DiscountKind.fixed => value,
    };
  }

  double get netTotal => total - discountAmount;

  bool get hasDiscount => discountKind != null;

  /// El descuento debe ser mayor que cero y menor que el total de la línea.
  bool get isDiscountValid {
    if (!hasDiscount) return true;
    final value = discountValue ?? 0;
    if (value <= 0) return false;
    return switch (discountKind!) {
      DiscountKind.percentage => value <= 100,
      DiscountKind.fixed => value < total,
    };
  }

  bool get areSuppliesValid =>
      supplies.isEmpty ||
      (warehouseId != null && supplies.every((s) => s.isValid));

  bool get isValid =>
      (quantity ?? 0) >= 1 &&
      (unitPrice ?? -1) >= 0 &&
      isDiscountValid &&
      areSuppliesValid &&
      isEvolutionValid;

  OrderLine copyWith({
    int? Function()? quantity,
    double? Function()? unitPrice,
    DiscountKind? Function()? discountKind,
    double? Function()? discountValue,
    int? Function()? warehouseId,
    String? evolution,
    List<SupplyDraft>? supplies,
  }) => OrderLine(
    key: key,
    procedure: procedure,
    quantity: quantity == null ? this.quantity : quantity(),
    unitPrice: unitPrice == null ? this.unitPrice : unitPrice(),
    discountKind: discountKind == null ? this.discountKind : discountKind(),
    discountValue: discountValue == null ? this.discountValue : discountValue(),
    warehouseId: warehouseId == null ? this.warehouseId : warehouseId(),
    evolution: evolution ?? this.evolution,
    supplies: supplies ?? this.supplies,
  );
}
