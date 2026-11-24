import 'package:flutter/material.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/bojani_text_field.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Resultado del diálogo: nueva URL, o [useDefault] para volver al servidor
/// del archivo de destino.
class ServerChoice {
  const ServerChoice.url(Uri this.url) : useDefault = false;
  const ServerChoice.useDefault() : url = null, useDefault = true;

  final Uri? url;
  final bool useDefault;
}

/// Pide la dirección del servidor (solo flavor dev).
Future<ServerChoice?> showServerChangeDialog(
  BuildContext context, {
  required String currentUrl,
}) => showDialog<ServerChoice>(
  context: context,
  builder: (_) => _ServerChangeDialog(currentUrl: currentUrl),
);

class _ServerChangeDialog extends StatefulWidget {
  const _ServerChangeDialog({required this.currentUrl});

  final String currentUrl;

  @override
  State<_ServerChangeDialog> createState() => _ServerChangeDialogState();
}

class _ServerChangeDialogState extends State<_ServerChangeDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller = TextEditingController(
    text: widget.currentUrl,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _accept() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final url = AppEnvironment.tryParseBaseUrl(_controller.text);
    if (url != null) Navigator.of(context).pop(ServerChoice.url(url));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.aboutChangeServer),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.aboutChangeServerNotice),
            const SizedBox(height: AppSpacing.md),
            BojaniTextField(
              label: l10n.aboutChangeServerHint,
              controller: _controller,
              keyboardType: TextInputType.url,
              validator: (value) =>
                  AppEnvironment.tryParseBaseUrl(value ?? '') == null
                  ? l10n.aboutChangeServerInvalid
                  : null,
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.all(AppSpacing.md),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        BojaniButton(label: l10n.actionAccept, onPressed: _accept),
        const SizedBox(height: AppSpacing.sm),
        BojaniButton(
          label: l10n.aboutUseDefaultServer,
          kind: BojaniButtonKind.secondary,
          onPressed: () =>
              Navigator.of(context).pop(const ServerChoice.useDefault()),
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
