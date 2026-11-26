import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Perfil técnico: solo los campos con valor y con etiqueta conocida.
class TechnicalProfileSection extends StatelessWidget {
  const TechnicalProfileSection({required this.profile, super.key});

  final Map<String, dynamic> profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rows = <Widget>[];
    for (final entry in profile.entries) {
      final label = technicalFieldLabel(l10n, entry.key);
      final text = _text(l10n, entry.value);
      if (label == null || text == null) continue;
      rows.add(InfoRow(label: label, value: text));
    }
    if (rows.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.assetTechnicalProfile,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        ...rows,
      ],
    );
  }

  static String? _text(AppLocalizations l10n, Object? value) => switch (value) {
    final bool flag => flag ? l10n.yes : l10n.no,
    final String text when text.trim().isNotEmpty => text,
    final num number => '$number',
    _ => null,
  };
}
