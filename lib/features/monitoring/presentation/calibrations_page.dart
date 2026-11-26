import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/file_sharer.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/empty_state.dart';
import 'package:sga_bojanini/core/widgets/error_state.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/skeleton.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/monitoring/application/monitoring_providers.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_models.dart';
import 'package:sga_bojanini/features/monitoring/data/monitoring_repository.dart';
import 'package:sga_bojanini/features/monitoring/presentation/monitoring_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Certificados de calibración de un sensor (descarga para compartir).
class CalibrationsPage extends ConsumerWidget {
  const CalibrationsPage({required this.sensorId, super.key});

  final int sensorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final certificates = ref.watch(calibrationsProvider(sensorId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.calibrationsTitle)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: certificates.when(
                loading: () => const SkeletonList(),
                error: (error, _) => ErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(calibrationsProvider(sensorId)),
                ),
                data: (items) => items.isEmpty
                    ? EmptyState(
                        icon: Icons.verified_outlined,
                        message: l10n.calibrationsEmpty,
                      )
                    : RefreshIndicator(
                        onRefresh: () =>
                            ref.refresh(calibrationsProvider(sensorId).future),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          itemCount: items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppSpacing.sm),
                          itemBuilder: (context, index) =>
                              _CertificateTile(certificate: items[index]),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CertificateTile extends ConsumerWidget {
  const _CertificateTile({required this.certificate});

  final CalibrationCertificate certificate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    certificate.certificateNumber ??
                        certificate.originalName ??
                        l10n.notAvailable,
                    style: textTheme.titleSmall,
                  ),
                ),
                if (certificate.isCurrent)
                  CalibrationChip(
                    status: certificate.status,
                    daysLeft: certificate.daysLeft,
                  )
                else
                  StatusChip(
                    label: l10n.calibrationReplaced,
                    kind: StatusKind.special,
                  ),
              ],
            ),
            if (certificate.laboratory != null) Text(certificate.laboratory!),
            if (certificate.expiresAt != null)
              Text(
                l10n.batchExpires(AppFormat.date(certificate.expiresAt!)),
                style: textTheme.bodySmall,
              ),
            const SizedBox(height: AppSpacing.sm),
            TextButton.icon(
              onPressed: () => unawaited(_download(context, ref)),
              icon: const Icon(Icons.download_outlined),
              label: Text(l10n.calibrationDownload),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _download(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    try {
      final bytes = await ref
          .read(monitoringRepositoryProvider)
          .downloadCalibration(certificate.id);
      await ref.read(fileSharerProvider)(
        bytes,
        certificate.originalName ?? 'certificado-${certificate.id}.pdf',
      );
    } on Object {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          l10n.errorGeneric,
          kind: AppSnackbarKind.error,
          closeLabel: l10n.actionClose,
        );
      }
    }
  }
}
