import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Comparte un archivo en memoria con otras apps. Se sustituye en pruebas.
typedef FileSharer = Future<void> Function(Uint8List bytes, String fileName);

/// Escribe el archivo en un directorio temporal, lo comparte y lo borra al
/// terminar: puede contener datos sensibles (comprobantes, certificados) y no
/// debe quedar copia en el teléfono.
final Provider<FileSharer> fileSharerProvider = Provider<FileSharer>(
  (ref) => (bytes, fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    try {
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    } finally {
      if (file.existsSync()) await file.delete();
    }
  },
);
