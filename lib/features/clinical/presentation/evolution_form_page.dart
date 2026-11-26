import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/permission_service.dart';
import 'package:sga_bojanini/core/clinical/clinical_lookup.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/clinical_text.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/clinical/application/clinical_providers.dart';
import 'package:sga_bojanini/features/clinical/application/evolution_actions.dart';
import 'package:sga_bojanini/features/clinical/data/evolution.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Crear o editar una evolución clínica. Al crear, precarga la plantilla del
/// servicio si hay permiso y existe. El texto se guarda sin formato.
class EvolutionFormPage extends ConsumerStatefulWidget {
  const EvolutionFormPage({required this.recordId, super.key, this.evolution});

  static String pathFor(int recordId) =>
      '/clinical-records/records/$recordId/evolution';

  final int recordId;

  /// Evolución a editar; `null` para crear una nueva.
  final Evolution? evolution;

  @override
  ConsumerState<EvolutionFormPage> createState() => _EvolutionFormPageState();
}

class _EvolutionFormPageState extends ConsumerState<EvolutionFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _text = TextEditingController(
    text: widget.evolution?.text ?? '',
  );
  bool _templateRequested = false;
  bool _templateLoaded = false;

  bool get _isEditing => widget.evolution != null;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final done = await ref
        .read(evolutionActionsProvider.notifier)
        .save(
          widget.recordId,
          _text.text,
          evolutionId: widget.evolution?.id,
        );
    if (!mounted || !done) return;
    AppSnackbar.show(
      context,
      AppLocalizations.of(context).clinicalEvolutionSaved,
    );
    context.pop();
  }

  /// Plantilla del servicio: solo al crear, una vez y sin pisar lo escrito.
  void _applyTemplate(int? serviceId) {
    if (_isEditing || serviceId == null || _templateRequested) return;
    _templateRequested = true;
    final canUse = ref
        .read(permissionServiceProvider)
        .can('plantillas_clinicas.ver');
    if (!canUse) return;
    ref.listenManual(clinicalTemplateProvider(serviceId), (_, next) {
      final template = next.value;
      if (template == null || _templateLoaded || _text.text.trim().isNotEmpty) {
        return;
      }
      setState(() {
        _templateLoaded = true;
        _text.text = ClinicalText.fromHtml(template.content);
      });
    }, fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(evolutionActionsProvider);
    final canWrite = ref.watch(canWriteProvider);
    final record = ref.watch(procedureRecordProvider(widget.recordId)).value;
    _applyTemplate(record?.medicalServiceId);
    final error = submission.error;
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? l10n.clinicalEvolutionEditTitle
              : l10n.clinicalEvolutionNewTitle,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    TextFormField(
                      controller: _text,
                      enabled: !submission.isSubmitting,
                      minLines: 6,
                      maxLines: 14,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: l10n.clinicalEvolutionField,
                        helperText: l10n.clinicalEvolutionFormatNote,
                        helperMaxLines: 2,
                        alignLabelWithHint: true,
                      ),
                      validator: (value) => ClinicalText.hasText(value)
                          ? null
                          : l10n.validationRequired,
                    ),
                    if (_templateLoaded) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(l10n.clinicalEvolutionTemplateLoaded),
                    ],
                    if (error != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      AlertBanner(
                        message: ApiErrorMessage.ofWrite(
                          l10n,
                          error,
                          isProd: isProd,
                          timeoutWarning: l10n.clinicalEvolutionTimeout,
                        ),
                        kind: StatusKind.error,
                        icon: Icons.error_outline,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: BojaniButton(
                label: l10n.clinicalEvolutionSave,
                isLoading: submission.isSubmitting,
                onPressed: canWrite ? () => unawaited(_save()) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
