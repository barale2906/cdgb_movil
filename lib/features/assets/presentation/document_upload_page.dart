import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/config/app_environment.dart';
import 'package:sga_bojanini/core/config/app_environment_provider.dart';
import 'package:sga_bojanini/core/files/file_picker_gateway.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/widgets/alert_banner.dart';
import 'package:sga_bojanini/core/widgets/api_error_message.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/bojani_button.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/form_fields.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/assets/application/assets_providers.dart';
import 'package:sga_bojanini/features/assets/application/documents_providers.dart';
import 'package:sga_bojanini/features/assets/data/asset_catalogs.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Datos del documento elegido (tipo, título y fechas) antes de subirlo.
class DocumentUploadPage extends ConsumerWidget {
  const DocumentUploadPage({
    required this.assetId,
    required this.file,
    super.key,
  });

  final int assetId;
  final PickedFile file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final filters = ref.watch(assetFiltersProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.assetDocumentAdd)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: filters.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(assetFiltersProvider),
                ),
                data: (data) => _Form(
                  assetId: assetId,
                  file: file,
                  types: data.documentTypes,
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
  const _Form({
    required this.assetId,
    required this.file,
    required this.types,
  });

  final int assetId;
  final PickedFile file;
  final List<CatalogOption> types;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  late final _title = TextEditingController(text: _suggestedTitle);
  CatalogOption? _type;
  DateTime? _issued;
  DateTime? _expires;

  String get _suggestedTitle {
    final name = widget.file.name;
    final dot = name.lastIndexOf('.');
    return dot > 0 ? name.substring(0, dot) : name;
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  static String? _iso(DateTime? date) =>
      date?.toIso8601String().substring(0, 10);

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final done = await ref
        .read(documentActionsProvider.notifier)
        .upload(
          widget.assetId,
          file: widget.file,
          documentType: _type!.value,
          title: _title.text,
          issuedAt: _iso(_issued),
          expiresAt: _iso(_expires),
        );
    if (done && mounted) {
      AppSnackbar.show(context, l10n.assetDocumentUploaded);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final submission = ref.watch(documentActionsProvider);
    final isProd = ref.watch(appEnvironmentProvider).env == AppEnv.prod;
    final error = submission.error;
    String? required(Object? value) =>
        value == null || value == '' ? l10n.validationRequired : null;
    final isImage = widget.file.name.toLowerCase().contains(
      RegExp(r'\.(jpe?g|png)$'),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                if (isImage)
                  Image.memory(
                    widget.file.bytes,
                    height: 180,
                    fit: BoxFit.contain,
                    semanticLabel: widget.file.name,
                  )
                else
                  ListTile(
                    leading: const Icon(Icons.picture_as_pdf_outlined),
                    title: Text(widget.file.name),
                  ),
                const SizedBox(height: AppSpacing.md),
                OptionDropdown<CatalogOption>(
                  label: l10n.assetDocumentType,
                  options: {for (final t in widget.types) t: t.label},
                  value: _type,
                  validator: required,
                  onChanged: (value) => setState(() => _type = value),
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _title,
                  maxLength: 150,
                  decoration: InputDecoration(
                    labelText: l10n.assetDocumentTitle,
                  ),
                  validator: required,
                ),
                DateField(
                  label: l10n.assetDocumentIssued,
                  value: _issued,
                  onChanged: (value) => setState(() => _issued = value),
                ),
                const SizedBox(height: AppSpacing.md),
                DateField(
                  label: l10n.assetDocumentExpiry,
                  value: _expires,
                  firstDate: _issued,
                  onChanged: (value) => setState(() => _expires = value),
                ),
                if (error != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  AlertBanner(
                    message: ApiErrorMessage.ofWrite(
                      l10n,
                      error,
                      isProd: isProd,
                      timeoutWarning: l10n.assetDocumentTimeoutWarning,
                    ),
                    kind: StatusKind.error,
                    icon: Icons.error_outline,
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: BojaniButton(
              label: l10n.assetDocumentUpload,
              isLoading: submission.isSubmitting,
              onPressed: () => unawaited(_submit()),
            ),
          ),
        ],
      ),
    );
  }
}
