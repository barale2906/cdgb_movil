import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Lista de los almacenes asignados al usuario.
class WarehousesPage extends ConsumerWidget {
  const WarehousesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final warehouses = ref.watch(warehousesProvider);

    return warehouses.when(
      loading: () => const SkeletonList(),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(warehousesProvider),
      ),
      data: (items) => items.isEmpty
          ? EmptyState(
              icon: Icons.warehouse_outlined,
              message: l10n.warehouseEmpty,
            )
          : RefreshIndicator(
              onRefresh: () => ref.refresh(warehousesProvider.future),
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: items.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final warehouse = items[index];
                  return Card(
                    child: ListTile(
                      minTileHeight: AppSizes.minTouchTarget,
                      leading: const Icon(Icons.warehouse_outlined),
                      title: Text(warehouse.name),
                      subtitle: warehouse.code == null
                          ? null
                          : Text(warehouse.code!),
                      trailing: StatusChip(
                        label: warehouse.isActive
                            ? l10n.statusActive
                            : l10n.statusInactive,
                        kind: warehouse.isActive
                            ? StatusKind.success
                            : StatusKind.error,
                      ),
                      onTap: () => context.push('/warehouses/${warehouse.id}'),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
