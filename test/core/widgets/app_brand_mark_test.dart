import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/widgets/app_brand_mark.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('AppBrandMark', () {
    for (final size in AppBrandMarkSize.values) {
      testWidgets('dibuja el círculo de ${size.diameter} px', (tester) async {
        await tester.pumpApp(Center(child: AppBrandMark(size: size)));

        final box = tester.getSize(find.byType(Container).first);
        expect(box, Size.square(size.diameter));
        expect(find.text('SGA'), findsOneWidget);
      });
    }

    testWidgets('muestra el nombre solo si se pide', (tester) async {
      await tester.pumpApp(const Center(child: AppBrandMark()));
      expect(find.text(AppBrandMark.semanticLabel), findsNothing);

      await tester.pumpApp(const Center(child: AppBrandMark(showName: true)));
      expect(find.text(AppBrandMark.semanticLabel), findsOneWidget);
    });

    testWidgets('expone una etiqueta accesible', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpApp(const Center(child: AppBrandMark()));

      expect(
        find.bySemanticsLabel(AppBrandMark.semanticLabel),
        findsOneWidget,
      );
      handle.dispose();
    });
  });
}
