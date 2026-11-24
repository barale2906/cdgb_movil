import 'package:intl/intl.dart';

/// Formatos de la app (es_CO): decimales con coma, miles con punto.
abstract final class AppFormat {
  static const locale = 'es_CO';

  /// Número con hasta [maxDecimals] decimales: `1.250,5`.
  static String decimal(num value, {int maxDecimals = 2}) {
    final format = NumberFormat.decimalPattern(locale)
      ..maximumFractionDigits = maxDecimals;
    return format.format(value);
  }

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
}
