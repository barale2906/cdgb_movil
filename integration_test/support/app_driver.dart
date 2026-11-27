import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sga_bojanini/bootstrap.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';

/// Usuario de pruebas del backend local. Las credenciales llegan por
/// `--dart-define-from-file=integration_test/test_user.local.json` (archivo ignorado por
/// git); nunca se escriben en el código.
const _email = String.fromEnvironment('TEST_EMAIL');
const _password = String.fromEnvironment('TEST_PASSWORD');

/// Conduce la app real contra el backend del destino elegido (`env/*.json`).
class AppDriver {
  AppDriver(this.tester);

  final WidgetTester tester;

  static IntegrationTestWidgetsFlutterBinding init() =>
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Arranca la app como lo hace `main()`.
  Future<void> launch() async {
    expect(
      _email.isNotEmpty && _password.isNotEmpty,
      isTrue,
      reason:
          'Falta --dart-define-from-file=integration_test/test_user.local.json',
    );
    runApp(RestartableApp(initial: await AppBootstrap.load()));
    await settle();
  }

  /// Espera sin depender de `pumpAndSettle` (hay indicadores animados).
  Future<void> settle([Duration duration = const Duration(seconds: 1)]) async {
    final end = DateTime.now().add(duration);
    while (DateTime.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  /// Espera hasta que [finder] aparezca; falla con un mensaje claro.
  Future<void> waitFor(
    Finder finder, {
    required String reason,
    Duration timeout = const Duration(seconds: 25),
  }) async {
    final end = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 200));
      if (finder.evaluate().isNotEmpty) return;
    }
    fail('No apareció $reason en ${timeout.inSeconds} s');
  }

  Future<void> waitForText(String text, {Duration? timeout}) => waitFor(
    find.text(text),
    reason: 'el texto «$text»',
    timeout: timeout ?? const Duration(seconds: 25),
  );

  Future<void> tapText(String text, {bool last = false}) async {
    await waitForText(text);
    await waitNoSnackBar();
    final finder = last ? find.text(text).last : find.text(text).first;
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await settle();
  }

  Future<void> tapTooltip(String message) async {
    await waitFor(find.byTooltip(message), reason: 'el botón «$message»');
    await tester.tap(find.byTooltip(message));
    await settle();
  }

  /// Espera a que se oculte el aviso (SnackBar) actual: tapa los botones de
  /// abajo del formulario siguiente.
  Future<void> waitNoSnackBar() async {
    final end = DateTime.now().add(const Duration(seconds: 12));
    while (find.byType(SnackBar).evaluate().isNotEmpty &&
        DateTime.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 200));
    }
  }

  Future<void> tapButton(String label) async {
    final finder = find.widgetWithText(FilledButton, label);
    await waitFor(finder, reason: 'el botón «$label»');
    await waitNoSnackBar();
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await settle(const Duration(seconds: 2));
  }

  Future<void> enter(String label, String text) async {
    // `TextField` cubre campos de formulario y de búsqueda (el rótulo o la
    // sugerencia es [label]).
    final finder = find.widgetWithText(TextField, label);
    await waitFor(finder, reason: 'el campo «$label»');
    await tester.ensureVisible(finder);
    await tester.enterText(finder, text);
    await tester.pump();
  }

  /// Escribe en el primer campo de texto visible (p. ej. el buscador de una
  /// pantalla de selección).
  Future<void> enterInFirstField(String text) async {
    await waitFor(find.byType(TextField), reason: 'un campo de búsqueda');
    await tester.enterText(find.byType(TextField).first, text);
    await settle(const Duration(seconds: 3));
  }

  Future<void> pick(String label, String option) async {
    final field = find.byWidgetPredicate(
      (w) => w is DropdownButtonFormField && w.decoration.labelText == label,
    );
    await waitFor(field, reason: 'la lista «$label»');
    await tester.ensureVisible(field);
    await tester.tap(field);
    await settle();
    await tester.tap(find.text(option).last);
    await settle();
  }

  /// Abre una lista y elige la primera opción real.
  Future<void> pickFirst(String label) async {
    final field = find.byWidgetPredicate(
      (w) => w is DropdownButtonFormField && w.decoration.labelText == label,
    );
    await waitFor(field, reason: 'la lista «$label»');
    await tester.ensureVisible(field);
    await tester.tap(field);
    await settle();
    await tester.tap(
      find.byWidgetPredicate((w) => w is DropdownMenuItem).last,
    );
    await settle();
  }

  /// Escribe una fecha (`DD/MM/AAAA`) en el selector, cambiándolo a modo de
  /// texto: evita recorrer el calendario mes a mes.
  Future<void> pickDateTyped(String label, String ddMmYyyy) async {
    final field = find.widgetWithText(DateField, label);
    await waitFor(field, reason: 'la fecha «$label»');
    await tester.ensureVisible(field);
    await tester.tap(field);
    await settle();
    await tester.tap(find.byIcon(Icons.edit_outlined));
    await settle(const Duration(milliseconds: 500));
    await tester.enterText(find.byType(TextField).last, ddMmYyyy);
    await tester.pump();
    await tester.tap(find.text('ACEPTAR'));
    await settle();
  }

  /// Elige la fecha de hoy en el selector de calendario.
  Future<void> pickToday(String label) async {
    final field = find.widgetWithText(DateField, label);
    await waitFor(field, reason: 'la fecha «$label»');
    await tester.ensureVisible(field);
    await tester.tap(field);
    await settle();
    await tester.tap(find.text('ACEPTAR'));
    await settle();
  }

  Future<void> login() async {
    await waitForText('Iniciar sesión');
    await tester.enterText(find.byType(TextFormField).at(0), _email);
    await tester.enterText(find.byType(TextFormField).at(1), _password);
    await tester.tap(find.text('Ingresar'));
    await settle(const Duration(seconds: 3));
    await waitFor(
      find.textContaining('Hola,'),
      reason: 'la pantalla de inicio',
    );
  }

  Future<void> openTab(String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(label),
      ),
    );
    await settle(const Duration(seconds: 2));
  }
}
