import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/my_signature.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/features/inventory/data/batch.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/data/product_presentation.dart';
import 'package:sga_bojanini/features/inventory/data/stock_item.dart';

import '../../helpers/fixtures.dart';

List<Json> _list(String name) =>
    (fixture(name)['data'] as List<dynamic>).cast<Json>();

void main() {
  test('StockItem: decimales como texto y variante sin producto cargado', () {
    final items = _list(
      'inventory/stock_response.json',
    ).map(StockItem.fromJson).toList();

    expect(items.first.productName, 'Gasa estéril 10x10');
    expect(items.first.totalQuantity, 120);
    expect(items.first.variantId, 50);
    expect(items.first.genericProductId, 5);
    expect(items.last.productName, isEmpty);
    expect(items.last.variantId, 51, reason: 'solo product_variant_id');
    expect(items.last.availableQuantity, 2);
  });

  test('Batch: estado, días, ubicaciones y lote vencido', () {
    final batches = _list(
      'inventory/batches_response.json',
    ).map(Batch.fromJson).toList();

    expect(batches.first.status, BatchStatus.active);
    expect(batches.first.quantityAvailable, 40);
    expect(batches.first.totalQuantityAvailable, 60);
    expect(
      batches.first.locations.single.zone?.warehouseName,
      'Bodega Central',
    );
    expect(batches.first.isExpired, isFalse);
    expect(batches.last.isExpired, isTrue);
    expect(batches.last.locations, isEmpty, reason: 'locations nulo');
    expect(batches.last.variant, isNull);
  });

  test('Batch: un estado nuevo cae en unknown', () {
    final batch = Batch.fromJson({
      'id': 1,
      'lot_number': 'X',
      'status': 'raro',
    });
    expect(batch.status, BatchStatus.unknown);
  });

  test('MovementDocument: pendiente de firma, centro de costo y líneas', () {
    final document = MovementDocument.fromJson(
      fixture('inventory/document_response.json')['data'] as Json,
    );

    expect(document.isPending, isTrue);
    expect(document.documentType, 'exit');
    expect(document.costCenter?.name, 'Urgencias');
    expect(document.signatures, isEmpty);
    expect(document.movements.single.quantity, 5);
    expect(document.movements.single.batchLotNumber, 'L-2026-01');
  });

  test('DocumentStatus: valores del backend y desconocidos', () {
    const converter = DocumentStatusConverter();
    expect(
      converter.fromJson('pending_signature'),
      DocumentStatus.pendingSignature,
    );
    expect(converter.fromJson('confirmed'), DocumentStatus.confirmed);
    expect(converter.fromJson('otro'), DocumentStatus.unknown);
    expect(
      converter.toJson(DocumentStatus.pendingSignature),
      'pending_signature',
    );
  });

  test('ProductPresentation: factor como texto', () {
    final presentation = ProductPresentation.fromJson(
      _list('inventory/presentations_response.json').single,
    );
    expect(presentation.factorToBase, 100);
  });

  test('MySignature: nunca trae PIN, solo has_pin', () {
    final data =
        (fixture('inventory/signature_response.json')['data']
                as Json)['signature']
            as Json;
    final signature = MySignature.fromJson(data);
    expect(signature.hasPin, isTrue);
    expect(signature.documentType, 'CC');
    expect(data.containsKey('pin'), isFalse);
  });
}
