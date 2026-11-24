import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';

void main() {
  final service = PermissionService(const ['stock.ver', 'movimientos.entrada']);

  test('can', () {
    expect(service.can('stock.ver'), isTrue);
    expect(service.can('stock.editar'), isFalse);
  });

  test('canAny / canAll', () {
    expect(service.canAny(['x.ver', 'stock.ver']), isTrue);
    expect(service.canAny(['x.ver']), isFalse);
    expect(service.canAll(['stock.ver', 'movimientos.entrada']), isTrue);
    expect(service.canAll(['stock.ver', 'x.ver']), isFalse);
  });

  test('sin sesión no hay permisos', () {
    expect(PermissionService.none.can('stock.ver'), isFalse);
  });

  test('es inmutable frente a la lista original', () {
    final source = ['a.ver'];
    final copy = PermissionService(source);
    source.add('b.ver');
    expect(copy.can('b.ver'), isFalse);
  });
}
