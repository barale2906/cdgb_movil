import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'app_harness.dart';

/// Abre un desplegable de formulario por su etiqueta y elige una opción.
Future<void> pickOption(
  WidgetTester tester,
  String label,
  String option,
) async {
  await scrollTo(
    tester,
    find.byWidgetPredicate(
      (w) => w is DropdownButtonFormField && w.decoration.labelText == label,
    ),
  );
  await tester.tap(
    find.byWidgetPredicate(
      (w) => w is DropdownButtonFormField && w.decoration.labelText == label,
    ),
  );
  await AppHarness.settle(tester, frames: 4);
  await tester.tap(find.text(option).last);
  await AppHarness.settle(tester, frames: 4);
}

/// Desplaza el último `Scrollable` hasta que [finder] sea visible.
Future<void> scrollTo(WidgetTester tester, Finder finder) =>
    tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).last,
    );

/// Escribe en el campo de texto con la etiqueta [label].
Future<void> enterField(WidgetTester tester, String label, String text) async {
  final field = find.widgetWithText(TextFormField, label);
  await scrollTo(tester, field);
  await tester.enterText(field, text);
}
