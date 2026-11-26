import 'package:intl/intl.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';

/// Formatos de la app (es_CO): decimales con coma, miles con punto.
abstract final class AppFormat {
  static const locale = 'es_CO';

  /// Número con hasta [maxDecimals] decimales: `1.250,5`.
  static String decimal(num value, {int maxDecimals = 2}) {
    final format = NumberFormat.decimalPattern(locale)
      ..maximumFractionDigits = maxDecimals;
    return format.format(value);
  }

  /// Número escrito por el usuario (acepta coma o punto decimal); `null` si
  /// está vacío o no es un número.
  static double? parseDecimal(String? text) =>
      double.tryParse((text ?? '').trim().replaceAll(',', '.'));

  /// Porcentaje con un decimal como máximo: `87,5 %`.
  static String percent(num value) => '${decimal(value, maxDecimals: 1)} %';

  /// Fecha `DD/MM/AAAA` desde un ISO 8601 (`2027-05-01` o con hora); si no
  /// se puede leer, devuelve el texto original.
  static String date(String iso) {
    final parsed = DateTime.tryParse(iso);
    return parsed == null
        ? iso
        : DateFormat('dd/MM/yyyy', locale).format(parsed);
  }

  /// Hora 12 h con a. m./p. m.: `02:30 p. m.`. Se arma a mano para no
  /// depender de los espacios especiales que usa ICU en el sufijo.
  static String time(DateTime value) {
    String two(int n) => n.toString().padLeft(2, '0');
    final hour = value.hour % 12 == 0 ? 12 : value.hour % 12;
    final suffix = value.hour < 12 ? 'a. m.' : 'p. m.';
    return '${two(hour)}:${two(value.minute)} $suffix';
  }

  /// `24/11/2026 02:30 p. m.` desde un texto del backend (hora Colombia).
  static String dateTime(String? raw) {
    final value = ColombiaTime.parse(raw);
    if (value == null) return raw ?? '';
    return '${DateFormat('dd/MM/yyyy', locale).format(value)} ${time(value)}';
  }

  /// Moneda colombiana sin decimales y con el símbolo delante: `$1.250.000`.
  static String cop(num value) => NumberFormat.currency(
    locale: locale,
    symbol: r'$',
    decimalDigits: 0,
    customPattern: '¤#,##0',
  ).format(value);
}
