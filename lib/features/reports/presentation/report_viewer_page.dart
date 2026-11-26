import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/utils/file_sharer.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/pdf_viewer.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Muestra un reporte PDF generado y permite compartirlo.
class ReportViewerPage extends ConsumerWidget {
  const ReportViewerPage({required this.file, super.key});

  final ReportFile file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(file.fileName),
        actions: [
          IconButton(
            tooltip: l10n.pdfShare,
            icon: const Icon(Icons.share_outlined),
            onPressed: () => unawaited(shareReportFile(context, ref, file)),
          ),
        ],
      ),
      body: SafeArea(
        child: ref.watch(pdfViewBuilderProvider)(context, file.bytes),
      ),
    );
  }
}

/// Comparte un reporte; ante un fallo avisa sin cerrar la pantalla.
Future<void> shareReportFile(
  BuildContext context,
  WidgetRef ref,
  ReportFile file,
) async {
  final l10n = AppLocalizations.of(context);
  try {
    await ref.read(fileSharerProvider)(file.bytes, file.fileName);
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
