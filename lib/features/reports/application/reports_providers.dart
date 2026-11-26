import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sga_bojanini/core/clock/clock.dart';
import 'package:sga_bojanini/core/network/api_response.dart';
import 'package:sga_bojanini/core/paging/paged_notifier.dart';
import 'package:sga_bojanini/core/utils/submission_notifier.dart';
import 'package:sga_bojanini/features/reports/data/report_models.dart';
import 'package:sga_bojanini/features/reports/data/reports_repository.dart';

class ExportListNotifier extends PagedNotifier<ReportExport> {
  @override
  Future<PagedList<ReportExport>> fetchPage(int page) =>
      ref.read(reportsRepositoryProvider).exports(page: page);
}

final NotifierProvider<ExportListNotifier, PagedState<ReportExport>>
exportListProvider =
    NotifierProvider.autoDispose<ExportListNotifier, PagedState<ReportExport>>(
      ExportListNotifier.new,
    );

final FutureProvider<List<ReportSensor>> reportSensorsProvider =
    FutureProvider.autoDispose<List<ReportSensor>>(
      (ref) => ref.watch(reportsRepositoryProvider).sensors(),
    );

/// Pide un reporte (lectura que genera archivo; un envío a la vez).
class GenerateReportController extends SubmissionNotifier {
  Future<ReportResult?> generate(
    ReportType type,
    ReportFormat format,
    Map<String, Object?> filters,
  ) async {
    final result = await runValue(
      () => ref
          .read(reportsRepositoryProvider)
          .generate(
            type,
            format,
            filters: filters,
            now: ref.read(clockProvider)(),
          ),
    );
    if (result is ReportQueued) ref.invalidate(exportListProvider);
    return result;
  }
}

final NotifierProvider<GenerateReportController, SubmissionState>
generateReportControllerProvider =
    NotifierProvider.autoDispose<GenerateReportController, SubmissionState>(
      GenerateReportController.new,
    );
