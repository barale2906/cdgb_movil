import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/my_signature.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/signature_pad.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/inventory/application/document_actions.dart';
import 'package:sga_bojanini/features/inventory/data/movement_requests.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

enum _DeliveredMode { registered, onScreen }

enum _ReceiverMode { pin, external }

/// Datos de una persona que firma en pantalla (nombre, documento, firma).
class _SignerFields {
  final name = TextEditingController();
  final document = TextEditingController();
  final pad = SignaturePadController();
  bool padError = false;

  void dispose() {
    name.dispose();
    document.dispose();
    pad.dispose();
  }

  Future<ExternalSigner?> read() async {
    padError = pad.isEmpty;
    if (pad.isEmpty) return null;
    final png = await pad.toDataUrl();
    if (png == null) return null;
    return ExternalSigner(
      name: name.text.trim(),
      document: document.text.trim(),
      signature: png,
    );
  }
}

/// Confirma un comprobante: quien entrega (firma registrada o en pantalla)
/// y quien recibe (PIN de 3 dígitos o persona externa con firma).
class ConfirmDocumentPage extends ConsumerStatefulWidget {
  const ConfirmDocumentPage({required this.documentId, super.key});

  final int documentId;

  @override
  ConsumerState<ConfirmDocumentPage> createState() =>
      _ConfirmDocumentPageState();
}

class _ConfirmDocumentPageState extends ConsumerState<ConfirmDocumentPage> {
  final _formKey = GlobalKey<FormState>();
  final _pin = TextEditingController();
  final _delivered = _SignerFields();
  final _received = _SignerFields();
  _DeliveredMode? _deliveredMode;
  _ReceiverMode _receiverMode = _ReceiverMode.pin;

  @override
  void dispose() {
    _pin.dispose();
    _delivered.dispose();
    _received.dispose();
    super.dispose();
  }

  Future<void> _submit(bool hasRegisteredSignature) async {
    final l10n = AppLocalizations.of(context);
    final deliveredMode =
        _deliveredMode ??
        (hasRegisteredSignature
            ? _DeliveredMode.registered
            : _DeliveredMode.onScreen);
    final valid = _formKey.currentState?.validate() ?? false;

    ExternalSigner? delivered;
    if (deliveredMode == _DeliveredMode.onScreen) {
      delivered = await _delivered.read();
    }
    Receiver? receiver;
    if (_receiverMode == _ReceiverMode.pin) {
      receiver = PinReceiver(_pin.text.trim());
    } else {
      final signer = await _received.read();
      if (signer != null) receiver = ExternalReceiver(signer);
    }
    setState(() {});
    final deliveredOk =
        deliveredMode == _DeliveredMode.registered || delivered != null;
    if (!valid || !deliveredOk || receiver == null) return;

    final document = await ref
        .read(confirmDocumentControllerProvider.notifier)
        .confirm(
          widget.documentId,
          ConfirmRequest(receivedBy: receiver, deliveredBy: delivered),
        );
    if (document == null || !mounted) return;
    AppSnackbar.show(context, l10n.confirmedMessage);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final signature = ref.watch(mySignatureProvider);
    final submission = ref.watch(confirmDocumentControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final canWrite = ref.watch(canWriteProvider);
    final hasSignature = signature.value != null;
    final deliveredMode =
        _deliveredMode ??
        (hasSignature ? _DeliveredMode.registered : _DeliveredMode.onScreen);
    final error = submission.error;
    final pinError = error is ValidationException
        ? error.firstErrorFor('received_by.pin')
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.confirmTitle)),
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
                      Text(
                        l10n.confirmDelivered,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SegmentedButton<_DeliveredMode>(
                        segments: [
                          ButtonSegment(
                            value: _DeliveredMode.registered,
                            label: Text(l10n.confirmUseMySignature),
                            enabled: hasSignature,
                          ),
                          ButtonSegment(
                            value: _DeliveredMode.onScreen,
                            label: Text(l10n.signHere),
                          ),
                        ],
                        selected: {deliveredMode},
                        onSelectionChanged: (s) =>
                            setState(() => _deliveredMode = s.first),
                      ),
                      if (!hasSignature && !signature.isLoading) ...[
                        const SizedBox(height: AppSpacing.sm),
                        AlertBanner(
                          message: l10n.confirmNoSignature,
                          kind: StatusKind.info,
                          actionLabel: l10n.confirmRegisterSignature,
                          onAction: () =>
                              unawaited(context.push('/profile/signature')),
                        ),
                      ],
                      if (deliveredMode == _DeliveredMode.onScreen) ...[
                        const SizedBox(height: AppSpacing.md),
                        _SignerForm(fields: _delivered),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.confirmReceived,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SegmentedButton<_ReceiverMode>(
                        segments: [
                          ButtonSegment(
                            value: _ReceiverMode.pin,
                            label: Text(l10n.confirmModePin),
                          ),
                          ButtonSegment(
                            value: _ReceiverMode.external,
                            label: Text(l10n.confirmModeExternal),
                          ),
                        ],
                        selected: {_receiverMode},
                        onSelectionChanged: (s) =>
                            setState(() => _receiverMode = s.first),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (_receiverMode == _ReceiverMode.pin)
                        BojaniTextField(
                          label: l10n.fieldPin,
                          controller: _pin,
                          isPassword: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          errorText: pinError,
                          validator: (v) =>
                              (v ?? '').length == 3 ? null : l10n.validationPin,
                        )
                      else
                        _SignerForm(fields: _received),
                      if (error != null && pinError == null) ...[
                        const SizedBox(height: AppSpacing.md),
                        AlertBanner(
                          message: writeErrorMessage(
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
                label: l10n.confirmAction,
                isLoading: submission.isSubmitting,
                onPressed: canWrite
                    ? () => unawaited(_submit(hasSignature))
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignerForm extends StatelessWidget {
  const _SignerForm({required this.fields});

  final _SignerFields fields;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String? required(String? v) =>
        (v ?? '').trim().isEmpty ? l10n.validationRequired : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BojaniTextField(
          label: l10n.fieldSignerName,
          controller: fields.name,
          textInputAction: TextInputAction.next,
          validator: required,
        ),
        const SizedBox(height: AppSpacing.md),
        BojaniTextField(
          label: l10n.fieldSignerDocument,
          controller: fields.document,
          validator: required,
        ),
        const SizedBox(height: AppSpacing.md),
        SignaturePad(
          controller: fields.pad,
          errorText: fields.padError ? l10n.signatureRequired : null,
        ),
      ],
    );
  }
}
