import 'package:flutter_test/flutter_test.dart';

import 'support/app_driver.dart';

void main() {
  AppDriver.init();

  testWidgets(
    'activos: registrar, editar, programar un mantenimiento y eliminar',
    (tester) async {
      final app = AppDriver(tester);
      final name =
          'Prueba integración ${DateTime.now().millisecondsSinceEpoch}';

      await app.launch();
      await app.login();
      await app.openTab('Activos');

      // Registrar.
      await app.tapTooltip('Nuevo activo');
      await app.enter('Nombre', name);
      await app.pick('Categoría', 'Equipo biomédico');
      await app.pick('Sede', 'Sede Principal');
      await app.pick('Lugar', 'Bodega');
      await app.enter('Marca', 'MarcaPrueba');
      await app.tapButton('Guardar');
      await app.waitForText('Activo registrado.');

      // Buscarlo en la lista y abrir la ficha.
      await app.enter('Buscar por nombre o código', name);
      await app.settle(const Duration(seconds: 3));
      // El texto también está escrito en el buscador: la ficha es el último.
      await app.tapText(name, last: true);
      await app.waitForText('MarcaPrueba');

      // Editar.
      await app.tapText('Editar datos');
      await app.enter('Modelo', 'MOD-1');
      await app.tapButton('Guardar');
      await app.waitForText('Datos del activo guardados.');
      await app.waitForText('MOD-1');

      // Hoja de vida técnica.
      await app.tapText('Editar hoja de vida técnica');
      await app.enter('Fabricante', 'Fabricante de prueba');
      await app.tapButton('Guardar');
      await app.waitForText('Hoja de vida técnica guardada.');
      await app.waitForText('Fabricante de prueba');

      // Programar un mantenimiento.
      await app.tapText('Programar mantenimiento');
      await app.pick('Tipo de mantenimiento', 'Inspección');
      await app.pickToday('Fecha programada');
      await app.tapButton('Programar mantenimiento');
      await app.waitForText('Mantenimiento programado.');

      // Eliminar (borrado lógico): el servidor decide si lo permite.
      await app.tapText('Eliminar activo');
      await app.tapText('Eliminar activo', last: true);
      await app.waitForText('Activo eliminado.');
    },
  );
}
