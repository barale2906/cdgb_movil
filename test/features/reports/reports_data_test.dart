import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/features/reports/data/reports_repository.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

void main() {
  test(
    'ReportExport (contrato): id numérico o texto, estados y vencimiento',
    () {
      final items =
          (fixture('reports/exports_response.json')['data'] as List<dynamic>)
              .map((e) => ReportExport.fromJson(e as Json))
              .toList();

      expect(items[0].id, '12');
      expect(items[0].canDownload, isTrue);
      expect(items[1].isInProgress, isTrue);
      expect(items[2].status, ExportStatus.failed);
      expect(items[2].errorMessage, 'Falló la consulta.');
      expect(items[3].id, 'uuid-15');
      expect(items[3].canDownload, isFalse, reason: 'listo pero vencido');
    },
  );

  test('ReportType: rutas, auditoría con permiso extra', () {
    expect(ReportType.fromPath('expiring'), ReportType.expiring);
    expect(ReportType.fromPath('nada'), isNull);
    expect(ReportType.audit.extraPermission, 'auditoria.ver');
    expect(ReportType.inventory.extraPermission, isNull);
    expect(ReportFormat.excel.extension, 'xlsx');
  });

  group('ReportsRepository', () {
    late FakeHttpAdapter adapter;
    late ReportsRepository repository;

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
      repository = container.read(reportsRepositoryProvider);
    });

    test('200: devuelve el archivo con nombre y filtros sin nulos', () async {
      adapter.onBytes('GET', '/reports/expiring', [37, 80, 68, 70]);

      final result = await repository.generate(
        ReportType.expiring,
        ReportFormat.pdf,
        filters: {'days': 15, 'warehouse_id': null},
        now: DateTime(2026, 11, 24),
      );

      final file = result as ReportFile;
      expect(file.bytes, [37, 80, 68, 70]);
      expect(file.fileName, 'expiring_2026-11-24.pdf');
      expect(
        adapter.callsTo('GET', '/reports/expiring').single.queryParameters,
        {
          'format': 'pdf',
          'days': 15,
        },
      );
    });

    test('202: el reporte es grande y queda en exportaciones', () async {
      adapter.onBytes(
        'GET',
        '/reports/inventory',
        utf8.encode(
          jsonEncode({
            'success': true,
            'data': {'mode': 'async', 'export_id': 12, 'status': 'queued'},
          }),
        ),
        status: 202,
      );
      final result = await repository.generate(
        ReportType.inventory,
        ReportFormat.excel,
      );
      expect((result as ReportQueued).exportId, '12');
    });

    test('un error con cuerpo binario se mapea (422 con campos)', () async {
      adapter.onBytes(
        'GET',
        '/reports/conditions',
        utf8.encode(
          jsonEncode({
            'message': 'Inválido',
            'errors': {
              'sensor_id': ['Seleccione un sensor.'],
            },
          }),
        ),
        status: 422,
      );
      await expectLater(
        repository.generate(ReportType.conditions, ReportFormat.pdf),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.firstErrorFor('sensor_id'),
            'sensor',
            'Seleccione un sensor.',
          ),
        ),
      );
    });

    test(
      'exportaciones: lista, y descarga vencida = 410 con mensaje',
      () async {
        adapter
          ..on(
            'GET',
            '/reports/exports',
            body: fixture('reports/exports_response.json'),
          )
          ..onBytes(
            'GET',
            '/reports/exports/uuid-15/download',
            utf8.encode(jsonEncode({'message': 'El reporte expiró.'})),
            status: 410,
          )
          ..onBytes(
            'GET',
            '/reports/exports/13/download',
            utf8.encode(
              jsonEncode({
                'message': 'El reporte aún no está listo para descargar.',
              }),
            ),
            status: 409,
          );

        expect((await repository.exports()).items, hasLength(4));
        await expectLater(
          repository.downloadExport('uuid-15'),
          throwsA(
            isA<GoneException>().having(
              (e) => e.message,
              'message',
              'El reporte expiró.',
            ),
          ),
        );
        await expectLater(
          repository.downloadExport('13'),
          throwsA(isA<BusinessRuleException>()),
        );
      },
    );

    test('sensores para el filtro de condiciones', () async {
      adapter.on(
        'GET',
        '/sensors',
        body: fixture('monitoring/sensors_response.json'),
      );
      final sensors = await repository.sensors();
      expect(sensors.first.name, 'Nevera farmacia');
      expect(sensors, hasLength(3));
    });
  });
}
