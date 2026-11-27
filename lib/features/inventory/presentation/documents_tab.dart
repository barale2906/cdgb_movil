import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sga_bojanini/core/theme/app_tokens.dart';
import 'package:sga_bojanini/core/utils/formatters.dart';
import 'package:sga_bojanini/core/widgets/choice_filter_bar.dart';
import 'package:sga_bojanini/core/widgets/paged_list_view.dart';
import 'package:sga_bojanini/features/inventory/application/inventory_providers.dart';
import 'package:sga_bojanini/features/inventory/data/inventory_queries.dart';
import 'package:sga_bojanini/features/inventory/data/movement_document.dart';
import 'package:sga_bojanini/features/inventory/presentation/inventory_labels.dart';
import 'package:sga_bojanini/l10n/app_localizations.dart';

/// Comprobantes del almacén, con filtro por estado.
class DocumentsTab extends ConsumerStatefulWidget {
  const DocumentsTab({required this.warehouseId, super.key});

  final int warehouseId;

  @override
  ConsumerState<DocumentsTab> createState() => _DocumentsTabState();
}

class _DocumentsTabState extends ConsumerState<DocumentsTab> {
  DocumentStatus? _status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = documentListProvider(
      DocumentQuery(warehouseId: widget.warehouseId, status: _status),
    );
    final notifier = ref.read(provider.notifier);

    return Column(
      children: [
        const SizedBox(height: AppSpacing.sm),
        ChoiceFilterBar<DocumentStatus?>(
          options: {
            null: l10n.documentFilterAll,
            DocumentStatus.pendingSignature: l10n.documentFilterPending,
            DocumentStatus.confirmed: l10n.documentFilterConfirmed,
          },
          selected: _status,
          onSelected: (value) => setState(() => _status = value),
        ),
        Expanded(
          child: PagedListView<MovementDocument>(
            state: ref.watch(provider),
            onRefresh: notifier.refresh,
            onLoadMore: notifier.loadMore,
            onRetry: notifier.retry,
            emptyMessage: l10n.documentsEmpty,
            emptyIcon: Icons.receipt_long_outlined,
            itemBuilder: (context, document) =>
                DocumentTile(document: document),
          ),
        ),
      ],
    );
  }
}

class DocumentTile extends StatelessWidget {
  const DocumentTile({required this.document, super.key});

  final MovementDocument document;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = document.movementDate ?? document.createdAt;
    return Card(
      child: ListTile(
        minTileHeight: AppSizes.minTouchTarget,
        title: Text(document.documentNumber),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(movementTypeLabel(l10n, document.documentType)),
            if (date != null) Text(AppFormat.date(date)),
            const SizedBox(height: AppSpacing.xs),
            DocumentStatusChip(status: document.status),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/inventory/documents/${document.id}'),
      ),
    );
  }
}
