import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sga_bojanini/core/utils/debouncer.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/utils/json_converters.dart';

void main() {
  setUpAll(() => initializeDateFormatting('es_CO'));

  group('AppFormat', () {
    test('decimal usa coma decimal y punto de miles (es_CO)', () {
      expect(AppFormat.decimal(1250.5), '1.250,5');
      expect(AppFormat.decimal(1000000), '1.000.000');
      expect(AppFormat.decimal(3.14159), '3,14');
      expect(AppFormat.decimal(3.14159, maxDecimals: 3), '3,142');
    });

    test('percent', () {
      expect(AppFormat.percent(87.54), '87,5 %');
      expect(AppFormat.percent(100), '100 %');
    });

    test('date da DD/MM/AAAA y tolera valores no ISO', () {
      expect(AppFormat.date('2027-05-01'), '01/05/2027');
      expect(AppFormat.date('2026-11-24T14:30:00-05:00'), '24/11/2026');
      expect(AppFormat.date('mañana'), 'mañana');
    });
  });

  test('DoubleConverter acepta número, texto decimal y nulo', () {
    const converter = DoubleConverter();
    expect(converter.fromJson(5), 5.0);
    expect(converter.fromJson(2.5), 2.5);
    expect(converter.fromJson('10.00'), 10.0);
    expect(converter.fromJson('abc'), isNull);
    expect(converter.fromJson(null), isNull);
  });

  testWidgets('Debouncer ejecuta solo la última acción', (tester) async {
    final debouncer = Debouncer(const Duration(milliseconds: 20));
    final calls = <int>[];
    debouncer
      ..run(() => calls.add(1))
      ..run(() => calls.add(2));

    await tester.pump(const Duration(milliseconds: 25));

    expect(calls, [2]);
    debouncer.dispose();
  });
}
