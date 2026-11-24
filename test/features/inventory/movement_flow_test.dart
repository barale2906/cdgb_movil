import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sga_bojanini/features/inventory/presentation/movement_fields.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';

const _base = ['stock.ver', 'almacenes.ver', 'generic-products.ver'];

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness(initialPrefs: {'active_warehouse_id': 1}));

  Future<void> open(
    WidgetTester tester,
    List<String> permissions,
    String typeLabel,
  ) async {
    tester.view
      ..physicalSize = const Size(800, 2600)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    harness
      ..stubSignedInUser(
        permissions: [..._base, ...permissions],
        menu: 'auth/menu_inventory_response.json',
      )
      ..stubInventoryReads()
      ..storeSession();
    harness.adapter
      ..on(
        'GET',
        '/generic-products',
        body: fixture('catalog/products_list_response.json'),
      )
      ..on(
        'GET',
        '/generic-products/5',
        body: fixture('catalog/product_detail_response.json'),
      )
      ..on(
        'GET',
        '/generic-products/5/presentations',
        body: fixture('inventory/presentations_response.json'),
      )
      ..on(
        'GET',
        '/generic-products/5/batches',
        body: fixture('inventory/batches_response.json'),
      )
      ..on(
        'GET',
        '/warehouses/1/capacity',
        body: fixture('warehouse/capacity_response.json'),
      )
      ..on(
        'GET',
        '/cost-centers',
        body: fixture('inventory/cost_centers_response.json'),
      );
    await harness.pump(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Inventario'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Nuevo movimiento'));
    await AppHarness.settle(tester);
    await tester.tap(find.text(typeLabel));
    await AppHarness.settle(tester);
  }

  Future<void> pickProduct(WidgetTester tester) async {
    await tester.tap(find.byType(ProductPickerField));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Gasa estéril 10x10'));
    await AppHarness.settle(tester);
  }

  Future<void> pickOption(
    WidgetTester tester,
    String label,
    String option,
  ) async {
    await tester.tap(
      find.byWidgetPredicate(
        (w) => w is DropdownButtonFormField && w.decoration.labelText == label,
      ),
    );
    await AppHarness.settle(tester, frames: 4);
    await tester.tap(find.text(option).last);
    await AppHarness.settle(tester, frames: 4);
  }

  Future<void> typeInto(WidgetTester tester, String label, String text) async {
    await tester.enterText(find.widgetWithText(TextFormField, label), text);
    await tester.pump();
  }

  group('entrada', () {
    Future<void> fillItem(WidgetTester tester) async {
      await tester.tap(find.text('Agregar producto'));
      await AppHarness.settle(tester);
      await pickProduct(tester);
      await pickOption(tester, 'Ubicación', 'Zona fría · Estante A1');
      await typeInto(tester, 'Número de lote', 'L-NUEVO');
      await tester.tap(find.widgetWithText(DateField, 'Fecha de vencimiento'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('ACEPTAR'));
      await AppHarness.settle(tester);
      await typeInto(tester, 'Cantidad', '12,5');
      await tester.tap(find.text('Agregar').last);
      await AppHarness.settle(tester);
    }

    testWidgets('registra una entrada con lote, ubicación y cantidad', (
      tester,
    ) async {
      await open(tester, ['movimientos.entrada'], 'Entrada');
      harness.adapter.on(
        'POST',
        '/movements/entry',
        status: 201,
        body: fixture('inventory/document_response.json'),
      );

      await fillItem(tester);
      expect(find.text('Gasa estéril 10x10'), findsWidgets);
      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter.callsTo('POST', '/movements/entry').single.data
              as Map;
      expect(body['warehouse_id'], 1);
      final item = (body['items'] as List).single as Map;
      expect(item['product_variant_id'], 50);
      expect(item['location_id'], 100);
      expect(item['lot_number'], 'L-NUEVO');
      expect(item['quantity_base'], 12.5);
      expect(item.containsKey('product_presentation_id'), isFalse);
      expect(
        find.textContaining('Comprobante SAL-2026-000123 registrado'),
        findsOneWidget,
      );
    });

    testWidgets('sin productos no envía y lo indica', (tester) async {
      await open(tester, ['movimientos.entrada'], 'Entrada');

      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      expect(find.text('Agregue al menos un producto.'), findsOneWidget);
      expect(harness.adapter.callsTo('POST', '/movements/entry'), isEmpty);
    });

    testWidgets('la hoja valida los campos obligatorios', (tester) async {
      await open(tester, ['movimientos.entrada'], 'Entrada');
      await tester.tap(find.text('Agregar producto'));
      await AppHarness.settle(tester);

      await tester.tap(find.text('Agregar').last);
      await AppHarness.settle(tester);

      expect(find.text('Este campo es obligatorio.'), findsWidgets);
      expect(find.text('Ingrese un número válido.'), findsOneWidget);
    });

    testWidgets('con presentación envía la cantidad en la presentación', (
      tester,
    ) async {
      await open(tester, ['movimientos.entrada'], 'Entrada');
      harness.adapter.on(
        'POST',
        '/movements/entry',
        status: 201,
        body: fixture('inventory/document_response.json'),
      );
      await tester.tap(find.text('Agregar producto'));
      await AppHarness.settle(tester);
      await pickProduct(tester);
      await pickOption(tester, 'Ubicación', 'Zona fría · Estante A1');
      await typeInto(tester, 'Número de lote', 'L-P');
      await tester.tap(find.widgetWithText(DateField, 'Fecha de vencimiento'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('ACEPTAR'));
      await AppHarness.settle(tester);
      await pickOption(tester, 'Presentación', 'Caja x 100');
      await typeInto(tester, 'Cantidad', '2');
      await tester.tap(find.text('Agregar').last);
      await AppHarness.settle(tester);

      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      final item =
          ((harness.adapter.callsTo('POST', '/movements/entry').single.data
                          as Map)['items']
                      as List)
                  .single
              as Map;
      expect(item['product_presentation_id'], 3);
      expect(item['quantity_in_presentation'], 2.0);
      expect(item.containsKey('quantity_base'), isFalse);
    });

    testWidgets('timeout: advierte revisar el historial y no reintenta', (
      tester,
    ) async {
      await open(tester, ['movimientos.entrada'], 'Entrada');
      harness.adapter.onError(
        'POST',
        '/movements/entry',
        DioExceptionType.receiveTimeout,
      );
      await fillItem(tester);

      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      expect(
        find.textContaining('Antes de repetirlo, revise el historial'),
        findsOneWidget,
      );
      expect(harness.adapter.callsTo('POST', '/movements/entry'), hasLength(1));
    });
  });

  group('salida', () {
    testWidgets('sin centros_costo.ver explica por qué no se puede', (
      tester,
    ) async {
      await open(tester, ['movimientos.salida'], 'Salida');
      expect(
        find.text(
          'Para registrar salidas se necesita poder consultar centros de '
          'costo.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('registra la salida con FEFO y abre el comprobante pendiente', (
      tester,
    ) async {
      await open(tester, ['movimientos.salida', 'centros_costo.ver'], 'Salida');
      harness.adapter.on(
        'POST',
        '/movements/exit',
        status: 201,
        body: fixture('inventory/document_response.json'),
      );

      await pickOption(tester, 'Centro de costo', 'URG · Urgencias');
      await tester.tap(find.text('Agregar producto'));
      await AppHarness.settle(tester);
      await pickProduct(tester);
      await typeInto(tester, 'Cantidad', '3');
      await tester.tap(find.text('Agregar').last);
      await AppHarness.settle(tester);
      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter.callsTo('POST', '/movements/exit').single.data as Map;
      expect(body['cost_center_id'], 4);
      expect((body['items'] as List).single, {
        'generic_product_id': 5,
        'quantity': 3.0,
      });
      expect(
        find.text('PENDIENTE DE FIRMA'),
        findsOneWidget,
        reason: 'abre el detalle pendiente',
      );
      expect(find.text('SAL-2026-000123'), findsWidgets);
    });

    testWidgets('el documento del paciente solo aparece con centro externo', (
      tester,
    ) async {
      await open(tester, ['movimientos.salida', 'centros_costo.ver'], 'Salida');
      expect(find.text('Documento del paciente (opcional)'), findsNothing);

      await pickOption(tester, 'Centro de costo', 'CEX · Consulta externa');

      expect(find.text('Documento del paciente (opcional)'), findsOneWidget);
    });

    testWidgets('lote vencido (409): muestra el mensaje del servidor', (
      tester,
    ) async {
      await open(tester, ['movimientos.salida', 'centros_costo.ver'], 'Salida');
      harness.adapter.on(
        'POST',
        '/movements/exit',
        status: 409,
        body: errorBody(
          'No se puede mover stock de un lote vencido.',
          extra: {'error_code': 'EXPIRED_STOCK'},
        ),
      );
      await pickOption(tester, 'Centro de costo', 'URG · Urgencias');
      await tester.tap(find.text('Agregar producto'));
      await AppHarness.settle(tester);
      await pickProduct(tester);
      await typeInto(tester, 'Cantidad', '1');
      await tester.tap(find.text('Agregar').last);
      await AppHarness.settle(tester);

      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      expect(
        find.text('No se puede mover stock de un lote vencido.'),
        findsOneWidget,
      );
    });
  });

  group('ajuste', () {
    testWidgets('exige motivo y cantidad distinta de cero', (tester) async {
      await open(tester, ['movimientos.ajuste'], 'Ajuste');
      await pickProduct(tester);

      await typeInto(tester, 'Cantidad (negativa para restar)', '0');
      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      expect(
        find.text('Ingrese una cantidad distinta de cero.'),
        findsOneWidget,
      );
      expect(find.text('Este campo es obligatorio.'), findsWidgets);
      expect(harness.adapter.callsTo('POST', '/movements/adjustment'), isEmpty);
    });

    testWidgets('registra un ajuste negativo', (tester) async {
      await open(tester, ['movimientos.ajuste'], 'Ajuste');
      harness.adapter.on(
        'POST',
        '/movements/adjustment',
        status: 201,
        body: fixture('inventory/line_response.json'),
      );
      await pickProduct(tester);
      await pickOption(tester, 'Ubicación', 'Zona fría · Estante A1');
      await typeInto(tester, 'Cantidad (negativa para restar)', '-2');
      await typeInto(tester, 'Motivo', 'Conteo físico');

      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter.callsTo('POST', '/movements/adjustment').single.data
              as Map;
      expect(body['quantity'], -2.0);
      expect(body['reason'], 'Conteo físico');
      expect(body['warehouse_id'], 1);
      expect(body['location_id'], 100);
      expect(find.text('Movimiento registrado.'), findsOneWidget);
    });
  });

  group('traslado', () {
    testWidgets(
      'elige destino, agrega la línea y abre el comprobante pendiente',
      (tester) async {
        await open(tester, ['movimientos.transferir'], 'Traslado');
        harness.adapter
          ..on(
            'GET',
            '/warehouses/2/capacity',
            body: fixture('warehouse/capacity_response.json'),
          )
          ..on(
            'POST',
            '/movements/transfer',
            status: 201,
            body: fixture('inventory/document_response.json'),
          );

        await pickOption(tester, 'Almacén destino', 'Farmacia');
        await tester.tap(find.text('Agregar producto'));
        await AppHarness.settle(tester);
        await pickProduct(tester);
        await pickOption(tester, 'Ubicación', 'Zona fría · Estante A1');
        await typeInto(tester, 'Cantidad', '4');
        await tester.tap(find.text('Agregar').last);
        await AppHarness.settle(tester);
        await tester.tap(find.text('Registrar'));
        await AppHarness.settle(tester);

        final body =
            harness.adapter.callsTo('POST', '/movements/transfer').single.data
                as Map;
        expect(body['warehouse_from_id'], 1);
        expect(body['warehouse_to_id'], 2);
        expect((body['items'] as List).single, {
          'product_variant_id': 50,
          'location_to_id': 100,
          'quantity': 4.0,
        });
        expect(find.text('PENDIENTE DE FIRMA'), findsOneWidget);
      },
    );

    testWidgets('no se puede agregar productos sin elegir destino', (
      tester,
    ) async {
      await open(tester, ['movimientos.transferir'], 'Traslado');

      await tester.tap(find.text('Agregar producto'), warnIfMissed: false);
      await AppHarness.settle(tester);

      expect(find.text('Seleccionar producto'), findsNothing);
    });
  });

  group('baja por vencimiento, pérdida y devolución', () {
    testWidgets('baja por vencimiento: exige lote y envía batch_id', (
      tester,
    ) async {
      await open(tester, ['movimientos.baja'], 'Baja por vencimiento');
      harness.adapter.on(
        'POST',
        '/movements/write-off',
        status: 201,
        body: fixture('inventory/line_response.json'),
      );
      await pickProduct(tester);

      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);
      expect(find.text('Este campo es obligatorio.'), findsWidgets);
      expect(harness.adapter.callsTo('POST', '/movements/write-off'), isEmpty);

      await pickOption(tester, 'Lote', 'L-2025-09 · 2');
      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter.callsTo('POST', '/movements/write-off').single.data
              as Map;
      expect(body, {'batch_id': 71, 'warehouse_id': 1});
    });

    testWidgets('pérdida: lote, ubicación, cantidad y motivo', (tester) async {
      await open(tester, ['movimientos.baja'], 'Pérdida');
      harness.adapter.on(
        'POST',
        '/movements/loss',
        status: 201,
        body: fixture('inventory/line_response.json'),
      );
      await pickProduct(tester);
      await pickOption(tester, 'Ubicación', 'Zona fría · Estante A1');
      await pickOption(tester, 'Lote', 'L-2026-01 · 40');
      await typeInto(tester, 'Cantidad', '1');
      await typeInto(tester, 'Motivo', 'Rotura');

      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter.callsTo('POST', '/movements/loss').single.data as Map;
      expect(body['batch_id'], 70);
      expect(body['location_id'], 100);
      expect(body['quantity'], 1.0);
      expect(body['reason'], 'Rotura');
    });

    testWidgets('devolución: el lote y la ubicación son opcionales', (
      tester,
    ) async {
      await open(tester, ['movimientos.devolucion'], 'Devolución');
      harness.adapter.on(
        'POST',
        '/movements/return',
        status: 201,
        body: fixture('inventory/line_response.json'),
      );
      await pickProduct(tester);
      await typeInto(tester, 'Cantidad', '2');

      await tester.tap(find.text('Registrar'));
      await AppHarness.settle(tester);

      final body =
          harness.adapter.callsTo('POST', '/movements/return').single.data
              as Map;
      expect(body, {
        'product_variant_id': 50,
        'warehouse_id': 1,
        'quantity': 2.0,
      });
    });
  });
}
