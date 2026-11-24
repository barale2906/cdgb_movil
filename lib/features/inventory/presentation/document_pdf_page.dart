import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/pdf_viewer.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/inventory/application/document_actions.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// PDF del comprobante, con opción de compartirlo.
class DocumentPdfPage extends ConsumerWidget {
  const DocumentPdfPage({required this.documentId, super.key});

  final int documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final pdf = ref.watch(documentPdfProvider(documentId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pdfTitle),
        actions: [
          IconButton(
            tooltip: l10n.pdfShare,
            icon: const Icon(Icons.share_outlined),
            onPressed: pdf.value == null
                ? null
                : () => unawaited(_share(context, ref, pdf.value!)),
          ),
        ],
      ),
      body: SafeArea(
        child: pdf.when(
          loading: () => const SkeletonList(itemCount: 3),
          error: (error, _) => ErrorState(
            error: error,
            onRetry: () => ref.invalidate(documentPdfProvider(documentId)),
          ),
          data: (bytes) => ref.watch(pdfViewBuilderProvider)(context, bytes),
        ),
      ),
    );
  }

  Future<void> _share(
    BuildContext context,
    WidgetRef ref,
    List<int> bytes,
  ) async {
    final l10n = AppLocalizations.of(context);
    try {
      await ref.read(pdfSharerProvider)(
        bytes is Uint8List ? bytes : Uint8List.fromList(bytes),
        'comprobante-$documentId.pdf',
      );
    } on Object {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          l10n.pdfError,
          kind: AppSnackbarKind.error,
          closeLabel: l10n.actionClose,
        );
      }
    }
  }
}
