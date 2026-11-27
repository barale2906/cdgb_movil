import 'package:flutter/foundation.dart';

/// Estado de facturación por el que se filtra el listado de órdenes.
enum OrderBillingFilter {
  all(null),
  unbilled('null'),
  billed('billed'),
  cancelled('cancelled')
  ;

  const OrderBillingFilter(this.value);

  /// Valor de `billing_status` que entiende el servidor (`null` = sin filtro).
  final String? value;
}

/// Filtros del listado de órdenes (`GET /service-orders`).
@immutable
class OrderQuery {
  const OrderQuery({
    this.search = '',
    this.billing = OrderBillingFilter.all,
  });

  final String search;
  final OrderBillingFilter billing;

  static final RegExp _digitsOnly = RegExp(r'^\d+$');

  /// Solo dígitos es un documento de paciente; cualquier otro texto, un número
  /// de orden (p. ej. `OS-20261126`). El servidor busca de forma parcial.
  Map<String, Object> toParams() {
    final text = search.trim();
    return {
      if (text.isNotEmpty)
        (_digitsOnly.hasMatch(text) ? 'patient_document' : 'order_number'): text
            .toUpperCase(),
      'billing_status': ?billing.value,
    };
  }

  @override
  bool operator ==(Object other) =>
      other is OrderQuery && other.search == search && other.billing == billing;

  @override
  int get hashCode => Object.hash(search, billing);
}
