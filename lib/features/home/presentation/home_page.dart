import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/auth/session_controller.dart';
import 'package:sga_bojanini/core/navigation/app_section_label.dart';
import 'package:sga_bojanini/core/navigation/menu_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/scan_product.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/features/dashboard/application/dashboard_providers.dart';
import 'package:sga_bojanini/features/dashboard/presentation/dashboard_blocks.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

const _dashboardPermission = 'tablero.ver';
const _movementPermissions = [
  'movimientos.entrada',
  'movimientos.salida',
  'movimientos.transferir',
  'movimientos.ajuste',
  'movimientos.devolucion',
  'movimientos.baja',
];

/// Registrar una venta exige crear el registro y buscar el servicio.
const _salePermissions = [
  'registros_procedimientos.crear',
  'servicios_medicos.ver',
];

/// Crear una orden de servicio exige crearla y buscar el procedimiento.
const _newOrderPermissions = [
  'ordenes_servicio.crear',
  'servicios_medicos.ver',
];

/// Inicio: saludo, accesos rápidos, tablero (cada bloque solo con el permiso
/// de su módulo) y accesos a los módulos del usuario.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final name = ref.watch(currentUserProvider.select((user) => user?.name));
    final plan = ref.watch(navigationPlanProvider);
    final permissions = ref.watch(permissionServiceProvider);
    final showDashboard = permissions.can(_dashboardPermission);
    final canMove =
        permissions.can('stock.ver') &&
        permissions.canAny(_movementPermissions);
    final canScan = permissions.can('generic-products.barcode');
    final canSell = permissions.canAll(_salePermissions);
    final canOrder = permissions.canAll(_newOrderPermissions);

    return plan.when(
      loading: () => const SkeletonList(),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(menuProvider),
      ),
      data: (plan) {
        final modules = plan.all.skip(1).toList();
        return RefreshIndicator(
          onRefresh: () async {
            invalidateDashboard(ref);
            ref.invalidate(menuProvider);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                l10n.homeGreeting(name ?? ''),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (canMove || canScan || canSell || canOrder) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.dashQuickActions,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    if (canMove)
                      BojaniButton(
                        label: l10n.dashNewMovement,
                        icon: Icons.add,
                        expand: false,
                        onPressed: () => context.push('/inventory/new'),
                      ),
                    if (canOrder)
                      BojaniButton(
                        label: l10n.serviceOrderNew,
                        icon: Icons.assignment_outlined,
                        kind: BojaniButtonKind.secondary,
                        expand: false,
                        onPressed: () => context.push('/service-orders/new'),
                      ),
                    if (canSell)
                      BojaniButton(
                        label: l10n.saleAction,
                        icon: Icons.point_of_sale,
                        kind: BojaniButtonKind.secondary,
                        expand: false,
                        onPressed: () => context.push('/clinical-records/sale'),
                      ),
                    if (canScan)
                      BojaniButton(
                        label: l10n.dashScan,
                        icon: Icons.qr_code_scanner,
                        kind: BojaniButtonKind.secondary,
                        expand: false,
                        onPressed: () =>
                            unawaited(scanAndOpenProduct(context, ref)),
                      ),
                  ],
                ),
              ],
              if (showDashboard) ...[
                const SizedBox(height: AppSpacing.lg),
                if (permissions.can('stock.ver')) ...[
                  const InventoryBlock(),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (permissions.can('notificaciones.ver')) ...[
                  const AlertsBlock(),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (permissions.can('ordenes_compra.ver')) ...[
                  const PurchasingBlock(),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (permissions.can('sensores.ver')) ...[
                  const MonitoringBlock(),
                  const SizedBox(height: AppSpacing.md),
                ],
                // El feed viene de la bitácora de auditoría: solo con permiso.
                if (permissions.can('auditoria.ver')) const ActivityBlock(),
              ],
              const SizedBox(height: AppSpacing.lg),
              if (modules.isEmpty)
                EmptyState(
                  icon: Icons.lock_outline,
                  message: l10n.homeNoModules,
                )
              else ...[
                Text(
                  l10n.homeModules,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final section in modules)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Card(
                      child: ListTile(
                        minTileHeight: AppSizes.minTouchTarget,
                        leading: Icon(section.icon),
                        title: Text(section.label(l10n)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.go(section.path),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}
