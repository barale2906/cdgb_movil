import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/info_row.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_comments_tab.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_documents_tab.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_history_tab.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_labels.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_management_actions.dart';
import 'package:sga_bojanini/features/assets/presentation/change_status_dialog.dart';
import 'package:sga_bojanini/features/assets/presentation/maintenance_plans_section.dart';
import 'package:sga_bojanini/features/assets/presentation/technical_profile_section.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Ficha del activo en tres pestañas: datos, historial y comentarios.
class AssetDetailPage extends ConsumerWidget {
  const AssetDetailPage({required this.assetId, super.key});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asset = ref.watch(assetDetailProvider(assetId));
    return Scaffold(
      appBar: AppBar(title: Text(asset.value?.code ?? l10n.assetDetailTitle)),
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
                data: (data) => _Tabs(asset: data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Material(
            color: AppColors.surface,
            child: TabBar(
              tabs: [
                Tab(text: l10n.assetTabData),
                Tab(text: l10n.assetTabHistory),
                Tab(text: l10n.assetTabComments),
                Tab(text: l10n.assetTabDocuments),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _DataTab(asset: asset),
                AssetHistoryTab(assetId: asset.id),
                AssetCommentsTab(assetId: asset.id),
                AssetDocumentsTab(assetId: asset.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataTab extends ConsumerWidget {
  const _DataTab({required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final next = asset.nextMaintenance;
    final pending = asset.pendingTransfer;
    // Un traslado pendiente bloquea otro (409) y un activo dado de baja ya no
    // se traslada.
    // Mantiene vivo el controlador mientras el servidor responde.
    ref.watch(changeStatusControllerProvider);
    final canChangeStatus =
        ref.watch(permissionServiceProvider).can('activos.editar') &&
        !asset.isRetired;
    final canViewMaintenance = ref
        .watch(permissionServiceProvider)
        .can('activos_mantenimientos.ver');
    final canRequestTransfer =
        ref
            .watch(permissionServiceProvider)
            .can('activos_traslados.solicitar') &&
        pending == null &&
        !asset.isRetired;
    return RefreshIndicator(
      onRefresh: () => ref.refresh(assetDetailProvider(asset.id).future),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(asset.name, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AssetStatusChip(status: asset.status),
          if (pending != null) ...[
            const SizedBox(height: AppSpacing.md),
            AlertBanner(
              message: l10n.assetPendingTransfer(pending.typeLabel ?? ''),
              kind: StatusKind.warning,
              icon: Icons.swap_horiz,
            ),
          ],
          if (next != null && next.isOverdue) ...[
            const SizedBox(height: AppSpacing.md),
            AlertBanner(
              message: l10n.assetMaintenanceOverdueOn(
                AppFormat.date(next.scheduledDate ?? ''),
              ),
              kind: StatusKind.error,
              icon: Icons.build_outlined,
              actionLabel: canViewMaintenance
                  ? l10n.assetViewMaintenance
                  : null,
              onAction: canViewMaintenance
                  ? () => context.push('/maintenance/${next.id}')
                  : null,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          InfoRow(label: l10n.assetCode, value: asset.code, mono: true),
          InfoRow(
            label: l10n.assetType,
            value: assetTypeLabel(l10n, asset.assetType),
          ),
          InfoRow(label: l10n.assetCategory, value: asset.category?.name),
          InfoRow(label: l10n.assetLocation, value: asset.locationLabel),
          InfoRow(label: l10n.assetResponsible, value: asset.responsible?.name),
          InfoRow(label: l10n.assetBrand, value: asset.brand),
          InfoRow(label: l10n.assetModel, value: asset.model),
          InfoRow(label: l10n.assetSerial, value: asset.serial, mono: true),
          InfoRow(label: l10n.assetSupplier, value: asset.supplier?.name),
          InfoRow(label: l10n.assetInvoice, value: asset.invoiceNumber),
          InfoRow(
            label: l10n.assetAcquisition,
            value: asset.acquisitionDate == null
                ? null
                : AppFormat.date(asset.acquisitionDate!),
          ),
          InfoRow(
            label: l10n.assetAcquisitionValue,
            value: asset.acquisitionValue == null
                ? null
                : AppFormat.cop(asset.acquisitionValue!),
          ),
          InfoRow(
            label: l10n.assetWarrantyUntil,
            value: asset.warrantyUntil == null
                ? null
                : AppFormat.date(asset.warrantyUntil!),
          ),
          InfoRow(label: l10n.assetDescription, value: asset.description),
          InfoRow(label: l10n.orderNotes, value: asset.notes),
          if (asset.isRetired) ...[
            InfoRow(
              label: l10n.assetRetiredAt,
              value: asset.retiredAt == null
                  ? null
                  : AppFormat.date(asset.retiredAt!),
            ),
            InfoRow(
              label: l10n.assetRetirementReason,
              value: asset.retirementReason,
            ),
          ],
          TechnicalProfileSection(profile: asset.technicalProfile),
          if (canViewMaintenance)
            MaintenancePlansSection(
              assetId: asset.id,
              canEdit: asset.requiresMaintenance && !asset.isRetired,
            ),
          const SizedBox(height: AppSpacing.lg),
          if (canRequestTransfer) ...[
            BojaniButton(
              label: l10n.transferRequestAction,
              icon: Icons.swap_horiz,
              onPressed: () => context.push('/assets/${asset.id}/transfer'),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (canChangeStatus) ...[
            BojaniButton(
              label: l10n.assetChangeStatus,
              icon: Icons.published_with_changes,
              kind: BojaniButtonKind.secondary,
              onPressed: () => unawaited(_changeStatus(context, ref)),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          AssetManagementActions(asset: asset),
          BojaniButton(
            label: l10n.assetLifeSheet,
            icon: Icons.picture_as_pdf_outlined,
            kind: BojaniButtonKind.secondary,
            onPressed: () => context.push('/assets/${asset.id}/life-sheet'),
          ),
        ],
      ),
    );
  }

  Future<void> _changeStatus(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final filters = await ref.read(assetFiltersProvider.future);
    if (!context.mounted) return;
    final options = [
      for (final option in filters.settableStatuses)
        if (AssetStatus.parse(option.value) != asset.status &&
            AssetStatus.parse(option.value) != AssetStatus.unknown)
          AssetStatus.parse(option.value),
    ];
    final choice = await askNewStatus(context, options: options);
    if (choice == null || !context.mounted) return;
    final done = await ref
        .read(changeStatusControllerProvider.notifier)
        .change(asset.id, choice.status, reason: choice.reason);
    if (!context.mounted) return;
    if (done) {
      AppSnackbar.show(context, l10n.assetStatusChanged);
      return;
    }
    AppSnackbar.show(
      context,
      ApiErrorMessage.ofWrite(
        l10n,
        ref.read(changeStatusControllerProvider).error,
        isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
        timeoutWarning: l10n.assetStatusTimeoutWarning,
      ),
      kind: AppSnackbarKind.error,
      closeLabel: l10n.actionClose,
    );
  }
}
