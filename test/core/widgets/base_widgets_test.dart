import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/auth_user.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/confirm_dialog.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/permission_gate.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('BojaniButton', () {
    testWidgets('ejecuta la acción al tocar', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        BojaniButton(label: 'Guardar', onPressed: () => taps++),
      );

      await tester.tap(find.text('Guardar'));

      expect(taps, 1);
    });

    testWidgets('en vuelo se bloquea y mantiene su ancho', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        BojaniButton(label: 'Guardar', onPressed: () => taps++),
      );
      final idleWidth = tester.getSize(find.byType(FilledButton)).width;

      await tester.pumpApp(
        BojaniButton(
          label: 'Guardar',
          onPressed: () => taps++,
          isLoading: true,
        ),
      );
      await tester.tap(find.byType(FilledButton), warnIfMissed: false);

      expect(taps, 0, reason: 'no hay envíos dobles');
      expect(tester.getSize(find.byType(FilledButton)).width, idleWidth);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('cumple el objetivo táctil mínimo de 44 pt', (tester) async {
      await tester.pumpApp(
        BojaniButton(label: 'OK', onPressed: () {}, expand: false),
      );
      expect(
        tester.getSize(find.byType(FilledButton)).height,
        greaterThanOrEqualTo(44),
      );
    });
  });

  group('PermissionGate', () {
    Future<void> pumpGate(WidgetTester tester, List<String> permissions) =>
        tester.pumpApp(
          const PermissionGate(permission: 'stock.ver', child: Text('Acción')),
          overrides: [
            permissionServiceProvider.overrideWithValue(
              PermissionService(permissions),
            ),
          ],
        );

    testWidgets('muestra el contenido con permiso', (tester) async {
      await pumpGate(tester, ['stock.ver']);
      expect(find.text('Acción'), findsOneWidget);
    });

    testWidgets('lo oculta sin permiso', (tester) async {
      await pumpGate(tester, ['otro.ver']);
      expect(find.text('Acción'), findsNothing);
    });

    testWidgets('muestra el fallback si se indica', (tester) async {
      await tester.pumpApp(
        const PermissionGate(
          permission: 'stock.ver',
          fallback: Text('Sin acceso'),
          child: Text('Acción'),
        ),
        overrides: [
          currentUserProvider.overrideWithValue(
            const AuthUser(id: 1, name: 'Ana', email: 'a@b.co'),
          ),
        ],
      );
      expect(find.text('Sin acceso'), findsOneWidget);
    });
  });

  group('ErrorState', () {
    final prod = AppEnvironment.fromValues(
      env: 'prod',
      apiBaseUrl: 'https://api.example.com/api/v1',
    );

    testWidgets('en producción, un fallo de red orienta a la VPN', (
      tester,
    ) async {
      await tester.pumpApp(
        ErrorState(
          error: const NetworkException(NetworkFailureKind.noConnection),
          onRetry: () {},
        ),
        environment: prod,
      );
      expect(find.textContaining('VPN de la clínica'), findsOneWidget);
    });

    testWidgets('el botón reintentar llama a la acción', (tester) async {
      var retries = 0;
      await tester.pumpApp(
        ErrorState(
          error: const ServerException('boom', statusCode: 500),
          onRetry: () => retries++,
        ),
      );
      expect(
        find.textContaining('El servidor no pudo completar'),
        findsOneWidget,
      );

      await tester.tap(find.text('Reintentar'));

      expect(retries, 1);
    });

    testWidgets('un 409 muestra el mensaje del servidor', (tester) async {
      await tester.pumpApp(
        ErrorState(
          error: const BusinessRuleException('Stock insuficiente en el lote.'),
          onRetry: () {},
        ),
      );
      expect(find.text('Stock insuficiente en el lote.'), findsOneWidget);
    });

    testWidgets('un error desconocido usa el mensaje genérico', (tester) async {
      await tester.pumpApp(ErrorState(error: StateError('x'), onRetry: () {}));
      expect(find.textContaining('error inesperado'), findsOneWidget);
    });
  });

  group('EmptyState y StatusChip', () {
    testWidgets('EmptyState muestra mensaje y acción', (tester) async {
      var pressed = false;
      await tester.pumpApp(
        EmptyState(
          icon: Icons.inbox_outlined,
          title: 'Sin datos',
          message: 'No hay registros.',
          actionLabel: 'Actualizar',
          onAction: () => pressed = true,
        ),
      );

      expect(find.text('Sin datos'), findsOneWidget);
      expect(find.text('No hay registros.'), findsOneWidget);
      await tester.tap(find.text('Actualizar'));
      expect(pressed, isTrue);
    });

    testWidgets('StatusChip lleva siempre texto (no solo color)', (
      tester,
    ) async {
      await tester.pumpApp(
        const StatusChip(label: 'Vencido', kind: StatusKind.error),
      );
      expect(find.text('VENCIDO'), findsOneWidget);
    });
  });

  group('Skeleton', () {
    testWidgets('con "reducir movimiento" no anima', (tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Skeleton(width: 100),
          ),
        ),
      );
      // Sin animación infinita, pumpAndSettle termina.
      await tester.pumpAndSettle();
    });
  });

  group('AppSnackbar y ConfirmDialog', () {
    testWidgets('el error persiste y se cierra con la acción', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => AppSnackbar.show(
                context,
                'Algo falló',
                kind: AppSnackbarKind.error,
                closeLabel: 'Cerrar',
              ),
              child: const Text('Mostrar'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Mostrar'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 10));
      expect(find.text('Algo falló'), findsOneWidget);

      await tester.tap(find.text('Cerrar'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Algo falló'), findsNothing);
    });

    testWidgets('ConfirmDialog devuelve true solo al confirmar', (
      tester,
    ) async {
      bool? result;
      await tester.pumpApp(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => result = await ConfirmDialog.show(
              context,
              title: '¿Seguro?',
              message: 'Se borrará.',
              confirmLabel: 'Borrar',
              destructive: true,
            ),
            child: const Text('Abrir'),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(result, isFalse);

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Borrar'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });
  });
}
