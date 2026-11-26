import 'package:dio/dio.dart' show FormData;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/network/no_auto_retry.dart';
import 'package:sga_bojanini/features/assets/data/asset_document.dart';
import 'package:sga_bojanini/features/assets/data/documents_repository.dart';

import '../../helpers/app_harness.dart';
import '../../helpers/fake_file_picker.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/in_memory_token_store.dart';
import '../../helpers/test_container.dart';

List<AssetDocument> _docs() =>
    (fixture('assets/documents_response.json')['data'] as List<dynamic>)
        .map((e) => AssetDocument.fromJson(e as Json))
        .toList();

void main() {
  group('AssetDocument (contrato)', () {
    test('parsea tipo, tamaño, fechas y quién lo subió', () {
      final doc = _docs().first;
      expect(doc.title, 'Manual del usuario');
      expect(doc.documentTypeLabel, 'Manual');
      expect(doc.size, 2411724);
      expect(doc.uploadedBy?.name, 'Usuario Prueba');
      expect(doc.isImage, isFalse);
      expect(_docs().last.isImage, isTrue);
      expect(_docs().last.maintenanceId, 31);
    });

    test('vence: sin fecha nunca; con fecha, desde el día siguiente', () {
      final today = DateTime(2026, 11, 25);
      expect(_docs().first.isExpiredAt(today), isFalse);
      final doc = _docs().last;
      expect(doc.isExpiredAt(DateTime(2025, 12, 31, 23)), isFalse);
      expect(doc.isExpiredAt(DateTime(2026)), isTrue);
    });
  });

  group('DocumentsRepository', () {
    late FakeHttpAdapter adapter;
    late DocumentsRepository repository;

    setUp(() async {
      adapter = FakeHttpAdapter();
      final container = ProviderContainer(
        retry: noAutoRetry,
        overrides: await baseOverrides(
          adapter: adapter,
          store: InMemoryTokenStore(),
          clock: TestClock(DateTime(2026, 11, 25)),
        ),
      );
      addTearDown(container.dispose);
      repository = container.read(documentsRepositoryProvider);
    });

    test('lista, descarga binaria y eliminación', () async {
      adapter
        ..on(
          'GET',
          '/assets/7/documents',
          body: fixture('assets/documents_response.json'),
        )
        ..onBytes('GET', '/assets/documents/61/download', [1, 2, 3])
        ..on('DELETE', '/assets/documents/61', body: envelope(null));

      expect(await repository.list(7), hasLength(2));
      expect(await repository.download(61), [1, 2, 3]);
      await repository.delete(61);
      expect(adapter.callsTo('DELETE', '/assets/documents/61'), hasLength(1));
    });

    test('subir envía multipart con archivo, tipo, título y fechas', () async {
      adapter.on(
        'POST',
        '/assets/7/documents',
        status: 201,
        body: fixture('assets/document_saved_response.json'),
      );
      await repository.upload(
        7,
        file: fakeFile('foto.jpg', size: 10),
        documentType: 'photo',
        title: '  Foto del equipo ',
        expiresAt: '2027-01-01',
      );

      final form =
          adapter.callsTo('POST', '/assets/7/documents').single.data
              as FormData;
      final fields = {for (final f in form.fields) f.key: f.value};
      expect(fields, {
        'document_type': 'photo',
        'title': 'Foto del equipo',
        'expires_at': '2027-01-01',
      });
      expect(form.files.single.key, 'file');
      expect(form.files.single.value.filename, 'foto.jpg');
      expect(form.files.single.value.length, 10);
    });
  });

  group('pestaña Documentos', () {
    const view = ['activos.ver'];
    late AppHarness harness;

    setUp(() => harness = AppHarness());

    Future<void> openDocuments(
      WidgetTester tester, {
      List<String> permissions = view,
    }) async {
      tester.view
        ..physicalSize = const Size(800, 3000)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      harness
        ..stubSignedInUser(
          permissions: permissions,
          menu: 'auth/menu_assets_response.json',
        )
        ..stubAssetsReads()
        ..storeSession();
      await harness.pump(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Activos'),
        ),
      );
      await AppHarness.settle(tester);
      await tester.tap(find.text('Monitor de signos vitales').first);
      await AppHarness.settle(tester);
      await tester.tap(find.text('Documentos'));
      await AppHarness.settle(tester);
    }

    testWidgets('lista documentos con tipo, tamaño y vencimiento', (
      tester,
    ) async {
      await openDocuments(tester);

      expect(find.text('Manual del usuario'), findsOneWidget);
      expect(find.textContaining('Manual · 2,3 MB'), findsOneWidget);
      expect(find.text('Certificado 2025'), findsOneWidget);
      expect(find.text('Vence el 31/12/2025'), findsOneWidget);
      expect(find.text('VENCIDO'), findsOneWidget);
    });

    testWidgets('sin permisos no hay agregar ni eliminar', (tester) async {
      await openDocuments(tester);
      expect(find.text('Agregar documento'), findsNothing);
      expect(find.byTooltip('Eliminar documento'), findsNothing);
    });

    testWidgets('tocar un documento lo descarga y lo comparte', (tester) async {
      await openDocuments(tester);
      harness.adapter.onBytes('GET', '/assets/documents/61/download', [
        1,
        2,
        3,
      ]);

      await tester.tap(find.text('Manual del usuario'));
      await AppHarness.settle(tester);

      expect(harness.sharedFiles, [('manual.pdf', 3)]);
    });

    testWidgets('eliminar pide confirmación', (tester) async {
      await openDocuments(
        tester,
        permissions: [...view, 'activos_documentos.eliminar'],
      );
      harness.adapter.on(
        'DELETE',
        '/assets/documents/61',
        body: envelope(null),
      );

      await tester.tap(find.byTooltip('Eliminar documento').first);
      await AppHarness.settle(tester);
      await tester.tap(find.text('Eliminar documento').last);
      await AppHarness.settle(tester);

      expect(
        harness.adapter.callsTo('DELETE', '/assets/documents/61'),
        hasLength(1),
      );
      expect(find.text('Documento eliminado.'), findsOneWidget);
    });

    testWidgets('sin documentos: mensaje', (tester) async {
      harness.adapter.on(
        'GET',
        '/assets/7/documents',
        body: envelope(<dynamic>[]),
      );
      await openDocuments(tester);
      expect(find.text('Este activo no tiene documentos.'), findsOneWidget);
    });

    group('agregar', () {
      const upload = [...view, 'activos_documentos.cargar'];

      Future<void> choose(WidgetTester tester, String source) async {
        await tester.tap(find.text('Agregar documento'));
        await AppHarness.settle(tester);
        await tester.tap(find.text(source));
        await AppHarness.settle(tester);
      }

      testWidgets('foto de la cámara: pide tipo y título y la sube', (
        tester,
      ) async {
        harness.picker.camera = fakeFile('IMG_001.jpg', image: true);
        await openDocuments(tester, permissions: upload);
        harness.adapter.on(
          'POST',
          '/assets/7/documents',
          status: 201,
          body: fixture('assets/document_saved_response.json'),
        );
        await choose(tester, 'Tomar una foto');

        expect(
          find.widgetWithText(TextFormField, 'Título'),
          findsOneWidget,
        );
        await tester.tap(find.widgetWithText(FilledButton, 'Subir documento'));
        await AppHarness.settle(tester);
        expect(find.text('Este campo es obligatorio.'), findsOneWidget);
        expect(harness.adapter.callsTo('POST', '/assets/7/documents'), isEmpty);

        await tester.tap(
          find.byWidgetPredicate(
            (w) =>
                w is DropdownButtonFormField &&
                w.decoration.labelText == 'Tipo de documento',
          ),
        );
        await AppHarness.settle(tester, frames: 4);
        await tester.tap(find.text('Foto').last);
        await AppHarness.settle(tester, frames: 4);
        await tester.tap(find.widgetWithText(FilledButton, 'Subir documento'));
        await AppHarness.settle(tester);

        final form =
            harness.adapter.callsTo('POST', '/assets/7/documents').single.data
                as FormData;
        final fields = {for (final f in form.fields) f.key: f.value};
        expect(fields['document_type'], 'photo');
        expect(
          fields['title'],
          'IMG_001',
          reason: 'título sugerido sin extensión',
        );
        expect(form.files.single.value.filename, 'IMG_001.jpg');
        expect(find.text('Documento agregado.'), findsOneWidget);
      });

      testWidgets('cancelar la cámara no cambia de pantalla', (tester) async {
        await openDocuments(tester, permissions: upload);
        await choose(tester, 'Tomar una foto');

        expect(find.text('Subir documento'), findsNothing);
      });

      testWidgets('un archivo de más de 10 MB se rechaza antes de subir', (
        tester,
      ) async {
        harness.picker.document = fakeFile(
          'grande.pdf',
          size: 10 * 1024 * 1024 + 1,
        );
        await openDocuments(tester, permissions: upload);
        await choose(tester, 'Elegir un archivo (PDF o imagen)');

        expect(
          find.text('El archivo supera los 10 MB. Elija uno más liviano.'),
          findsOneWidget,
        );
        expect(find.text('Subir documento'), findsNothing);
      });

      testWidgets('un PDF de la galería de archivos se sube', (tester) async {
        harness.picker.document = fakeFile('manual.pdf');
        await openDocuments(tester, permissions: upload);
        harness.adapter.on(
          'POST',
          '/assets/7/documents',
          status: 422,
          body: errorBody(
            'El archivo no es válido.',
            extra: {
              'errors': {
                'file': ['El archivo debe ser PDF, JPG o PNG.'],
              },
            },
          ),
        );
        await choose(tester, 'Elegir un archivo (PDF o imagen)');
        await tester.tap(
          find.byWidgetPredicate(
            (w) =>
                w is DropdownButtonFormField &&
                w.decoration.labelText == 'Tipo de documento',
          ),
        );
        await AppHarness.settle(tester, frames: 4);
        await tester.tap(find.text('Manual').last);
        await AppHarness.settle(tester, frames: 4);
        await tester.tap(find.widgetWithText(FilledButton, 'Subir documento'));
        await AppHarness.settle(tester);

        expect(find.text('El archivo no es válido.'), findsOneWidget);
        expect(
          harness.adapter.callsTo('POST', '/assets/7/documents'),
          hasLength(1),
        );
      });
    });
  });
}
