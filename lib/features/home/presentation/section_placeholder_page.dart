import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/navigation/app_section.dart';
import 'package:sga_bojanini/core/navigation/app_section_label.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Marcador de una sección cuya fase aún no se implementa.
class SectionPlaceholderPage extends StatelessWidget {
  const SectionPlaceholderPage({required this.section, super.key});

  final AppSection section;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyState(
      icon: section.icon,
      title: '${section.label(l10n)} · ${l10n.comingSoonTitle}',
      message: l10n.comingSoonBody,
    );
  }
}
