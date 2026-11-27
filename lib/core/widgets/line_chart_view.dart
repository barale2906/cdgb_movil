import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';

/// Punto de una serie temporal.
class ChartPoint {
  const ChartPoint({required this.time, required this.value});

  final DateTime time;
  final double value;
}

/// Gráfica de línea simple con banda de valores permitidos (mín./máx.).
/// Muestra los extremos de ambos ejes como texto y un resumen accesible.
class LineChartView extends StatelessWidget {
  const LineChartView({
    required this.points,
    required this.semanticLabel,
    super.key,
    this.min,
    this.max,
    this.unit = '',
    this.height = 180,
  });

  final List<ChartPoint> points;
  final double? min;
  final double? max;
  final String unit;
  final String semanticLabel;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) return SizedBox(height: height);
    final textTheme = Theme.of(context).textTheme;
    final values = [for (final p in points) p.value, ?min, ?max];
    final lo = values.reduce((a, b) => a < b ? a : b);
    final hi = values.reduce((a, b) => a > b ? a : b);
    return Semantics(
      label: semanticLabel,
      image: true,
      child: ExcludeSemantics(
        child: Column(
          children: [
            SizedBox(
              height: height,
              width: double.infinity,
              child: CustomPaint(
                painter: _LinePainter(
                  points: points,
                  min: min,
                  max: max,
                  lo: lo,
                  hi: hi,
                  bandColor: context.statusColors.success.icon.withValues(
                    alpha: 0.15,
                  ),
                  outsideColor: context.statusColors.error.text,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppFormat.dateTime(points.first.time.toIso8601String()),
                  style: textTheme.bodySmall,
                ),
                Text(
                  '${AppFormat.decimal(lo)}–${AppFormat.decimal(hi)} $unit',
                  style: textTheme.bodySmall,
                ),
                Text(
                  AppFormat.dateTime(points.last.time.toIso8601String()),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter({
    required this.points,
    required this.min,
    required this.max,
    required this.lo,
    required this.hi,
    required this.bandColor,
    required this.outsideColor,
  });

  final List<ChartPoint> points;
  final double? min;
  final double? max;
  final double lo;
  final double hi;
  final Color bandColor;
  final Color outsideColor;

  @override
  void paint(Canvas canvas, Size size) {
    final span = (hi - lo).abs() < 1e-9 ? 1.0 : hi - lo;
    double y(double v) => size.height - ((v - lo) / span) * size.height;
    final t0 = points.first.time.millisecondsSinceEpoch;
    final tSpan = (points.last.time.millisecondsSinceEpoch - t0).clamp(
      1,
      1 << 62,
    );
    double x(DateTime t) => points.length == 1
        ? size.width / 2
        : (t.millisecondsSinceEpoch - t0) / tSpan * size.width;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(AppRadius.control),
      ),
      Paint()..color = AppColors.background,
    );
    if (min != null && max != null) {
      canvas.drawRect(
        Rect.fromLTRB(0, y(max!), size.width, y(min!)),
        Paint()..color = bandColor,
      );
    }
    final line = Paint()
      ..color = AppColors.dark
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    for (final (i, p) in points.indexed) {
      final dx = x(p.time);
      final dy = y(p.value);
      i == 0 ? path.moveTo(dx, dy) : path.lineTo(dx, dy);
    }
    canvas.drawPath(path, line);
    for (final p in points) {
      final outside =
          (min != null && p.value < min!) || (max != null && p.value > max!);
      canvas.drawCircle(
        Offset(x(p.time), y(p.value)),
        outside ? 4 : 2.5,
        Paint()..color = outside ? outsideColor : AppColors.dark,
      );
    }
  }

  @override
  bool shouldRepaint(_LinePainter old) =>
      old.points != points || old.min != min || old.max != max;
}
