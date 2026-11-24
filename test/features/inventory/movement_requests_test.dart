import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';

void main() {
  test('apiDate da YYYY-MM-DD', () {
    expect(apiDate(DateTime(2026, 3, 7)), '2026-03-07');
  });

  test('EntryRequest omite los campos vacíos y formatea fechas', () {
    final json = EntryRequest(
      warehouseId: 1,
      items: [
        EntryItem(
          productVariantId: 50,
          locationId: 100,
          lotNumber: 'L1',
          expirationDate: DateTime(2027, 1, 31),
          quantityBase: 10,
        ),
        EntryItem(
          productVariantId: 51,
          locationId: 100,
          lotNumber: 'L2',
          expirationDate: DateTime(2027, 2),
          manufacturingDate: DateTime(2026, 1, 2),
          presentationId: 3,
          quantityInPresentation: 2,
          notes: 'caja dañada',
        ),
      ],
      reason: 'Compra',
    ).toJson();

    expect(json, {
      'warehouse_id': 1,
      'reason': 'Compra',
      'items': [
        {
          'product_variant_id': 50,
          'location_id': 100,
          'lot_number': 'L1',
          'expiration_date': '2027-01-31',
          'quantity_base': 10.0,
        },
        {
          'product_variant_id': 51,
          'location_id': 100,
          'lot_number': 'L2',
          'expiration_date': '2027-02-01',
          'manufacturing_date': '2026-01-02',
          'product_presentation_id': 3,
          'quantity_in_presentation': 2.0,
          'notes': 'caja dañada',
        },
      ],
    });
  });

  test('ExitRequest: sin lote deja que el servidor use FEFO', () {
    final json = const ExitRequest(
      warehouseId: 1,
      costCenterId: 4,
      items: [ExitItem(genericProductId: 5, quantity: 3)],
    ).toJson();
    expect((json['items'] as List<dynamic>).single, {
      'generic_product_id': 5,
      'quantity': 3.0,
    });
    expect(json.containsKey('patient_document'), isFalse);
  });

  test('Ajuste con cantidad negativa y devolución', () {
    expect(
      const AdjustmentRequest(
        productVariantId: 50,
        warehouseId: 1,
        locationId: 100,
        quantity: -2,
        reason: 'Conteo',
      ).toJson()['quantity'],
      -2.0,
    );
    expect(
      const ReturnRequest(
        productVariantId: 50,
        warehouseId: 1,
        quantity: 1,
      ).toJson(),
      {'product_variant_id': 50, 'warehouse_id': 1, 'quantity': 1.0},
    );
  });

  test('Confirmación: PIN o externo, con o sin entrega explícita', () {
    expect(const ConfirmRequest(receivedBy: PinReceiver('123')).toJson(), {
      'received_by': {'pin': '123'},
    });
    final json = const ConfirmRequest(
      receivedBy: ExternalReceiver(
        ExternalSigner(
          name: 'Ana',
          document: '10',
          signature: 'data:image/png;base64,AA',
        ),
      ),
      deliveredBy: ExternalSigner(
        name: 'Luis',
        document: '20',
        signature: 'data:image/png;base64,BB',
      ),
    ).toJson();
    expect((json['received_by'] as Map)['name'], 'Ana');
    expect((json['delivered_by'] as Map)['document'], '20');
  });
}
