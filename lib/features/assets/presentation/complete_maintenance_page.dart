import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/presentation/complete_maintenance_form.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Registrar la ejecución de un mantenimiento en curso. El resultado define
/// el estado final del activo.
class CompleteMaintenancePage extends ConsumerWidget {
  const CompleteMaintenancePage({required this.maintenanceId, super.key});

  final int maintenanceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final filters = ref.watch(assetFiltersProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.maintenanceComplete)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: filters.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(assetFiltersProvider),
                ),
                data: (data) => CompleteMaintenanceForm(
                  maintenanceId: maintenanceId,
                  filters: data,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
