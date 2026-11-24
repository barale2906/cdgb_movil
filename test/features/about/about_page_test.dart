import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/features/about/presentation/about_page.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('AboutPage', () {
    testWidgets(
      'muestra ambiente dev, servidor y actualizaciones desactivadas',
      (
        tester,
      ) async {
        await tester.pumpApp(const AboutPage());

        expect(find.text('Acerca de'), findsOneWidget);
        expect(find.text('DESARROLLO'), findsOneWidget);
        expect(find.text('http://localhost:8000/api/v1'), findsOneWidget);
        expect(
          find.text('Desactivadas (ruta del APK pendiente)'),
          findsOneWidget,
        );
        expect(
          find.text('Bloqueo por inactividad: 15 min · Cierre de sesión: 12 h'),
          findsOneWidget,
        );
      },
    );

    testWidgets('muestra versión y build instalados', (tester) async {
      await tester.pumpApp(const AboutPage());
      await tester.pump();

      expect(find.text('0.1.0 (1)'), findsOneWidget);
    });

    testWidgets('en dev ofrece cambiar de servidor; en prod no', (
      tester,
    ) async {
      await tester.pumpApp(const AboutPage());
      expect(
        find.text('Cambiar servidor', skipOffstage: false),
        findsOneWidget,
      );

      await tester.pumpApp(
        const AboutPage(),
        environment: AppEnvironment.fromValues(
          env: 'prod',
          apiBaseUrl: 'https://api.example.com/api/v1',
        ),
      );
      expect(find.text('Cambiar servidor', skipOffstage: false), findsNothing);
    });

    testWidgets('muestra producción y la URL de actualización', (tester) async {
      await tester.pumpApp(
        const AboutPage(),
        environment: AppEnvironment.fromValues(
          env: 'prod',
          apiBaseUrl: 'https://api.example.com/api/v1',
          updateUrl: 'https://files.example.com/version.json',
        ),
      );

      expect(find.text('PRODUCCIÓN'), findsOneWidget);
      expect(find.text('https://api.example.com/api/v1'), findsOneWidget);
      expect(
        find.text('https://files.example.com/version.json'),
        findsOneWidget,
      );
    });
  });
}
