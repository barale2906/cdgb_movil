import 'dart:async';

import 'package:flutter/material.dart';
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
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/signoff_form.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/inventory/application/document_actions.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

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
  final _signoff = SignoffController();

  @override
  void dispose() {
    _signoff.dispose();
    super.dispose();
  }

  Future<void> _submit({required bool hasRegisteredSignature}) async {
    final l10n = AppLocalizations.of(context);
    final request = await _signoff.collect(
      hasRegisteredSignature: hasRegisteredSignature,
    );
    if (request == null) return;
    final document = await ref
        .read(confirmDocumentControllerProvider.notifier)
        .confirm(widget.documentId, request);
    if (document == null || !mounted) return;
    AppSnackbar.show(context, l10n.confirmedMessage);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasSignature = ref.watch(mySignatureProvider).value != null;
    final submission = ref.watch(confirmDocumentControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final canWrite = ref.watch(canWriteProvider);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SignoffForm(controller: _signoff, pinError: pinError),
                    if (error != null && pinError == null) ...[
                      const SizedBox(height: AppSpacing.md),
                      AlertBanner(
                        message: writeErrorMessage(l10n, error, isProd: isProd),
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
                label: l10n.confirmAction,
                isLoading: submission.isSubmitting,
                onPressed: canWrite
                    ? () => unawaited(
                        _submit(hasRegisteredSignature: hasSignature),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
