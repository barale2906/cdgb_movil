import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/presentation/technical_profile_form.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Hoja de vida técnica de un equipo biomédico o de cómputo. Solo se envían
/// los campos de esta pantalla: las especificaciones y licencias que ya tenga
/// el equipo se conservan.
class TechnicalProfileFormPage extends ConsumerWidget {
  const TechnicalProfileFormPage({required this.assetId, super.key});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asset = ref.watch(assetDetailProvider(assetId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.techProfileTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: asset.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(assetDetailProvider(assetId)),
                ),
                data: (data) => data.supportsTechnicalProfile
                    ? TechnicalProfileForm(asset: data)
                    : AlertBanner(
                        message: l10n.techNotApplicable,
                        kind: StatusKind.warning,
                        icon: Icons.info_outline,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
