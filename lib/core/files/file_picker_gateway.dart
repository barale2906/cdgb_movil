import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// Archivo elegido por la persona, en memoria (máx. 10 MB en los adjuntos).
@immutable
class PickedFile {
  const PickedFile({required this.name, required this.bytes});

  final String name;
  final Uint8List bytes;
}

/// Origen de archivos y fotos del teléfono. Se sustituye en pruebas.
abstract class FilePickerGateway {
  /// Foto con la cámara (redimensionada); `null` si se cancela.
  Future<PickedFile?> takePhoto();

  /// Foto de la galería (redimensionada); `null` si se cancela.
  Future<PickedFile?> pickPhoto();

  /// PDF o imagen del almacenamiento; `null` si se cancela.
  Future<PickedFile?> pickDocument();
}

/// `image_picker` (cámara y galería) y `file_picker` (PDF/imagen).
class DevicePickerGateway implements FilePickerGateway {
  const DevicePickerGateway();

  /// Lado mayor de las fotos: suficiente para leer un documento y mucho más
  /// liviano que la imagen original de la cámara.
  static const maxPhotoSide = 2048.0;
  static const photoQuality = 85;

  /// Extensiones que acepta el servidor.
  static const documentExtensions = ['pdf', 'jpg', 'jpeg', 'png'];

  @override
  Future<PickedFile?> takePhoto() => _photo(ImageSource.camera);

  @override
  Future<PickedFile?> pickPhoto() => _photo(ImageSource.gallery);

  Future<PickedFile?> _photo(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
      maxWidth: maxPhotoSide,
      maxHeight: maxPhotoSide,
      imageQuality: photoQuality,
    );
    if (image == null) return null;
    return PickedFile(name: image.name, bytes: await image.readAsBytes());
  }

  @override
  Future<PickedFile?> pickDocument() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: documentExtensions,
    );
    final file = files.firstOrNull;
    if (file == null) return null;
    return PickedFile(name: file.name, bytes: await file.readAsBytes());
  }
}

final Provider<FilePickerGateway> filePickerProvider =
    Provider<FilePickerGateway>((ref) => const DevicePickerGateway());
