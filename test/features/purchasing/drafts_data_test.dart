import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/catalog/supplier.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/features/purchasing/application/draft_state.dart';
import 'package:sga_bojanini/features/purchasing/application/expense_draft_controller.dart';
import 'package:sga_bojanini/features/purchasing/application/purchase_draft_controller.dart';
import 'package:sga_bojanini/features/purchasing/data/expense_order.dart';
import 'package:sga_bojanini/features/purchasing/data/order_drafts.dart';
import 'package:sga_bojanini/features/purchasing/data/purchase_order.dart';
import 'package:sga_bojanini/features/purchasing/presentation/draft_widgets.dart';

import '../../helpers/fixtures.dart';

void main() {
  group('solicitudes', () {
    test('línea de gasto: texto recortado y IVA solo si hay', () {
      expect(
        const ExpenseItemRequest(
          description: '  Aire  ',
          unit: ' und ',
          quantity: 2.5,
          unitPrice: 1000,
        ).toJson(),
        {
          'description': 'Aire',
          'unit': 'und',
          'quantity': 2.5,
          'unit_price': 1000.0,
        },
      );
    });

    test('borrador de gasto: omite fecha y notas vacías', () {
      const request = ExpenseDraftRequest(
        supplierId: 2,
        notes: '   ',
        items: [
          ExpenseItemRequest(
            description: 'x',
            unit: 'u',
            quantity: 1,
            unitPrice: 1,
            taxRate: 19,
          ),
        ],
      );
      final json = request.toJson();
      expect(json.keys, isNot(contains('notes')));
      expect(json.keys, isNot(contains('expected_delivery_date')));
      expect(((json['items']! as List).single as Map)['tax_rate'], 19.0);
    });

    test('borrador de compra: centro de costo y fecha solo si existen', () {
      const base = PurchaseDraftRequest(
        supplierId: 1,
        warehouseId: 2,
        items: [
          PurchaseItemRequest(
            productVariantId: 5,
            productPresentationId: 8,
            quantity: 3,
            unitPrice: 100,
          ),
        ],
      );
      expect(base.toJson().keys, isNot(contains('cost_center_id')));
      const full = PurchaseDraftRequest(
        supplierId: 1,
        warehouseId: 2,
        costCenterId: 4,
        expectedDeliveryDate: '2026-12-01',
        notes: ' Nota ',
        items: [],
      );
      expect(full.toJson(), {
        'supplier_id': 1,
        'warehouse_id': 2,
        'cost_center_id': 4,
        'items': <Object>[],
        'expected_delivery_date': '2026-12-01',
        'notes': 'Nota',
      });
    });
  });

  group('validación de líneas', () {
    test('gasto: descripción, unidad, cantidad y valor', () {
      const valid = ExpenseLine(
        key: 1,
        description: 'Aire',
        unit: 'und',
        unitPrice: 100,
      );
      expect(valid.isValid, isTrue);
      expect(valid.copyWith(description: '  ').isValid, isFalse);
      expect(valid.copyWith(unit: '').isValid, isFalse);
      expect(valid.copyWith(quantity: () => 0).isValid, isFalse);
      expect(valid.copyWith(unitPrice: () => null).isValid, isFalse);
      expect(valid.copyWith(taxRate: () => 101).isValid, isFalse);
      expect(valid.copyWith(description: 'x' * 256).isValid, isFalse);
      expect(valid.subtotal, 100);
    });

    test('compra: cantidad entera ≥ 1, valor e IVA', () {
      const valid = PurchaseLine(
        key: 1,
        productName: 'Gasa',
        variantId: 1,
        presentationId: 2,
        presentationName: 'Caja',
        unitPrice: 100,
        quantity: 3,
      );
      expect(valid.isValid, isTrue);
      expect(valid.subtotal, 300);
      expect(valid.copyWith(quantity: () => 0).isValid, isFalse);
      expect(valid.copyWith(unitPrice: () => null).isValid, isFalse);
      expect(valid.copyWith(taxRate: () => -1).isValid, isFalse);
    });

    test('IVA: sin valor o entre 0 y 100', () {
      expect(isValidTaxRate(null), isTrue);
      expect(isValidTaxRate(0), isTrue);
      expect(isValidTaxRate(100), isTrue);
      expect(isValidTaxRate(100.1), isFalse);
      expect(isValidTaxRate(-0.1), isFalse);
    });
  });

  group('desde una orden existente', () {
    test('gasto: carga proveedor, fecha, notas y líneas', () {
      final order = ExpenseOrder.fromJson(
        fixture('purchasing/expense_order_draft_response.json')['data'] as Json,
      );
      final state = ExpenseDraftState(
        editingId: order.id,
        supplierId: order.supplierId,
        expectedDate: parseDraftDate(order.expectedDeliveryDate),
      );
      expect(state.editingId, 33);
      expect(state.supplierId, 2);
      expect(state.expectedDate, DateTime(2026, 12, 10));
      expect(order.items.single.description, 'Mantenimiento aire');
    });

    test('compra: la línea guarda variante y presentación de la orden', () {
      final order = PurchaseOrder.fromJson(
        fixture('purchasing/purchase_order_draft_response.json')['data']
            as Json,
      );
      final item = order.items.single;
      expect(item.productVariantId, 50);
      expect(item.productPresentationId, 3);
      expect(item.presentation?.name, 'Caja x 100');
    });

    test('fechas del servidor sin hora; texto inválido es null', () {
      expect(parseDraftDate('2026-12-05'), DateTime(2026, 12, 5));
      expect(parseDraftDate('2026-12-05 10:30:00'), DateTime(2026, 12, 5));
      expect(parseDraftDate(null), isNull);
      expect(parseDraftDate('mañana'), isNull);
    });
  });

  group('envío del borrador', () {
    test('sin respuesta (timeout) queda sin confirmar', () {
      expect(const DraftSubmission().isUnconfirmed, isFalse);
      expect(const DraftSubmission(savedId: 3).savedId, 3);
    });
  });

  group('proveedores según el uso', () {
    const inventory = Supplier(id: 1, name: 'A');
    const expense = Supplier(id: 2, name: 'B', supplierType: 'expense');
    const both = Supplier(id: 3, name: 'C', supplierType: 'both');

    test('gasto: solo expense y both', () {
      expect(SupplierUse.expense.accepts(inventory), isFalse);
      expect(SupplierUse.expense.accepts(expense), isTrue);
      expect(SupplierUse.expense.accepts(both), isTrue);
    });

    test('compra: todos menos los solo de gasto', () {
      expect(SupplierUse.purchase.accepts(inventory), isTrue);
      expect(SupplierUse.purchase.accepts(expense), isFalse);
      expect(SupplierUse.purchase.accepts(both), isTrue);
    });
  });

  test('AppFormat.plain: sin separadores y vacío si es null', () {
    expect(AppFormat.plain(null), '');
    expect(AppFormat.plain(25000), '25000');
    expect(AppFormat.plain(2.5), '2.5');
  });
}
