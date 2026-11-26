import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/colombia_time.dart';
import 'package:sga_bojanini/core/warehouse/active_warehouse.dart';
import 'package:sga_bojanini/core/warehouse/warehouse_summary.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/reports/application/reports_providers.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/features/reports/data/reports_repository.dart';
import 'package:sga_bojanini/features/reports/presentation/report_labels.dart';
import 'package:sga_bojanini/features/reports/presentation/report_viewer_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

const _movementTypes = [
  'entry',
  'exit',
  'transfer',
  'adjustment',
  'return',
  'expiration_write_off',
  'loss',
];

const _defaultExpiringDays = 30;

/// Filtros y formato de un reporte; al generar lo muestra (PDF), lo
/// comparte (Excel/CSV) o lo deja en seguimiento si es grande.
class ReportFormPage extends ConsumerStatefulWidget {
  const ReportFormPage({required this.type, super.key, this.sensorId});

  final ReportType type;

  /// Sensor preseleccionado (desde el detalle de un sensor).
  final int? sensorId;

  @override
  ConsumerState<ReportFormPage> createState() => _ReportFormPageState();
}

class _ReportFormPageState extends ConsumerState<ReportFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _days = TextEditingController(text: '$_defaultExpiringDays');
  ReportFormat _format = ReportFormat.pdf;
  DateTime? _from;
  DateTime? _to;
  WarehouseSummary? _warehouse;
  String? _movementType;
  int? _sensorId;

  @override
  void initState() {
    super.initState();
    _sensorId = widget.sensorId;
  }

  @override
  void dispose() {
    _days.dispose();
    super.dispose();
  }

  bool get _usesWarehouse =>
      widget.type == ReportType.inventory || widget.type == ReportType.expiring;

  bool get _usesDates => switch (widget.type) {
    ReportType.inventory || ReportType.expiring => false,
    _ => true,
  };

  Map<String, Object?> _filters() {
    String? date(DateTime? value) =>
        value == null ? null : ColombiaTime.formatDate(value);
    return {
      if (_usesWarehouse) 'warehouse_id': _warehouse?.id,
      if (_usesDates) ...{'date_from': date(_from), 'date_to': date(_to)},
      if (widget.type == ReportType.movements) 'type': _movementType,
      if (widget.type == ReportType.expiring)
        'days': int.tryParse(_days.text.trim()),
      if (widget.type == ReportType.conditions) 'sensor_id': _sensorId,
    };
  }

  Future<void> _generate() async {
    final l10n = AppLocalizations.of(context);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    final result = await ref
        .read(generateReportControllerProvider.notifier)
        .generate(widget.type, _format, _filters());
    if (result == null || !mounted) return;
    switch (result) {
      case ReportQueued():
        AppSnackbar.show(
          context,
          l10n.reportQueued,
          kind: AppSnackbarKind.warning,
        );
        context.pushReplacement('/reports/exports');
      case final ReportFile file when file.format == ReportFormat.pdf:
        unawaited(context.push('/reports/view', extra: file));
      case final ReportFile file:
        AppSnackbar.show(context, l10n.reportReady);
        await shareReportFile(context, ref, file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(generateReportControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final canWrite = ref.watch(canWriteProvider);
    final error = submission.error;
    final activeWarehouse = ref.watch(activeWarehouseProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.type.label(l10n))),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(widget.type.hint(l10n)),
                      const SizedBox(height: AppSpacing.md),
                      if (_usesWarehouse)
                        AsyncOptionDropdown<WarehouseSummary>(
                          label: l10n.fieldWarehouse,
                          options: ref.watch(warehousesProvider),
                          labelOf: (w) => w.name,
                          value: _warehouse ?? activeWarehouse,
                          nullLabel: l10n.reportAnyType,
                          onRetry: () => ref.invalidate(warehousesProvider),
                          onChanged: (value) =>
                              setState(() => _warehouse = value),
                        ),
                      if (widget.type == ReportType.expiring) ...[
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _days,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l10n.reportDays,
                          ),
                          validator: (v) {
                            final days = int.tryParse((v ?? '').trim());
                            return days == null || days < 1 || days > 365
                                ? l10n.validationPositive
                                : null;
                          },
                        ),
                      ],
                      if (_usesDates) ...[
                        DateField(
                          label: l10n.reportDateFrom,
                          value: _from,
                          onChanged: (d) => setState(() => _from = d),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        FormField<DateTime>(
                          validator: (_) =>
                              _from != null &&
                                  _to != null &&
                                  _to!.isBefore(_from!)
                              ? l10n.reportDateRangeInvalid
                              : null,
                          builder: (state) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DateField(
                                label: l10n.reportDateTo,
                                value: _to,
                                onChanged: (d) => setState(() => _to = d),
                              ),
                              if (state.errorText != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: AppSpacing.xs,
                                  ),
                                  child: Text(
                                    state.errorText!,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                      if (widget.type == ReportType.movements) ...[
                        const SizedBox(height: AppSpacing.md),
                        OptionDropdown<String>(
                          label: l10n.reportMovementType,
                          options: {
                            for (final t in _movementTypes)
                              t: _movementLabel(l10n, t),
                          },
                          value: _movementType,
                          nullLabel: l10n.reportAnyType,
                          onChanged: (v) => setState(() => _movementType = v),
                        ),
                      ],
                      if (widget.type == ReportType.conditions) ...[
                        const SizedBox(height: AppSpacing.md),
                        AsyncOptionDropdown<ReportSensor>(
                          label: l10n.reportSensor,
                          options: ref.watch(reportSensorsProvider),
                          labelOf: (s) => s.name,
                          value: _sensorFrom(ref),
                          onRetry: () => ref.invalidate(reportSensorsProvider),
                          onChanged: (s) => setState(() => _sensorId = s?.id),
                          validator: (s) =>
                              _format == ReportFormat.pdf && _sensorId == null
                              ? l10n.reportPdfNeedsSensor
                              : null,
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.reportFormat,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SegmentedButton<ReportFormat>(
                        segments: [
                          for (final f in ReportFormat.values)
                            ButtonSegment(value: f, label: Text(f.label(l10n))),
                        ],
                        selected: {_format},
                        onSelectionChanged: (s) =>
                            setState(() => _format = s.first),
                      ),
                      if (error != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        AlertBanner(
                          message: ApiErrorMessage.of(
                            l10n,
                            error,
                            isProd: isProd,
                          ),
                          kind: StatusKind.error,
                          icon: Icons.error_outline,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: BojaniButton(
                label: l10n.reportGenerate,
                isLoading: submission.isSubmitting,
                onPressed: canWrite ? () => unawaited(_generate()) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ReportSensor? _sensorFrom(WidgetRef ref) {
    final sensors = ref.watch(reportSensorsProvider).value;
    if (sensors == null) return null;
    for (final sensor in sensors) {
      if (sensor.id == _sensorId) return sensor;
    }
    return null;
  }

  static String _movementLabel(AppLocalizations l10n, String type) =>
      switch (type) {
        'entry' => l10n.movementEntry,
        'exit' => l10n.movementExit,
        'transfer' => l10n.movementTransfer,
        'adjustment' => l10n.movementAdjustment,
        'return' => l10n.movementReturn,
        'expiration_write_off' => l10n.movementWriteOff,
        _ => l10n.movementLoss,
      };
}
