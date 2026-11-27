import 'package:flutter_test/flutter_test.dart';

import 'support/app_driver.dart';

/// Usuarios por rol del backend local (`test_users_flat.local.json`).
const _deliverEmail = String.fromEnvironment('JEFE_ALMACEN_EMAIL');
const _deliverPassword = String.fromEnvironment('JEFE_ALMACEN_PASSWORD');
const _receiverPin = String.fromEnvironment('OPERADOR_ALMACEN_PIN');

void main() {
  AppDriver.init();

  testWidgets(
    'inventario: una salida queda pendiente y se confirma con firma y PIN',
    (tester) async {
      expect(
        _deliverEmail.isNotEmpty && _receiverPin.isNotEmpty,
        isTrue,
        reason: 'Falta test_users_flat.local.json',
      );
      final app = AppDriver(tester);

      await app.launch();
      await app.login(email: _deliverEmail, password: _deliverPassword);

      // Almacén activo (si hay varios hay que elegir) e inventario.
      if (find.text('Seleccionar almacén').evaluate().isNotEmpty) {
        await app.tapText('Seleccionar almacén');
        await app.tapText('Antienvejecimiento');
      }
      await app.openTab('Inventario');
      await app.waitForText('Existencias');

      // Salida de 1 unidad a un centro de costo: queda pendiente de firma.
      await app.tapText('Nuevo movimiento');
      await app.tapText('Salida');
      await app.pickFirst('Centro de costo');
      await app.tapText('Agregar producto');
      await app.tapText('Seleccionar');
      await app.enter('Buscar por nombre o código de barras', 'Androcell');
      // Se toca por el código: el nombre también está en el buscador.
      await app.tapText('000001');
      await app.enter('Cantidad', '1');
      await app.tapText('Agregar', last: true);
      await app.tapButton('Registrar');
      await app.waitFor(
        find.textContaining('Comprobante SAL-'),
        reason: 'el aviso del comprobante de salida',
      );

      // Al registrar, la app abre el comprobante pendiente de firma.
      await app.waitForText('PENDIENTE DE FIRMA');
      await app.tapButton('Confirmar y firmar');

      // Entrega con la firma registrada; recibe un usuario del sistema por PIN.
      await app.tapText('Usar mi firma registrada');
      await app.tapText('Usuario del sistema');
      await app.enter('PIN de 3 dígitos', _receiverPin);
      await app.tapButton('Confirmar y firmar');

      await app.waitForText('Comprobante confirmado.');
    },
  );
}
