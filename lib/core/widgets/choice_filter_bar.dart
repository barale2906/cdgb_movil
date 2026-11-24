import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';

/// Fila de filtros excluyentes (chips). El elegido se distingue por forma y
/// marca, no solo por color.
class ChoiceFilterBar<T> extends StatelessWidget {
  const ChoiceFilterBar({
    required this.options,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  /// Valor → etiqueta, en orden de aparición.
  final Map<T, String> options;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          for (final entry in options.entries)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: ChoiceChip(
                label: Text(entry.value),
                selected: entry.key == selected,
                showCheckmark: true,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onSelected: (_) => onSelected(entry.key),
              ),
            ),
        ],
      ),
    );
  }
}
