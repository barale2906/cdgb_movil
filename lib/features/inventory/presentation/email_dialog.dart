import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/auth/application/validators.dart';
import 'package:sga_bojanini/features/inventory/application/document_actions.dart';
import 'package:sga_bojanini/features/inventory/presentation/movement_form_shell.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Envía el comprobante por correo a una lista de destinatarios.
Future<void> showEmailDialog(BuildContext context, int documentId) =>
    showDialog<void>(
      context: context,
      builder: (_) => _EmailDialog(documentId: documentId),
    );

class _EmailDialog extends ConsumerStatefulWidget {
  const _EmailDialog({required this.documentId});

  final int documentId;

  @override
  ConsumerState<_EmailDialog> createState() => _EmailDialogState();
}

class _EmailDialogState extends ConsumerState<_EmailDialog> {
  final _formKey = GlobalKey<FormState>();
  final _recipients = TextEditingController();

  @override
  void dispose() {
    _recipients.dispose();
    super.dispose();
  }

  List<String> get _parsed => _recipients.text
      .split(RegExp(r'[,;\s]+'))
      .where((email) => email.isNotEmpty)
      .toList();

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final messenger = ScaffoldMessenger.of(context);
    final ok = await ref
        .read(sendEmailControllerProvider.notifier)
        .send(widget.documentId, _parsed);
    if (!ok || !mounted) return;
    Navigator.of(context).pop();
    messenger.showSnackBar(SnackBar(content: Text(l10n.emailSent)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(sendEmailControllerProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final error = submission.error;

    return AlertDialog(
      title: Text(l10n.sendEmailAction),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _recipients,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: l10n.fieldRecipients),
              validator: (_) {
                final emails = _parsed;
                final valid =
                    emails.isNotEmpty &&
                    emails.every((e) => Validators.email(l10n, e) == null);
                return valid ? null : l10n.validationEmails;
              },
            ),
            if (error != null) ...[
              const SizedBox(height: AppSpacing.md),
              AlertBanner(
                message: writeErrorMessage(l10n, error, isProd: isProd),
                kind: StatusKind.error,
              ),
            ],
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.all(AppSpacing.md),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        BojaniButton(
          label: l10n.sendEmailAction,
          isLoading: submission.isSubmitting,
          onPressed: _send,
        ),
        const SizedBox(height: AppSpacing.sm),
        BojaniButton(
          label: l10n.actionCancel,
          kind: BojaniButtonKind.tertiary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
