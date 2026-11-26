import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/data/assets_repository.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

const _view = ['activos.ver'];

void main() {
  test('el repositorio envía el estado y el motivo recortado', () async {
    final adapter = FakeHttpAdapter()
      ..on(
        'POST',
        '/assets/7/status',
        body: fixture('assets/asset_response.json'),
      );
    final container = ProviderContainer(
      retry: noAutoRetry,
      overrides: await baseOverrides(
        adapter: adapter,
        store: InMemoryTokenStore(),
        clock: TestClock(DateTime(2026, 11, 25)),
      ),
    );
    addTearDown(container.dispose);
    final repository = container.read(assetsRepositoryProvider);

    await repository.changeStatus(
      7,
      AssetStatus.outOfService,
      reason: ' Daño ',
    );
    await repository.changeStatus(7, AssetStatus.available, reason: '  ');

    final calls = adapter.callsTo('POST', '/assets/7/status').toList();
    expect(calls.first.data, {'status': 'out_of_service', 'reason': 'Daño'});
    expect(calls.last.data, {'status': 'available'});
  });

  group('cambiar estado (ficha)', () {
    late AppHarness harness;

    setUp(() => harness = AppHarness());

    Future<void> openAsset(
      WidgetTester tester, {
      List<String> permissions = _view,
    }) async {
      tester.view
        ..physicalSize = const Size(800, 3000)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      harness
        ..stubSignedInUser(
          permissions: permissions,
          menu: 'auth/menu_assets_response.json',
        )
        ..stubAssetsReads()
        ..storeSession();
      await harness.pump(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Activos'),
        ),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('Monitor de signos vitales').first);
      await AppHarness.settle(tester);
    }

    Future<void> openDialog(WidgetTester tester) async {
      await tester.scrollUntilVisible(
        find.text('Cambiar estado'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.tap(find.text('Cambiar estado'));
      await AppHarness.settle(tester);
    }

    Future<void> pickStatus(WidgetTester tester, String option) async {
      await tester.tap(
        find.byWidgetPredicate(
          (w) =>
              w is DropdownButtonFormField &&
              w.decoration.labelText == 'Estado nuevo',
        ),
      );
      await AppHarness.settle(tester, frames: 4);
      await tester.tap(find.text(option).last);
      await AppHarness.settle(tester, frames: 4);
    }

    testWidgets('sin permiso de editar no hay botón', (tester) async {
      await openAsset(tester);
      expect(find.text('Cambiar estado'), findsNothing);
    });

    testWidgets('cambia el estado con motivo y refresca la ficha', (
      tester,
    ) async {
      await openAsset(tester, permissions: [..._view, 'activos.editar']);
      harness.adapter.on(
        'POST',
        '/assets/7/status',
        body: fixture('assets/asset_response.json'),
      );
      await openDialog(tester);
      await pickStatus(tester, 'Fuera de servicio');
      await tester.enterText(
        find.byType(TextFormField).last,
        'Pantalla dañada',
      );
      await tester.tap(find.text('Guardar'));
      await AppHarness.settle(tester);

      expect(harness.adapter.callsTo('POST', '/assets/7/status').single.data, {
        'status': 'out_of_service',
        'reason': 'Pantalla dañada',
      });
      expect(find.text('Estado actualizado.'), findsOneWidget);
    });

    testWidgets('exige elegir un estado y no ofrece el actual', (tester) async {
      await openAsset(tester, permissions: [..._view, 'activos.editar']);
      await openDialog(tester);
      await tester.tap(find.text('Guardar'));
      await AppHarness.settle(tester);
      expect(find.text('Este campo es obligatorio.'), findsOneWidget);

      await tester.tap(
        find.byWidgetPredicate(
          (w) =>
              w is DropdownButtonFormField &&
              w.decoration.labelText == 'Estado nuevo',
        ),
      );
      await AppHarness.settle(tester, frames: 4);
      expect(find.text('Fuera de servicio'), findsWidgets);
      expect(
        find.descendant(
          of: find.byType(DropdownMenuItem<AssetStatus>),
          matching: find.text('Operativo'),
        ),
        findsNothing,
        reason: 'el estado actual no se ofrece',
      );
      expect(harness.adapter.callsTo('POST', '/assets/7/status'), isEmpty);
    });

    testWidgets('error del servidor: se muestra su mensaje', (tester) async {
      await openAsset(tester, permissions: [..._view, 'activos.editar']);
      harness.adapter.on(
        'POST',
        '/assets/7/status',
        status: 409,
        body: errorBody('El activo tiene un mantenimiento en curso.'),
      );
      await openDialog(tester);
      await pickStatus(tester, 'Fuera de servicio');
      await tester.tap(find.text('Guardar'));
      await AppHarness.settle(tester);

      expect(
        find.text('El activo tiene un mantenimiento en curso.'),
        findsOneWidget,
      );
      expect(harness.adapter.callsTo('POST', '/assets/7/status'), hasLength(1));
    });
  });
}
