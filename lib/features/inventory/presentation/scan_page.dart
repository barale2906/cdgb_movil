import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/router/redirect.dart';
import 'package:sga_bojanini/core/widgets/barcode_scanner_view.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Pantalla de escaneo: devuelve el código leído a quien la abrió
/// (`context.push<String>('/scan')`).
class ScanPage extends ConsumerWidget {
  const ScanPage({super.key});

  static const String path = Routes.scan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.scanTitle)),
      body: ref.watch(scannerBuilderProvider)(
        context,
        (code) => Navigator.of(context).pop(code),
      ),
    );
  }
}
