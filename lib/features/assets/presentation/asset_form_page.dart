import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/models/named_ref.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/core/widgets/write_feedback.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/features/assets/data/asset_draft.dart';
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/presentation/asset_placement_fields.dart';
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
                (AsyncData(value: final f), null) => _Form(filters: f),
                (AsyncData(value: final f), AsyncData(value: final a)) => _Form(
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

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.filters, this.asset});

  final AssetFilters filters;
  final Asset? asset;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.asset?.name);
  late final _brand = TextEditingController(text: widget.asset?.brand);
  late final _model = TextEditingController(text: widget.asset?.model);
  late final _serial = TextEditingController(text: widget.asset?.serial);
  late final _invoice = TextEditingController(
    text: widget.asset?.invoiceNumber,
  );
  late final _description = TextEditingController(
    text: widget.asset?.description,
  );
  late final _notes = TextEditingController(text: widget.asset?.notes);
  late final _value = TextEditingController(
    text: AppFormat.plain(widget.asset?.acquisitionValue),
  );
  final _comment = TextEditingController();
  late AssetCategory? _category = widget.filters.categories
      .where((c) => c.id == widget.asset?.category?.id)
      .firstOrNull;
  late NamedRef? _supplier = widget.filters.suppliers
      .where((s) => s.id == widget.asset?.supplier?.id)
      .firstOrNull;
  late DateTime? _acquisitionDate = ColombiaTime.parse(
    widget.asset?.acquisitionDate,
  );
  late DateTime? _warrantyUntil = ColombiaTime.parse(
    widget.asset?.warrantyUntil,
  );
  AssetSite? _site;
  AssetPlace? _place;
  NamedRef? _responsible;
  AssetStatus? _status;

  bool get _isEdit => widget.asset != null;

  @override
  void dispose() {
    for (final controller in [
      _name,
      _brand,
      _model,
      _serial,
      _invoice,
      _description,
      _notes,
      _value,
      _comment,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  AssetDraft _draft() => AssetDraft(
    name: _name.text,
    categoryId: _category!.id,
    placeId: _place?.id,
    responsibleId: _responsible?.id,
    status: _status,
    description: _description.text,
    brand: _brand.text,
    model: _model.text,
    serial: _serial.text,
    acquisitionDate: _acquisitionDate,
    acquisitionValue: AppFormat.parseDecimal(_value.text),
    supplierId: _supplier?.id,
    invoiceNumber: _invoice.text,
    warrantyUntil: _warrantyUntil,
    notes: _notes.text,
    comment: _comment.text,
  );

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(assetFormControllerProvider.notifier);
    final asset = widget.asset;
    final done = asset == null
        ? await controller.create(_draft()) != null
        : await controller.update(asset.id, _draft());
    if (!mounted) return;
    if (!done) {
      showWriteError(
        context,
        ref,
        error: ref.read(assetFormControllerProvider).error,
        timeoutWarning: l10n.assetFormTimeoutWarning,
      );
      return;
    }
    AppSnackbar.show(
      context,
      asset == null ? l10n.assetCreated : l10n.assetUpdated,
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submitting = ref.watch(assetFormControllerProvider).isSubmitting;
    String? required(Object? value) =>
        value == null || value == '' ? l10n.validationRequired : null;
    String? requiredText(String? value) => required(value?.trim());
    String? money(String? value) =>
        (value ?? '').trim().isEmpty || AppFormat.parseDecimal(value) != null
        ? null
        : l10n.assetFormAcquisitionValueInvalid;
    final filters = widget.filters;
    const gap = SizedBox(height: AppSpacing.md);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                AlertBanner(
                  message: _isEdit
                      ? l10n.assetFormLocationInfo
                      : l10n.assetFormCodeInfo,
                  kind: StatusKind.info,
                  icon: Icons.info_outline,
                ),
                gap,
                LabeledTextField(
                  label: l10n.assetFormName,
                  controller: _name,
                  validator: requiredText,
                  maxLength: 200,
                  textCapitalization: TextCapitalization.sentences,
                ),
                gap,
                OptionDropdown<AssetCategory>(
                  label: l10n.assetCategory,
                  options: {for (final c in filters.categories) c: c.name},
                  value: _category,
                  validator: required,
                  onChanged: (value) => setState(() => _category = value),
                ),
                if (!_isEdit) ...[
                  gap,
                  AssetPlacementFields(
                    filters: filters,
                    site: _site,
                    place: _place,
                    responsible: _responsible,
                    status: _status,
                    comment: _comment,
                    required: required,
                    onSite: (value) => setState(() {
                      _site = value;
                      _place = null;
                    }),
                    onPlace: (value) => setState(() => _place = value),
                    onResponsible: (value) =>
                        setState(() => _responsible = value),
                    onStatus: (value) => setState(() => _status = value),
                  ),
                ],
                gap,
                LabeledTextField(
                  label: l10n.assetBrand,
                  controller: _brand,
                  maxLength: 100,
                ),
                gap,
                LabeledTextField(
                  label: l10n.assetModel,
                  controller: _model,
                  maxLength: 100,
                ),
                gap,
                LabeledTextField(
                  label: l10n.assetSerial,
                  controller: _serial,
                  maxLength: 100,
                ),
                gap,
                DateField(
                  label: l10n.assetAcquisition,
                  value: _acquisitionDate,
                  lastDate: DateTime.now(),
                  onChanged: (value) =>
                      setState(() => _acquisitionDate = value),
                ),
                gap,
                LabeledTextField(
                  label: l10n.assetAcquisitionValue,
                  controller: _value,
                  validator: money,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                gap,
                OptionDropdown<NamedRef>(
                  label: l10n.assetSupplier,
                  nullLabel: l10n.assetFormNoSupplier,
                  options: {for (final s in filters.suppliers) s: s.name},
                  value: _supplier,
                  onChanged: (value) => setState(() => _supplier = value),
                ),
                gap,
                LabeledTextField(
                  label: l10n.assetInvoice,
                  controller: _invoice,
                  maxLength: 50,
                ),
                gap,
                DateField(
                  label: l10n.assetWarrantyUntil,
                  value: _warrantyUntil,
                  onChanged: (value) => setState(() => _warrantyUntil = value),
                ),
                gap,
                LabeledTextField(
                  label: l10n.assetDescription,
                  controller: _description,
                  maxLines: 3,
                ),
                gap,
                LabeledTextField(
                  label: l10n.orderNotes,
                  controller: _notes,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.actionSave,
              isLoading: submitting,
              onPressed: () => unawaited(_submit()),
            ),
          ),
        ],
      ),
    );
  }
}
