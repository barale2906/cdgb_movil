import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Controla un [SignaturePad]: trazos capturados y exportación a PNG.
class SignaturePadController extends ChangeNotifier {
  /// Tamaño lógico del lienzo exportado.
  static const exportSize = Size(600, 240);

  /// Tope del PNG en base64 (el backend admite ~700 KB; se deja margen).
  static const int maxBase64Length = 512 * 1024;

  static const _strokeWidth = 4.0;
  static const _minScale = 0.25;
  static const _scaleStep = 0.75;

  final List<List<Offset>> _strokes = [];

  List<List<Offset>> get strokes => List.unmodifiable(_strokes);

  bool get isEmpty => _strokes.isEmpty;

  void startStroke(Offset point) {
    _strokes.add([point]);
    notifyListeners();
  }

  void extendStroke(Offset point) {
    if (_strokes.isEmpty) return;
    _strokes.last.add(point);
    notifyListeners();
  }

  void clear() {
    _strokes.clear();
    notifyListeners();
  }

  /// PNG `data:image/png;base64,...` de la firma (trazo negro sobre fondo
  /// blanco). Reduce la escala hasta cumplir el tope de tamaño; `null` si
  /// no hay trazos.
  Future<String?> toDataUrl({Size canvasSize = exportSize}) async {
    if (_strokes.isEmpty) return null;
    var scale = 1.0;
    while (true) {
      final bytes = await _render(canvasSize, scale);
      final encoded = base64Encode(bytes);
      if (encoded.length <= maxBase64Length || scale <= _minScale) {
        return 'data:image/png;base64,$encoded';
      }
      scale *= _scaleStep;
    }
  }

  Future<List<int>> _render(Size source, double scale) async {
    final target = Size(source.width * scale, source.height * scale);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder)
      ..drawRect(Offset.zero & target, Paint()..color = Colors.white);
    SignaturePainter(
      strokes: _strokes,
      color: Colors.black,
      scale: scale,
    ).paint(canvas, target);
    final image = await recorder.endRecording().toImage(
      target.width.round(),
      target.height.round(),
    );
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}

class SignaturePainter extends CustomPainter {
  const SignaturePainter({
    required this.strokes,
    required this.color,
    this.scale = 1,
  });

  final List<List<Offset>> strokes;
  final Color color;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = SignaturePadController._strokeWidth * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    for (final stroke in strokes) {
      if (stroke.length == 1) {
        canvas.drawCircle(
          stroke.first * scale,
          paint.strokeWidth / 2,
          paint..style = PaintingStyle.fill,
        );
        paint.style = PaintingStyle.stroke;
        continue;
      }
      final path = Path()
        ..moveTo(stroke.first.dx * scale, stroke.first.dy * scale);
      for (final point in stroke.skip(1)) {
        path.lineTo(point.dx * scale, point.dy * scale);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}

/// Lienzo para firmar con el dedo. Los puntos se guardan en coordenadas del
/// tamaño de exportación, así el PNG no depende del tamaño de pantalla.
class SignaturePad extends StatelessWidget {
  const SignaturePad({
    required this.controller,
    super.key,
    this.errorText,
  });

  final SignaturePadController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio:
              SignaturePadController.exportSize.width /
              SignaturePadController.exportSize.height,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final factor =
                  SignaturePadController.exportSize.width /
                  constraints.maxWidth;
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  border: Border.all(
                    color: errorText == null
                        ? AppColors.borderStrong
                        : Theme.of(context).colorScheme.error,
                    width: errorText == null
                        ? AppSizes.borderWidth
                        : AppSizes.focusBorderWidth,
                  ),
                ),
                child: Semantics(
                  label: l10n.signHere,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanStart: (d) =>
                        controller.startStroke(d.localPosition * factor),
                    onPanUpdate: (d) =>
                        controller.extendStroke(d.localPosition * factor),
                    child: ListenableBuilder(
                      listenable: controller,
                      builder: (context, _) => CustomPaint(
                        painter: SignaturePainter(
                          strokes: controller.strokes,
                          color: AppColors.dark,
                          scale: 1 / factor,
                        ),
                        child: controller.isEmpty
                            ? Center(
                                child: Text(
                                  l10n.signHere,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textDisabled,
                                  ),
                                ),
                              )
                            : const SizedBox.expand(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            if (errorText != null)
              Expanded(
                child: Text(
                  errorText!,
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              )
            else
              const Spacer(),
            TextButton.icon(
              onPressed: controller.clear,
              icon: const Icon(Icons.refresh, size: AppSizes.iconCompact),
              label: Text(l10n.clearSignature),
            ),
          ],
        ),
      ],
    );
  }
}
