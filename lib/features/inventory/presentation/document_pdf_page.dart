import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/widgets/pdf_preview_page.dart';
import 'package:sga_bojanini/features/inventory/application/document_actions.dart';

/// PDF del comprobante, con opción de compartirlo.
class DocumentPdfPage extends StatelessWidget {
  const DocumentPdfPage({required this.documentId, super.key});

  final int documentId;

  @override
  Widget build(BuildContext context) => PdfPreviewPage(
    provider: documentPdfProvider(documentId),
    fileName: 'comprobante-$documentId.pdf',
  );
}
