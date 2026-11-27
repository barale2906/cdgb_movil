import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
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
