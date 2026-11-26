import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/utils/clinical_text.dart';

void main() {
  group('fromHtml', () {
    test('cada párrafo es una línea', () {
      expect(
        ClinicalText.fromHtml('<p>Paciente estable.</p><p>Sin dolor.</p>'),
        'Paciente estable.\nSin dolor.',
      );
    });

    test('quita negritas, cursivas y subrayado', () {
      expect(
        ClinicalText.fromHtml(
          '<p><strong>Dx:</strong> <em>x</em> <u>y</u></p>',
        ),
        'Dx: x y',
      );
    });

    test('las listas quedan con guion', () {
      expect(
        ClinicalText.fromHtml('<ol><li>Uno</li><li>Dos</li></ol>'),
        '- Uno\n- Dos',
      );
    });

    test('<br> y entidades', () {
      expect(
        ClinicalText.fromHtml('<p>A&nbsp;&amp;&nbsp;B<br>&lt;5 mg&gt;</p>'),
        'A & B\n<5 mg>',
      );
    });

    test('un párrafo vacío de Quill no deja líneas de más', () {
      expect(
        ClinicalText.fromHtml('<p>Uno</p><p><br></p><p><br></p><p>Dos</p>'),
        'Uno\n\nDos',
      );
    });

    test('texto simple, vacío o nulo', () {
      expect(ClinicalText.fromHtml('Ya es texto'), 'Ya es texto');
      expect(ClinicalText.fromHtml(''), '');
      expect(ClinicalText.fromHtml(null), '');
    });
  });

  group('toHtml', () {
    test('una línea por párrafo, sin líneas vacías ni espacios sobrantes', () {
      expect(
        ClinicalText.toHtml('  Uno \n\nDos  '),
        '<p>Uno</p><p>Dos</p>',
      );
    });

    test('escapa lo que parece HTML', () {
      expect(
        ClinicalText.toHtml('a < b & c > d'),
        '<p>a &lt; b &amp; c &gt; d</p>',
      );
    });

    test('sin texto, vacío', () {
      expect(ClinicalText.toHtml('   \n  '), '');
      expect(ClinicalText.toHtml(null), '');
    });

    test('ida y vuelta conserva el texto', () {
      const text = 'Línea 1\nLínea 2 & más <3';
      expect(ClinicalText.fromHtml(ClinicalText.toHtml(text)), text);
    });
  });

  test('hasText ignora etiquetas y espacios', () {
    expect(ClinicalText.hasText('<p><br></p>'), isFalse);
    expect(ClinicalText.hasText('  '), isFalse);
    expect(ClinicalText.hasText('<p>x</p>'), isTrue);
  });
}
