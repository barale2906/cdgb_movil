import 'package:dio/dio.dart' show DioExceptionType;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/application/record_actions.dart';
import 'package:sga_bojanini/features/clinical/data/clinical_repository.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

const _record = '/patient-procedure-records/22';
const Map<String, Object> _ok = {
  'success': true,
  'message': 'Registro eliminado',
};

void main() {
  group('acciones', () {
    late FakeHttpAdapter adapter;
    late ProviderContainer container;

    setUp(() async {
      adapter = FakeHttpAdapter();
      container = ProviderContainer(
        retry: noAutoRetry,
        overrides: await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 26)),
        ),
      );
      addTearDown(container.dispose);
      container.listen(recordActionsProvider, (_, _) {});
    });

    test('el repositorio usa DELETE sobre el registro', () async {
      adapter.on('DELETE', _record, body: _ok);
      await container.read(clinicalRepositoryProvider).deleteRecord(22);
      expect(adapter.callsTo('DELETE', _record), hasLength(1));
    });

    test('eliminar recarga las listas del registro y del historial', () async {
      adapter
        ..on('DELETE', _record, body: _ok)
        ..on(
          'GET',
          '/patient-procedure-records',
          body: fixture('clinical/records_response.json'),
        );
      final sub = container.listen(procedureRecordsProvider(''), (_, _) {});
      addTearDown(sub.close);
      await container.read(procedureRecordsProvider('').future);

      final done = await container
          .read(recordActionsProvider.notifier)
          .delete(22);
      await container.read(procedureRecordsProvider('').future);

      expect(done, isTrue);
      expect(
        adapter.callsTo('GET', '/patient-procedure-records'),
        hasLength(2),
      );
    });

    test('un 403 deja el error y no se repite', () async {
      adapter.on(
        'DELETE',
        _record,
        status: 403,
        body: errorBody('No tiene permiso'),
      );
      final done = await container
          .read(recordActionsProvider.notifier)
          .delete(22);
      expect(done, isFalse);
      expect(
        container.read(recordActionsProvider).error,
        isA<ForbiddenException>(),
      );
      expect(adapter.callsTo('DELETE', _record), hasLength(1));
    });
  });

  group('pantalla', () {
    late AppHarness harness;

    setUp(() => harness = AppHarness());

    Future<void> openRecord(
      WidgetTester tester, {
      required List<String> permissions,
      String record = 'clinical/record_response.json',
    }) async {
      tester.view
        ..physicalSize = const Size(800, 4000)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      harness
        ..stubSignedInUser(
          permissions: permissions,
          menu: 'auth/menu_clinical_response.json',
        )
        ..storeSession();
      harness.adapter
        ..on(
          'GET',
          '/patient-procedure-records',
          body: fixture('clinical/records_response.json'),
        )
        ..on('GET', _record, body: fixture(record));
      await harness.pump(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Más'),
        ),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('Registros clínicos').last);
      await AppHarness.settle(tester);
      await tester.tap(find.text('Consulta dermatología'));
      await AppHarness.settle(tester);
    }

    testWidgets('sin el permiso no hay botón', (tester) async {
      await openRecord(tester, permissions: ['registros_procedimientos.ver']);
      expect(find.text('Eliminar registro'), findsNothing);
    });

    testWidgets('pide confirmar, avisa de la orden y elimina', (tester) async {
      harness.adapter.on('DELETE', _record, body: _ok);
      await openRecord(
        tester,
        permissions: [
          'registros_procedimientos.ver',
          'registros_procedimientos.eliminar',
        ],
      );

      await tester.tap(find.text('Eliminar registro'));
      await AppHarness.settle(tester);
      expect(
        find.textContaining('Pertenece a la orden de servicio OS-2026-0007.'),
        findsOneWidget,
      );
      expect(find.textContaining('no se puede deshacer'), findsOneWidget);
      await tester.tap(find.text('Eliminar registro').last);
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('DELETE', _record), hasLength(1));
      expect(find.text('Registro eliminado.'), findsOneWidget);
      expect(
        find.text('Registro de procedimiento'),
        findsNothing,
        reason: 'vuelve a la lista',
      );
    });

    testWidgets('cancelar el diálogo no elimina nada', (tester) async {
      await openRecord(
        tester,
        permissions: [
          'registros_procedimientos.ver',
          'registros_procedimientos.eliminar',
        ],
      );

      await tester.tap(find.text('Eliminar registro'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Cancelar'));
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('DELETE', _record), isEmpty);
    });

    testWidgets('sin respuesta: avisa que pudo eliminarse y no repite', (
      tester,
    ) async {
      harness.adapter.onError(
        'DELETE',
        _record,
        DioExceptionType.receiveTimeout,
      );
      await openRecord(
        tester,
        permissions: [
          'registros_procedimientos.ver',
          'registros_procedimientos.eliminar',
        ],
      );

      await tester.tap(find.text('Eliminar registro'));
      await AppHarness.settle(tester);
      await tester.tap(find.text('Eliminar registro').last);
      await AppHarness.settle(tester);

      expect(
        find.textContaining('es posible que sí se haya eliminado'),
        findsOneWidget,
      );
      expect(harness.adapter.callsTo('DELETE', _record), hasLength(1));
    });
  });
}
