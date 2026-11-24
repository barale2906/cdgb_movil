import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/auth_user.dart';
import 'package:sga_bojanini/core/auth/menu_item.dart';

import '../../helpers/fixtures.dart';

void main() {
  group('AuthUser (contrato)', () {
    test('parsea el usuario del login', () {
      final data =
          fixture('auth/login_response.json')['data'] as Map<String, dynamic>;
      final user = AuthUser.fromJson(data['user'] as Map<String, dynamic>);

      expect(user.id, 42);
      expect(user.email, 'usuario.prueba@example.com');
      expect(user.roles.single.name, 'jefe_almacen');
      expect(user.permissions, contains('stock.ver'));
      expect(user.warehouses, isEmpty, reason: 'el login no los incluye');
    });

    test('parsea /auth/me tolerando campos desconocidos y phone nulo', () {
      final user = AuthUser.fromJson(
        fixture('auth/me_response.json')['data'] as Map<String, dynamic>,
      );
      expect(user.phone, isNull);
      expect(user.warehouses.single.code, 'BC');
    });
  });

  group('MenuItem (contrato)', () {
    late List<MenuItem> menu;

    setUp(() {
      final data = fixture('auth/menu_response.json')['data'] as List<dynamic>;
      menu = [
        for (final item in data)
          MenuItem.fromJson(item as Map<String, dynamic>),
      ];
    });

    test(
      'tolera actions como lista vacía, mapa u omitido, y children ausente',
      () {
        expect(menu, hasLength(3));
        final purchaseOrders = menu.last.children.single;
        expect(purchaseOrders.actions['create'], isTrue);
        expect(purchaseOrders.children, isEmpty);
      },
    );

    test('flattened recorre todos los niveles', () {
      final keys = menu.expand((item) => item.flattened).map((i) => i.key);
      expect(keys, contains('stock'));
      expect(keys, contains('purchase-orders'));
    });
  });
}
