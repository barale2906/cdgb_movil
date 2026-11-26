import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/theme/status_colors.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';

/// Tramo de una [SegmentedBar].
class BarSegment {
  const BarSegment({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final num value;
  final Color color;
}

/// Barra apilada con leyenda. Cada tramo lleva su etiqueta y valor en texto:
/// el estado nunca depende solo del color.
class SegmentedBar extends StatelessWidget {
  const SegmentedBar({required this.segments, super.key});

  final List<BarSegment> segments;

  static const _height = 12.0;

  @override
  Widget build(BuildContext context) {
    final total = segments.fold<num>(0, (sum, s) => sum + s.value);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: SizedBox(
            height: _height,
            child: total == 0
                ? const ColoredBox(
                    color: AppColors.surfaceAlt,
                    child: SizedBox.expand(),
                  )
                : Row(
                    children: [
                      for (final segment in segments)
                        if (segment.value > 0)
                          Expanded(
                            flex: (segment.value * 1000).round(),
                            child: ColoredBox(
                              color: segment.color,
                              child: const SizedBox.expand(),
                            ),
                          ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.xs,
          children: [
            for (final segment in segments)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: AppSpacing.sm + AppSpacing.xs,
                    height: AppSpacing.sm + AppSpacing.xs,
                    decoration: BoxDecoration(
                      color: segment.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '${segment.label}: '
                    '${AppFormat.decimal(segment.value, maxDecimals: 0)}',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// Fila de un [BarList].
class BarItem {
  const BarItem({required this.label, required this.value, this.detail});

  final String label;
  final num value;
  final String? detail;
}

/// Lista de barras horizontales proporcionales al mayor valor.
class BarList extends StatelessWidget {
  const BarList({required this.items, super.key, this.color = AppColors.dark2});

  final List<BarItem> items;
  final Color color;

  static const _barHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final maxValue = items.fold<num>(
      0,
      (max, i) => i.value > max ? i.value : max,
    );
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.label,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      item.detail ??
                          AppFormat.decimal(item.value, maxDecimals: 1),
                      style: textTheme.labelLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: LinearProgressIndicator(
                    value: maxValue == 0 ? 0 : (item.value / maxValue),
                    minHeight: _barHeight,
                    backgroundColor: AppColors.surfaceAlt,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

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
