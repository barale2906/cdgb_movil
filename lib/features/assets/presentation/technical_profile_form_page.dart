import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
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
import 'package:sga_bojanini/features/assets/data/asset_enums.dart';
import 'package:sga_bojanini/features/assets/presentation/technical_profile_options.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

final RegExp _ipV4 = RegExp(
  r'^((25[0-5]|2[0-4]\d|1?\d?\d)\.){3}(25[0-5]|2[0-4]\d|1?\d?\d)$',
);
final RegExp _mac = RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}$');

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
                    ? _Form(asset: data)
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

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.asset});

  final Asset asset;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  static const _textFields = [
    'manufacturer',
    'country_of_origin',
    'accessories',
    'usage_recommendations',
    'invima_registry',
    'voltage',
    'current',
    'power',
    'frequency',
    'operating_conditions',
    'processor',
    'ram',
    'storage',
    'operating_system',
    'ip_address',
    'mac_address',
    'hostname',
    'manufacture_year',
    'useful_life_years',
  ];

  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers = {
    for (final field in _textFields)
      field: TextEditingController(
        text: '${widget.asset.technicalProfile[field] ?? ''}',
      ),
  };
  late final Map<String, String?> _choices = {
    for (final field in const [
      'acquisition_mode',
      'risk_class',
      'biomedical_class',
      'power_source',
    ])
      field: widget.asset.technicalProfile[field] as String?,
  };
  late bool _requiresCalibration =
      widget.asset.technicalProfile['requires_calibration'] == true;

  bool get _isBiomedical => widget.asset.assetType == AssetType.biomedical;

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _value(String field) {
    final text = _controllers[field]!.text.trim();
    return text.isEmpty ? null : text;
  }

  Map<String, Object?> _payload() => {
    for (final field in _textFields)
      if (_applies(field))
        field: field == 'manufacture_year' || field == 'useful_life_years'
            ? int.tryParse(_value(field) ?? '')
            : _value(field),
    for (final entry in _choices.entries)
      if (_applies(entry.key)) entry.key: entry.value,
    if (_isBiomedical) 'requires_calibration': _requiresCalibration,
  };

  bool _applies(String field) => switch (field) {
    'invima_registry' ||
    'risk_class' ||
    'biomedical_class' ||
    'power_source' ||
    'voltage' ||
    'current' ||
    'power' ||
    'frequency' ||
    'operating_conditions' => _isBiomedical,
    'processor' ||
    'ram' ||
    'storage' ||
    'operating_system' ||
    'ip_address' ||
    'mac_address' ||
    'hostname' => !_isBiomedical,
    _ => true,
  };

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final l10n = AppLocalizations.of(context);
    final done = await ref
        .read(assetFormControllerProvider.notifier)
        .saveTechnicalProfile(widget.asset.id, _payload());
    if (!mounted) return;
    if (!done) {
      showWriteError(
        context,
        ref,
        error: ref.read(assetFormControllerProvider).error,
        timeoutWarning: l10n.techProfileTimeoutWarning,
      );
      return;
    }
    AppSnackbar.show(context, l10n.techProfileSaved);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submitting = ref.watch(assetFormControllerProvider).isSubmitting;
    // El servidor acepta hasta el año siguiente al actual.
    final maxYear = ColombiaTime.now(ref.watch(clockProvider)).year + 1;
    const gap = SizedBox(height: AppSpacing.md);

    Widget text(
      String field,
      String label, {
      String? Function(String?)? check,
    }) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: LabeledTextField(
        label: label,
        controller: _controllers[field]!,
        validator: check,
      ),
    );

    Widget choice(String field, String label, Map<String, String> options) =>
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: OptionDropdown<String>(
            label: label,
            nullLabel: l10n.optionUnset,
            options: options,
            value: _choices[field],
            onChanged: (value) => setState(() => _choices[field] = value),
          ),
        );

    String? integerBetween(String? value, int min, int max, String message) {
      final text = (value ?? '').trim();
      if (text.isEmpty) return null;
      final number = int.tryParse(text);
      return number == null || number < min || number > max ? message : null;
    }

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
                gap,
                Text(
                  l10n.techProfileGeneral,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                gap,
                text('manufacturer', l10n.techManufacturer),
                text('country_of_origin', l10n.techCountry),
                text(
                  'manufacture_year',
                  l10n.techYear,
                  check: (v) => integerBetween(
                    v,
                    1900,
                    maxYear,
                    l10n.techYearInvalid(maxYear),
                  ),
                ),
                text(
                  'useful_life_years',
                  l10n.techUsefulLife,
                  check: (v) =>
                      integerBetween(v, 1, 100, l10n.techUsefulLifeInvalid),
                ),
                choice(
                  'acquisition_mode',
                  l10n.techAcquisitionMode,
                  TechnicalProfileOptions.acquisitionModes(l10n),
                ),
                text('accessories', l10n.techAccessories),
                text('usage_recommendations', l10n.techRecommendations),
                if (_isBiomedical) ..._biomedical(l10n, text, choice),
                if (!_isBiomedical) ..._computing(l10n, text),
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

  List<Widget> _biomedical(
    AppLocalizations l10n,
    Widget Function(String, String, {String? Function(String?)? check}) text,
    Widget Function(String, String, Map<String, String>) choice,
  ) => [
    Text(
      l10n.techProfileBiomedical,
      style: Theme.of(context).textTheme.titleSmall,
    ),
    const SizedBox(height: AppSpacing.md),
    text('invima_registry', l10n.techInvima),
    choice(
      'risk_class',
      l10n.techRiskClass,
      TechnicalProfileOptions.riskClasses(l10n),
    ),
    choice(
      'biomedical_class',
      l10n.techBiomedicalClass,
      TechnicalProfileOptions.biomedicalClasses(l10n),
    ),
    choice(
      'power_source',
      l10n.techPowerSource,
      TechnicalProfileOptions.powerSources(l10n),
    ),
    text('voltage', l10n.techVoltage),
    text('current', l10n.techCurrent),
    text('power', l10n.techPower),
    text('frequency', l10n.techFrequency),
    text('operating_conditions', l10n.techOperatingConditions),
    SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(l10n.techRequiresCalibration),
      value: _requiresCalibration,
      onChanged: (value) => setState(() => _requiresCalibration = value),
    ),
  ];

  List<Widget> _computing(
    AppLocalizations l10n,
    Widget Function(String, String, {String? Function(String?)? check}) text,
  ) => [
    Text(
      l10n.techProfileComputing,
      style: Theme.of(context).textTheme.titleSmall,
    ),
    const SizedBox(height: AppSpacing.md),
    text('processor', l10n.techProcessor),
    text('ram', l10n.techRam),
    text('storage', l10n.techStorage),
    text('operating_system', l10n.techOperatingSystem),
    text(
      'ip_address',
      l10n.techIp,
      check: (v) => (v ?? '').trim().isEmpty || _ipV4.hasMatch(v!.trim())
          ? null
          : l10n.techIpInvalid,
    ),
    text(
      'mac_address',
      l10n.techMac,
      check: (v) => (v ?? '').trim().isEmpty || _mac.hasMatch(v!.trim())
          ? null
          : l10n.techMacInvalid,
    ),
    text('hostname', l10n.techHostname),
  ];
}
