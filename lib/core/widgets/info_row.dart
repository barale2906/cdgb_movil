import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';

/// Par etiqueta / valor para pantallas de detalle. No se muestra si el
/// valor está vacío.
class InfoRow extends StatelessWidget {
  const InfoRow({
    required this.label,
    required this.value,
    super.key,
    this.mono = false,
  });

  final String label;
  final String? value;

  /// Usa tipografía monoespaciada (códigos, SKU, lotes).
  final bool mono;

  @override
  Widget build(BuildContext context) {
    final text = value;
    if (text == null || text.isEmpty) return const SizedBox.shrink();
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.labelMedium),
          const SizedBox(height: AppSpacing.xs / 2),
          SelectableText(
            text,
            style: mono
                ? textTheme.bodyLarge?.copyWith(
                    fontFamilyFallback: const ['monospace'],
                  )
                : textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
