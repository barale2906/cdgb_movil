import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/auth/my_signature.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/signature_pad.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/auth/application/signature_controllers.dart';
import 'package:sga_bojanini/features/auth/presentation/pin_dialogs.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

String _documentTypeLabel(AppLocalizations l10n, String type) => switch (type) {
  'CC' => l10n.docTypeCC,
  'CE' => l10n.docTypeCE,
  'TI' => l10n.docTypeTI,
  'PA' => l10n.docTypePA,
  'PPT' => l10n.docTypePPT,
  _ => type,
};

/// "Mi firma": registro y cambio de la firma y del PIN de 3 dígitos.
class MySignaturePage extends ConsumerStatefulWidget {
  const MySignaturePage({super.key});

  @override
  ConsumerState<MySignaturePage> createState() => _MySignaturePageState();
}

class _MySignaturePageState extends ConsumerState<MySignaturePage> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final signature = ref.watch(mySignatureProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signatureTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: signature.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(mySignatureProvider),
                ),
                data: (data) => data == null || _editing
                    ? _SignatureForm(
                        current: data,
                        onSaved: () => setState(() => _editing = false),
                      )
                    : _SignatureSummary(
                        signature: data,
                        onEdit: () => setState(() => _editing = true),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignatureSummary extends StatelessWidget {
  const _SignatureSummary({required this.signature, required this.onEdit});

  final MySignature signature;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final image = signature.signatureData?.split(',').last;
    final registered = signature.registeredAt;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(signature.signerName, style: textTheme.titleMedium),
        Text(
          '${_documentTypeLabel(l10n, signature.documentType)} '
          '${signature.documentNumber}',
        ),
        if (registered != null)
          Text(
            l10n.signatureRegisteredOn(AppFormat.date(registered)),
            style: textTheme.bodySmall,
          ),
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            label: signature.hasPin
                ? l10n.signatureHasPin
                : l10n.signatureNoPin,
            kind: signature.hasPin ? StatusKind.success : StatusKind.warning,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (image != null)
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadius.control),
            ),
            child: Image.memory(
              base64Decode(image),
              height: 140,
              fit: BoxFit.contain,
              semanticLabel: l10n.signatureTitle,
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        BojaniButton(label: l10n.signatureSave, onPressed: onEdit),
        const SizedBox(height: AppSpacing.sm),
        BojaniButton(
          label: l10n.signaturePinRegenerate,
          kind: BojaniButtonKind.secondary,
          icon: Icons.pin_outlined,
          onPressed: () => unawaited(regeneratePinFlow(context)),
        ),
      ],
    );
  }
}

class _SignatureForm extends ConsumerStatefulWidget {
  const _SignatureForm({required this.current, required this.onSaved});

  final MySignature? current;
  final VoidCallback onSaved;

  @override
  ConsumerState<_SignatureForm> createState() => _SignatureFormState();
}

class _SignatureFormState extends ConsumerState<_SignatureForm> {
  static final _documentNumber = RegExp(r'^[A-Za-z0-9]{4,20}$');

  final _formKey = GlobalKey<FormState>();
  final _number = TextEditingController();
  final _password = TextEditingController();
  final _pad = SignaturePadController();
  late String _type =
      widget.current?.documentType ?? identityDocumentTypes.first;
  bool _padError = false;

  @override
  void initState() {
    super.initState();
    _number.text = widget.current?.documentNumber ?? '';
  }

  @override
  void dispose() {
    _number.dispose();
    _password.dispose();
    _pad.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() => _padError = _pad.isEmpty);
    if (!valid || _pad.isEmpty) return;
    final png = await _pad.toDataUrl();
    if (png == null) return;
    final result = await ref
        .read(saveSignatureControllerProvider.notifier)
        .submit(
          currentPassword: _password.text,
          documentType: _type,
          documentNumber: _number.text.trim(),
          signature: png,
        );
    if (result == null || !mounted) return;
    _password.clear();
    widget.onSaved();
    AppSnackbar.show(context, l10n.signatureSaved);
    final pin = result.pin;
    if (pin != null) await showPinDialog(context, pin);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(saveSignatureControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final canWrite = ref.watch(canWriteProvider);
    final error = submission.error;
    final validation = error is ValidationException ? error : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.signatureIntro),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: InputDecoration(labelText: l10n.fieldDocumentType),
              items: [
                for (final type in identityDocumentTypes)
                  DropdownMenuItem(
                    value: type,
                    child: Text(_documentTypeLabel(l10n, type)),
                  ),
              ],
              onChanged: (value) => setState(() => _type = value ?? _type),
            ),
            const SizedBox(height: AppSpacing.md),
            BojaniTextField(
              label: l10n.fieldDocumentNumber,
              controller: _number,
              errorText: validation?.firstErrorFor('document_number'),
              validator: (v) => _documentNumber.hasMatch((v ?? '').trim())
                  ? null
                  : l10n.validationDocumentNumber,
            ),
            const SizedBox(height: AppSpacing.md),
            SignaturePad(
              controller: _pad,
              errorText: _padError
                  ? l10n.signatureRequired
                  : validation?.firstErrorFor('signature'),
            ),
            const SizedBox(height: AppSpacing.md),
            BojaniTextField(
              label: l10n.fieldPassword,
              controller: _password,
              isPassword: true,
              errorText: validation?.firstErrorFor('current_password'),
              validator: (v) =>
                  (v ?? '').isEmpty ? l10n.validationPasswordRequired : null,
            ),
            if (error != null && validation == null) ...[
              const SizedBox(height: AppSpacing.md),
              AlertBanner(
                message: ApiErrorMessage.of(l10n, error, isProd: isProd),
                kind: StatusKind.error,
                icon: Icons.error_outline,
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            BojaniButton(
              label: l10n.signatureSave,
              isLoading: submission.isSubmitting,
              onPressed: canWrite ? () => unawaited(_save()) : null,
            ),
          ],
        ),
      ),
    );
  }
}
