import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/audit/application/audit_providers.dart';
import 'package:sga_bojanini/features/audit/data/audit_log.dart';
import 'package:sga_bojanini/features/audit/data/audit_repository.dart';
import 'package:sga_bojanini/features/audit/presentation/audit_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';
import 'package:sga_bojanini/l10n/app_localizations_es.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

const _menu = 'auth/menu_audit_response.json';
final AppLocalizations _l10n = AppLocalizationsEs();

List<AuditLog> _logs() =>
    ((fixture('audit/audit_logs_response.json')['data'] as Json)['items']
            as List<dynamic>)
        .map((e) => AuditLog.fromJson(e as Json))
        .toList();

void main() {
  group('contrato', () {
    test('lee usuario, acción, elemento y valores', () {
      final first = _logs().first;
      expect(first.action, 'updated');
      expect(first.userName, 'Usuario Prueba');
      expect(
        first.auditableId,
        '5',
        reason: 'el id numérico se lee como texto',
      );
      expect(first.oldValues?['name'], 'Gasa');
      expect(first.newValues?['name'], 'Gasa estéril');
    });

    test('un id de texto y los valores vacíos de PHP (`[]`) no rompen', () {
      final second = _logs()[1];
      expect(second.auditableId, 'U-12');
      expect(second.oldValues, isNull, reason: '[] es «sin valores»');
      expect(second.userName, isNull);
      expect(_logs().last.newValues, isNull);
    });

    test('resumen: totales por acción; `[]` es sin datos', () {
      final summary = AuditSummary.fromJson(
        fixture('audit/summary_response.json')['data'] as Json,
      );
      expect(summary.total, 3);
      expect(summary.byAction['updated'], 1);
      expect(summary.byType, isEmpty);

      final empty = AuditSummary.fromJson(
        fixture('audit/summary_empty_response.json')['data'] as Json,
      );
      expect(empty.total, 0);
      expect(empty.byAction, isEmpty);
    });
  });

  group('textos', () {
    test('acciones conocidas y desconocidas', () {
      expect(auditActionLabel(_l10n, 'created'), 'Creación');
      expect(auditActionLabel(_l10n, 'updated'), 'Modificación');
      expect(auditActionLabel(_l10n, 'deleted'), 'Eliminación');
      expect(auditActionLabel(_l10n, 'access'), 'Acceso');
      expect(auditActionLabel(_l10n, 'algo_nuevo'), 'Otra acción');
    });

    test('el nombre del elemento sale de la clase PHP', () {
      expect(
        auditEntityName(
          r'App\Modules\Catalog\Infrastructure\Persistence\Models\GenericProductModel',
          _l10n,
        ),
        'Generic Product',
      );
      expect(auditEntityName('Location', _l10n), 'Location');
      expect(auditEntityName(null, _l10n), 'Sistema');
      expect(auditEntityName('', _l10n), 'Sistema');
    });

    test('los cambios ocultan contraseñas, tokens, PIN y firmas', () {
      final changes = auditChanges(_logs().first, _l10n);
      final byField = {for (final c in changes) c.field: c};

      expect(byField['name']?.before, 'Gasa');
      expect(byField['name']?.after, 'Gasa estéril');
      expect(byField['min stock']?.after, '20.00');
      expect(byField['password']?.before, 'Oculto por seguridad');
      expect(byField['password']?.after, 'Oculto por seguridad');
      for (final word in ['api_token', 'pin_hash', 'signature_data', 'firma']) {
        final log = AuditLog(
          id: 1,
          action: 'updated',
          newValues: {word: 'secreto-123'},
        );
        expect(
          auditChanges(log, _l10n).single.after,
          'Oculto por seguridad',
          reason: word,
        );
      }
    });

    test('los valores anidados se acortan', () {
      final changes = auditChanges(_logs()[1], _l10n);
      expect(
        changes.firstWhere((c) => c.field == 'payload').after,
        '{"a":1}',
      );
      final long = AuditLog(
        id: 1,
        action: 'updated',
        newValues: {'datos': List.generate(100, (i) => 'valor-$i')},
      );
      expect(auditChanges(long, _l10n).single.after!.length, lessThan(170));
    });

    test('un registro sin valores no tiene cambios', () {
      expect(auditChanges(_logs().last, _l10n), isEmpty);
    });
  });

  group('periodos y repositorio', () {
    test('rangos según el día de hoy en Colombia', () {
      // 26/11 03:00 UTC = 25/11 10:00 p. m. en Colombia.
      DateTime clock() => DateTime.utc(2026, 11, 26, 3);
      expect(auditRange(AuditPeriod.today, clock).from, '2026-11-25');
      expect(auditRange(AuditPeriod.week, clock).from, '2026-11-19');
      expect(auditRange(AuditPeriod.month, clock).from, '2026-10-27');
      expect(auditRange(AuditPeriod.month, clock).to, '2026-11-25');
    });

    test('filtros iguales por valor', () {
      expect(
        const AuditFilter(action: 'created'),
        const AuditFilter(action: 'created'),
      );
      expect(const AuditFilter(), isNot(const AuditFilter(action: 'created')));
    });

    test('lista con filtros, detalle y resumen', () async {
      final adapter = FakeHttpAdapter()
        ..on(
          'GET',
          '/audit-logs',
          body: fixture('audit/audit_logs_response.json'),
        )
        ..on(
          'GET',
          '/audit-logs/101',
          body: fixture('audit/audit_log_response.json'),
        )
        ..on(
          'GET',
          '/audit-logs/summary',
          body: fixture('audit/summary_response.json'),
        );
      final container = ProviderContainer(
        retry: noAutoRetry,
        overrides: await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 26)),
        ),
      );
      addTearDown(container.dispose);
      final repository = container.read(auditRepositoryProvider);

      final page = await repository.list(
        action: 'updated',
        auditableType: r'App\Modules\Catalog\GenericProductModel',
        dateFrom: '2026-11-19',
        dateTo: '2026-11-26',
      );
      expect(page.items, hasLength(3));
      expect(page.meta.total, 3);
      expect(
        adapter.callsTo('GET', '/audit-logs').single.queryParameters,
        {
          'action': 'updated',
          'auditable_type': r'App\Modules\Catalog\GenericProductModel',
          'date_from': '2026-11-19',
          'date_to': '2026-11-26',
          'page': 1,
          'per_page': 25,
        },
      );
      expect((await repository.detail(101)).id, 101);
      expect(
        (await repository.summary(
          dateFrom: '2026-11-19',
          dateTo: '2026-11-26',
        )).total,
        3,
      );
    });
  });

  group('pantalla', () {
    late AppHarness harness;

    setUp(() => harness = AppHarness());

    Future<void> openAudit(WidgetTester tester) async {
      tester.view
        ..physicalSize = const Size(800, 3500)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      harness
        ..stubSignedInUser(permissions: ['auditoria.ver'], menu: _menu)
        ..storeSession();
      harness.adapter
        ..on(
          'GET',
          '/audit-logs',
          body: fixture('audit/audit_logs_response.json'),
        )
        ..on(
          'GET',
          '/audit-logs/101',
          body: fixture('audit/audit_log_response.json'),
        )
        ..on(
          'GET',
          '/audit-logs/99',
          body: fixture('audit/audit_log_empty_response.json'),
        )
        ..on(
          'GET',
          '/audit-logs/summary',
          body: fixture('audit/summary_response.json'),
        );
      await harness.pump(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Más'),
        ),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('Auditoría').last);
      await AppHarness.settle(tester);
    }

    testWidgets('lista los registros con usuario, fecha y acción', (
      tester,
    ) async {
      await openAudit(tester);

      expect(find.text('Generic Product'), findsOneWidget);
      expect(find.text('Usuario Prueba'), findsOneWidget);
      expect(find.text('26/11/2026 09:30 a. m.'), findsOneWidget);
      expect(find.text('MODIFICACIÓN'), findsOneWidget);
      expect(find.text('CREACIÓN'), findsOneWidget);
      expect(find.text('ACCESO'), findsOneWidget);
      expect(
        find.text('Sistema'),
        findsWidgets,
        reason: 'sin usuario ni elemento',
      );
      expect(find.text('3 registros'), findsOneWidget);
    });

    testWidgets('pide siete días por defecto y filtra por acción y periodo', (
      tester,
    ) async {
      await openAudit(tester);

      final first = harness.adapter.callsTo('GET', '/audit-logs').first;
      expect(first.queryParameters['date_from'], '2026-11-18');
      expect(first.queryParameters['date_to'], '2026-11-24');
      expect(first.queryParameters.containsKey('action'), isFalse);

      await tester.tap(find.widgetWithText(ChoiceChip, 'Eliminación'));
      await AppHarness.settle(tester);
      await tester.tap(find.widgetWithText(ChoiceChip, '30 días'));
      await AppHarness.settle(tester);

      final last = harness.adapter.callsTo('GET', '/audit-logs').last;
      expect(last.queryParameters['action'], 'deleted');
      expect(last.queryParameters['date_from'], '2026-10-26');
    });

    testWidgets('el filtro de elemento sale del resumen y se envía', (
      tester,
    ) async {
      harness.adapter.on(
        'GET',
        '/audit-logs/summary',
        body: fixture('audit/summary_types_response.json'),
      );
      await openAudit(tester);

      await tester.tap(find.text('Elemento'));
      await AppHarness.settle(tester);
      expect(find.text('Location'), findsWidgets);
      await tester.tap(find.text('Generic Product').last);
      await AppHarness.settle(tester);

      final last = harness.adapter.callsTo('GET', '/audit-logs').last;
      expect(
        last.queryParameters['auditable_type'],
        r'App\Modules\Catalog\Infrastructure\Persistence\Models\GenericProductModel',
      );
    });

    testWidgets('sin tipos en el resumen no hay filtro de elemento', (
      tester,
    ) async {
      await openAudit(tester);

      expect(find.text('Elemento'), findsNothing);
    });

    testWidgets('el detalle muestra cambios y oculta valores sensibles', (
      tester,
    ) async {
      await openAudit(tester);

      await tester.tap(find.text('Generic Product'));
      await AppHarness.settle(tester);

      expect(find.text('Registro de auditoría'), findsOneWidget);
      expect(find.text('192.168.81.20'), findsOneWidget);
      expect(find.text('Anterior: Gasa'), findsOneWidget);
      expect(find.text('Nuevo: Gasa estéril'), findsOneWidget);
      expect(find.text('Anterior: 10.00'), findsOneWidget);
      expect(find.text('Anterior: Oculto por seguridad'), findsOneWidget);
      expect(find.textContaining('hash-'), findsNothing);
    });

    testWidgets('un registro sin valores lo dice', (tester) async {
      await openAudit(tester);

      await tester.tap(find.text('ACCESO'));
      await AppHarness.settle(tester);

      expect(find.text('Este registro no guarda valores.'), findsOneWidget);
    });

    testWidgets('sin registros: mensaje', (tester) async {
      harness.adapter.on(
        'GET',
        '/audit-logs',
        body: envelope({
          'items': <dynamic>[],
          'meta': {
            'current_page': 1,
            'per_page': 25,
            'total': 0,
            'last_page': 1,
          },
        }),
      );
      await openAudit(tester);

      expect(
        find.text('No hay registros en el periodo elegido.'),
        findsOneWidget,
      );
    });
  });
}
