import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/utils/file_sharer.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/pdf_viewer.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Muestra un PDF que entrega [provider] (descarga con la sesión: un enlace
/// directo respondería 401) y permite compartirlo sin dejar copia en el
/// teléfono. Lo usan comprobantes, hoja de vida, actas y reportes.
class PdfPreviewPage extends ConsumerWidget {
  const PdfPreviewPage({
    required this.provider,
    required this.fileName,
    super.key,
  });

  final FutureProvider<Uint8List> provider;

  /// Nombre con el que se comparte (con `.pdf`).
  final String fileName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final pdf = ref.watch(provider);
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
            onRetry: () => ref.invalidate(provider),
          ),
          data: (bytes) => ref.watch(pdfViewBuilderProvider)(context, bytes),
        ),
      ),
    );
  }

  Future<void> _share(
    BuildContext context,
    WidgetRef ref,
    Uint8List bytes,
  ) async {
    final l10n = AppLocalizations.of(context);
    try {
      await ref.read(fileSharerProvider)(bytes, fileName);
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
