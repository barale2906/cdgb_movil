import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/network/api_exception.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/app_snackbar.dart';
import 'package:sga_bojanini/core/widgets/offline_banner.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/core/widgets/status_chip.dart';
import 'package:sga_bojanini/features/reports/application/reports_providers.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/features/reports/data/reports_repository.dart';
import 'package:sga_bojanini/features/reports/presentation/report_labels.dart';
import 'package:sga_bojanini/features/reports/presentation/report_viewer_page.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Cada cuánto se consulta el estado mientras haya reportes en cola.
const exportsPollInterval = Duration(seconds: 5);

/// Exportaciones del usuario: sigue `queued → processing → ready | failed`
/// y permite descargarlas.
class ExportsPage extends ConsumerStatefulWidget {
  const ExportsPage({super.key});

  @override
  ConsumerState<ExportsPage> createState() => _ExportsPageState();
}

class _ExportsPageState extends ConsumerState<ExportsPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(exportsPollInterval, (_) {
      final state = ref.read(exportListProvider);
      if (state.items.any((e) => e.isInProgress)) {
        unawaited(ref.read(exportListProvider.notifier).refresh());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(exportListProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportsMyExports)),
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: PagedListView<ReportExport>(
                state: ref.watch(exportListProvider),
                onRefresh: notifier.refresh,
                onLoadMore: notifier.loadMore,
                onRetry: notifier.retry,
                emptyIcon: Icons.download_for_offline_outlined,
                emptyMessage: l10n.exportsEmpty,
                itemBuilder: (context, item) => _ExportTile(export: item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExportTile extends ConsumerWidget {
  const _ExportTile({required this.export});

  final ReportExport export;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final type = ReportType.fromPath(export.type);
    final (kind, label) = switch (export.status) {
      _ when export.isExpired => (StatusKind.special, l10n.exportExpired),
      ExportStatus.queued => (StatusKind.info, l10n.exportQueued),
      ExportStatus.processing => (StatusKind.warning, l10n.exportProcessing),
      ExportStatus.ready => (StatusKind.success, l10n.exportReady),
      ExportStatus.failed => (StatusKind.error, l10n.exportFailed),
      ExportStatus.unknown => (StatusKind.info, export.status.name),
    };
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
                    '${type?.label(l10n) ?? export.type} · '
                    '${export.format.toUpperCase()}',
                    style: textTheme.titleSmall,
                  ),
                ),
                StatusChip(label: label, kind: kind),
              ],
            ),
            Text(
              l10n.exportCreatedAt(AppFormat.dateTime(export.createdAt)),
              style: textTheme.bodySmall,
            ),
            if (export.fileSize != null)
              Text(
                l10n.exportSize(
                  AppFormat.decimal(export.fileSize! / 1024, maxDecimals: 1),
                ),
                style: textTheme.bodySmall,
              ),
            if (export.status == ExportStatus.failed)
              Text(
                export.errorMessage ?? l10n.exportFailedDetail,
                style: textTheme.bodySmall,
              ),
            if (export.canDownload)
              TextButton.icon(
                onPressed: () => unawaited(_download(context, ref)),
                icon: const Icon(Icons.download_outlined),
                label: Text(l10n.exportDownload),
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
          .read(reportsRepositoryProvider)
          .downloadExport(export.id);
      final format = ReportFormat.values.firstWhere(
        (f) => f.value == export.format || f.extension == export.format,
        orElse: () => ReportFormat.pdf,
      );
      final file = ReportFile(
        bytes: bytes,
        fileName: '${export.type}_${export.id}.${format.extension}',
        format: format,
      );
      if (!context.mounted) return;
      if (format == ReportFormat.pdf) {
        unawaited(context.push('/reports/view', extra: file));
      } else {
        await shareReportFile(context, ref, file);
      }
    } on GoneException {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          l10n.exportGone,
          kind: AppSnackbarKind.warning,
        );
        ref.invalidate(exportListProvider);
      }
    } on ApiException catch (error) {
      if (context.mounted) {
        AppSnackbar.show(
          context,
          error.message.isEmpty ? l10n.errorGeneric : error.message,
          kind: AppSnackbarKind.error,
          closeLabel: l10n.actionClose,
        );
      }
    }
  }
}
