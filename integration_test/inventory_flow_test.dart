import 'package:flutter_test/flutter_test.dart';

import 'support/app_driver.dart';

void main() {
  AppDriver.init();

  testWidgets('inventario: registra una entrada y la ve en Existencias', (
    tester,
  ) async {
    final app = AppDriver(tester);
    final lot = 'LOT-IT-${DateTime.now().millisecondsSinceEpoch}';

    await app.launch();
    await app.login();

    // Almacén activo (barra superior) y sección de inventario.
    await app.tapText('Seleccionar almacén');
    await app.tapText('Antienvejecimiento');
    await app.openTab('Inventario');
    await app.waitForText('Existencias');

    // Nuevo movimiento → Entrada.
    await app.tapText('Nuevo movimiento');
    await app.tapText('Entrada');
    await app.tapText('Agregar producto');

    // Producto, ubicación, lote, vencimiento y cantidad.
    await app.tapText('Seleccionar');
    await app.enterInFirstField('Androcell');
    await app.tapText('Androcell', last: true);
    await app.pickFirst('Variante');
    await app.pickFirst('Ubicación');
    await app.enter('Número de lote', lot);
    await app.pickDateTyped('Fecha de vencimiento', '31/12/2028');
    await app.enter('Cantidad', '7');
    await app.tapText('Agregar', last: true);

    await app.tapButton('Registrar');
    await app.waitFor(
      find.textContaining('Comprobante ENT-'),
      reason: 'el aviso del comprobante de entrada',
    );
    expect(find.textContaining('registrado.'), findsOneWidget);
  });
}
