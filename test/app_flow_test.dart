import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/token_store.dart';

import 'helpers/app_harness.dart';
import 'helpers/fake_http_adapter.dart';
import 'helpers/fixtures.dart';

void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  group('arranque y acceso', () {
    testWidgets('sin sesión guardada muestra el login', (tester) async {
      await harness.pump(tester);

      expect(find.text('Iniciar sesión'), findsOneWidget);
      expect(find.text('Ingresar'), findsOneWidget);
    });

    testWidgets('valida los campos antes de enviar', (tester) async {
      await harness.pump(tester);

      await tester.tap(find.text('Ingresar'));
      await AppHarness.settle(tester);

      expect(find.text('Ingrese su correo electrónico.'), findsOneWidget);
      expect(find.text('Ingrese su contraseña.'), findsOneWidget);
      expect(harness.adapter.callsTo('POST', '/auth/login'), isEmpty);
    });

    testWidgets('login correcto lleva a Inicio con el menú filtrado', (
      tester,
    ) async {
      harness.stubLogin();
      await harness.pump(tester);

      await harness.login(tester);

      expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
      // Tiene stock.ver y el menú trae stock.index → Inventario.
      expect(find.text('Inventario'), findsWidgets);
      // El menú trae Compras, pero falta ordenes_compra.ver → no se muestra.
      expect(find.text('Compras'), findsNothing);
      expect(harness.store.session, isNotNull);
    });

    testWidgets('credenciales inválidas: mensaje del servidor y campo limpio', (
      tester,
    ) async {
      harness.adapter.on(
        'POST',
        '/auth/login',
        status: 401,
        body: errorBody('Credenciales inválidas.'),
      );
      await harness.pump(tester);

      await harness.login(tester, password: 'mala');

      expect(find.text('Credenciales inválidas.'), findsOneWidget);
      expect(find.text('Iniciar sesión'), findsOneWidget);
      expect(harness.store.session, isNull);
    });

    testWidgets('cuenta desactivada (409) muestra el mensaje', (tester) async {
      harness.adapter.on(
        'POST',
        '/auth/login',
        status: 409,
        body: errorBody(
          'Tu cuenta está desactivada. Contacta al administrador.',
        ),
      );
      await harness.pump(tester);

      await harness.login(tester);

      expect(
        find.text('Tu cuenta está desactivada. Contacta al administrador.'),
        findsOneWidget,
      );
    });

    testWidgets('sin red en dev: mensaje sin hablar de VPN', (tester) async {
      harness.adapter.onSocketFailure('POST', '/auth/login');
      await harness.pump(tester);

      await harness.login(tester);

      expect(
        find.textContaining('Revise su conexión a internet'),
        findsOneWidget,
      );
      expect(find.textContaining('VPN'), findsNothing);
    });

    testWidgets('una sesión guardada válida entra directo a Inicio', (
      tester,
    ) async {
      harness
        ..stubSignedInUser()
        ..storeSession();
      await harness.pump(tester);

      expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
      expect(find.text('Iniciar sesión'), findsNothing);
    });

    testWidgets('sin red al abrir: permite reintentar y no cierra la sesión', (
      tester,
    ) async {
      harness
        ..stubSignedInUser(includeMe: false)
        ..storeSession();
      // Primer intento falla; el segundo (reintento) responde.
      harness.adapter
        ..onSocketFailure('GET', '/auth/me')
        ..on('GET', '/auth/me', body: fixture('auth/me_response.json'));
      await harness.pump(tester);

      expect(find.text('Reintentar'), findsOneWidget);
      expect(harness.store.session, isNotNull);

      await tester.tap(find.text('Reintentar'));
      await AppHarness.settle(tester);

      expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
    });
  });

  group('bloqueo por inactividad', () {
    Future<void> signIn(WidgetTester tester) async {
      harness
        ..stubSignedInUser()
        ..storeSession();
      await harness.pump(tester);
      expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
    }

    testWidgets('se bloquea tras el tiempo configurado sin interacción', (
      tester,
    ) async {
      await signIn(tester);

      await tester.pump(const Duration(minutes: 15, seconds: 1));
      await AppHarness.settle(tester);

      expect(find.text('Sesión bloqueada'), findsOneWidget);
      expect(
        find.textContaining('Usuario Prueba, ingrese su contraseña'),
        findsOneWidget,
      );
      expect(find.text('Hola, Usuario Prueba'), findsNothing);
    });

    testWidgets('tocar la pantalla reinicia el conteo', (tester) async {
      await signIn(tester);

      await tester.pump(const Duration(minutes: 10));
      await tester.tapAt(const Offset(200, 300));
      await tester.pump(const Duration(minutes: 10));
      await AppHarness.settle(tester);

      expect(find.text('Sesión bloqueada'), findsNothing);
    });

    testWidgets('contraseña correcta desbloquea y vuelve a Inicio', (
      tester,
    ) async {
      await signIn(tester);
      await tester.pump(const Duration(minutes: 15, seconds: 1));
      await AppHarness.settle(tester);
      harness.stubLogin();
      harness.adapter.on('POST', '/auth/logout', body: envelope(null));

      await tester.enterText(find.byType(TextFormField), 'secreto123');
      await tester.tap(find.text('Desbloquear'));
      await AppHarness.settle(tester);

      expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
      expect(harness.adapter.callsTo('POST', '/auth/logout'), hasLength(1));
    });

    testWidgets('contraseña incorrecta sigue bloqueado', (tester) async {
      await signIn(tester);
      await tester.pump(const Duration(minutes: 15, seconds: 1));
      await AppHarness.settle(tester);
      harness.adapter.on(
        'POST',
        '/auth/login',
        status: 401,
        body: errorBody('Credenciales inválidas.'),
      );

      await tester.enterText(find.byType(TextFormField), 'mala');
      await tester.tap(find.text('Desbloquear'));
      await AppHarness.settle(tester);

      expect(find.text('La contraseña no es correcta.'), findsOneWidget);
      expect(find.text('Sesión bloqueada'), findsOneWidget);
    });

    testWidgets('"Cambiar de usuario" cierra la sesión tras confirmar', (
      tester,
    ) async {
      await signIn(tester);
      await tester.pump(const Duration(minutes: 15, seconds: 1));
      await AppHarness.settle(tester);
      harness.adapter.on('POST', '/auth/logout', body: envelope(null));

      await tester.tap(find.text('Cambiar de usuario'));
      await AppHarness.settle(tester);
      await tester.tap(find.widgetWithText(FilledButton, 'Cambiar de usuario'));
      await AppHarness.settle(tester);

      expect(find.text('Iniciar sesión'), findsOneWidget);
      expect(harness.store.session, isNull);
    });

    testWidgets(
      'en segundo plano más del tiempo permitido: bloqueado al volver',
      (
        tester,
      ) async {
        await signIn(tester);

        tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
        harness.clock.advance(const Duration(minutes: 16));
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        await AppHarness.settle(tester);

        expect(find.text('Sesión bloqueada'), findsOneWidget);
      },
    );

    testWidgets('una salida corta a segundo plano no bloquea', (tester) async {
      await signIn(tester);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      harness.clock.advance(const Duration(minutes: 2));
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await AppHarness.settle(tester);

      expect(find.text('Sesión bloqueada'), findsNothing);
      expect(find.text('Hola, Usuario Prueba'), findsOneWidget);
    });

    testWidgets('al pasar a segundo plano se guarda la hora para el arranque', (
      tester,
    ) async {
      await signIn(tester);
      harness.clock.advance(const Duration(minutes: 3));

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await AppHarness.settle(tester, frames: 2);

      expect(harness.store.session!.lastActiveAt, harness.clock.now);
    });

    testWidgets(
      'si el turno venció en segundo plano, cierra la sesión al volver',
      (
        tester,
      ) async {
        await signIn(tester);
        harness.adapter.on('POST', '/auth/logout', body: envelope(null));

        tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
        harness.clock.advance(const Duration(hours: 12));
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        await AppHarness.settle(tester);

        expect(find.text('Iniciar sesión'), findsOneWidget);
        expect(find.textContaining('Su turno terminó'), findsOneWidget);
      },
    );

    testWidgets('al reabrir tras mucha inactividad arranca bloqueado', (
      tester,
    ) async {
      harness
        ..stubSignedInUser()
        ..storeSession(activeAgo: const Duration(minutes: 40));
      await harness.pump(tester);

      expect(find.text('Sesión bloqueada'), findsOneWidget);
    });
  });

  group('sesión terminada', () {
    testWidgets('un 401 en el menú lleva al login con aviso', (tester) async {
      harness
        ..stubSignedInUser(includeMenu: false)
        ..storeSession();
      harness.adapter.on(
        'GET',
        '/auth/menu',
        status: 401,
        body: errorBody('No autenticado.'),
      );
      await harness.pump(tester);

      expect(find.text('Iniciar sesión'), findsOneWidget);
      expect(
        find.text('Su sesión expiró. Inicie sesión de nuevo.'),
        findsOneWidget,
      );
      expect(harness.store.session, isNull);
    });

    testWidgets('turno vencido al abrir: aviso de cierre por seguridad', (
      tester,
    ) async {
      harness.store.session = StoredSession(
        token: 'viejo',
        startedAt: harness.clock.now.subtract(const Duration(hours: 13)),
        tokenIssuedAt: harness.clock.now.subtract(const Duration(hours: 13)),
      );
      harness.adapter.on('POST', '/auth/logout', body: envelope(null));
      await harness.pump(tester);

      expect(find.textContaining('Su turno terminó'), findsOneWidget);
    });
  });
}
