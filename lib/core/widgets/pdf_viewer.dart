import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';

typedef PdfViewBuilder = Widget Function(BuildContext context, Uint8List bytes);

/// Visor de PDF; se sustituye en pruebas (el render nativo no existe allí).
final Provider<PdfViewBuilder> pdfViewBuilderProvider =
    Provider<PdfViewBuilder>(
      (ref) =>
          (context, bytes) => PdfBytesView(bytes: bytes),
    );

/// Muestra un PDF en memoria con zoom por pellizco.
class PdfBytesView extends StatefulWidget {
  const PdfBytesView({required this.bytes, super.key});

  final Uint8List bytes;

  @override
  State<PdfBytesView> createState() => _PdfBytesViewState();
}

class _PdfBytesViewState extends State<PdfBytesView> {
  late final PdfControllerPinch _controller = PdfControllerPinch(
    document: PdfDocument.openData(widget.bytes),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PdfViewPinch(controller: _controller);
}
