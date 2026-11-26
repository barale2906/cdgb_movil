import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_http_adapter.dart';

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  Future<void> signIn(
    WidgetTester tester,
    List<String> permissions, {
    String menu = 'auth/menu_response.json',
  }) async {
    harness
      ..stubSignedInUser(permissions: permissions, menu: menu)
      ..storeSession();
    await harness.pump(tester);
  }

  testWidgets('con Inventario la barra inferior lo muestra junto a Inicio', (
    tester,
  ) async {
    await signIn(tester, ['stock.ver', 'almacenes.ver']);

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Inventario'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('tocar un destino de «Más» abre la sección', (tester) async {
    harness.adapter
      ..on(
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
      )
      ..on(
        'GET',
        '/audit-logs/summary',
        body: envelope({
          'total': 0,
          'by_action': <dynamic>[],
          'by_type': <dynamic>[],
        }),
      );
    await signIn(
      tester,
      ['auditoria.ver'],
      menu: 'auth/menu_audit_response.json',
    );

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text('Auditoría').last);
    await AppHarness.settle(tester);

    expect(find.text('Hoy'), findsOneWidget);
    expect(find.textContaining('Próximamente'), findsNothing);
  });

  testWidgets('sin módulos no hay barra inferior y se explica por qué', (
    tester,
  ) async {
    await signIn(tester, []);

    expect(find.byType(NavigationBar), findsNothing);
    expect(
      find.textContaining('no tiene módulos habilitados'),
      findsOneWidget,
    );
  });

  testWidgets('una ruta sin permiso de entrada vuelve a Inicio', (
    tester,
  ) async {
    await signIn(tester, ['stock.ver']);
    final context = tester.element(find.byType(Scaffold).first);

    // Compras está en el menú del backend, pero falta ordenes_compra.ver.
    GoRouter.of(context).go('/purchasing');
    await AppHarness.settle(tester);

    expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
  });

  testWidgets('el avatar abre el perfil con roles y almacenes', (tester) async {
    await signIn(tester, ['almacenes.ver']);

    await tester.tap(find.byTooltip('Abrir perfil'));
    await AppHarness.settle(tester);

    expect(find.text('Mi perfil'), findsOneWidget);
    expect(find.text('usuario.prueba@example.com'), findsOneWidget);
    expect(find.text('JEFE_ALMACEN'), findsOneWidget);
    expect(find.text('Bodega Central'), findsWidgets);
    expect(find.text('Farmacia'), findsWidgets);
  });

  testWidgets('con varios almacenes se elige el activo y se recuerda', (
    tester,
  ) async {
    await signIn(tester, ['almacenes.ver']);

    expect(find.text('Seleccionar almacén'), findsOneWidget);

    await tester.tap(find.text('Seleccionar almacén'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Farmacia'));
    await AppHarness.settle(tester);

    expect(find.text('Seleccionar almacén'), findsNothing);
    expect(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Farmacia'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('sin conexión muestra el aviso y lo quita al volver', (
    tester,
  ) async {
    await signIn(tester, []);
    expect(find.textContaining('Sin conexión'), findsNothing);

    harness.connectivity.emit(online: false);
    await AppHarness.settle(tester, frames: 2);
    expect(find.textContaining('Sin conexión'), findsOneWidget);

    harness.connectivity.emit(online: true);
    await AppHarness.settle(tester, frames: 2);
    expect(find.textContaining('Sin conexión'), findsNothing);
  });

  testWidgets('cerrar sesión pide confirmación y vuelve al login', (
    tester,
  ) async {
    await signIn(tester, []);
    harness.adapter.on('POST', '/auth/logout', body: {'success': true});

    await tester.tap(find.byTooltip('Abrir perfil'));
    await AppHarness.settle(tester);
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await AppHarness.settle(tester, frames: 3);
    await tester.tap(find.widgetWithText(FilledButton, 'Cerrar sesión'));
    await AppHarness.settle(tester, frames: 3);
    await tester.tap(find.widgetWithText(FilledButton, 'Cerrar sesión').last);
    await AppHarness.settle(tester);

    expect(find.text('Iniciar sesión'), findsOneWidget);
    expect(harness.store.session, isNull);
  });
}
