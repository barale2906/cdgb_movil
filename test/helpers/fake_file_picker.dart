import 'dart:convert';
import 'dart:typed_data';

import 'package:sga_bojanini/core/files/file_picker_gateway.dart';

/// Cámara, galería y archivos falsos: devuelven lo que la prueba configure.
class FakeFilePicker implements FilePickerGateway {
  PickedFile? camera;
  PickedFile? gallery;
  PickedFile? document;

  @override
  Future<PickedFile?> takePhoto() async => camera;

  @override
  Future<PickedFile?> pickPhoto() async => gallery;

  @override
  Future<PickedFile?> pickDocument() async => document;
}

/// PNG válido de 1×1 px (para pantallas que muestran la imagen).
final Uint8List _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDw'
  'ADhgGAWjR9awAAAABJRU5ErkJggg==',
);

/// Archivo falso: ceros del [size] dado o, con [image], un PNG real.
PickedFile fakeFile(String name, {int size = 1024, bool image = false}) =>
    PickedFile(name: name, bytes: image ? _png : Uint8List(size));
