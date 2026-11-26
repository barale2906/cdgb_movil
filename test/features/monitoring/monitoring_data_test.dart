import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<Sensor> _sensors() =>
    (fixture('monitoring/sensors_response.json')['data'] as List<dynamic>)
        .map((e) => Sensor.fromJson(e as Json))
        .toList();

void main() {
  group('Sensor (contrato y reglas de rango)', () {
    test('parsea zona, calibración y última lectura', () {
      final sensor = _sensors().first;
      expect(sensor.type, SensorType.temperature);
      expect(sensor.zone?.warehouseName, 'Bodega Central');
      expect(sensor.zone?.tempMax, 8, reason: 'llega como "8.0"');
      expect(sensor.calibration?.status, 'expiring');
      expect(sensor.calibration?.daysLeft, 16);
      expect(sensor.lastReading?.value, 9.5);
      expect(sensor.lastReading?.userName, 'Usuario Prueba');
    });

    test('el rango permitido depende del tipo de sensor', () {
      final sensors = _sensors();
      expect(sensors[0].allowedMin, 2);
      expect(sensors[0].allowedMax, 8);
      expect(sensors[1].allowedMin, 30, reason: 'humedad usa humidity_*');
      expect(sensors[1].allowedMax, 60);
    });

    test('fuera de rango por arriba, por abajo y dentro', () {
      final temperature = _sensors().first;
      expect(temperature.isOutOfRange(9.5), isTrue);
      expect(temperature.isOutOfRange(1.9), isTrue);
      expect(temperature.isOutOfRange(5), isFalse);
      expect(
        temperature.isOutOfRange(2),
        isFalse,
        reason: 'los extremos son válidos',
      );
    });

    test('tipo desconocido, sin zona ni lecturas: no rompe', () {
      final sensor = _sensors().last;
      expect(sensor.type, SensorType.unknown);
      expect(sensor.hasLimits, isFalse);
      expect(sensor.isOutOfRange(999), isFalse);
      expect(sensor.lastReading, isNull);
      expect(sensor.calibration?.status, 'missing');
    });
  });

  test('TrendAnalysis, certificados y reglas (contrato)', () {
    final trend = TrendAnalysis.fromJson(
      fixture('monitoring/trend_response.json')['data'] as Json,
    );
    expect(trend.overallTrend, isTrue);
    expect(trend.overallDirection, 'up');
    expect(trend.confidence, 'medium');
    expect(trend.linearRegression?.interpretation, contains('alza'));

    final certs =
        (fixture('monitoring/calibrations_response.json')['data']
                as List<dynamic>)
            .map((e) => CalibrationCertificate.fromJson(e as Json))
            .toList();
    expect(certs.first.isCurrent, isTrue);
    expect(certs.last.status, 'replaced');

    final rules =
        (fixture('monitoring/alert_rules_response.json')['data']
                as List<dynamic>)
            .map((e) => AlertRule.fromJson(e as Json))
            .toList();
    expect(rules.first.threshold, 8, reason: '"8.00"');
    expect(rules.first.notificationChannels, ['internal', 'push']);
    expect(rules.last.isActive, isFalse);
  });

  group('MonitoringRepository', () {
    late FakeHttpAdapter adapter;
    late MonitoringRepository repository;

    setUp(() async {
      adapter = FakeHttpAdapter();
      final container = ProviderContainer(
        retry: noAutoRetry,
        overrides: await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 24)),
        ),
      );
      addTearDown(container.dispose);
      repository = container.read(monitoringRepositoryProvider);
    });

    test('lecturas y tendencia piden el periodo como Y-m-d', () async {
      adapter
        ..on(
          'GET',
          '/sensors/1/readings',
          body: fixture('monitoring/readings_response.json'),
        )
        ..on(
          'GET',
          '/sensors/1/trend',
          body: fixture('monitoring/trend_response.json'),
        );

      final readings = await repository.readings(
        1,
        from: DateTime(2026, 11, 17, 9),
        to: DateTime(2026, 11, 24, 9),
      );
      await repository.trend(
        1,
        from: DateTime(2026, 11, 17),
        to: DateTime(2026, 11, 24),
      );

      expect(readings, hasLength(3));
      expect(readings[1].value, 6.5, reason: '"6.5" como texto');
      expect(
        adapter.callsTo('GET', '/sensors/1/readings').single.queryParameters,
        {
          'date_from': '2026-11-17',
          'date_to': '2026-11-24',
        },
      );
    });

    test('lectura manual: fuente manual, hora de Colombia y alertas', () async {
      adapter.on(
        'POST',
        '/sensors/1/readings',
        status: 201,
        body: fixture('monitoring/reading_saved_response.json'),
      );

      final result = await repository.registerReading(
        1,
        value: 7.5,
        recordedAt: DateTime(2026, 11, 24, 14, 30),
      );

      expect(result.reading.id, 950);
      expect(result.alertCount, 1);
      expect(adapter.callsTo('POST', '/sensors/1/readings').single.data, {
        'value': 7.5,
        'reading_source': 'manual',
        'recorded_at': '2026-11-24 14:30:00',
      });
    });

    test('sin permiso de sensor (403) llega el mensaje del servidor', () async {
      adapter.on(
        'POST',
        '/sensors/9/readings',
        status: 403,
        body: errorBody('No tienes acceso a este sensor.'),
      );
      await expectLater(
        repository.registerReading(9, value: 1, recordedAt: DateTime(2026)),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test('certificado: descarga binaria; calibraciones y reglas', () async {
      adapter
        ..onBytes('GET', '/calibrations/3/download', [1, 2, 3])
        ..on(
          'GET',
          '/sensors/1/calibrations',
          body: fixture('monitoring/calibrations_response.json'),
        )
        ..on(
          'GET',
          '/sensors/1/alert-rules',
          body: fixture('monitoring/alert_rules_response.json'),
        );

      expect(await repository.downloadCalibration(3), [1, 2, 3]);
      expect(await repository.calibrations(1), hasLength(2));
      expect(await repository.alertRules(1), hasLength(2));
    });
  });
}
