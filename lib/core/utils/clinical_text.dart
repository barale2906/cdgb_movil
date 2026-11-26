/// Texto clínico entre la app (texto simple) y el web (HTML de Quill con
/// párrafos, negritas y listas). La app no tiene editor de texto enriquecido:
/// al mostrar convierte el HTML a texto y al guardar envía párrafos.
abstract final class ClinicalText {
  static final _lineBreaks = RegExp(
    r'<br\s*/?>|</p>|</div>|</li>|</h[1-6]>|</ul>|</ol>',
    caseSensitive: false,
  );
  static final _listItem = RegExp('<li[^>]*>', caseSensitive: false);
  static final _tags = RegExp('<[^>]+>');
  static final _manyBlankLines = RegExp(r'\n{3,}');
  static final _trailingSpaces = RegExp(r'[ \t]+\n');

  /// Texto simple a partir de HTML; si ya es texto, lo deja igual.
  static String fromHtml(String? html) {
    if (html == null || html.isEmpty) return '';
    final text = html
        .replaceAll(_listItem, '- ')
        .replaceAll(_lineBreaks, '\n')
        .replaceAll(_tags, '');
    return _decodeEntities(text)
        .replaceAll(_trailingSpaces, '\n')
        .replaceAll(_manyBlankLines, '\n\n')
        .trim();
  }

  /// HTML de párrafos a partir de texto simple (una línea = un párrafo; las
  /// líneas vacías se omiten). Vacío si no hay texto.
  static String toHtml(String? text) {
    final lines = (text ?? '')
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty);
    return lines.map((line) => '<p>${_escape(line)}</p>').join();
  }

  /// Hay texto visible (ignora espacios y etiquetas).
  static bool hasText(String? value) => fromHtml(value).isNotEmpty;

  static String _escape(String value) => value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');

  static String _decodeEntities(String value) => value
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&amp;', '&');
}
