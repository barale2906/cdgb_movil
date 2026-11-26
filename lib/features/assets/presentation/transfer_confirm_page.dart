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
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/signoff_form.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/application/transfers_providers.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Confirma un traslado pendiente con las firmas de quien entrega y de quien
/// recibe (misma pantalla de firmas que los comprobantes de inventario).
class TransferConfirmPage extends ConsumerStatefulWidget {
  const TransferConfirmPage({required this.transferId, super.key});

  final int transferId;

  @override
  ConsumerState<TransferConfirmPage> createState() =>
      _TransferConfirmPageState();
}

class _TransferConfirmPageState extends ConsumerState<TransferConfirmPage> {
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
    final done = await ref
        .read(transferActionsProvider.notifier)
        .confirm(widget.transferId, request);
    if (done && mounted) {
      AppSnackbar.show(context, l10n.transferConfirmed);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasSignature = ref.watch(mySignatureProvider).value != null;
    final submission = ref.watch(transferActionsProvider);
    final canWrite = ref.watch(canWriteProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
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
                        message: ApiErrorMessage.ofWrite(
                          l10n,
                          error,
                          isProd: isProd,
                          timeoutWarning: l10n.transferTimeoutWarning,
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
