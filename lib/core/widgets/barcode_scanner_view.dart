import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

typedef ScannerBuilder =
    Widget Function(
      BuildContext context,
      ValueChanged<String> onCode,
    );

/// Cámara que lee códigos de barras/QR. Se sustituye en pruebas (no hay
/// cámara) por un widget que emite códigos a voluntad.
final scannerBuilderProvider = Provider<ScannerBuilder>(
  (ref) =>
      (context, onCode) => BarcodeScannerView(onCode: onCode),
);

/// Vista de cámara con linterna y manejo del permiso denegado.
class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({required this.onCode, super.key});

  final ValueChanged<String> onCode;

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _handled = false;

  @override
  void dispose() {
    unawaited(_controller.dispose());
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final value = capture.barcodes
        .map((barcode) => barcode.rawValue)
        .whereType<String>()
        .where((code) => code.isNotEmpty)
        .firstOrNull;
    if (value == null) return;
    _handled = true;
    widget.onCode(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _controller,
          onDetect: _onDetect,
          errorBuilder: (context, error) => EmptyState(
            icon: Icons.no_photography_outlined,
            message: error.errorCode == MobileScannerErrorCode.permissionDenied
                ? l10n.scanPermissionDenied
                : l10n.errorGeneric,
          ),
        ),
        Positioned(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: AppSpacing.xl,
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.circular(AppRadius.control),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    l10n.scanHint,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.onDark),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              IconButton.filled(
                tooltip: l10n.scanTorch,
                constraints: const BoxConstraints(
                  minWidth: AppSizes.minTouchTarget,
                  minHeight: AppSizes.minTouchTarget,
                ),
                onPressed: _controller.toggleTorch,
                icon: const Icon(Icons.flashlight_on_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
