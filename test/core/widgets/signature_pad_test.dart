import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/widgets/signature_pad.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('SignaturePadController', () {
    test('sin trazos no hay firma', () async {
      final controller = SignaturePadController();
      expect(controller.isEmpty, isTrue);
      expect(await controller.toDataUrl(), isNull);
    });

    test('exporta un PNG data URL válido', () async {
      final controller = SignaturePadController()
        ..startStroke(const Offset(10, 10))
        ..extendStroke(const Offset(200, 100))
        ..startStroke(const Offset(50, 50));

      final dataUrl = await controller.toDataUrl();

      expect(dataUrl, startsWith('data:image/png;base64,'));
      final bytes = base64Decode(dataUrl!.split(',').last);
      expect(bytes.sublist(0, 4), [
        0x89,
        0x50,
        0x4E,
        0x47,
      ], reason: 'cabecera PNG');
      // El backend exige este patrón exacto.
      expect(
        RegExp(r'^data:image/png;base64,[A-Za-z0-9+/]+=*$').hasMatch(dataUrl),
        isTrue,
      );
      expect(
        dataUrl.length,
        lessThanOrEqualTo(SignaturePadController.maxBase64Length),
      );
    });

    test('clear borra los trazos y avisa a quien escucha', () {
      var notified = 0;
      final controller = SignaturePadController()
        ..addListener(() => notified++)
        ..startStroke(const Offset(1, 1))
        ..clear();
      expect(controller.isEmpty, isTrue);
      expect(notified, 2);
    });
  });

  testWidgets('dibujar con el dedo agrega trazos; "Borrar firma" los quita', (
    tester,
  ) async {
    final controller = SignaturePadController();
    await tester.pumpApp(Scaffold(body: SignaturePad(controller: controller)));
    expect(find.text('Firme aquí'), findsOneWidget);

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(SignaturePad)),
    );
    await gesture.moveBy(const Offset(40, 10));
    await gesture.moveBy(const Offset(40, -10));
    await gesture.up();
    await tester.pump();

    expect(controller.isEmpty, isFalse);
    expect(find.text('Firme aquí'), findsNothing);

    await tester.tap(find.text('Borrar firma'));
    await tester.pump();
    expect(controller.isEmpty, isTrue);
  });

  testWidgets('muestra el error de validación', (tester) async {
    await tester.pumpApp(
      Scaffold(
        body: SignaturePad(
          controller: SignaturePadController(),
          errorText: 'La firma es obligatoria.',
        ),
      ),
    );
    expect(find.text('La firma es obligatoria.'), findsOneWidget);
  });
}
