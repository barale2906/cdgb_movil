import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/application/transfers_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_transfer.dart';
import 'package:sga_bojanini/features/assets/data/transfers_repository.dart';
import 'package:sga_bojanini/features/assets/presentation/transfer_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Solicitar el traslado de un activo. Los campos dependen del tipo; un
/// activo fuera de las instalaciones solo admite devolución o baja.
class TransferRequestPage extends ConsumerWidget {
  const TransferRequestPage({required this.assetId, super.key});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asset = ref.watch(assetDetailProvider(assetId));
    final filters = ref.watch(assetFiltersProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.transferRequestTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: switch ((asset, filters)) {
                (AsyncData(value: final a), AsyncData(value: final f)) => _Form(
                  asset: a,
                  filters: f,
                ),
                (AsyncError(:final error), _) ||
                (_, AsyncError(:final error)) => ErrorState(
                  error: error,
                  onRetry: () {
                    ref
                      ..invalidate(assetDetailProvider(assetId))
                      ..invalidate(assetFiltersProvider);
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

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.asset, required this.filters});

  final Asset asset;
  final AssetFilters filters;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  final _destination = TextEditingController();
  final _reason = TextEditingController();
  TransferType? _type;
  AssetSite? _site;
  AssetPlace? _place;
  NamedRef? _responsible;
  DateTime? _expectedReturn;

  @override
  void dispose() {
    _destination.dispose();
    _reason.dispose();
    super.dispose();
  }

  List<TransferType> _allowedTypes({required bool canRetire}) => [
    for (final type in TransferType.allowedFor(
      isOffPremises: widget.asset.isOffPremises,
    ))
      if (type != TransferType.retirement || canRetire) type,
  ];

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (_type == null || !(_formKey.currentState?.validate() ?? false)) return;
    final transfer = await ref
        .read(transferActionsProvider.notifier)
        .request(
          widget.asset.id,
          TransferRequest(
            type: _type!,
            toPlaceId: _place?.id,
            toResponsibleId: _responsible?.id,
            externalDestination: _destination.text,
            expectedReturnDate: _expectedReturn?.toIso8601String().substring(
              0,
              10,
            ),
            reason: _reason.text,
          ),
        );
    if (!mounted) return;
    if (transfer == null) {
      AppSnackbar.show(
        context,
        ApiErrorMessage.ofWrite(
          l10n,
          ref.read(transferActionsProvider).error,
          isProd: ref.read(appEnvironmentProvider).env == AppEnv.prod,
          timeoutWarning: l10n.transferTimeoutWarning,
        ),
        kind: AppSnackbarKind.error,
        closeLabel: l10n.actionClose,
      );
      return;
    }
    AppSnackbar.show(
      context,
      transfer.isPending ? l10n.transferRequestedPending : l10n.transferApplied,
    );
    context.pop();
    if (transfer.isPending) {
      unawaited(context.push('/assets/transfers/${transfer.id}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final canRetire = ref
        .watch(permissionServiceProvider)
        .can('activos.dar_baja');
    final submitting = ref.watch(transferActionsProvider).isSubmitting;
    final types = _allowedTypes(canRetire: canRetire);
    final type = _type;
    String? required(Object? value) =>
        value == null || value == '' ? l10n.validationRequired : null;
    final needsPlace =
        type == TransferType.relocation || type == TransferType.returnToSite;
    final isExternal =
        type == TransferType.externalRepair || type == TransferType.loan;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Text(
                  widget.asset.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(widget.asset.code),
                const SizedBox(height: AppSpacing.md),
                OptionDropdown<TransferType>(
                  label: l10n.transferType,
                  options: {
                    for (final t in types) t: transferTypeLabel(l10n, t),
                  },
                  value: type,
                  validator: required,
                  onChanged: (value) => setState(() => _type = value),
                ),
                if (_isSignatureType(type)) ...[
                  const SizedBox(height: AppSpacing.sm),
                  AlertBanner(
                    message: l10n.transferNeedsSignature,
                    kind: StatusKind.info,
                    icon: Icons.draw_outlined,
                  ),
                ],
                if (needsPlace) ...[
                  const SizedBox(height: AppSpacing.md),
                  OptionDropdown<AssetSite>(
                    label: l10n.transferSite,
                    options: {
                      for (final s in widget.filters.sites) s: s.name,
                    },
                    value: _site,
                    validator: required,
                    onChanged: (value) => setState(() {
                      _site = value;
                      _place = null;
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  OptionDropdown<AssetPlace>(
                    label: l10n.transferPlace,
                    options: {
                      for (final p in _site?.places ?? const <AssetPlace>[])
                        p: p.name,
                    },
                    value: _place,
                    validator: required,
                    onChanged: (value) => setState(() => _place = value),
                  ),
                ],
                if (type == TransferType.relocation) ...[
                  const SizedBox(height: AppSpacing.md),
                  OptionDropdown<NamedRef>(
                    label: l10n.transferNewResponsible,
                    nullLabel: l10n.transferKeepResponsible,
                    options: {for (final u in widget.filters.users) u: u.name},
                    value: _responsible,
                    onChanged: (value) => setState(() => _responsible = value),
                  ),
                ],
                if (isExternal) ...[
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _destination,
                    decoration: InputDecoration(
                      labelText: l10n.transferExternalDestination,
                    ),
                    validator: required,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DateField(
                    label: l10n.transferExpectedReturn,
                    value: _expectedReturn,
                    firstDate: DateTime.now(),
                    onChanged: (value) =>
                        setState(() => _expectedReturn = value),
                  ),
                ],
                if (type != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    controller: _reason,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: type == TransferType.retirement
                          ? l10n.transferReason
                          : l10n.transferReasonOptional,
                    ),
                    validator: type == TransferType.retirement
                        ? required
                        : null,
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.transferRequestAction,
              isLoading: submitting,
              onPressed: type == null ? null : () => unawaited(_submit()),
            ),
          ),
        ],
      ),
    );
  }

  /// Tipos que el servidor deja pendientes de firma (`transfer_types`).
  bool _isSignatureType(TransferType? type) =>
      type != null &&
      widget.filters.transferTypes.any(
        (option) => option.value == type.value && option.requiresSignature,
      );
}
