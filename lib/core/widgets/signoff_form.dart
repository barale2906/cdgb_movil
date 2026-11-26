import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/auth/my_signature.dart';
import 'package:sga_bojanini/core/signing/signoff.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/core/widgets/signature_pad.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
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

/// Estado del formulario de firmas: quién entrega (firma registrada o en
/// pantalla) y quién recibe (PIN de 3 dígitos o persona externa con firma).
/// Lo crea la pantalla (como un `TextEditingController`) y lo libera.
class SignoffController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final _pin = TextEditingController();
  final _delivered = _SignerFields();
  final _received = _SignerFields();
  _DeliveredMode? _deliveredMode;
  _ReceiverMode _receiverMode = _ReceiverMode.pin;

  _DeliveredMode _effectiveDelivered({required bool hasRegisteredSignature}) =>
      _deliveredMode ??
      (hasRegisteredSignature
          ? _DeliveredMode.registered
          : _DeliveredMode.onScreen);

  /// Valida y arma la confirmación; `null` si falta algo (el formulario
  /// muestra qué).
  Future<ConfirmRequest?> collect({
    required bool hasRegisteredSignature,
  }) async {
    final deliveredMode = _effectiveDelivered(
      hasRegisteredSignature: hasRegisteredSignature,
    );
    final valid = formKey.currentState?.validate() ?? false;

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
    notifyListeners();
    final deliveredOk =
        deliveredMode == _DeliveredMode.registered || delivered != null;
    if (!valid || !deliveredOk || receiver == null) return null;
    return ConfirmRequest(receivedBy: receiver, deliveredBy: delivered);
  }

  void _setDelivered(_DeliveredMode mode) {
    _deliveredMode = mode;
    notifyListeners();
  }

  void _setReceiver(_ReceiverMode mode) {
    _receiverMode = mode;
    notifyListeners();
  }

  @override
  void dispose() {
    _pin.dispose();
    _delivered.dispose();
    _received.dispose();
    super.dispose();
  }
}

/// Formulario de quién entrega y quién recibe. [pinError] es el error del
/// servidor sobre el PIN (p. ej. PIN incorrecto).
class SignoffForm extends ConsumerWidget {
  const SignoffForm({required this.controller, super.key, this.pinError});

  final SignoffController controller;
  final String? pinError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signature = ref.watch(mySignatureProvider);
    final hasSignature = signature.value != null;
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final l10n = AppLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final deliveredMode = controller._effectiveDelivered(
          hasRegisteredSignature: hasSignature,
        );
        return Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.confirmDelivered, style: textTheme.titleSmall),
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
                onSelectionChanged: (s) => controller._setDelivered(s.first),
              ),
              if (!hasSignature && !signature.isLoading) ...[
                const SizedBox(height: AppSpacing.sm),
                AlertBanner(
                  message: l10n.confirmNoSignature,
                  kind: StatusKind.info,
                  actionLabel: l10n.confirmRegisterSignature,
                  onAction: () => unawaited(context.push('/profile/signature')),
                ),
              ],
              if (deliveredMode == _DeliveredMode.onScreen) ...[
                const SizedBox(height: AppSpacing.md),
                _SignerForm(fields: controller._delivered),
              ],
              const SizedBox(height: AppSpacing.lg),
              Text(l10n.confirmReceived, style: textTheme.titleSmall),
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
                selected: {controller._receiverMode},
                onSelectionChanged: (s) => controller._setReceiver(s.first),
              ),
              const SizedBox(height: AppSpacing.md),
              if (controller._receiverMode == _ReceiverMode.pin)
                BojaniTextField(
                  label: l10n.fieldPin,
                  controller: controller._pin,
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
                _SignerForm(fields: controller._received),
            ],
          ),
        );
      },
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
