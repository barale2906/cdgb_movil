import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/catalog/generic_product.dart';
import 'package:sga_bojanini/core/clinical/medsys_patient.dart';
import 'package:sga_bojanini/core/clinical/procedure_match.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/service_orders/application/new_order_controller.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

const _path = '/service-orders';
final _today = DateTime(2026, 11, 26);

final _patient = MedsysPatient.fromJson(
  ((fixture('clinical/patients_response.json')['data'] as Json)['patients']
              as List<dynamic>)
          .first
      as Json,
);

List<ProcedureMatch> _procedures() =>
    (fixture('clinical/procedures_response.json')['data'] as List<dynamic>)
        .map((e) => ProcedureMatch.fromJson(e as Json))
        .toList();

const _gauze = GenericProduct(id: 9, name: 'Gasa estéril');

void main() {
  late FakeHttpAdapter adapter;
  late ProviderContainer container;
  late NewOrderNotifier order;

  NewOrderState state() => container.read(newOrderProvider);

  setUp(() async {
    adapter = FakeHttpAdapter();
    container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: InMemoryTokenStore(),
        // 26/11/2026 02:00 a. m. en Colombia = 07:00 UTC.
        clock: TestClock(DateTime.utc(2026, 11, 26, 7)),
      ),
    );
    addTearDown(container.dispose);
    container.listen(newOrderProvider, (_, _) {});
    order = container.read(newOrderProvider.notifier);
  });

  /// Orden válida: paciente y un procedimiento con tarifa.
  int fill() {
    order
      ..setPatient(_patient)
      ..addLine(_procedures().first);
    return state().lines.single.key;
  }

  group('armado', () {
    test('la fecha inicia hoy en Colombia y la tarifa es el valor', () {
      final key = fill();
      expect(state().serviceDate, DateTime(2026, 11, 26));
      expect(state().lines.single.unitPrice, 50000);
      expect(state().lines.single.key, key);
      expect(state().canSubmit(_today), isTrue);
    });

    test('un procedimiento sin tarifa exige escribir el valor', () {
      order
        ..setPatient(_patient)
        ..addLine(_procedures().last);
      expect(state().canSubmit(_today), isFalse);
      order.setUnitPrice(state().lines.single.key, 150000);
      expect(state().canSubmit(_today), isTrue);
    });

    test('sin paciente, sin líneas o con fecha futura no se envía', () {
      expect(state().canSubmit(_today), isFalse);
      order.setPatient(_patient);
      expect(state().canSubmit(_today), isFalse);
      order
        ..addLine(_procedures().first)
        ..setServiceDate(DateTime(2026, 11, 27));
      expect(state().canSubmit(_today), isFalse);
    });

    test('totales con descuento por porcentaje y por valor', () {
      final key = fill();
      order.setQuantity(key, 2);
      expect(state().total, 100000);

      order
        ..setDiscountKind(key, DiscountKind.percentage)
        ..setDiscountValue(key, 10);
      expect(state().totalDiscount, 10000);
      expect(state().netTotal, 90000);

      order
        ..setDiscountKind(key, DiscountKind.fixed)
        ..setDiscountValue(key, 25000);
      expect(state().netTotal, 75000);
      expect(state().hasDiscount, isTrue);
    });

    test('quitar el tipo de descuento borra su valor', () {
      final key = fill();
      order
        ..setDiscountKind(key, DiscountKind.percentage)
        ..setDiscountValue(key, 10)
        ..setDiscountKind(key, null);
      expect(state().lines.single.discountValue, isNull);
      expect(state().totalDiscount, 0);
    });
  });

  group('validación del descuento', () {
    test('el porcentaje va de 0 (sin incluir) a 100', () {
      final key = fill();
      order.setDiscountKind(key, DiscountKind.percentage);
      for (final (value, valid) in [
        (null, false),
        (0.0, false),
        (50.0, true),
        (100.0, true),
        (101.0, false),
      ]) {
        order.setDiscountValue(key, value);
        expect(state().lines.single.isDiscountValid, valid, reason: '$value');
        expect(state().canSubmit(_today), valid, reason: '$value');
      }
    });

    test('el valor fijo debe ser menor que el total de la línea', () {
      final key = fill();
      order
        ..setDiscountKind(key, DiscountKind.fixed)
        ..setDiscountValue(key, 49999);
      expect(state().lines.single.isDiscountValid, isTrue);
      order.setDiscountValue(key, 50000);
      expect(state().lines.single.isDiscountValid, isFalse);
    });
  });

  group('insumos', () {
    test('exigen almacén y cantidad mayor que cero', () {
      final key = fill();
      order.addSupply(key, _gauze);
      expect(state().canSubmit(_today), isFalse, reason: 'sin almacén');

      order.setWarehouse(key, 2);
      expect(state().canSubmit(_today), isFalse, reason: 'sin cantidad');

      order.setSupplyQuantity(key, state().lines.single.supplies.single.key, 3);
      expect(state().canSubmit(_today), isTrue);
    });

    test('al quitar el último insumo se olvida el almacén', () {
      final key = fill();
      order
        ..addSupply(key, _gauze)
        ..setWarehouse(key, 2)
        ..removeSupply(key, state().lines.single.supplies.single.key);
      expect(state().lines.single.supplies, isEmpty);
      expect(state().lines.single.warehouseId, isNull);
      expect(state().canSubmit(_today), isTrue);
    });
  });

  group('envío', () {
    test('un solo POST con contacto, descuento e insumos', () async {
      adapter.on(
        'POST',
        _path,
        status: 201,
        body: fixture('service_orders/order_pending_response.json'),
      );
      final key = fill();
      order
        ..setSeller(' Vendedor ')
        ..setDiscountKind(key, DiscountKind.percentage)
        ..setDiscountValue(key, 10)
        ..addSupply(key, _gauze)
        ..setWarehouse(key, 2)
        ..setSupplyQuantity(key, state().lines.single.supplies.single.key, 1.5);

      final created = await order.submit();

      expect(created?.orderNumber, 'OS-20261124-000001');
      expect(state().created, isNotNull);
      expect(adapter.callsTo('POST', _path), hasLength(1));
      expect(adapter.callsTo('POST', _path).single.data, {
        'patient_external_id': 'P00001',
        'patient_document': '1000000001',
        'patient_first_name': 'ANA MARIA',
        'patient_last_name': 'PEREZ GOMEZ',
        'patient_email': 'paciente.uno@example.com',
        'patient_address': 'Calle 1 # 2-3',
        'patient_phone': '3000000001',
        'service_date': '2026-11-26',
        'seller': 'Vendedor',
        'procedures': [
          {
            'medical_service_id': 3,
            'quantity': 1.0,
            'unit_price': 50000.0,
            'discount_type': 'percentage',
            'discount_value': 10.0,
            'supplies': [
              {'warehouse_id': 2, 'generic_product_id': 9, 'quantity': 1.5},
            ],
          },
        ],
      });
    });

    test('una orden ya creada no se vuelve a enviar', () async {
      adapter.on(
        'POST',
        _path,
        body: fixture('service_orders/order_approved_response.json'),
      );
      fill();
      await order.submit();

      expect(state().canSubmit(_today), isFalse);
      expect(await order.submit(), isNull);
      expect(adapter.callsTo('POST', _path), hasLength(1));
    });

    test('un rechazo conserva lo escrito y guarda el error', () async {
      adapter.on(
        'POST',
        _path,
        status: 409,
        body: errorBody('Stock insuficiente para Gasa estéril.'),
      );
      fill();

      expect(await order.submit(), isNull);

      expect(state().created, isNull);
      expect(state().error, isA<BusinessRuleException>());
      expect(state().lines, hasLength(1));
      expect(state().isSubmitting, isFalse);
      expect(state().canSubmit(_today), isTrue);
    });

    test(
      'sin respuesta: no se reenvía hasta que el usuario confirme',
      () async {
        adapter
          ..onError('POST', _path, DioExceptionType.receiveTimeout)
          ..on(
            'POST',
            _path,
            body: fixture('service_orders/order_approved_response.json'),
          );
        fill();

        await order.submit();
        expect(state().isUnconfirmed, isTrue);
        expect(state().canSubmit(_today), isFalse);
        expect(await order.submit(), isNull);
        expect(
          adapter.callsTo('POST', _path),
          hasLength(1),
          reason: 'jamás se reintenta automáticamente',
        );

        order.acknowledgeNotCreated();
        expect(state().canSubmit(_today), isTrue);
        expect(await order.submit(), isNotNull);
        expect(adapter.callsTo('POST', _path), hasLength(2));
      },
    );

    test(
      'confirmar "no se creó" no borra un error que no sea timeout',
      () async {
        adapter.on(
          'POST',
          _path,
          status: 422,
          body: errorBody('Datos inválidos'),
        );
        fill();
        await order.submit();

        order.acknowledgeNotCreated();

        expect(state().error, isA<ValidationException>());
      },
    );

    test('un envío en curso bloquea otro simultáneo', () async {
      adapter.on(
        'POST',
        _path,
        body: fixture('service_orders/order_approved_response.json'),
      );
      fill();

      final first = order.submit();
      final second = await order.submit();
      await first;

      expect(second, isNull);
      expect(adapter.callsTo('POST', _path), hasLength(1));
    });
  });
}
