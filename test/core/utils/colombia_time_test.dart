import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';

void main() {
  setUpAll(() => initializeDateFormatting('es_CO'));

  group('ColombiaTime', () {
    test('now convierte UTC a UTC-5 sin depender de la zona del teléfono', () {
      final utc = DateTime.utc(2026, 11, 24, 3, 30);
      expect(ColombiaTime.now(() => utc), DateTime.utc(2026, 11, 23, 22, 30));
    });

    test('parse: sin zona se toma tal cual (ya es hora de Colombia)', () {
      expect(
        ColombiaTime.parse('2026-11-24 14:30:00'),
        DateTime(2026, 11, 24, 14, 30),
      );
    });

    test('parse: con zona se lleva a Colombia', () {
      expect(
        ColombiaTime.parse('2026-11-24T19:30:00Z')!.hour,
        14,
      );
      expect(
        ColombiaTime.parse('2026-11-24T14:30:00-05:00')!.hour,
        14,
      );
    });

    test('parse: vacío o inválido es null', () {
      expect(ColombiaTime.parse(null), isNull);
      expect(ColombiaTime.parse(''), isNull);
      expect(ColombiaTime.parse('ayer'), isNull);
    });

    test('format da Y-m-d H:i:s con ceros', () {
      expect(
        ColombiaTime.format(DateTime(2026, 3, 7, 4, 5, 6)),
        '2026-03-07 04:05:06',
      );
    });
  });

  group('AppFormat (hora y moneda)', () {
    test('time en 12 h con a. m. / p. m.', () {
      expect(AppFormat.time(DateTime(2026, 1, 1, 14, 30)), '02:30 p. m.');
      expect(AppFormat.time(DateTime(2026, 1, 1, 9, 5)), '09:05 a. m.');
    });

    test('dateTime desde el texto del backend', () {
      expect(
        AppFormat.dateTime('2026-11-24 14:30:00'),
        '24/11/2026 02:30 p. m.',
      );
      expect(AppFormat.dateTime(null), '');
    });

    test('cop sin decimales y con separador de miles', () {
      expect(AppFormat.cop(1250000.5), r'$1.250.001');
      expect(AppFormat.cop(0), r'$0');
    });
  });
}
