/// Hora de negocio: Colombia (UTC-5, sin horario de verano).
///
/// El backend manda fechas sin zona (`2026-11-24 14:30:00`) ya expresadas en
/// hora de Colombia: se leen y se muestran tal cual, sin convertir con la
/// zona del teléfono (que puede ser otra).
abstract final class ColombiaTime {
  static const utcOffset = Duration(hours: -5);

  /// "Ahora" en Colombia como fecha sin zona, a partir de un reloj UTC o
  /// local. Se usa para el valor por defecto de formularios.
  static DateTime now(DateTime Function() clock) =>
      clock().toUtc().add(utcOffset);

  /// Lee `Y-m-d H:i:s` o ISO 8601 como hora de Colombia (sin convertir).
  static DateTime? parse(String? value) {
    if (value == null || value.isEmpty) return null;
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return null;
    // Un valor con zona (ISO con offset) se lleva a Colombia; sin zona se
    // toma como ya expresado en Colombia.
    return parsed.isUtc || value.contains(RegExp(r'[+-]\d\d:\d\d$|Z$'))
        ? parsed.toUtc().add(utcOffset)
        : parsed;
  }

  /// `Y-m-d` para enviar al backend (filtros y fechas de negocio).
  static String formatDate(DateTime value) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${value.year}-${two(value.month)}-${two(value.day)}';
  }

  /// `Y-m-d H:i:s` para enviar al backend.
  static String format(DateTime value) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${value.year}-${two(value.month)}-${two(value.day)} '
        '${two(value.hour)}:${two(value.minute)}:${two(value.second)}';
  }
}
