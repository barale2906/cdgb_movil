import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_form.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Registrar (sin [assetId]) o editar un activo. Al editar solo cambian los
/// datos generales: la ubicación y el estado tienen sus propios flujos.
class AssetFormPage extends ConsumerWidget {
  const AssetFormPage({super.key, this.assetId});

  final int? assetId;

  static const newPath = '/assets/new';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = assetId;
    final filters = ref.watch(assetFiltersProvider);
    final asset = id == null ? null : ref.watch(assetDetailProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text(id == null ? l10n.assetNewTitle : l10n.assetEditTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: switch ((filters, asset)) {
                (AsyncData(value: final f), null) => AssetForm(filters: f),
                (AsyncData(value: final f), AsyncData(value: final a)) =>
                  AssetForm(
                    filters: f,
                    asset: a,
                  ),
                (AsyncError(:final error), _) ||
                (_, AsyncError(:final error)) => ErrorState(
                  error: error,
                  onRetry: () {
                    ref.invalidate(assetFiltersProvider);
                    if (id != null) ref.invalidate(assetDetailProvider(id));
                  },
                ),
                _ => const SkeletonList(),
              },
            ),
          ],
        ),
      ),
    );
  }
}
