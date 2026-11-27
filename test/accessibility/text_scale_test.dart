import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_harness.dart';
import '../helpers/fixtures.dart';
import '../helpers/text_scale.dart';

/// Texto escalable hasta 200 % (CLAUDE.md §6): las pantallas principales no
/// deben desbordarse en un teléfono de 360 dp de ancho con el texto al doble.
/// Un desborde (`RenderFlex overflowed`) hace fallar la prueba. La altura es
/// grande a propósito: lo que importa aquí es el ancho, y así todo el
/// contenido de las listas se construye.
void main() {
  late AppHarness harness;

  setUp(() => harness = AppHarness());

  void stubAll(List<String> permissions, String menu) {
    harness
      ..stubSignedInUser(permissions: permissions, menu: menu)
      ..storeSession();
    harness.adapter
      ..on(
        'GET',
        '/patient-procedure-records',
        body: fixture('clinical/records_response.json'),
      )
      ..on(
        'GET',
        '/patient-procedure-records/22',
        body: fixture('clinical/record_response.json'),
      )
      ..on(
        'GET',
        '/patient-procedure-records/22/evolutions',
        body: fixture('clinical/evolutions_response.json'),
      )
      ..on(
        'GET',
        '/patient-procedure-records/22/medications',
        body: fixture('clinical/medications_response.json'),
      )
      ..on(
        'GET',
        '/medsys/patients',
        body: fixture('clinical/patients_response.json'),
      )
      ..on(
        'GET',
        '/medical-services/search',
        body: fixture('clinical/procedures_response.json'),
      )
      ..on(
        'GET',
        '/service-orders/OS-20261124-000001',
        body: fixture('service_orders/order_pending_response.json'),
      )
      ..on(
        'GET',
        '/consumptions',
        body: fixture('consumptions/consumptions_response.json'),
      )
      ..on(
        'GET',
        '/consumptions/31',
        body: fixture('consumptions/consumption_response.json'),
      )
      ..on(
        'GET',
        '/cost-centers',
        body: fixture('cost_centers/cost_centers_response.json'),
      )
      ..on(
        'GET',
        '/generic-products',
        body: fixture('catalog/products_list_response.json'),
      )
      ..on(
        'GET',
        '/audit-logs',
        body: fixture('audit/audit_logs_response.json'),
      )
      ..on(
        'GET',
        '/audit-logs/101',
        body: fixture('audit/audit_log_response.json'),
      )
      ..on(
        'GET',
        '/audit-logs/summary',
        body: fixture('audit/summary_response.json'),
      );
  }

  Future<void> openFromMore(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Más'),
      ),
    );
    await AppHarness.settle(tester);
    await tester.tap(find.text(label).last);
    await AppHarness.settle(tester);
  }

  const seller = [
    'registros_procedimientos.ver',
    'registros_procedimientos.crear',
    'servicios_medicos.ver',
    'evoluciones_clinicas.ver',
    'evoluciones_clinicas.crear',
    'evoluciones_clinicas.editar',
    'medicamentos_procedimiento.ver',
    'integraciones.ver',
  ];

  testWidgets('inicio con accesos rápidos', (tester) async {
    phoneWithDoubleText(tester);
    stubAll([
      ...seller,
      'ordenes_servicio.crear',
    ], 'auth/menu_clinical_response.json');
    await harness.pump(tester);

    expect(find.text('Registrar venta'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('registros clínicos: lista, detalle y evoluciones', (
    tester,
  ) async {
    phoneWithDoubleText(tester);
    stubAll(seller, 'auth/menu_clinical_response.json');
    await harness.pump(tester);
    await openFromMore(tester, 'Registros clínicos');
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Consulta dermatología'));
    await AppHarness.settle(tester);
    expect(find.text('Evoluciones clínicas'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Agregar evolución'));
    await AppHarness.settle(tester);
    expect(find.text('Guardar evolución'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('formulario de venta con un servicio', (tester) async {
    phoneWithDoubleText(tester);
    stubAll(seller, 'auth/menu_clinical_response.json');
    await harness.pump(tester);

    await tester.tap(find.text('Registrar venta'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Buscar paciente'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextField).first, '1000000001');
    await AppHarness.settle(tester);
    await tester.tap(find.text('ANA MARIA PEREZ GOMEZ'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Agregar servicio'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextField).first, 'cu');
    await AppHarness.settle(tester);
    await tester.tap(find.text('Curaciones simples'));
    await AppHarness.settle(tester);

    expect(find.text(r'Total de la venta: $50.000'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('nueva orden de servicio con un procedimiento y su detalle', (
    tester,
  ) async {
    phoneWithDoubleText(tester);
    stubAll(
      [
        ...seller,
        'ordenes_servicio.ver',
        'ordenes_servicio.crear',
        'ordenes_servicio.aprobar',
      ],
      'auth/menu_service_orders_response.json',
    );
    await harness.pump(tester);

    await tester.tap(find.text('Nueva orden'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Buscar paciente'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextField).first, '1000000001');
    await AppHarness.settle(tester);
    await tester.tap(find.text('ANA MARIA PEREZ GOMEZ'));
    await AppHarness.settle(tester);
    await tester.tap(find.text('Agregar servicio'));
    await AppHarness.settle(tester);
    await tester.enterText(find.byType(TextField).first, 'cu');
    await AppHarness.settle(tester);
    await tester.tap(find.text('Curaciones simples'));
    await AppHarness.settle(tester);
    await tester.tap(find.byType(Switch));
    await AppHarness.settle(tester);
    expect(find.text('Porcentaje (%)'), findsOneWidget);

    expect(find.text('Crear orden'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('consumos: lista, detalle y formulario', (tester) async {
    phoneWithDoubleText(tester);
    stubAll(
      [
        'consumos.ver',
        'consumos.crear',
        'almacenes.ver',
        'centros_costo.ver',
        'generic-products.ver',
        'integraciones.ver',
      ],
      'auth/menu_consumptions_response.json',
    );
    await harness.pump(tester);
    await openFromMore(tester, 'Consumos');
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Gasa estéril 10x10'));
    await AppHarness.settle(tester);
    expect(find.text('Reintentar sincronización'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('auditoría: lista y detalle', (tester) async {
    phoneWithDoubleText(tester);
    stubAll(['auditoria.ver'], 'auth/menu_audit_response.json');
    await harness.pump(tester);
    await openFromMore(tester, 'Auditoría');
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Generic Product'));
    await AppHarness.settle(tester);
    expect(find.text('Registro de auditoría'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
