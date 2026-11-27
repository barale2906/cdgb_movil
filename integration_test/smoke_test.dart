import 'package:flutter_test/flutter_test.dart';

import 'support/app_driver.dart';

void main() {
  AppDriver.init();

  testWidgets('humo: inicia sesión y abre Activos contra el backend', (
    tester,
  ) async {
    final app = AppDriver(tester);
    await app.launch();
    await app.login();

    expect(find.textContaining('Hola,'), findsOneWidget);
    await app.openTab('Activos');
    await app.waitForText('Activos');
  });
}
