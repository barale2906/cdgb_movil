import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';

/// Teléfono de 360 dp de ancho con el texto del sistema al 200 % (CLAUDE.md
/// §6). La altura es grande a propósito: lo que importa es el ancho, y así
/// el contenido completo de las listas se construye.
void phoneWithDoubleText(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(360, 4000)
    ..devicePixelRatio = 1;
  tester.platformDispatcher.textScaleFactorTestValue = 2;
  addTearDown(() {
    tester.view.reset();
    tester.platformDispatcher.clearTextScaleFactorTestValue();
  });
}
