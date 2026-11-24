import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/auth_user.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_state.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/router/redirect.dart';

const _user = AuthUser(id: 1, name: 'Ana', email: 'ana@example.com');

SessionState _authenticated({bool locked = false}) =>
    SessionState.authenticated(
      user: _user,
      startedAt: DateTime(2026),
      locked: locked,
    );

String? _go(
  SessionState session,
  String location, {
  List<String> permissions = const [],
}) => resolveRedirect(
  session: session,
  permissions: PermissionService(permissions),
  location: location,
);

void main() {
  group('sin sesión', () {
    test('restaurando o con fallo de verificación → splash', () {
      expect(_go(const SessionState.restoring(), '/home'), Routes.splash);
      expect(
        _go(
          const SessionState.restoreFailed(
            NetworkException(NetworkFailureKind.noConnection),
          ),
          '/inventory',
        ),
        Routes.splash,
      );
      expect(_go(const SessionState.restoring(), Routes.splash), isNull);
    });

    test('sin autenticar → login desde cualquier ruta protegida', () {
      const unauthenticated = SessionState.unauthenticated();
      expect(_go(unauthenticated, '/home'), Routes.login);
      expect(_go(unauthenticated, '/profile'), Routes.login);
      expect(_go(unauthenticated, Routes.login), isNull);
    });
  });

  group('bloqueada', () {
    test('todo lleva a la pantalla de bloqueo', () {
      expect(_go(_authenticated(locked: true), '/home'), Routes.locked);
      expect(_go(_authenticated(locked: true), '/profile'), Routes.locked);
      expect(_go(_authenticated(locked: true), Routes.locked), isNull);
    });
  });

  group('autenticada', () {
    test('las pantallas de acceso llevan a Inicio', () {
      for (final screen in [Routes.splash, Routes.login, Routes.locked]) {
        expect(_go(_authenticated(), screen), Routes.home);
      }
    });

    test('Inicio, perfil y acerca de no piden permiso', () {
      for (final location in [
        Routes.home,
        Routes.profile,
        Routes.changePassword,
        Routes.about,
      ]) {
        expect(_go(_authenticated(), location), isNull);
      }
    });

    test('una sección sin permiso de entrada vuelve a Inicio', () {
      expect(_go(_authenticated(), '/inventory'), Routes.home);
      expect(_go(_authenticated(), '/inventory/stock/3'), Routes.home);
    });

    test('con el permiso de la sección deja pasar', () {
      expect(
        _go(_authenticated(), '/inventory', permissions: ['stock.ver']),
        isNull,
      );
    });

    test('un permiso de otra sección no sirve', () {
      expect(
        _go(_authenticated(), '/purchasing', permissions: ['stock.ver']),
        Routes.home,
      );
    });
  });
}
